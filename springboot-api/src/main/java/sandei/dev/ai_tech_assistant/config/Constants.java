package sandei.dev.ai_tech_assistant.config;

import org.springframework.beans.factory.annotation.Value;

public class Constants {
    @Value("${url}")
    static public String API_URL;
}
