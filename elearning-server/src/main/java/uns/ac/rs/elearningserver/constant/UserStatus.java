package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatus {

    ACTIVE(1, "Active"),
    DELETED(2, "Deleted");

    private final long id;
    private final String value;
}
