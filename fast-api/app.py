import torch
import os
from fastapi import FastAPI
from transformers import AutoTokenizer
from huggingface_hub import hf_hub_download

from models import (
    QueryRequest,
    QueryResponse,
    CategoryPrediction,
    UrgencyPrediction
)
from multi_task_model_class import MultiTaskModel
from rag import generate_answer
from memory import get_conversation, add_message

DEVICE = "cuda" if torch.cuda.is_available() else "cpu"

CLASSIFIER_MODEL_ID = "Sandei/tech-support-classifier"
ENCODER_NAME = "distilbert-base-uncased"

tag_classes = ['Email & Communication', 'Classroom/Lab Support', 'Software & Applications', 'Classroom/Lab Support', 'Classroom/Lab Support', 'Network & Connectivity', 'General IT Support', 'Data Management', 'Classroom/Lab Support', 'Security & Compliance']


urgency_encoder = {
    0: "low",
    1: "medium",
    2: "high",
    3: "critical"  # Added 4th level
}

print("Loading tokenizer...")
tokenizer = AutoTokenizer.from_pretrained(CLASSIFIER_MODEL_ID, trust_remote_code=True)

print("Initializing model structure...")
model = MultiTaskModel(
    encoder_name=ENCODER_NAME,
    num_category_labels=len(tag_classes),
    num_urgency_labels=4
)

# Load model weights
print("Downloading model weights...")
try:
    model_path = hf_hub_download(
        repo_id=CLASSIFIER_MODEL_ID,
        filename="pytorch_model.bin",
        token=None,  # Set to your HF token if repo is private
    )
    print(f"✓ Model downloaded to: {model_path}")
    
    print("Loading model weights...")
    state_dict = torch.load(model_path, map_location=DEVICE, weights_only=False)
    model.load_state_dict(state_dict)
    print("✓ Model weights loaded successfully")
    
except Exception as e:
    print(f"✗ Error downloading from Hugging Face: {e}")
    print("\nTrying alternative methods...")
    
    # Method 2: Try loading from cache
    from huggingface_hub import try_to_load_from_cache
    cache_path = try_to_load_from_cache(
        repo_id=CLASSIFIER_MODEL_ID,
        filename="pytorch_model.bin"
    )
    
    if cache_path and os.path.exists(cache_path):
        print(f"✓ Found in cache: {cache_path}")
        state_dict = torch.load(cache_path, map_location=DEVICE, weights_only=False)
        model.load_state_dict(state_dict)
        print("✓ Model loaded from cache")
    else:
        print("\n" + "="*60)
        print("ERROR: Could not load model weights")
        print("="*60)
        print("\nPossible solutions:")
        print("1. Login to Hugging Face:")
        print("   huggingface-cli login")
        print("\n2. Or download manually:")
        print(f"   Visit: https://huggingface.co/{CLASSIFIER_MODEL_ID}/tree/main")
        print(f"   Download 'pytorch_model.bin' to: ./Sandei/tech-support-classifier/")
        print("\n3. Check your internet connection")
        print("="*60)
        raise

model.to(DEVICE)
model.eval()

print(f"\n✓ Model ready on {DEVICE}\n")

app = FastAPI(title="RAG + Conversation Memory API")

# ---------------------
# CLASSIFIER
# ---------------------
def classify_text(text: str, threshold: float = 0.5):
    """
    Classify input text into categories and urgency level.
    """
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True).to(DEVICE)

    with torch.no_grad():
        outputs = model(**inputs)

    # Category predictions (multi-label)
    category_probs = torch.sigmoid(outputs.category_logits)[0].cpu().numpy()

    categories = [
        CategoryPrediction(
            category=tag_classes[i],
            confidence=float(category_probs[i])
        )
        for i in range(len(tag_classes))
        if category_probs[i] >= threshold
    ]

    # Urgency prediction (multi-class)
    urgency_probs = torch.softmax(outputs.urgency_logits, dim=-1)[0].cpu().numpy()
    urgency_idx = int(torch.argmax(outputs.urgency_logits, dim=-1)[0])

    urgency = UrgencyPrediction(
        label=urgency_encoder[urgency_idx],
        confidence=float(urgency_probs[urgency_idx])
    )

    return categories, urgency


def retrieve_documents(query: str):
    """
    Retrieve relevant documents for RAG.
    """
    return [
        "Restarting the router fixes most connectivity issues.",
        "Check for planned ISP maintenance.",
        "Verify cables are securely connected."
    ]


@app.get("/")
def root():
    """Health check endpoint"""
    return {
        "status": "running",
        "device": DEVICE,
        "model": CLASSIFIER_MODEL_ID
    }


@app.post("/query", response_model=QueryResponse)
def query_endpoint(req: QueryRequest):
    """
    Main query endpoint.
    """
    # Load conversation history
    history = get_conversation(req.user_id)

    # Classification
    categories, urgency = classify_text(req.query)

    # RAG
    docs = retrieve_documents(req.query)
    answer = generate_answer(req.query, docs, history)

    # Update conversation memory
    add_message(req.user_id, "user", req.query)
    add_message(req.user_id, "assistant", answer)

    return QueryResponse(
        user_id=req.user_id,
        query=req.query,
        answer=answer,
        categories=categories,
        urgency=urgency,
        conversation=get_conversation(req.user_id)
    )


@app.post("/classify")
def classify_endpoint(req: QueryRequest):
    """
    Standalone classification endpoint.
    """
    categories, urgency = classify_text(req.query)
    
    return {
        "query": req.query,
        "categories": categories,
        "urgency": urgency
    }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)