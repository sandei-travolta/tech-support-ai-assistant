package sandei.dev.ai_tech_assistant.dTOs.authentication;

public class RegisterRequestDto extends LoginRequestDto{

    public RegisterRequestDto(String email, String password) {
        super(email, password);
    }
}
