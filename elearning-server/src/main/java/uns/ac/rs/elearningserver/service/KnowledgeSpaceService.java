package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.external.FlaskApiService;
import uns.ac.rs.elearningserver.model.LinkEntity;
import uns.ac.rs.elearningserver.model.ProblemEntity;
import uns.ac.rs.elearningserver.repository.AnswerHistoryRepository;
import uns.ac.rs.elearningserver.repository.ProblemRepository;
import uns.ac.rs.elearningserver.rest.resource.KnowledgeSpaceGraphResource;
import uns.ac.rs.elearningserver.rest.resource.LinkResource;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;

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
        Map<String, int[]> map = new HashMap<>();
        for(Long question: questions) {
            List<Integer> values = answerHistoryRepository.findAllAnswersPerQuestion(question)
                    .stream()
                    .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? Integer.valueOf(1): Integer.valueOf(0))
                    .collect(Collectors.toList());
            map.put(String.valueOf(question), values.stream().mapToInt(i->i).toArray());
        }
        map.forEach((s, ints) -> {
            System.out.println(s + " " + Arrays.toString(ints));
        });
        Integer[][] knowledgeSpace = flaskApiService.getKnowledgeSpace(map);
        return getKnowledgeSpaceGraphResource(knowledgeSpace, testId);
    }

    public KnowledgeSpaceGraphResource getKnowledgeSpaceGraphResource(Integer[][] knowledgeSpace, String testId){
        List<LinkEntity> links = new ArrayList<>();
        List<ProblemEntity> problems = problemRepository.findAllByQuestion_Test_Md5H(testId);
        for(Integer[] knowledge: knowledgeSpace){
            Integer source = knowledge[0];
            Integer target = knowledge[1];
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
