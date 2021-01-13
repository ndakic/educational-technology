package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
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
    private Integer credibility;
    private Double probability;
    private DomainResource domain;
    private String[] knowledgeState;
    private Double x;
    private Double y;

    public static ProblemResource entityToResource(ProblemEntity problemEntity){
        if(ObjectUtils.isEmpty(problemEntity)) { return null; }
        return ProblemResource.builder()
                .id(problemEntity.getId())
                .md5h(problemEntity.getMd5H())
                .reflexive(problemEntity.getReflexive())
                .title(problemEntity.getTitle())
                .credibility(problemEntity.getCredibility())
                .probability(problemEntity.getProbability())
                .status(StatusResource.entityToResource(problemEntity.getStatus()))
                .domain(DomainResource.builder()
                        .id(!ObjectUtils.isEmpty(problemEntity.getDomain()) ? problemEntity.getDomain().getMd5H(): null)
                        .title(!ObjectUtils.isEmpty(problemEntity.getDomain()) ? problemEntity.getDomain().getTitle(): null)
                        .build())
                .knowledgeState(StringUtils.isEmpty(problemEntity.getKnowledgeState()) ? null: problemEntity.getKnowledgeState().split(","))
                .x(problemEntity.getX())
                .y(problemEntity.getY())
                .build();
    }
}
