package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
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
        return ResponseEntity.ok(answerService.response(resource));
    }

    @RequestMapping(value = "/history/rejected-question/{questionId}/{userId}", method = RequestMethod.GET)
    public ResponseEntity<?> rejectedQuestion(@PathVariable String questionId, @PathVariable String userId) {
        return ResponseEntity.ok(answerService.rejectedQuestion(questionId, userId));
    }

    @RequestMapping(value = "/history/test", method = RequestMethod.POST)
    public ResponseEntity<?> history(@RequestBody List<AnswerResource> resources) {
        answerService.history(resources);
        return ResponseEntity.ok(resources);
    }
}
