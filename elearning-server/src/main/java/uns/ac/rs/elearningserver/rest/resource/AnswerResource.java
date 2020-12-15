package uns.ac.rs.elearningserver.rest.resource;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
    private boolean isCorrect;
}
