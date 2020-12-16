package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.DomainEntity;

import java.util.List;
import java.util.Optional;

@Repository
public interface DomainRepository extends JpaRepository<DomainEntity, Long> {

    List<DomainEntity> findAllByMd5H(String domainId);

    Optional<DomainEntity> findOneByMd5H(String domainId);
}
