package sandei.dev.ai_tech_assistant.services.messaging;

import lombok.AllArgsConstructor;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;
import sandei.dev.ai_tech_assistant.repositories.messaging.MessagingRepository;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
public class MessagingService {
    private final MessagingRepository messagingRepository;
    public void saveMessage(MessagingEntity message){
        messagingRepository.save(message);
    }
    public List<MessagingEntity> fetchConversations(){
        return messagingRepository.findLatestMessagePerSender();
    }
    public List<MessagingEntity> fetchConversationMessages(String sender){
        return messagingRepository.findBySenderOrderByTimestampDesc(sender);
    }
}
