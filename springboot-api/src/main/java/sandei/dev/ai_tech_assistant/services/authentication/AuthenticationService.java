package sandei.dev.ai_tech_assistant.services.authentication;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import sandei.dev.ai_tech_assistant.dTOs.authentication.LoginRequestDto;
import sandei.dev.ai_tech_assistant.entities.authentication.AuthenticationEntity;
import sandei.dev.ai_tech_assistant.repositories.authentication.AuthenticationRepository;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationRepository authenticationRepository;
    public UUID login(LoginRequestDto loginRequest){
        return authenticationRepository.findByEmail(loginRequest.getEmail())
                .filter(auth->passwordEncoder.matches(loginRequest.getPassword(),auth.getPassword()))
                .map(AuthenticationEntity::getUuid)
                .orElse(null);
    }
}
