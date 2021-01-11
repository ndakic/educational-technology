package uns.ac.rs.elearningserver.rest.resource;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;
import uns.ac.rs.elearningserver.model.LinkEntity;
import uns.ac.rs.elearningserver.model.TestEntity;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

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
    private UserResource teacher;
    private DomainResource domain;
    private List<QuestionResource> questions;

    public static TestResource entityToResource(TestEntity testEntity){
        if(ObjectUtils.isEmpty(testEntity)) { return null; }
        return TestResource.builder()
                .id(testEntity.getMd5H())
                .title(testEntity.getTitle())
                .startDate(testEntity.getStartDate())
                .endDate(testEntity.getEndDate())
                .teacher(UserResource.entityToResource(testEntity.getTeacher()))
                .questions(testEntity.getQuestions()
                        .stream()
                        .map(QuestionResource::entityToResource)
                        .collect(Collectors.toList()))
                .build();
    }
}
