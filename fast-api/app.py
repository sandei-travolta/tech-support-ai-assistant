import torch
from fastapi import FastAPI
from transformers import AutoTokenizer, AutoModelForSequenceClassification, AutoConfig

from models import (
    QueryRequest,
    QueryResponse,
    CategoryPrediction,
    UrgencyPrediction
)
from rag import generate_answer
from memory import get_conversation, add_message

DEVICE = "cuda" if torch.cuda.is_available() else "cpu"

CLASSIFIER_MODEL_ID = "your-org/your-multitask-model"

tag_classes = [
    "Billing",
    "Network & Connectivity",
    "Account Access",
    "Hardware",
    "Other"
]

urgency_encoder = {
    0: "low",
    1: "medium",
    2: "high"
}

tokenizer = AutoTokenizer.from_pretrained(CLASSIFIER_MODEL_ID)
config = AutoConfig.from_pretrained(CLASSIFIER_MODEL_ID)

model = AutoModelForSequenceClassification.from_pretrained(
    CLASSIFIER_MODEL_ID,
    config=config,
    trust_remote_code=True
).to(DEVICE)

model.eval()

app = FastAPI(title="RAG + Conversation Memory API")

# ---------------------
# CLASSIFIER
# ---------------------
def classify_text(text: str, threshold: float = 0.5):
    inputs = tokenizer(text, return_tensors="pt", truncation=True).to(DEVICE)

    with torch.no_grad():
        outputs = model(**inputs)

    category_probs = torch.sigmoid(outputs.category_logits)[0].cpu().numpy()

    categories = [
        CategoryPrediction(
            category=tag_classes[i],
            confidence=float(category_probs[i])
        )
        for i in range(len(tag_classes))
        if category_probs[i] >= threshold
    ]

    urgency_probs = torch.softmax(outputs.urgency_logits, dim=-1)[0].cpu().numpy()
    urgency_idx = int(torch.argmax(outputs.urgency_logits, dim=-1)[0])

    urgency = UrgencyPrediction(
        label=urgency_encoder[urgency_idx],
        confidence=float(urgency_probs[urgency_idx])
    )

    return categories, urgency


def retrieve_documents(query: str):
    return [
        "Restarting the router fixes most connectivity issues.",
        "Check for planned ISP maintenance.",
        "Verify cables are securely connected."
    ]


@app.post("/query", response_model=QueryResponse)
def query_endpoint(req: QueryRequest):
    # ---- Load conversation
    history = get_conversation(req.user_id)

    # ---- Classification
    categories, urgency = classify_text(req.query)

    # ---- RAG
    docs = retrieve_documents(req.query)
    answer = generate_answer(req.query, docs, history)

    # ---- Update memory
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
