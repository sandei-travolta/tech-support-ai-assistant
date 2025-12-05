package sandei.dev.ai_tech_assistant.DTOs.inferenceEngine;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Data
public class TagDto {
    private String tag;
    private double probability;
}
