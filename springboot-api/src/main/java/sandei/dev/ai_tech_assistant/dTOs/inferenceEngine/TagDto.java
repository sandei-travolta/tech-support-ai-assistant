package sandei.dev.ai_tech_assistant.dTOs.inferenceEngine;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Data
public class TagDto {
    private String tag;
    private double probability;
}
