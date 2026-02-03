import csv
from pathlib import Path

class CSVDataLoader:
    def __init__(self, filename: str):
        self.path = Path(filename)

    def load_qa_pairs(self) -> list[str]:
        documents = []

        with self.path.open(encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                q = row.get("question", "").strip()
                a = row.get("answer", "").strip()

                if q and a:
                    documents.append(f"Question: {q}\nAnswer: {a}")

        return documents
