package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.DomainEntity;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DomainResource {
    private String id;
    private String title;
    private UserResource user;
    private StatusResource status;
    private List<ProblemResource> problems;
    private List<LinkResource> links;

    public static DomainResource entityToResource(DomainEntity domainEntity){
        if(ObjectUtils.isEmpty(domainEntity)) { return null; }
        return DomainResource.builder()
                .id(domainEntity.getMd5H())
                .title(domainEntity.getTitle())
                .user(UserResource.entityToResource(domainEntity.getUser()))
                .status(StatusResource.entityToResource(domainEntity.getStatus()))
                .problems(domainEntity.getProblems().stream().map(ProblemResource::entityToResource).collect(Collectors.toList()))
                .links(domainEntity.getLinks().stream().map(LinkResource::entityToResource).collect(Collectors.toList()))
                .build();
    }
}