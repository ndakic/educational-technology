package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.repository.AnswerRepository;

@Service
@RequiredArgsConstructor
public class AnswerService {

    @NonNull
    private final AnswerRepository answerRepository;
}
