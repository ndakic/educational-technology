package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.AnswerStatus;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.ProblemStatus;
import uns.ac.rs.elearningserver.exception.ResourceAlreadyExist;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.*;
import uns.ac.rs.elearningserver.repository.*;
import uns.ac.rs.elearningserver.rest.resource.AnswerResource;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;
import uns.ac.rs.elearningserver.util.DateUtil;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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
    private final UserRepository userRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final KnowledgeSpaceService knowledgeSpaceService;
    @NonNull
    private final ProblemRepository problemRepository;


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


    @Transactional
    public void history(List<AnswerResource> resources){
        for (AnswerResource resource: resources) {
            response(resource);
        }
    }

    public AnswerResource response(AnswerResource resource){
        AnswerEntity answer = answerRepository.findOneByMd5H(resource.getAnswerId()).orElseThrow(() -> new ResourceNotExistException(String.format("Answer %s not found!", resource.getAnswerId()), ErrorCode.NOT_FOUND));
        UserEntity user = userRepository.findOneByMd5H(resource.getUserId()).orElseThrow(() -> new ResourceNotExistException(String.format("User %s not found!", resource.getUserId()), ErrorCode.NOT_FOUND));
        answerHistoryRepository.save(AnswerHistory.builder()
                .answer(answer)
                .user(user)
                .question(answer.getQuestion())
                .test(answer.getQuestion().getTest())
                .date(DateUtil.nowSystemTime())
                .build());

        Optional<QuestionEntity> questionEntity = questionRepository.getOneByMd5H(answer.getQuestion().getMd5H());
        List<ProblemEntity> problems = problemRepository.findAllByDomain_Md5HAndStatus_idAndKnowledgeStateContaining(answer.getQuestion().getProblem().getDomain().getMd5H(),
                                       ProblemStatus.ACTIVE.getId(), answer.getQuestion().getProblem().getTitle())
                .stream()
                .filter(problemEntity -> !problemEntity.getMd5H().equals(questionEntity.get().getProblem().getMd5H()))
                .collect(Collectors.toList());
        /*
            if answer is correct/wrong, update all problems which are related to that question/problem
         */
        for(ProblemEntity problem: problems) {
            int value = answer.getCorrect() ? 2: -2;
            problem.setCredibility(problem.getCredibility() + value);
            problem.setCredibility(problem.getCredibility() < 0 ? 0: problem.getCredibility());
            problemRepository.save(problem);
        }
        int value = answer.getCorrect() ? 10: -10;
        ProblemEntity problemEntity = questionEntity.get().getProblem();
        problemEntity.setCredibility(problemEntity.getCredibility() + value);
        problemEntity.setCredibility(problemEntity.getCredibility() < 0 ? 0: problemEntity.getCredibility());
        problemRepository.save(problemEntity);

        knowledgeSpaceService.calculateProbability(answer.getQuestion().getProblem().getDomain().getMd5H());
        return AnswerResource.builder()
                .questionId(answer.getQuestion().getMd5H())
                .problem(ProblemResource.entityToResource(answer.getQuestion().getProblem()))
                .correct(answer.getCorrect())
                .build();
    }

    public AnswerResource rejectedQuestion(String questionId, String userId){
        Optional<QuestionEntity> questionEntity = questionRepository.getOneByMd5H(questionId);
        Optional<AnswerEntity> answer = answerRepository.findFirstByQuestion_Md5HAndCorrectAndStatus_Id(questionEntity.get().getMd5H(), false, AnswerStatus.ACTIVE.getId());
        UserEntity user = userRepository.findOneByMd5H(userId).orElseThrow(() -> new ResourceNotExistException(String.format("User %s not found!", userId), ErrorCode.NOT_FOUND));
        answer.ifPresent(answerEntity -> answerHistoryRepository.save(AnswerHistory.builder()
                .answer(answerEntity)
                .user(user)
                .question(answerEntity.getQuestion())
                .test(answerEntity.getQuestion().getTest())
                .date(DateUtil.nowSystemTime())
                .build()));
        return AnswerResource.builder()
                .questionId(questionId)
                .userId(userId)
                .build();
    }
}
