import numpy as np

class VectorStoreService:
    def __init__(self, embeddings, documents):
        self.embeddings = np.array(embeddings)
        self.documents = documents

    def search(self, query_embedding, top_k: int = 3):
        query = np.array(query_embedding)
        scores = np.dot(self.embeddings, query)
        top_idx = scores.argsort()[-top_k:][::-1]
        return [self.documents[i] for i in top_idx]
