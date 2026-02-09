package sandei.dev.ai_tech_assistant.config;

import com.twilio.Twilio;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TwilioConfig {

    private static final Logger log = LoggerFactory.getLogger(TwilioConfig.class);


    private String accountSid="AC36b2da151328a87308a7370a1c12d8e5";


    private String authToken="55ec426fc4d1dd4d592856607a232a9b";

    @PostConstruct
    public void initTwilio() {
        log.info("Initializing Twilio with Account SID: {}", accountSid);
        Twilio.init(accountSid, authToken);
        log.info("Twilio initialized successfully");
    }
}