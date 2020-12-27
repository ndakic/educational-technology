package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.ProblemEntity;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProblemRepository extends JpaRepository<ProblemEntity, Long> {

    List<ProblemEntity> findAllByDomain_Md5HAndStatus_Id(String domainId, long statusId);

    Optional<ProblemEntity> findByMd5H(String problemId);

    List<ProblemEntity> findAllByQuestion_Test_Md5H(String testId);
}
