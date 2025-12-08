package sandei.dev.ai_tech_assistant.dTOs.authentication;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class LoginRequestDto {
    private String email;
    private String password;
}
