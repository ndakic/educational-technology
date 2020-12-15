package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.ProblemEntity;

import java.util.List;

@Repository
public interface ProblemRepository extends JpaRepository<ProblemEntity, Long> {

    List<ProblemEntity> findAllByDomain_Md5HAndStatus_Id(String domainId, long statusId);
}
