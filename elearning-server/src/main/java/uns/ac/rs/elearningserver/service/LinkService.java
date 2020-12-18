package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.LinkStatus;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.ProblemStatus;
import uns.ac.rs.elearningserver.model.LinkEntity;
import uns.ac.rs.elearningserver.model.ProblemEntity;
import uns.ac.rs.elearningserver.repository.DomainRepository;
import uns.ac.rs.elearningserver.repository.LinkRepository;
import uns.ac.rs.elearningserver.repository.ProblemRepository;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.rest.resource.LinkResource;
import uns.ac.rs.elearningserver.rest.resource.ProblemResource;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class LinkService {

    @NonNull
    private final LinkRepository linkRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final DomainRepository domainRepository;
    @NonNull
    private final ProblemRepository problemRepository;


    public List<LinkResource> getAllLinksByDomainIdAndStatus(String domainId){
        return linkRepository.findAllByDomain_Md5HAndStatus_Id(domainId, LinkStatus.ACTIVE.getId())
                .stream()
                .map(LinkResource::entityToResource)
                .collect(Collectors.toList());
    }

    @Transactional
    public LinkResource save(LinkResource linkResource){
        LinkEntity linkEntity = linkRepository.save(LinkEntity.builder()
                .leftDirection(linkResource.getLeft())
                .rightDirection(linkResource.getRight())
                .source(problemRepository.findByMd5H(linkResource.getSource().getMd5h()).get())
                .target(problemRepository.findByMd5H(linkResource.getTarget().getMd5h()).get())
                .domain(domainRepository.findOneByMd5H("f36c55b1740b77205e3277ef1c030c92").get())
                .status(statusRepository.getOne(LinkStatus.ACTIVE.getId()))
                .build());
        linkEntity.setMd5h(Md5Generator.generateHash(linkEntity.getId(), Md5Salt.LINK));
        return LinkResource.entityToResource(linkEntity);
    }

    public void delete(String linkId){
        LinkEntity linkEntity = linkRepository.findOneByMd5h(linkId).get();
        linkEntity.setStatus(statusRepository.getOne(LinkStatus.DELETED.getId()));
        linkRepository.save(linkEntity);
    }

    @Transactional
    public void deleteLinks(String problemId){
        List<LinkEntity> linkEntities = linkRepository.findAllBySource_Md5HOrTarget_Md5H(problemId, problemId);
        for(LinkEntity linkEntity: linkEntities) {
            linkEntity.setStatus(statusRepository.getOne(LinkStatus.DELETED.getId()));
            linkRepository.save(linkEntity);
        }
    }
}
