package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.service.QuestionService;
import uns.ac.rs.elearningserver.service.TestService;

@RestController
@RequestMapping("/test")
@RequiredArgsConstructor
public class TestController {

    @NonNull
    private final TestService testService;
    @NonNull
    private final QuestionService questionService;

    @RequestMapping(value = "/{testId}", method = RequestMethod.GET)
    public ResponseEntity<?> get(@PathVariable String testId){
        return ResponseEntity.ok(testService.get(testId));
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ResponseEntity<?> get(){
        return ResponseEntity.ok(testService.getAll());
    }
}
