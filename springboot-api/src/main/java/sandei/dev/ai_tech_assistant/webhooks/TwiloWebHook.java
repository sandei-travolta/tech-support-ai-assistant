package sandei.dev.ai_tech_assistant.webhooks;

import org.springframework.beans.factory.annotation.Autowired;
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
    void twiloEndpoint(
            @RequestParam("From") String from,
            @RequestParam("Body") String body){
        twiloService.receiveMessage(from,body);
    }
}
