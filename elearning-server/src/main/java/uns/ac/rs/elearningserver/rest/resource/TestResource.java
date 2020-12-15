package uns.ac.rs.elearningserver.rest.resource;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TestResource {
    private String id;
    private String title;
    private Timestamp startDate;
    private Timestamp endDate;
    private String teacherId;
    private List<QuestionResource> questions;
}
