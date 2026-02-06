package sandei.dev.ai_tech_assistant.dTOs.inferenceEngine;

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
    @JsonProperty("categories")
    private List<TagDto> tags;
    @JsonProperty("urgency")
    private  UrgencyDto urgency;
    @JsonProperty("generated_text")
    private String generatedText;

}
