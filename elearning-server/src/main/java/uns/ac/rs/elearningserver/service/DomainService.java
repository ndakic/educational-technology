package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.DomainStatus;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.model.DomainEntity;
import uns.ac.rs.elearningserver.repository.DomainRepository;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.repository.UserRepository;
import uns.ac.rs.elearningserver.rest.resource.DomainResource;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class DomainService {

    @NonNull
    private final DomainRepository domainRepository;
    @NonNull
    private final UserRepository userRepository;
    @NonNull
    private final StatusRepository statusRepository;


    public List<DomainResource> get(String domainId){
        return domainRepository.findAllByMd5H(domainId)
                .stream()
                .map(DomainResource::entityToResource)
                .collect(Collectors.toList());
    }

    @Transactional
    public DomainResource save(DomainResource domain){
        DomainEntity domainEntity = domainRepository.save(DomainEntity.builder()
                .title(domain.getTitle())
                .user(userRepository.findOneByMd5H(domain.getUser().getId()).get())
                .status(statusRepository.getOne(DomainStatus.ACTIVE.getId()))
                .build());
        domainEntity.setMd5H(Md5Generator.generateHash(domainEntity.getId(), Md5Salt.DOMAIN));
        return domain;
    }
}
