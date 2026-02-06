package sandei.dev.ai_tech_assistant.dTOs.inferenceEngine;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Data
public class UrgencyDto {
    @JsonProperty("label")
    private String urgency;
    @JsonProperty("confidence")
    private  double confidence;
}
