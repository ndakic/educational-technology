package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import uns.ac.rs.elearningserver.rest.resource.LinkResource;
import uns.ac.rs.elearningserver.service.LinkService;

@RestController
@RequestMapping("/link")
@RequiredArgsConstructor
public class LinkController {

    @NonNull
    private final LinkService linkService;

    @RequestMapping(value = "/domain/{domainId}/all", method = RequestMethod.GET)
    public ResponseEntity<?> getAll(@PathVariable String domainId){
        return ResponseEntity.ok(linkService.getAllLinksByDomainIdAndStatus(domainId));
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<?> save(@RequestBody LinkResource linkResource){
        return ResponseEntity.ok(linkService.save(linkResource));
    }

    @RequestMapping(value = "/{linkId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> delete(@PathVariable String linkId){
        linkService.delete(linkId);
        return ResponseEntity.ok(HttpEntity.EMPTY);
    }

    @RequestMapping(value = "/problem/{problemId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteLinks(@PathVariable String problemId){
        linkService.deleteLinks(problemId);
        return ResponseEntity.ok(HttpEntity.EMPTY);
    }
}
