package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.DomainEntity;

import java.util.List;

@Repository
public interface DomainRepository extends JpaRepository<DomainEntity, Long> {

    List<DomainEntity> findAllByMd5H(String domainId);
}
