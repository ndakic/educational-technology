package uns.ac.rs.elearningserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import uns.ac.rs.elearningserver.model.TestEntity;

@Repository
public interface TestRepository extends JpaRepository<TestEntity, Long> {
}
