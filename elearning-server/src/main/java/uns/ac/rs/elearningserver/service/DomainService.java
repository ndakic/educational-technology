package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.DomainStatus;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
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

    public DomainResource get(String domainId){
        return domainRepository.findOneByMd5H(domainId)
                .map(DomainResource::entityToResource)
                .orElse(null);
    }

    public List<DomainResource> getAll(){
        return domainRepository.findAll()
                .stream()
                .filter(domainEntity -> domainEntity.getStatus().getId() == DomainStatus.ACTIVE.getId())
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
        domain.setId(domainEntity.getMd5H());
        return domain;
    }

    public void delete(String domainId){
        DomainEntity domainEntity = domainRepository.findOneByMd5H(domainId).orElseThrow(() -> new ResourceNotExistException("Domain not exist! ", ErrorCode.NOT_FOUND));
        domainEntity.setStatus(statusRepository.getOne(DomainStatus.DELETED.getId()));
        domainRepository.save(domainEntity);
    }
}
