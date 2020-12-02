package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.AnswerHistory;

import java.util.Optional;

@Repository

public interface AnswerHistoryRepository extends JpaRepository<AnswerHistory, Long> {

    Optional<AnswerHistory> findOneByAnswer_Md5HAndQuestion_Md5HAndTest_Md5H(String answerId, String questionId, String testId);
}
