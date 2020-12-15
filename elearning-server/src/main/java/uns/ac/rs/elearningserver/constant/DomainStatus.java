package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum DomainStatus {

    ACTIVE(60, "Active"),
    DELETED(61, "Deleted");

    private final long id;
    private final String value;
}
