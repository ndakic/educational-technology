package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ProblemStatus {

    ACTIVE(40, "Active"),
    DELETED(41, "Deleted");

    private final long id;
    private final String value;
}
