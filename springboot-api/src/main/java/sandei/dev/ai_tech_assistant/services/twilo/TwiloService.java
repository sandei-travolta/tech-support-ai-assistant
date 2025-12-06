package sandei.dev.ai_tech_assistant.services.twilo;

import com.twilio.twiml.MessagingResponse;
import com.twilio.twiml.messaging.Body;
import com.twilio.twiml.messaging.Message;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import sandei.dev.ai_tech_assistant.dTOs.inferenceEngine.MessageDto;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;
import sandei.dev.ai_tech_assistant.services.inferenceService.InferenceService;
import sandei.dev.ai_tech_assistant.services.messaging.MessagingService;

import java.sql.Timestamp;
import java.time.Instant;

@AllArgsConstructor
@Service
public class TwiloService {
    private final InferenceService inferenceService;
    private final MessagingService messagingService;
    public String receiveMessage(String from, String body) throws Exception {
    String message= inferenceService.makeInference(new MessageDto(body)).getGeneratedText();

     System.out.println("Body:"+body+"from:"+from);
        saveResponse(from,message);
        return sendResponse(message);
    }
    String sendResponse(String message){
        Body body=new Body.Builder(message).build();
        Message twimlMessage = new Message.Builder().body(body).build();
        MessagingResponse response=new MessagingResponse.Builder()
                .message(twimlMessage)
                .build();

        return response.toXml();
    }
    void saveResponse(String from,String message){
        MessagingEntity messagingEntity=new MessagingEntity();
        messagingEntity.setMessage(message);
        messagingEntity.setSender(from);
        messagingEntity.setTimestamp(Timestamp.from(Instant.now()));
        messagingService.saveMessage(messagingEntity);
    }

}
