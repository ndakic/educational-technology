package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.ProblemEntity;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProblemResource {
    private Long id;
    private Boolean reflexive;
    private String title;
    private QuestionResource question;
    private StatusResource status;

    public static ProblemResource entityToResource(ProblemEntity problemEntity){
        if(ObjectUtils.isEmpty(problemEntity)) { return null; }
        return ProblemResource.builder()
                .id(problemEntity.getId())
                .reflexive(problemEntity.getReflexive())
                .title(problemEntity.getTitle())
                .question(QuestionResource.entityToResource(problemEntity.getQuestion()))
                .status(StatusResource.entityToResource(problemEntity.getStatus()))
                .build();
    }
}
