package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.AnswerStatus;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.QuestionStatus;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.AnswerHistory;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.repository.AnswerHistoryRepository;
import uns.ac.rs.elearningserver.repository.AnswerRepository;
import uns.ac.rs.elearningserver.repository.QuestionRepository;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.repository.TestRepository;
import uns.ac.rs.elearningserver.repository.UserRepository;
import uns.ac.rs.elearningserver.rest.resource.AnswerResource;
import uns.ac.rs.elearningserver.rest.resource.QuestionResource;
import uns.ac.rs.elearningserver.util.DateUtil;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuestionService {

    @NonNull
    private final QuestionRepository questionRepository;
    @NonNull
    private final TestRepository testRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final AnswerHistoryRepository answerHistoryRepository;
    @NonNull
    private final UserRepository userRepository;
    @NonNull
    private final AnswerRepository answerRepository;

    public final static Double PROBABILITY_THRESHOLD = 3.0;

    @Transactional
    public void create(QuestionResource question){
        QuestionEntity questionEntity = QuestionEntity.builder()
                .text(question.getText())
                .test(testRepository.getOnyByMd5H(question.getTestId()).get())
                .status(statusRepository.getOne(QuestionStatus.ACTIVE.getId()))
                .build();
        questionRepository.save(questionEntity);
        questionEntity.setMd5H(Md5Generator.generateHash(questionEntity.getId(), Md5Salt.QUESTION));
    }

    public QuestionResource get(String questionId){
        QuestionEntity question = questionRepository.getOneByMd5H(questionId).orElseThrow(() -> new ResourceNotExistException(String.format("Campaign %s not found!", questionId), ErrorCode.NOT_FOUND));
        return QuestionResource.builder()
                .id(question.getMd5H())
                .text(question.getText())
                .testId(question.getTest().getMd5H())
                .answers(question.getAnswers()
                        .stream()
                        .map(answerEntity -> AnswerResource.builder()
                                .answerId(answerEntity.getMd5H())
                                .text(answerEntity.getText())
                                .questionId(answerEntity.getQuestion().getMd5H())
                                .build())
                        .collect(Collectors.toList())
                )
                .build();
    }

    public Optional<QuestionResource> getQuestionByTestAndProbability(String testId, String userId){
        List<QuestionEntity> questions = questionRepository.findAllByTest_Md5H(testId);
        List<Long> alreadyAnsweredQuestions = questionRepository.getAlreadyAnsweredQuestions(userId);
        List<QuestionResource> unansweredQuestions = questions.stream()
                .filter(questionEntity -> !alreadyAnsweredQuestions.contains(questionEntity.getId()))
                .map(QuestionResource::entityToResource)
                .sorted(Comparator.comparingDouble(QuestionResource::getProbability).reversed())
                .collect(Collectors.toList());
        updateAnswerHistory(testId, userId);
        return unansweredQuestions.size() >= 1 ? Optional.of(unansweredQuestions.get(0)): Optional.empty();
    }

    /*
        NOTE: Every user has to respond to the same number of questions, because of ks-server design (limitation).
              So questions which are bellow PROBABILITY_THRESHOLD need to be added to user answer_history table as wrong answers.
              Those questions will be later treated as already answered.
     */
    public void updateAnswerHistory(String testId, String userId){
        List<QuestionEntity> questionsBellowProbabilityThreshold =
                questionRepository.findAllByTest_Md5HAndStatus_Id(testId, QuestionStatus.ACTIVE.getId())
                        .stream()
                        .filter(questionEntity -> questionEntity.getProblem().getProbability() < PROBABILITY_THRESHOLD)
                        .collect(Collectors.toList());
        for(QuestionEntity question: questionsBellowProbabilityThreshold) {
            System.out.printf("Question/Problem %s bellow threshold added to answer_history table!%n", question.getMd5H());
            answerHistoryRepository.save(AnswerHistory.builder()
                    .question(question)
                    .answer(answerRepository.findFirstByQuestion_Md5HAndCorrectAndStatus_Id(question.getMd5H(), false, AnswerStatus.ACTIVE.getId()).get())
                    .user(userRepository.findOneByMd5H(userId).get())
                    .test(testRepository.getOnyByMd5H(testId).get())
                    .date(DateUtil.nowSystemTime())
                    .build());
        }
    }
}
