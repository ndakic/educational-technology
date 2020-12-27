package uns.ac.rs.elearningserver.rest.resource;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserTestAnswersResource {

    /*
        NOTE: Model limited to n questions because of KST library
     */
    private List<Integer> first;
    private List<Integer> second;
    private List<Integer> third;
    private List<Integer> fourth;
    private List<Integer> fifth;
}
