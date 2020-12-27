package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.service.KnowledgeSpaceService;

@RestController
@RequestMapping("/knowledge-space")
@RequiredArgsConstructor
public class KnowledgeSpaceController {

    @NonNull
    private final KnowledgeSpaceService knowledgeSpaceService;

    @RequestMapping(value = "/{testId}", method = RequestMethod.GET)
    public ResponseEntity<?> get(@PathVariable String testId){
        return ResponseEntity.ok(knowledgeSpaceService.getKnowledgeSpace(testId));
    }
}
