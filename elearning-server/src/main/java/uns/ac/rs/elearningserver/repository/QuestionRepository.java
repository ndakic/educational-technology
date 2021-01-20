package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.QuestionEntity;

import java.util.List;
import java.util.Optional;

@Repository
public interface QuestionRepository extends JpaRepository<QuestionEntity, Long> {

    Optional<QuestionEntity> getOneByMd5H(String questionId);

    List<QuestionEntity> findAllByTest_Md5H(String testId);

    Optional<QuestionEntity> deleteByMd5H(String questionId);

    @Query(value = "    SELECT distinct question.id FROM QuestionEntity question" +
            "               INNER JOIN AnswerHistory ah on ah.question.id = question.id" +
            "           WHERE ah.user.md5H = :userId")
    List<Long> getAlreadyAnsweredQuestions(String userId);

    List<QuestionEntity> findAllByTest_Md5HAndStatus_Id(String testId, long statusId);
}
