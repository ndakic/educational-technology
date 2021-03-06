package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.LinkEntity;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LinkResource {
    private String md5h;
    private Boolean left;
    private Boolean right;
    private ProblemResource source;
    private ProblemResource target;
    private StatusResource status;
    private DomainResource domain;

    public static LinkResource entityToResource(LinkEntity linkEntity){
        if(ObjectUtils.isEmpty(linkEntity)) { return null; }
        return LinkResource.builder()
                .md5h(linkEntity.getMd5h())
                .left(linkEntity.getLeftDirection())
                .right(linkEntity.getRightDirection())
                .source(ProblemResource.entityToResource(linkEntity.getSource()))
                .target(ProblemResource.entityToResource(linkEntity.getTarget()))
                .status(StatusResource.entityToResource(linkEntity.getStatus()))
                .domain(DomainResource.builder()
                        .id(!ObjectUtils.isEmpty(linkEntity.getDomain()) ? linkEntity.getDomain().getMd5H(): null)
                        .title(!ObjectUtils.isEmpty(linkEntity.getDomain()) ? linkEntity.getDomain().getTitle(): null)
                        .build())
                .build();
    }
}
