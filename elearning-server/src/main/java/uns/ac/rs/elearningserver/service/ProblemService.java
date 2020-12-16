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
                .domain(domainRepository.findOneByMd5H("f36c55b1740b77205e3277ef1c030c92").get())
                .reflexive(problem.getReflexive())
                .status(statusRepository.getOne(DomainStatus.ACTIVE.getId()))
                .build());
        problemEntity.setMd5H(Md5Generator.generateHash(problemEntity.getId(), Md5Salt.PROBLEM));
        return problem;
    }
}
