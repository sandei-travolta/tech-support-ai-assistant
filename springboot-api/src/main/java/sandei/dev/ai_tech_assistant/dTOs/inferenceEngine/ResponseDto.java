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
   @JsonProperty("query")
    private String input;
    @JsonProperty("categories")
    private List<TagDto> tags;
    @JsonProperty("urgency")
    private  UrgencyDto urgency;
    @JsonProperty("answer")
    private String generatedText;
    @JsonProperty("user_id")
    private String userId;

}
