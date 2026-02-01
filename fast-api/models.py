from pydantic import BaseModel
from typing import List


class QueryRequest(BaseModel):
    user_id: str
    query: str


class CategoryPrediction(BaseModel):
    category: str
    confidence: float


class UrgencyPrediction(BaseModel):
    label: str
    confidence: float


class Message(BaseModel):
    role: str
    content: str


class QueryResponse(BaseModel):
    user_id: str
    query: str
    answer: str
    categories: List[CategoryPrediction]
    urgency: UrgencyPrediction
    conversation: List[Message]
