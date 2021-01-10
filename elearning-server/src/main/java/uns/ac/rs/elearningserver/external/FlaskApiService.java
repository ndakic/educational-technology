package uns.ac.rs.elearningserver.external;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class FlaskApiService {

    private final RestTemplate restTemplate = new RestTemplate();

    private static final String KNOWLEDGE_SPACE_API_URL = "http://172.17.0.1:5000";
//    private static final String KNOWLEDGE_SPACE_API_URL = "http://localhost:5000";

    public Integer[][] getKnowledgeSpace(Map<String, int[]> testAnswers){
        ResponseEntity<Integer[][]> response = restTemplate.postForEntity
                (KNOWLEDGE_SPACE_API_URL + "/knowledge-space", testAnswers, Integer[][].class);
        return response.getBody();
    }
}
