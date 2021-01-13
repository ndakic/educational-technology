package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.DomainStatus;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.ProblemStatus;
import uns.ac.rs.elearningserver.model.ProblemEntity;
import uns.ac.rs.elearningserver.repository.DomainRepository;
import uns.ac.rs.elearningserver.repository.ProblemRepository;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ProblemService {

    @NonNull
    private final ProblemRepository problemRepository;
    @NonNull
    private final DomainRepository domainRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final KnowledgeSpaceService knowledgeSpaceService;


    public List<ProblemResource> getAllProblemsByDomain(String domainId){
        return problemRepository.findAllByDomain_Md5HAndStatus_Id(domainId, ProblemStatus.ACTIVE.getId())
                .stream()
                .map(ProblemResource::entityToResource)
                .collect(Collectors.toList());
    }

    @Transactional
    public ProblemResource save(ProblemResource problem){
        ProblemEntity problemEntity = problemRepository.save(ProblemEntity.builder()
                .title(problem.getTitle())
                .domain(domainRepository.findOneByMd5H(problem.getDomain().getId()).get())
                .reflexive(problem.getReflexive())
                .credibility(problem.getCredibility())
                .probability(problem.getProbability())
                .status(statusRepository.getOne(ProblemStatus.ACTIVE.getId()))
                .knowledgeState(String.join(",", problem.getKnowledgeState()))
                .x(problem.getX())
                .y(problem.getY())
                .build());
        problemEntity.setMd5H(Md5Generator.generateHash(problemEntity.getId(), Md5Salt.PROBLEM));
        knowledgeSpaceService.calculateProbability(problem.getDomain().getId());
        return ProblemResource.entityToResource(problemEntity);
    }

    public ProblemResource delete(String problemId){
        ProblemEntity problemEntity = problemRepository.findByMd5H(problemId).get();
        problemEntity.setStatus(statusRepository.getOne(ProblemStatus.DELETED.getId()));
        problemRepository.save(problemEntity);
        knowledgeSpaceService.calculateProbability(problemEntity.getDomain().getMd5H());
        return ProblemResource.entityToResource(problemEntity);
    }

    public ProblemResource update(ProblemResource problem){
        ProblemEntity problemEntity = problemRepository.findByMd5H(problem.getMd5h()).get();
        problemEntity.setTitle(problem.getTitle());
        problemEntity.setProbability(problem.getProbability());
        problemEntity.setCredibility(problem.getCredibility());
        problemEntity.setKnowledgeState(String.join(",", problem.getKnowledgeState()));
        problemRepository.save(problemEntity);
        return ProblemResource.entityToResource(problemEntity);
    }
}
