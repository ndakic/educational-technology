package uns.ac.rs.elearningserver.controler;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import uns.ac.rs.elearningserver.repository.QuestionRepository;
import uns.ac.rs.elearningserver.service.QuestionService;

@RestController
@RequestMapping("/question")
@RequiredArgsConstructor
public class QuestionController {

    @NonNull
    private final QuestionService questionService;
}
