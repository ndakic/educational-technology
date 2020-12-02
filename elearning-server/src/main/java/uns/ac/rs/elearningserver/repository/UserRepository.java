package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.constant.UserType;
import uns.ac.rs.elearningserver.model.UserEntity;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    Optional<UserEntity> findOneByMd5H(String userId);

    Optional<UserEntity> findOneByMd5HAndUserType(String userId, UserType userType);
}
