package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum LinkStatus {

    ACTIVE(50, "Active"),
    DELETED(51, "Deleted");

    private final long id;
    private final String value;
}
