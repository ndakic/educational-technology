package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.DomainEntity;
import uns.ac.rs.elearningserver.model.StatusEntity;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class StatusResource {
    private long id;
    private String name;
    private String description;

    public static StatusResource entityToResource(StatusEntity statusEntity){
        if(ObjectUtils.isEmpty(statusEntity)) { return null; }
        return StatusResource.builder()
                .id(statusEntity.getId())
                .name(statusEntity.getName())
                .description(statusEntity.getDescription())
                .build();
    }
}
