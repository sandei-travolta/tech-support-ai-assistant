from fastapi import FastAPI
from pydantic import BaseModel
from transformers import (
    AutoTokenizer,
    AutoModelForSequenceClassification,
)
import torch
import json
from google import genai
from dotenv import load_dotenv
import os


load_dotenv()

# Access the API key


app = FastAPI()

# ----------------------------
# CONFIG
# ----------------------------
CLASSIFIER_MODEL_ID = "Sandei/tech-support-classifier"
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")


# ----------------------------
# LOAD CLASSIFIER (MULTI-LABEL)
# ----------------------------
clf_tokenizer = AutoTokenizer.from_pretrained(CLASSIFIER_MODEL_ID)
clf_model = AutoModelForSequenceClassification.from_pretrained(CLASSIFIER_MODEL_ID)

# Load tag mapping from HuggingFace repo
tag_mapping_file = clf_tokenizer.vocab_files_names.get("tag_mapping")
try:
    import huggingface_hub
    tag_json = huggingface_hub.hf_hub_download(CLASSIFIER_MODEL_ID, "tag_mapping.json")
    with open(tag_json, "r") as f:
        tag_classes = json.load(f)
except:
    tag_classes = []

device = "cuda" if torch.cuda.is_available() else "cpu"
clf_model.to(device)

def classify_multilabel(text):
    inputs = clf_tokenizer(text, return_tensors="pt", truncation=True).to(device)
    with torch.no_grad():
        logits = clf_model(**inputs).logits
        probs = logits.sigmoid().cpu().numpy()[0]

    result = []
    for i, p in enumerate(probs):
        if p > 0.5:
            result.append({"tag": tag_classes[i], "probability": float(p)})

    return result

# ----------------------------
# INITIALIZE GEMINI CLIENT
# ----------------------------
gemini_client = genai.Client(api_key=GEMINI_API_KEY)

def generate_with_gemini(text: str) -> str:
    """Generate response using Gemini, directing the model to limit output to 1600 characters."""
    
    prompt = f"Take the role of a IT help support desk assistant.keep the responses clear {text}\n\nPlease limit your response to **1600 characters or less**."
    
    response = gemini_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt
    )
    
    return response.text


# ----------------------------
# API MODEL
# ----------------------------
class Message(BaseModel):
    message: str

# ----------------------------
# ENDPOINT
# ----------------------------
@app.post("/process")
def process_message(req: Message):
    text = req.message

    # 1️⃣ Classification
    tags = classify_multilabel(text)

    # 2️⃣ Generation with Gemini
    generated = generate_with_gemini(text)

    return {
        "input": text,
        "tags": tags,
        "generated_text": generated
    }