package sandei.dev.ai_tech_assistant.config;

import okhttp3.OkHttpClient;
import org.springframework.stereotype.Service;

@Service
public class HttpClientService {
    private final OkHttpClient client=new OkHttpClient();
    public OkHttpClient getClient(){
        return client;
    }
}
