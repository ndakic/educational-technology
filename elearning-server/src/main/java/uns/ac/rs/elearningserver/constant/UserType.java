package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserType {

    TEACHER("TEACHER"),
    STUDENT("STUDENT");

    private String value;
}
