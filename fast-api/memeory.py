from collections import defaultdict, deque

MAX_TURNS = 6  # last N messages per user

conversation_store = defaultdict(
    lambda: deque(maxlen=MAX_TURNS)
)


def get_conversation(user_id: str):
    return list(conversation_store[user_id])


def add_message(user_id: str, role: str, content: str):
    conversation_store[user_id].append(
        {"role": role, "content": content}
    )
