package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.repository.DomainRepository;
import uns.ac.rs.elearningserver.rest.resource.DomainResource;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class DomainService {

    @NonNull
    private final DomainRepository domainRepository;


    public List<DomainResource> get(String domainId){
        return domainRepository.findAllByMd5H(domainId)
                .stream()
                .map(DomainResource::entityToResource)
                .collect(Collectors.toList());
    }
}
