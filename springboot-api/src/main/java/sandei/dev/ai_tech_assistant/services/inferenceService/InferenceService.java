package sandei.dev.ai_tech_assistant.services.inferenceService;

import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import org.springframework.stereotype.Service;
import sandei.dev.ai_tech_assistant.dTOs.inferenceEngine.MessageDto;
import sandei.dev.ai_tech_assistant.dTOs.inferenceEngine.ResponseDto;
import sandei.dev.ai_tech_assistant.config.Constants;
@Service
public class InferenceService {
    OkHttpClient client = new OkHttpClient.Builder()
            .connectTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
            .writeTimeout(60, java.util.concurrent.TimeUnit.SECONDS)
            .readTimeout(60, java.util.concurrent.TimeUnit.SECONDS)
            .build();

    MediaType JSON = MediaType.get("application/json; charset=utf-8");
    private final ObjectMapper mapper = new ObjectMapper();

    public ResponseDto makeInference(MessageDto message)throws Exception{
        String json=mapper.writeValueAsString(message);
        RequestBody body =RequestBody.create(json,MediaType.parse("application/json"));
        Request httpRequest =new Request.Builder()
                .url(Constants.API_URL+"process")
                .post(body)
                .build();
        Response response=client.newCall(httpRequest).execute();
        String responseJson=response.body().string();
        System.out.println(responseJson);
        return  mapper.readValue(responseJson,ResponseDto.class);
    }
}
