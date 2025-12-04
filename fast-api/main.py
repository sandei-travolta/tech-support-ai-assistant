from fastapi import FastAPI
from pydantic import BaseModel
from transformers import (
    AutoTokenizer,
    AutoModelForSequenceClassification,
    AutoModelForSeq2SeqLM,
    pipeline
)
import torch
import json

app = FastAPI()

# ----------------------------
# CONFIG
# ----------------------------
CLASSIFIER_MODEL_ID = "Sandei/tech-support-classifier"
GENERATION_MODEL_ID = "Sandei/tech_support_flan"

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
# LOAD FLAN-T5 (Seq2Seq)
# ----------------------------
gen_tokenizer = AutoTokenizer.from_pretrained(GENERATION_MODEL_ID)
gen_model = AutoModelForSeq2SeqLM.from_pretrained(GENERATION_MODEL_ID)

gen_pipe = pipeline(
    "text2text-generation",
    model=gen_model,
    tokenizer=gen_tokenizer,
    device=0 if torch.cuda.is_available() else -1
)

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

    # 2️⃣ Generation
    generated = gen_pipe(
        text,
        max_new_tokens=150,
        temperature=0.7,
        top_p=0.95,
        do_sample=True
    )[0]["generated_text"]

    return {
        "input": text,
        "tags": tags,
        "generated_text": generated
    }


