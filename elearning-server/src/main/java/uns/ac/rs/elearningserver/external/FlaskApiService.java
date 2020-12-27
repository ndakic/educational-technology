package uns.ac.rs.elearningserver.external;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import uns.ac.rs.elearningserver.rest.resource.KnowledgeSpaceGraphResource;
import uns.ac.rs.elearningserver.rest.resource.UserTestAnswersResource;

@Service
@RequiredArgsConstructor
public class FlaskApiService {

    private final RestTemplate restTemplate = new RestTemplate();

    private static final String KNOWLEDGE_SPACE_API_URL = "http://localhost:5000";

    public Integer[][] getKnowledgeSpace(UserTestAnswersResource userTestAnswersResource){
        ResponseEntity<Integer[][]> response = restTemplate.postForEntity
                (KNOWLEDGE_SPACE_API_URL + "/knowledge-space", userTestAnswersResource, Integer[][].class);
        return response.getBody();
    }
}
