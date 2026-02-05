package sandei.dev.ai_tech_assistant.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sandei.dev.ai_tech_assistant.dTOs.authentication.LoginRequestDto;
import sandei.dev.ai_tech_assistant.dTOs.authentication.RegisterRequestDto;
import sandei.dev.ai_tech_assistant.services.authentication.AuthenticationService;
import sandei.dev.ai_tech_assistant.utils.JwtUtil;

@RestController
@RequestMapping("/auth")
public class AuthenticationContoller {
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private AuthenticationService authenticationService;
    @PostMapping("/login")
    public ResponseEntity<String> login(LoginRequestDto requestDto){

        if(authenticationService.login(requestDto).equals(null)){
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
        return ResponseEntity.ok(jwtUtil.generateToken(authenticationService.login(requestDto)));
    }
    @PostMapping("/register")
    public ResponseEntity<String> login(RegisterRequestDto requestDto){
        if(authenticationService.registerUser(requestDto)){
            return ResponseEntity.ok("success");
        }
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).build();
    }
}
