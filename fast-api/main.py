# api_rag_llama_autocreate.py

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from transformers import AutoTokenizer, AutoModel, AutoModelForCausalLM, AutoModelForSequenceClassification
import torch
import faiss
import pickle
import pandas as pd
from collections import deque
import os
from dotenv import load_dotenv

load_dotenv()

# ----------------------------
# CONFIG
# ----------------------------
CLASSIFIER_MODEL_ID = "Sandei/tech-support-classifier"
KNOWLEDGE_BASE_CSV = "final_data_set(in).csv"
FAISS_INDEX_PATH = "faiss_index.bin"
CHUNKED_DATASET_PATH = "chunked_dataset.pkl"
MAX_HISTORY = 5
device = "cuda" if torch.cuda.is_available() else "cpu"

# ----------------------------
# FASTAPI INIT
# ----------------------------
app = FastAPI(title="RAG + TinyLlama + Multi-Label API")

# ----------------------------
# USER MEMORY
# ----------------------------
user_memory = {}  # user_id -> deque
def add_to_memory(user_id, question, answer):
    if user_id not in user_memory:
        user_memory[user_id] = deque(maxlen=MAX_HISTORY)
    user_memory[user_id].append({"question": question, "answer": answer})

# ----------------------------
# MULTI-LABEL CLASSIFIER
# ----------------------------
clf_tokenizer = AutoTokenizer.from_pretrained(CLASSIFIER_MODEL_ID)
clf_model = AutoModelForSequenceClassification.from_pretrained(CLASSIFIER_MODEL_ID)
clf_model.to(device)
clf_model.eval()

# Load tag mapping
try:
    import huggingface_hub
    tag_json = huggingface_hub.hf_hub_download(CLASSIFIER_MODEL_ID, "tag_mapping.json")
    with open(tag_json, "r") as f:
        tag_classes = json.load(f)
except:
    tag_classes = []

def classify_multilabel(text, threshold=0.5):
    inputs = clf_tokenizer(text, return_tensors="pt", truncation=True, padding=True).to(device)
    with torch.no_grad():
        logits = clf_model(**inputs).logits
        probs = torch.sigmoid(logits).cpu().numpy()[0]
    result = []
    for i, p in enumerate(probs):
        if p >= threshold and i < len(tag_classes):
            result.append({"tag": tag_classes[i], "probability": float(p)})
    return result

# ----------------------------
# RAG: Embedding + FAISS
# ----------------------------
embedding_model_name = "sentence-transformers/all-MiniLM-L6-v2"
embed_tokenizer = AutoTokenizer.from_pretrained(embedding_model_name)
embed_model = AutoModel.from_pretrained(embedding_model_name).to(device)
embed_model.eval()

def embed_texts(texts, batch_size=32):
    embeddings = []
    for i in range(0, len(texts), batch_size):
        batch_texts = texts[i:i+batch_size]
        encoded = embed_tokenizer(batch_texts, return_tensors="pt", truncation=True, padding=True).to(device)
        with torch.no_grad():
            output = embed_model(**encoded)
            token_embeddings = output.last_hidden_state
            attention_mask = encoded['attention_mask'].unsqueeze(-1)
            masked = token_embeddings * attention_mask
            summed = masked.sum(dim=1)
            counts = attention_mask.sum(dim=1)
            mean_pooled = summed / counts
            embeddings.append(mean_pooled.cpu().numpy())
    return np.vstack(embeddings)

def build_faiss_index():
    print("Building FAISS index...")
    df = pd.read_csv(KNOWLEDGE_BASE_CSV)
    texts = (df["question"] + " " + df["answer"]).tolist()
    embeddings = embed_texts(texts)
    dimension = embeddings.shape[1]
    index = faiss.IndexFlatL2(dimension)
    index.add(embeddings)
    faiss.write_index(index, FAISS_INDEX_PATH)
    chunked_dataset = [{"text": t} for t in texts]
    with open(CHUNKED_DATASET_PATH, "wb") as f:
        pickle.dump(chunked_dataset, f)
    print("FAISS index and dataset saved.")
    return index, chunked_dataset

# Load or create FAISS index
if os.path.exists(FAISS_INDEX_PATH) and os.path.exists(CHUNKED_DATASET_PATH):
    print("Loading existing FAISS index and dataset...")
    faiss_index = faiss.read_index(FAISS_INDEX_PATH)
    with open(CHUNKED_DATASET_PATH, "rb") as f:
        chunked_dataset = pickle.load(f)
else:
    faiss_index, chunked_dataset = build_faiss_index()

def embed_query(query):
    with torch.no_grad():
        encoded_input = embed_tokenizer(query, return_tensors="pt", truncation=True, padding=True).to(device)
        output = embed_model(**encoded_input)
        token_embeddings = output.last_hidden_state
        attention_mask = encoded_input['attention_mask'].unsqueeze(-1)
        masked = token_embeddings * attention_mask
        summed = masked.sum(dim=1)
        counts = attention_mask.sum(dim=1)
        mean_pooled = summed / counts
    return mean_pooled.cpu().numpy()

def retrieve(query, top_k=3):
    query_embedding = embed_query(query)
    distances, indices = faiss_index.search(query_embedding, top_k)
    return [chunked_dataset[int(idx)]["text"] for idx in indices[0]]

# ----------------------------
# TinyLlama Generation
# ----------------------------
llama_model_name = "TinyLlama/TinyLlama-1.1B-Chat-v1.0"
llama_tokenizer = AutoTokenizer.from_pretrained(llama_model_name)
llama_model = AutoModelForCausalLM.from_pretrained(
    llama_model_name,
    device_map="auto",
    torch_dtype=torch.float16
)

def build_prompt(user_id, query, context_chunks):
    history = user_memory.get(user_id, [])
    history_text = "".join([f"Q: {h['question']}\nA: {h['answer']}\n" for h in history])
    context_text = "\n".join(context_chunks)
    return f"""
You are an IT support assistant. Use context and conversation history to answer clearly.

Conversation History:
{history_text}

Context:
{context_text}

Question:
{query}

Answer:
"""

def generate_answer(prompt, max_new_tokens=200):
    inputs = llama_tokenizer(prompt, return_tensors="pt").to(device)
    with torch.no_grad():
        output = llama_model.generate(
            **inputs,
            max_new_tokens=max_new_tokens,
            do_sample=True,
            temperature=0.7
        )
    answer = llama_tokenizer.decode(output[0], skip_special_tokens=True)
    return answer.replace(prompt, "").strip()

# ----------------------------
# API MODEL
# ----------------------------
class QueryRequest(BaseModel):
    user_id: str
    query: str
    top_k: int = 3

# ----------------------------
# API ENDPOINT
# ----------------------------
@app.post("/chat")
def chat_endpoint(req: QueryRequest):
    if not req.query.strip():
        raise HTTPException(status_code=400, detail="Query cannot be empty.")

    context_chunks = retrieve(req.query, top_k=req.top_k)
    prompt = build_prompt(req.user_id, req.query, context_chunks)
    answer = generate_answer(prompt)
    add_to_memory(req.user_id, req.query, answer)
    tags = classify_multilabel(req.query)

    return {
        "user_id": req.user_id,
        "query": req.query,
        "answer": answer,
        "tags": tags
    }

# ----------------------------
# LOCAL SERVER
# ----------------------------
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("api_rag_llama_autocreate:app", host="0.0.0.0", port=8000, reload=True)
