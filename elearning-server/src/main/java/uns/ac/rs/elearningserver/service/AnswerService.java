package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.AnswerStatus;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.exception.ResourceAlreadyExist;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.AnswerEntity;
import uns.ac.rs.elearningserver.model.AnswerHistory;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.model.UserEntity;
import uns.ac.rs.elearningserver.repository.AnswerHistoryRepository;
import uns.ac.rs.elearningserver.repository.AnswerRepository;
import uns.ac.rs.elearningserver.repository.QuestionRepository;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.repository.TestRepository;
import uns.ac.rs.elearningserver.repository.UserRepository;
import uns.ac.rs.elearningserver.rest.resource.AnswerResource;
import uns.ac.rs.elearningserver.util.DateUtil;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AnswerService {

    @NonNull
    private final AnswerRepository answerRepository;
    @NonNull
    private final AnswerHistoryRepository answerHistoryRepository;
    @NonNull
    private final QuestionRepository questionRepository;
    @NonNull
    private final TestRepository testRepository;
    @NonNull
    private final UserRepository userRepository;
    @NonNull
    private final StatusRepository statusRepository;


    @Transactional
    public void create(AnswerResource resource){
        QuestionEntity question = questionRepository.getOneByMd5H(resource.getQuestionId()).orElseThrow(() -> new ResourceNotExistException(String.format("Question %s not found!", resource.getQuestionId()), ErrorCode.NOT_FOUND));
        Optional<AnswerEntity> check = answerRepository.findOneByQuestion_Md5HAndTextAndStatus_Id(resource.getQuestionId(), resource.getText(), AnswerStatus.ACTIVE.getId());
        if(check.isPresent()) { throw new ResourceAlreadyExist(String.format("Answer %s already exist!", resource.getText()), ErrorCode.NOT_FOUND); }
        AnswerEntity answer = AnswerEntity.builder()
                .text(resource.getText())
                .question(question)
                .isCorrect(resource.isCorrect())
                .status(statusRepository.getOne(AnswerStatus.ACTIVE.getId()))
                .build();
        answerRepository.save(answer);
        answer.setMd5H(Md5Generator.generateHash(answer.getId(), Md5Salt.ANSWER));
    }

    public void history(AnswerResource resource){
        AnswerEntity answer = answerRepository.findOneByMd5H(resource.getAnswerId()).orElseThrow(() -> new ResourceNotExistException(String.format("Answer %s not found!", resource.getAnswerId()), ErrorCode.NOT_FOUND));
        UserEntity user = userRepository.findOneByMd5H(resource.getUserId()).orElseThrow(() -> new ResourceNotExistException(String.format("User %s not found!", resource.getUserId()), ErrorCode.NOT_FOUND));
        answerHistoryRepository.save(AnswerHistory.builder()
                .answer(answer)
                .user(user)
                .question(answer.getQuestion())
                .test(answer.getQuestion().getTest())
                .date(DateUtil.nowSystemTime())
                .build());
    }
}
