package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.rest.resource.QuestionResource;
import uns.ac.rs.elearningserver.service.QuestionService;

@RestController
@RequestMapping("/question")
@RequiredArgsConstructor
public class QuestionController {

    @NonNull
    private final QuestionService questionService;

    @RequestMapping(value = "/{questionId}", method = RequestMethod.GET)
    public ResponseEntity<?> get(@PathVariable String questionId){
        return ResponseEntity.ok(questionService.get(questionId));
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<?> create(@RequestBody QuestionResource resource) {
        questionService.create(resource);
        return ResponseEntity.ok(resource);
    }
}
