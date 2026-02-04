package sandei.dev.ai_tech_assistant.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sandei.dev.ai_tech_assistant.dTOs.authentication.LoginRequestDto;

@RestController
@RequestMapping("/auth")
public class AuthenticationContoller {
    @PostMapping("/login")
    public ResponseEntity<Integer> login(LoginRequestDto requestDto){
        return ResponseEntity.ok(1);
    }
}
