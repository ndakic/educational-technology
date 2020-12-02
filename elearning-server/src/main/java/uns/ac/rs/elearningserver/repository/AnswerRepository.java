package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.AnswerEntity;
import uns.ac.rs.elearningserver.model.StatusEntity;

import java.util.Optional;

@Repository
public interface AnswerRepository extends JpaRepository<AnswerEntity, Long> {

    Optional<AnswerEntity> findOneByMd5H(String answerId);

    Optional<AnswerEntity> findOneByQuestion_Md5HAndTextAndStatus_Id(String questionId, String text, long statusId);
}
