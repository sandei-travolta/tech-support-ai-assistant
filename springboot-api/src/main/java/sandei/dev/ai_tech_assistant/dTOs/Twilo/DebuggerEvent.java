package sandei.dev.ai_tech_assistant.dTOs.Twilo;

import com.fasterxml.jackson.databind.JsonNode;

import java.time.Instant;

public  class DebuggerEvent {
    private String AccountSid;
    private String Sid;
    private String ParentAccountSid;
    private Instant Timestamp;
    private String Level;
    private String PayloadType;
    private JsonNode Payload;

    // Getters and Setters
    public String getAccountSid() {
        return AccountSid;
    }

    public void setAccountSid(String accountSid) {
        AccountSid = accountSid;
    }

    public String getSid() {
        return Sid;
    }

    public void setSid(String sid) {
        Sid = sid;
    }

    public String getParentAccountSid() {
        return ParentAccountSid;
    }

    public void setParentAccountSid(String parentAccountSid) {
        ParentAccountSid = parentAccountSid;
    }

    public Instant getTimestamp() {
        return Timestamp;
    }

    public void setTimestamp(Instant timestamp) {
        Timestamp = timestamp;
    }

    public String getLevel() {
        return Level;
    }

    public void setLevel(String level) {
        Level = level;
    }

    public String getPayloadType() {
        return PayloadType;
    }

    public void setPayloadType(String payloadType) {
        PayloadType = payloadType;
    }

    public JsonNode getPayload() {
        return Payload;
    }

    public void setPayload(JsonNode payload) {
        Payload = payload;
    }
}