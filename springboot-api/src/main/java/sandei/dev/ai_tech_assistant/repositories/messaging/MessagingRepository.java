package sandei.dev.ai_tech_assistant.repositories.messaging;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;

import java.util.List;

public interface MessagingRepository extends JpaRepository<MessagingEntity, Integer> {
    @Query("""
    SELECT m
    FROM message m
    WHERE m.timestamp = (
        SELECT MAX(m2.timestamp)
        FROM message m2
        WHERE m2.sender = m.sender
    )
    ORDER BY m.timestamp DESC
""")
    List<MessagingEntity> findLatestMessagesPerSender();


    List<MessagingEntity> findBySenderOrderByTimestampDesc(String sender);
    List<MessagingEntity> findAllByOrderByTimestampDesc();
}
