package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.constant.UserType;
import uns.ac.rs.elearningserver.model.DomainEntity;
import uns.ac.rs.elearningserver.model.UserEntity;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserResource {
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private UserType userType;

    public static UserResource entityToResource(UserEntity userEntity){
        if(ObjectUtils.isEmpty(userEntity)) { return null; }
        return UserResource.builder()
                .id(userEntity.getMd5H())
                .firstName(userEntity.getFirstName())
                .lastName(userEntity.getLastName())
                .email(userEntity.getEmail())
                .userType(userEntity.getUserType())
                .build();
    }
}
