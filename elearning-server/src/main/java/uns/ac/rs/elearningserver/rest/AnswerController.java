package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.rest.resource.AnswerResource;
import uns.ac.rs.elearningserver.service.AnswerService;

import java.util.List;

@RestController
@RequestMapping("/answer")
@RequiredArgsConstructor
public class AnswerController {

    @NonNull
    private final AnswerService answerService;

    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<?> create(@RequestBody AnswerResource resource) {
        answerService.create(resource);
        return ResponseEntity.ok(resource);
    }

    @RequestMapping(value = "/history", method = RequestMethod.POST)
    public ResponseEntity<?> history(@RequestBody AnswerResource resource) {
        answerService.history(resource);
        return ResponseEntity.ok(resource);
    }

    @RequestMapping(value = "/history/test", method = RequestMethod.POST)
    public ResponseEntity<?> history(@RequestBody List<AnswerResource> resources) {
        for (AnswerResource resource : resources) {
            answerService.history(resource);
        }
        return ResponseEntity.ok(resources);
    }
}
