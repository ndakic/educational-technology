package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.QuestionStatus;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.AnswerEntity;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.repository.QuestionRepository;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.repository.TestRepository;
import uns.ac.rs.elearningserver.rest.resource.Answer;
import uns.ac.rs.elearningserver.rest.resource.Question;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuestionService {

    @NonNull
    private final QuestionRepository questionRepository;
    @NonNull
    private final TestService testService;
    @NonNull
    private final TestRepository testRepository;
    @NonNull
    private final StatusRepository statusRepository;

    @Transactional
    public void create(Question.Resource question){
        QuestionEntity questionEntity = QuestionEntity.builder()
                .text(question.getText())
                .test(testRepository.getOnyByMd5H(question.getTestId()).get())
                .status(statusRepository.getOne(QuestionStatus.ACTIVE.getId()))
                .build();
        questionRepository.save(questionEntity);
        questionEntity.setMd5H(Md5Generator.generateHash(questionEntity.getId(), Md5Salt.QUESTION));
    }

    public Question.Resource get(String questionId){
        QuestionEntity question = questionRepository.getOneByMd5H(questionId).orElseThrow(() -> new ResourceNotExistException(String.format("Campaign %s not found!", questionId), ErrorCode.NOT_FOUND));
        return Question.Resource.builder()
                .id(question.getMd5H())
                .text(question.getText())
                .testId(question.getTest().getMd5H())
                .answers(question.getAnswers()
                        .stream()
                        .map(answerEntity -> Answer.Resource.builder()
                                .id(answerEntity.getMd5H())
                                .text(answerEntity.getText())
                                .questionId(answerEntity.getQuestion().getMd5H())
                                .build())
                        .collect(Collectors.toList())
                )
                .build();
    }

    public List<Question.Resource> getAllQuestionsByTestId(String testId){
        return questionRepository.findAllByTest_Md5H(testId)
                .stream()
                .map(questionEntity -> Question.Resource.builder()
                        .id(questionEntity.getMd5H())
                        .text(questionEntity.getText())
                        .answers(questionEntity.getAnswers()
                                .stream()
                                .map(answerEntity -> Answer.Resource.builder()
                                        .id(answerEntity.getMd5H())
                                        .text(answerEntity.getText())
                                        .questionId(answerEntity.getQuestion().getMd5H())
                                        .build())
                                .collect(Collectors.toList()))
                        .build())
                .collect(Collectors.toList());
    }
}
