package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.service.ExportService;

@RestController
@RequestMapping("/export")
@RequiredArgsConstructor
public class ExportController {

    @NonNull
    private final ExportService exportService;

    @RequestMapping(value = "/{testId}", method = RequestMethod.GET)
    public ResponseEntity<?> get(@PathVariable String testId){
        return ResponseEntity.ok(exportService.exportToMsiQti(testId));
    }

}
