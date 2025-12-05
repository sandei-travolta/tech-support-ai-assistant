package sandei.dev.ai_tech_assistant.DTOs.inferenceEngine;

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
    private String input;
    private List<TagDto> tags;
    private String generatedText;
}
