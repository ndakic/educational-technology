package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.LinkEntity;

import java.util.List;

@Repository
public interface LinkRepository extends JpaRepository<LinkEntity, Long> {

    List<LinkEntity> findAllByDomain_Md5HAndStatus_Id(String domainId, long statusId);
}
