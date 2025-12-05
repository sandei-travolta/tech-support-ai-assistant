package sandei.dev.ai_tech_assistant.services.Twilo;

import org.springframework.stereotype.Service;

@Service
public class TwiloService {
    public void receiveMessage(String from, String body){
     System.out.println("Body:"+body+"from:"+from);
    }
}
