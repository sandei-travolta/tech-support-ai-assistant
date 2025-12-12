package sandei.dev.ai_tech_assistant.repositories.authentication;

import org.springframework.data.jpa.repository.JpaRepository;
import sandei.dev.ai_tech_assistant.entities.authentication.AuthenticationEntity;

import java.util.Optional;
import java.util.UUID;

public interface AuthenticationRepository extends JpaRepository<AuthenticationEntity, UUID> {
    Optional<AuthenticationEntity> findByEmail(String email);
}
