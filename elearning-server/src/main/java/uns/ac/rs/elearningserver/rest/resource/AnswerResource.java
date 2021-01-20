package uns.ac.rs.elearningserver.rest.resource;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.AnswerEntity;
import uns.ac.rs.elearningserver.model.QuestionEntity;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AnswerResource {
    private String answerId;
    private String text;
    private String questionId;
    private String testId;
    private String userId;
    private boolean correct;
    private ProblemResource problem;

    public static AnswerResource entityToResource(AnswerEntity answerEntity){
        if(ObjectUtils.isEmpty(answerEntity)) { return null; }
        return AnswerResource.builder()
                .answerId(answerEntity.getMd5H())
                .text(answerEntity.getText())
                .questionId(answerEntity.getQuestion().getMd5H())
                .correct(false)
                .build();
    }
}
