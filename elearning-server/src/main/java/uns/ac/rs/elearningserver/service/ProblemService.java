package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ProblemStatus;
import uns.ac.rs.elearningserver.repository.ProblemRepository;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ProblemService {

    @NonNull
    private final ProblemRepository problemRepository;


    public List<ProblemResource> getAllProblemsByDomain(String domainId){
        return problemRepository.findAllByDomain_Md5HAndStatus_Id(domainId, ProblemStatus.ACTIVE.getId())
                .stream()
                .map(ProblemResource::entityToResource)
                .collect(Collectors.toList());
    }
}
