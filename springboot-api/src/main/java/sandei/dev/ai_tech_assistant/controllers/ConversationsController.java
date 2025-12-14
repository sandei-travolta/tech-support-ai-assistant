package sandei.dev.ai_tech_assistant.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;
import sandei.dev.ai_tech_assistant.services.messaging.MessagingService;

import java.util.List;

@RestController
@RequestMapping("/messaging")
public class ConversationsController {
    private final MessagingService messagingService;


    public ConversationsController(MessagingService messagingService) {
        this.messagingService = messagingService;
    }
    @GetMapping("/conversations")
    ResponseEntity<List<MessagingEntity>> fetchConversations(){
        return ResponseEntity.ok().body(messagingService.fetchConversations());
    }
    @GetMapping("/messages")
    ResponseEntity<List<MessagingEntity>> fetchAllMessages(){
        return  ResponseEntity.ok().body(messagingService.fetchMessages());
    }
    @GetMapping("/messages/{sender}")
    ResponseEntity<List<MessagingEntity>> fetchMessages(@RequestParam String sender){
        return ResponseEntity.ok().body(messagingService.fetchConversationMessages(sender));
    }
}
