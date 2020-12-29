package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.LinkStatus;
import uns.ac.rs.elearningserver.external.FlaskApiService;
import uns.ac.rs.elearningserver.model.LinkEntity;
import uns.ac.rs.elearningserver.model.ProblemEntity;
import uns.ac.rs.elearningserver.model.TestEntity;
import uns.ac.rs.elearningserver.repository.AnswerHistoryRepository;
import uns.ac.rs.elearningserver.repository.LinkRepository;
import uns.ac.rs.elearningserver.repository.ProblemRepository;
import uns.ac.rs.elearningserver.repository.TestRepository;
import uns.ac.rs.elearningserver.rest.resource.KnowledgeSpaceGraphResource;
import uns.ac.rs.elearningserver.rest.resource.LinkResource;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
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
    @NonNull
    private final TestRepository testRepository;
    @NonNull
    private LinkRepository linkRepository;

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
                        .map(LinkResource::entityToResource)
                        .collect(Collectors.toList()))
                .build();
    }


    public KnowledgeSpaceGraphResource compareGraphs(String testId){
        TestEntity testEntity = testRepository.getOnyByMd5H(testId).get();
        KnowledgeSpaceGraphResource knowledgeSpaceGraphResource = getKnowledgeSpace(testId);
        System.out.printf("DomainId: %s\n", testEntity.getDomain().getMd5H());
        List<LinkEntity> links = linkRepository.findAllByDomain_Md5HAndStatus_Id(testEntity.getDomain().getMd5H(), LinkStatus.ACTIVE.getId());
        return compare(links
                        .stream()
                        .map(LinkResource::entityToResource)
                        .collect(Collectors.toList()), knowledgeSpaceGraphResource.getLinks()
                       );
    }

    public KnowledgeSpaceGraphResource compare(List<LinkResource> graph1Links, List<LinkResource> graph2Links){
        System.out.printf("Graph1 length: %d - Graph2 length: %d \n", graph1Links.size(), graph2Links.size());
        List<LinkResource> sameLinks = new ArrayList<>();
        List<ProblemResource> sameProblems = new ArrayList<>();
        for(LinkResource link: graph1Links){
            if(compareLink(graph2Links, link)) {
                sameLinks.add(link);
                sameProblems.add(link.getSource());
                sameProblems.add(link.getTarget());
            }
        }
        return KnowledgeSpaceGraphResource.builder()
                .problems(sameProblems.stream().filter(distinctByKey(ProblemResource::getMd5h)).collect(Collectors.toList())) // filter duplicates
                .links(sameLinks.stream().filter(distinctByKey(LinkResource::getMd5h)).collect(Collectors.toList()))          // filter duplicates
                .build();
    }

    /*
        Two links are same if their source and target nodes are the same.
     */
    public boolean compareLink(List<LinkResource> links, LinkResource compareToLink){
        for(LinkResource linkResource: links) {
            if(linkResource.getSource().getId().equals(compareToLink.getSource().getId()) &&
               linkResource.getTarget().getId().equals(compareToLink.getTarget().getId())) {
                return true;
            }
        }
        return false;
    }

    public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Set<Object> seen = ConcurrentHashMap.newKeySet();
        return t -> seen.add(keyExtractor.apply(t));
    }
}
