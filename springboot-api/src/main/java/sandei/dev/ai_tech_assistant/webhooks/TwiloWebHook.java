package sandei.dev.ai_tech_assistant.webhooks;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sandei.dev.ai_tech_assistant.services.Twilo.TwiloService;

@RestController
@RequestMapping("/webhook")
public class TwiloWebHook {

    private final TwiloService twiloService;

    public TwiloWebHook(TwiloService twiloService) {
        this.twiloService = twiloService;
    }
    @PostMapping(value = "/message",consumes = "application/x-www-form-urlencoded" )
    public ResponseEntity<String> twiloEndpoint(
            @RequestParam("From") String from,
            @RequestParam("Body") String body) throws Exception {
        return ResponseEntity.ok()
                .header("Content-Type", "application/xml")
                .body(twiloService.receiveMessage(from,body));
    }
}
