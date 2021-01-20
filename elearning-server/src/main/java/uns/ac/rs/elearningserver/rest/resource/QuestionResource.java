package uns.ac.rs.elearningserver.rest.resource;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.DomainEntity;
import uns.ac.rs.elearningserver.model.QuestionEntity;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QuestionResource {
    private String id;
    private String text;
    private String testId;
    private Double probability;
    private ProblemResource problem;
    private List<AnswerResource> answers;
    private boolean answered;

    public static QuestionResource entityToResource(QuestionEntity questionEntity){
        if(ObjectUtils.isEmpty(questionEntity)) { return null; }
        return QuestionResource.builder()
                .id(questionEntity.getMd5H())
                .text(questionEntity.getText())
                .testId(questionEntity.getTest().getMd5H())
                .probability(questionEntity.getProblem().getProbability())
                .problem(ProblemResource.entityToResource(questionEntity.getProblem()))
                .answers(questionEntity.getAnswers().stream().map(AnswerResource::entityToResource).collect(Collectors.toList()))
                .answered(false)
                .build();
    }
}
