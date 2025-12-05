package sandei.dev.ai_tech_assistant.services.Twilo;

import com.twilio.twiml.MessagingResponse;
import com.twilio.twiml.messaging.Body;
import com.twilio.twiml.messaging.Message;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import sandei.dev.ai_tech_assistant.DTOs.inferenceEngine.MessageDto;
import sandei.dev.ai_tech_assistant.services.inferenceService.InferenceService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

@AllArgsConstructor
@Service
public class TwiloService {
    private final InferenceService inferenceService;
    public String receiveMessage(String from, String body) throws Exception {
    String message= inferenceService.makeInference(new MessageDto(body)).getGeneratedText();

     System.out.println("Body:"+body+"from:"+from);
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



}
