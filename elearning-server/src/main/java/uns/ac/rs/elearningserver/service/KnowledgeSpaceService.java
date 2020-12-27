package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.exception.ResourceException;
import uns.ac.rs.elearningserver.external.FlaskApiService;
import uns.ac.rs.elearningserver.model.LinkEntity;
import uns.ac.rs.elearningserver.model.ProblemEntity;
import uns.ac.rs.elearningserver.repository.AnswerHistoryRepository;
import uns.ac.rs.elearningserver.repository.ProblemRepository;
import uns.ac.rs.elearningserver.rest.resource.KnowledgeSpaceGraphResource;
import uns.ac.rs.elearningserver.rest.resource.LinkResource;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;
import uns.ac.rs.elearningserver.rest.resource.UserTestAnswersResource;

import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class KnowledgeSpaceService {

    @NonNull
    private final AnswerHistoryRepository answerHistoryRepository;
    @NonNull
    private final ProblemRepository problemRepository;
    @NonNull
    private final FlaskApiService flaskApiService;

    public KnowledgeSpaceGraphResource getKnowledgeSpace(String testId){
        List<Long> questions = answerHistoryRepository.findAllQuestionsByTest_Md5H(testId);
        if(questions.size() != 5) { throw new ResourceException("Test must have 5 questions exactly!", ErrorCode.ILLEGAL_ARGUMENT); }
        Integer[][] knowledgeSpace = flaskApiService.getKnowledgeSpace(UserTestAnswersResource.builder()
                .first(answerHistoryRepository.findAllAnswersPerQuestion(questions.get(0))
                        .stream()
                        .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? 1: 0)
                        .collect(Collectors.toList()))
                .second(answerHistoryRepository.findAllAnswersPerQuestion(questions.get(1))
                        .stream()
                        .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? 1: 0)
                        .collect(Collectors.toList()))
                .third(answerHistoryRepository.findAllAnswersPerQuestion(questions.get(2))
                        .stream()
                        .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? 1: 0)
                        .collect(Collectors.toList()))
                .fourth(answerHistoryRepository.findAllAnswersPerQuestion(questions.get(3))
                        .stream()
                        .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? 1: 0)
                        .collect(Collectors.toList()))
                .fifth(answerHistoryRepository.findAllAnswersPerQuestion(questions.get(4))
                        .stream()
                        .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? 1: 0)
                        .collect(Collectors.toList()))
                .build());
        return getKnowledgeSpaceGraphResource(knowledgeSpace, testId);
    }

    public KnowledgeSpaceGraphResource getKnowledgeSpaceGraphResource(Integer[][] knowledgeSpace, String testId){
        List<LinkEntity> links = new ArrayList<>();
        List<ProblemEntity> problems = problemRepository.findAllByQuestion_Test_Md5H(testId);
        if(problems.size() != 5) { throw new ResourceException("Test must have 5 problems/questions exactly!", ErrorCode.ILLEGAL_ARGUMENT); }
        for(Integer[] knowledge: knowledgeSpace){
            Integer source = knowledge[0];
            Integer target = knowledge[0];
            links.add(LinkEntity.builder()
                    .source(problems.get(source))
                    .target(problems.get(target))
                    .leftDirection(true)
                    .rightDirection(false)
                    .build());
        }
        return KnowledgeSpaceGraphResource.builder()
                .problems(problems.stream()
                        .map(ProblemResource::entityToResource)
                        .collect(Collectors.toList()))
                .links(links
                        .stream()
                        .map(LinkResource::entityToResource).collect(Collectors.toList()))
                .build();
    }
}
