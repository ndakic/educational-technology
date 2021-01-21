package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.KnowledgeSpaceStatus;
import uns.ac.rs.elearningserver.constant.LinkStatus;
import uns.ac.rs.elearningserver.constant.ProblemStatus;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
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
import uns.ac.rs.elearningserver.util.FileUtil;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
    private final LinkRepository linkRepository;

    public KnowledgeSpaceGraphResource getKnowledgeSpace(String testId, KnowledgeSpaceStatus knowledgeSpaceStatus){
        List<Long> questions = answerHistoryRepository.findAllQuestionsByTest_Md5H(testId);
        Map<String, int[]> map = new HashMap<>();
        for(Long question: questions) {
            List<Integer> values = answerHistoryRepository.findAllAnswersPerQuestion(question)
                    .stream()
                    .map(answerHistory -> answerHistory.getAnswer().getCorrect() ? Integer.valueOf(1): Integer.valueOf(0))
                    .collect(Collectors.toList());
            map.put(String.valueOf(question), values.stream().mapToInt(i->i).toArray());
        }
        if(map.isEmpty()) { return new KnowledgeSpaceGraphResource();}
        Integer[][] knowledgeSpace = flaskApiService.getKnowledgeSpace(map);
        return getRealKnowledgeSpaceGraphResource(knowledgeSpace, testId, knowledgeSpaceStatus);
    }

    public KnowledgeSpaceGraphResource getDefaultKnowledgeSpace(String testId) {
        try {
            InputStream initialStream = new FileInputStream("files/pisa.txt");
            Map<String, int[]> result = FileUtil.readFromInputStream(initialStream);
            Integer[][] knowledgeSpace = flaskApiService.getKnowledgeSpace(result);
            return getRealKnowledgeSpaceGraphResource(knowledgeSpace, testId, KnowledgeSpaceStatus.DEFAULT);
        } catch (IOException e) {
            System.out.println(Arrays.toString(e.getStackTrace()));
        }
        return new KnowledgeSpaceGraphResource();
    }


    public KnowledgeSpaceGraphResource getRealKnowledgeSpaceGraphResource(Integer[][] knowledgeSpace, String testId, KnowledgeSpaceStatus knowledgeSpaceStatus){
        List<LinkEntity> links = new ArrayList<>();
        List<ProblemEntity> problems = problemRepository.findAllProblemsByTest(testId);
        List<LinkEntity> duplicateLinks = new ArrayList<>();
        for(ProblemEntity problemEntity: problems) {
            String [] subProblems = problemEntity.getKnowledgeState().split(",");
            if(subProblems.length > 1) {
                for(String title: Arrays.copyOfRange(subProblems, 1, subProblems.length)) {
                    ProblemEntity subProblem = problemRepository.findFirstByTitleAndDomain_Md5H(title, problemEntity.getDomain().getMd5H()).orElseThrow(() -> new ResourceNotExistException("Problem not found!", ErrorCode.NOT_FOUND));
                    duplicateLinks.add(LinkEntity.builder()
                            .source(problemEntity)
                            .target(subProblem)
                            .leftDirection(false)
                            .rightDirection(false)
                            .build());
                }
            }
        }
        for(Integer[] knowledge: knowledgeSpace){
            Integer source = knowledge[0];
            Integer target = knowledge[1];
            LinkEntity link = LinkEntity.builder()
                    .source(problems.get(source))
                    .target(problems.get(target))
                    .leftDirection(false)
                    .rightDirection(false)
                    .build();
            if(!compareLink(links
                            .stream()
                            .map(LinkResource::entityToResource)
                            .collect(Collectors.toList()), LinkResource.entityToResource(link)) &&
                    !compareLink(duplicateLinks
                            .stream()
                            .map(LinkResource::entityToResource)
                            .collect(Collectors.toList()), LinkResource.entityToResource(link)) && knowledgeSpaceStatus == KnowledgeSpaceStatus.REAL)
            {
                links.add(link);
            }
            if(!compareInBothDirection(links
                    .stream()
                    .map(LinkResource::entityToResource)
                    .collect(Collectors.toList()), LinkResource.entityToResource(link)) && knowledgeSpaceStatus != KnowledgeSpaceStatus.REAL)
            {
                links.add(link);
            }

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
        KnowledgeSpaceGraphResource knowledgeSpaceGraphResource = getKnowledgeSpace(testId, KnowledgeSpaceStatus.COMPARED);
        List<LinkEntity> links = linkRepository.findAllByDomain_Md5HAndStatus_Id(testEntity.getDomain().getMd5H(), LinkStatus.ACTIVE.getId());
        return compare(testEntity.getDomain().getMd5H(), links
                        .stream()
                        .map(LinkResource::entityToResource)
                        .collect(Collectors.toList()), knowledgeSpaceGraphResource.getLinks()
                       );
    }

    public KnowledgeSpaceGraphResource compare(String domainId, List<LinkResource> graph1Links, List<LinkResource> graph2Links){
        List<LinkResource> sameLinks = new ArrayList<>();
        List<ProblemEntity> problems = problemRepository.getAllByDomain_Md5HAndStatus_Id(domainId, ProblemStatus.ACTIVE.getId());
        for(LinkResource link: graph1Links){
            if(compareInBothDirection(graph2Links, link)) {
                sameLinks.add(link);
            }
        }
        return KnowledgeSpaceGraphResource.builder()
                .problems(problems.stream().map(ProblemResource::entityToResource).collect(Collectors.toList()))
                .links(sameLinks.stream().filter(distinctByKey(LinkResource::getMd5h)).collect(Collectors.toList()))          // filter duplicates
                .graphSimilarityPercent((double) sameLinks.size() / Math.max(graph1Links.size(), graph2Links.size()) * 100)
                .build();
    }

    /*
        Two links are same if their source and target nodes are the same.
     */
    public boolean compareInBothDirection(List<LinkResource> links, LinkResource compareToLink){
        for(LinkResource linkResource: links) {
            if(
               (linkResource.getSource().getId().equals(compareToLink.getSource().getId()) && linkResource.getTarget().getId().equals(compareToLink.getTarget().getId())) ||
               (linkResource.getSource().getId().equals(compareToLink.getTarget().getId()) && linkResource.getTarget().getId().equals(compareToLink.getSource().getId()))
              ){
                return true;
            }
        }
        return false;
    }

    public boolean compareLink(List<LinkResource> links, LinkResource compareToLink){
        for(LinkResource linkResource: links) {
            if(linkResource.getSource().getId().equals(compareToLink.getSource().getId()) && linkResource.getTarget().getId().equals(compareToLink.getTarget().getId())){
                return true;
            }
        }
        return false;
    }

    public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Set<Object> seen = ConcurrentHashMap.newKeySet();
        return t -> seen.add(keyExtractor.apply(t));
    }


    public void calculateProbability(String domainId){
        List<ProblemEntity> problems = problemRepository.getAllByDomain_Md5HAndStatus_Id(domainId, ProblemStatus.ACTIVE.getId());
        int totalCredibility = problems.stream().flatMapToInt(problemEntity -> IntStream.of(problemEntity.getCredibility())).sum();
        for(ProblemEntity problemEntity: problems) {
            problemEntity.setProbability((double) problemEntity.getCredibility() / totalCredibility * 100);
            problemRepository.save(problemEntity);
        }
    }
}
