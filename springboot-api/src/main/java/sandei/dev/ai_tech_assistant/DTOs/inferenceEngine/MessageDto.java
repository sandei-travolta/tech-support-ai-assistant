package sandei.dev.ai_tech_assistant.DTOs.inferenceEngine;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor  // <-- this generates a constructor with a String argument
public class MessageDto {
    private String message;
}
