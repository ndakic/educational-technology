package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum  AnswerStatus {

    ACTIVE(30, "Active"),
    DELETED(31, "Deleted");

    private final long id;
    private final String value;
}
