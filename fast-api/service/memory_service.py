memory_store: dict[str, list[str]] = {}

def get_memory(session_id: str) -> str:
    return "\n".join(memory_store.get(session_id, []))

def save_memory(session_id: str, user: str, assistant: str):
    if session_id not in memory_store:
        memory_store[session_id] = []

    memory_store[session_id].append(f"User: {user}")
    memory_store[session_id].append(f"Assistant: {assistant}")
