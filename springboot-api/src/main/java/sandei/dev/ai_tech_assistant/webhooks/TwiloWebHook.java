package sandei.dev.ai_tech_assistant.webhooks;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sandei.dev.ai_tech_assistant.dTOs.Twilo.DebuggerEvent;
import sandei.dev.ai_tech_assistant.services.twilo.TwiloService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

        twiloService.processMessageAsync(from, body);

        // Return empty 200 OK immediately
        return ResponseEntity.ok().build();
    }
    private static final Logger log = LoggerFactory.getLogger(TwiloWebHook.class);

    @PostMapping("/debugger-events")
    public ResponseEntity<String> handleDebuggerEvent(@RequestBody DebuggerEvent event) {
        log.info("Received Twilio Debugger Event:");
        log.info("  AccountSid: {}", event.getAccountSid());
        log.info("  Sid: {}", event.getSid());
        log.info("  ParentAccountSid: {}", event.getParentAccountSid());
        log.info("  Timestamp: {}", event.getTimestamp());
        log.info("  Level: {}", event.getLevel());
        log.info("  PayloadType: {}", event.getPayloadType());
        log.info("  Payload: {}", event.getPayload());

        if ("Error".equalsIgnoreCase(event.getLevel())) {
            log.error("ERROR level Debugger event detected - Sid: {}, Timestamp: {}",
                    event.getSid(), event.getTimestamp());
        } else if ("Warning".equalsIgnoreCase(event.getLevel())) {
            log.warn("WARNING level Debugger event detected - Sid: {}, Timestamp: {}",
                    event.getSid(), event.getTimestamp());
        }

        return ResponseEntity.ok("Event received and logged");
    }
}
