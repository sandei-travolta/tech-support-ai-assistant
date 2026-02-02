import torch.nn as nn
from transformers import AutoModel


class MultiTaskModel(nn.Module):
    def __init__(self, encoder_name, num_category_labels, num_urgency_labels):
        super().__init__()

        self.encoder = AutoModel.from_pretrained(encoder_name)
        hidden_size = self.encoder.config.hidden_size

        # Changed from category_head to category_classifier
        self.category_classifier = nn.Linear(hidden_size, num_category_labels)
        # Changed from urgency_head to urgency_classifier
        self.urgency_classifier = nn.Linear(hidden_size, num_urgency_labels)

    def forward(self, input_ids, attention_mask):
        outputs = self.encoder(
            input_ids=input_ids,
            attention_mask=attention_mask
        )

        pooled = outputs.last_hidden_state[:, 0]

        return type(
            "Output",
            (),
            {
                "category_logits": self.category_classifier(pooled),
                "urgency_logits": self.urgency_classifier(pooled),
            }
        )()