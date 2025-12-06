package sandei.dev.ai_tech_assistant.entities.messaging;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity(name = "message")
@Getter
@Setter
@NoArgsConstructor
public class MessagingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(unique = true)
    private String sender;
    private String message;
    private String response;
    private Timestamp timestamp;

}
