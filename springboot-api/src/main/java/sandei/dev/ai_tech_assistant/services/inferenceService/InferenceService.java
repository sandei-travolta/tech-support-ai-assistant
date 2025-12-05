package sandei.dev.ai_tech_assistant.services.inferenceService;

import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.*;
import sandei.dev.ai_tech_assistant.DTOs.inferenceEngine.Message;
import sandei.dev.ai_tech_assistant.DTOs.inferenceEngine.ResponseDto;

public class InferenceService {
    OkHttpClient client =new OkHttpClient();
    MediaType JSON = MediaType.get("application/json; charset=utf-8");
    private final ObjectMapper mapper = new ObjectMapper();

    public ResponseDto makeInference(Message message)throws Exception{
        String json=mapper.writeValueAsString(message);
        RequestBody body =RequestBody.create(json,MediaType.parse("application/json"));
        Request httpRequest =new Request.Builder()
                .url("")
                .post(body)
                .build();
        Response response=client.newCall(httpRequest).execute();
        String responseJson=response.body().toString();
        return  mapper.readValue(responseJson,ResponseDto.class);
    }
}
