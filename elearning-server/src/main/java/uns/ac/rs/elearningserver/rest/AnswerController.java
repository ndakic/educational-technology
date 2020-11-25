package uns.ac.rs.elearningserver.rest;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.service.AnswerService;

@RestController
@RequestMapping("/answer")
@RequiredArgsConstructor
public class AnswerController {

    @NonNull
    private final AnswerService answerService;
}
