def generate_answer(query: str, retrieved_docs: list[str], history: list[dict]) -> str:
    history_text = "\n".join(
        f"{m['role']}: {m['content']}" for m in history
    )

    context = "\n".join(retrieved_docs[:3])

    return f"""
Conversation so far:
{history_text}

Knowledge base:
{context}

Answer:
We have received your request regarding "{query}".
Our support team will assist you shortly.
""".strip()
