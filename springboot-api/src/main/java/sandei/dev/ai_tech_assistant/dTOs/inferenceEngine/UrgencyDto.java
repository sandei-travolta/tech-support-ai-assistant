package sandei.dev.ai_tech_assistant.dTOs.inferenceEngine;

import lombok.Data;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Data
public class UrgencyDto {
    private String urgency;
    private  double confidence;
}
