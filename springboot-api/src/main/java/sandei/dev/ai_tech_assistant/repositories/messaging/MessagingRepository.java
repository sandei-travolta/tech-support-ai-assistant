package sandei.dev.ai_tech_assistant.repositories.messaging;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import sandei.dev.ai_tech_assistant.entities.messaging.MessagingEntity;

import java.util.List;

public interface MessagingRepository extends JpaRepository<MessagingEntity, Integer> {
    @Query("""
    SELECT m FROM Message m
    WHERE m.timestamp IN (
        SELECT MAX(m2.timestamp)
        FROM Message m2
        GROUP BY m2.senderId
    )
    ORDER BY m.timestamp DESC
""")
    List<MessagingEntity> findLatestMessagePerSender();

    List<MessagingEntity> findBySenderOrderByTimestampDesc(String sender);

}
