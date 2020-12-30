package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import uns.ac.rs.elearningserver.rest.resource.DomainResource;
import uns.ac.rs.elearningserver.service.DomainService;

@RestController
@RequestMapping("/domain")
@RequiredArgsConstructor
public class DomainController {

    @NonNull
    private final DomainService domainService;

    @RequestMapping(value = "/{domainId}", method = RequestMethod.GET)
    public ResponseEntity<?> get(@PathVariable String domainId){
        return ResponseEntity.ok(domainService.get(domainId));
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ResponseEntity<?> getAll(){
        return ResponseEntity.ok(domainService.getAll());
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<?> save(@RequestBody DomainResource domain){
        return ResponseEntity.ok(domainService.save(domain));
    }
}
