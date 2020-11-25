package uns.ac.rs.elearningserver.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum QuestionStatus {

    ACTIVE(20, "Active"),
    DELETED(21, "Deleted");

    private final long id;
    private final String value;
}
