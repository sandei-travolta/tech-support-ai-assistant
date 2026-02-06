package sandei.dev.ai_tech_assistant.config;

import org.springframework.beans.factory.annotation.Value;

import org.springframework.stereotype.Component;

@Component
public class Constants {

    @Value("${url}")
    private String apiUrl;

    public String getApiUrl() {
        return apiUrl;
    }
}
