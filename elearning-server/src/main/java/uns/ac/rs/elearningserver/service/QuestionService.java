package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.repository.QuestionRepository;

@Service
@RequiredArgsConstructor
public class QuestionService {

    @NonNull
    private final QuestionRepository questionRepository;
}
