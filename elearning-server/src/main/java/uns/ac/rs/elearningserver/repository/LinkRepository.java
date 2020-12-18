package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.LinkEntity;

import java.util.List;
import java.util.Optional;

@Repository
public interface LinkRepository extends JpaRepository<LinkEntity, Long> {

    List<LinkEntity> findAllByDomain_Md5HAndStatus_Id(String domainId, long statusId);

    Optional<LinkEntity> findOneByMd5h(String linkId);

    List<LinkEntity> findAllBySource_Md5HOrTarget_Md5H(String sourceId, String targetId);
}
