package sandei.dev.ai_tech_assistant.DTOs.inferenceEngine;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ResponseDto {
   @JsonProperty("input")
    private String input;
    @JsonProperty("tags")
    private List<TagDto> tags;
    @JsonProperty("generated_text")
    private String generatedText;
}
