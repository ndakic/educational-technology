package uns.ac.rs.elearningserver.service;

import lombok.AllArgsConstructor;
import lombok.NonNull;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.LinkStatus;
import uns.ac.rs.elearningserver.repository.LinkRepository;
import uns.ac.rs.elearningserver.rest.resource.LinkResource;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class LinkService {

    @NonNull
    private final LinkRepository linkRepository;


    public List<LinkResource> getAllLinksByDomainIdAndStatus(String domainId){
        return linkRepository.findAllByDomain_Md5HAndStatus_Id(domainId, LinkStatus.ACTIVE.getId())
                .stream()
                .map(LinkResource::entityToResource)
                .collect(Collectors.toList());
    }
}
