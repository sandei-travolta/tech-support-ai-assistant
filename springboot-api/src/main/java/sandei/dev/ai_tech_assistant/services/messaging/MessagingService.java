package sandei.dev.ai_tech_assistant.services.messaging;

import lombok.AllArgsConstructor;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;
import sandei.dev.ai_tech_assistant.repositories.messaging.MessagingRepository;

@AllArgsConstructor
public class MessagingService {
    private final MessagingRepository messagingRepository;
    public void saveMessage(MessagingEntity message){
        messagingRepository.save(message);
    }
}
