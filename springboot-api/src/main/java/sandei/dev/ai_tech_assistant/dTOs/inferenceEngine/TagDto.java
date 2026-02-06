package sandei.dev.ai_tech_assistant.dTOs.inferenceEngine;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Data
public class TagDto {
    private String category;
    @JsonProperty("confidence")
    private double probability;
}
