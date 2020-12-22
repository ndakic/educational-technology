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
    private String md5h;
    private Boolean reflexive;
    private String title;
    private QuestionResource question;
    private StatusResource status;
    private Integer order;

    public static ProblemResource entityToResource(ProblemEntity problemEntity){
        if(ObjectUtils.isEmpty(problemEntity)) { return null; }
        return ProblemResource.builder()
                .id(problemEntity.getId())
                .md5h(problemEntity.getMd5H())
                .reflexive(problemEntity.getReflexive())
                .title(problemEntity.getTitle())
                .order(problemEntity.getOrderValue())
                .question(QuestionResource.entityToResource(problemEntity.getQuestion()))
                .status(StatusResource.entityToResource(problemEntity.getStatus()))
                .build();
    }
}
