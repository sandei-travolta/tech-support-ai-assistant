
from service.data_loader_service import CSVDataLoader
from service.embedded_service import EmbeddingService
from service.vector_store_service import VectorStoreService
from service.llm_service import LLMService
from service.memory_service import get_memory, save_memory


# Initialize once
embedder = EmbeddingService()
llm = LLMService()

loader = CSVDataLoader("final_data_set(in).csv")
documents = loader.load_qa_pairs()

doc_embeddings = embedder.embed(documents)
vector_store = VectorStoreService(doc_embeddings, documents)


def generate_answer(question: str, session_id: str) -> str:
    query_embedding = embedder.embed([question])[0]
    context = vector_store.search(query_embedding)

    memory = get_memory(session_id)

    prompt = f"""
    <|system|>
    You are a helpful assistant.
    Answer ONLY using the provided context.
    Give a COMPLETE, well-formed answer.
    Do not stop mid-sentence.
    If the answer is not in the context, say "I don't know".

    Conversation memory:
    {memory}

    <|user|>
    Context:
    {chr(10).join(context)}

    Question:
    {question}

    <|assistant|>
    """


    answer = llm.generate(prompt)

    # ✅ Hard safety fallback
    if not answer:
        answer = context[0].split("Answer:", 1)[-1].strip()

    save_memory(session_id, question, answer)
    return answer
