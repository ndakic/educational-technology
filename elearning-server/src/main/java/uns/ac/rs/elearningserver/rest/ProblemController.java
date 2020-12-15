package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.service.ProblemService;

@RestController
@RequestMapping("/problem")
@RequiredArgsConstructor
public class ProblemController {

    @NonNull
    private final ProblemService problemService;

    @RequestMapping(value = "/domain/{domainId}/all", method = RequestMethod.GET)
    public ResponseEntity<?> getAll(@PathVariable String domainId){
        return ResponseEntity.ok(problemService.getAllProblemsByDomain(domainId));
    }

}
