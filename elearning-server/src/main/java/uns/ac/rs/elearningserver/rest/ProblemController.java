package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;
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

    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<?> save(@RequestBody ProblemResource problem){
        return ResponseEntity.ok(problemService.save(problem));
    }

}
