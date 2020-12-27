package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.AnswerHistory;

import java.util.List;
import java.util.Optional;

@Repository

public interface AnswerHistoryRepository extends JpaRepository<AnswerHistory, Long> {

    Optional<AnswerHistory> findOneByAnswer_Md5HAndQuestion_Md5HAndTest_Md5H(String answerId, String questionId, String testId);

    @Query(value = "SELECT DISTINCT ah.question.id FROM AnswerHistory ah" +
            "       WHERE ah.test.md5H = :testMd5h" +
            "       ORDER BY ah.question.id")
    List<Long> findAllQuestionsByTest_Md5H(String testMd5h);

    @Query(value = "SELECT ah FROM AnswerHistory ah" +
            "       WHERE ah.question.id = :questionId" +
            "       ORDER BY ah.user.id")
    List<AnswerHistory> findAllAnswersPerQuestion(Long questionId);

}
