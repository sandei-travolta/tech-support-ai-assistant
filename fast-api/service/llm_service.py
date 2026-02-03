import torch
from transformers import AutoTokenizer, AutoModelForCausalLM

class LLMService:
    def __init__(self):
        self.tokenizer = AutoTokenizer.from_pretrained(
            "TinyLlama/TinyLlama-1.1B-Chat-v1.0"
        )
        self.model = AutoModelForCausalLM.from_pretrained(
            "TinyLlama/TinyLlama-1.1B-Chat-v1.0",
            torch_dtype=torch.float16,
            device_map="auto"
        )

    def generate(self, prompt: str) -> str:
        inputs = self.tokenizer(prompt, return_tensors="pt").to(self.model.device)

        output = self.model.generate(
            **inputs,
            max_new_tokens=256,
            do_sample=True,
            temperature=0.7,
            top_p=0.9,
            eos_token_id=self.tokenizer.eos_token_id
        )

        text = self.tokenizer.decode(output[0], skip_special_tokens=False)
        return self._clean(text)

    def _clean(self, text: str) -> str:
        # ✅ Extract content AFTER <|assistant|>
        if "<|assistant|>" in text:
            text = text.split("<|assistant|>")[-1]

        # Stop if model continues roles
        for stop in ["<|system|>", "<|user|>"]:
            if stop in text:
                text = text.split(stop)[0]

        return text.strip()
