package sandei.dev.ai_tech_assistant.services.twilo;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.twiml.MessagingResponse;
import com.twilio.twiml.messaging.Body;
import lombok.AllArgsConstructor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import sandei.dev.ai_tech_assistant.dTOs.inferenceEngine.MessageDto;
import sandei.dev.ai_tech_assistant.dTOs.inferenceEngine.ResponseDto;
import sandei.dev.ai_tech_assistant.dTOs.inferenceEngine.TagDto;
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
    @Async
    public void processMessageAsync(String from, String body) {
        try {
            System.out.println("Started");
            // Make inference
            ResponseDto response = inferenceService.makeInference(new MessageDto(body, from));

            // Extract phone number
            String phoneNumber = from.split(":")[1];

            // Save to database
            saveResponse(phoneNumber, body, response);

            // Send actual response via Twilio API
            sendResponseViaTwilio(from, response.getGeneratedText());


        } catch (Exception e) {
            System.out.println(e);
        }
    }
    private void sendResponseViaTwilio(String to, String messageBody) {
        try {
            Message.creator(
                    new com.twilio.type.PhoneNumber(to),
                    new com.twilio.type.PhoneNumber("whatsapp:+14155238886"), // Your Twilio number
                    messageBody
            ).create();

        } catch (Exception e) {
            throw e;
        }
    }
    void saveResponse(String from,String message,ResponseDto response){
        MessagingEntity messagingEntity=new MessagingEntity();
        messagingEntity.setMessage(message);
        messagingEntity.setSender(from);
        messagingEntity.setResponse(response.getGeneratedText());
        messagingEntity.setTimestamp(Timestamp.from(Instant.now()));
        String tag = response.getTags().stream()
                .findFirst()
                .map(TagDto::getCategory)
                .orElse("");
        messagingEntity.setTags(tag);

        double confidenceScore = response.getTags().stream()
                .findFirst()
                .map(TagDto::getProbability)
                .orElse(0.0);
        messagingEntity.setConfidenceScore(confidenceScore);
        messagingEntity.setUrgency(response.getUrgency().getUrgency());
        messagingService.saveMessage(messagingEntity);
    }
}
