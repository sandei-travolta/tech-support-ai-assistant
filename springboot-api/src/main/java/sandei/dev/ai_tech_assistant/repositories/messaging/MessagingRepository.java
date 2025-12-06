package sandei.dev.ai_tech_assistant.repositories.messaging;

import org.springframework.data.jpa.repository.JpaRepository;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;

public interface MessagingRepository extends JpaRepository<MessagingEntity, Integer> {

}
