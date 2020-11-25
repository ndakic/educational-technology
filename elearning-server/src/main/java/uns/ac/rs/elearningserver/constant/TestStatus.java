package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TestStatus {

    ACTIVE(10, "Active"),
    DELETED(11, "Deleted");

    private final long id;
    private final String value;

}
