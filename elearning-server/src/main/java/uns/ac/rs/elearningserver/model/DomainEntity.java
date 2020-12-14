package uns.ac.rs.elearningserver.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "domain")
@SequenceGenerator(name = "domain_id_seq", sequenceName = "domain_id_seq", allocationSize = 1)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DomainEntity {

    private long id;
    private String md5H;
    private String title;
    private StatusEntity status;
    private UserEntity user;
    private Collection<ProblemEntity> problems;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "domain_id_seq")
    @Column(name = "domain_id")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getMd5H() {
        return md5H;
    }

    public void setMd5H(String md5H) {
        this.md5H = md5H;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id", referencedColumnName = "status_id", nullable = false)
    public StatusEntity getStatus() {
        return status;
    }

    public void setStatus(StatusEntity status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "euser_id", referencedColumnName = "euser_id", nullable = false)
    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

    @OneToMany(mappedBy = "domain", fetch = FetchType.EAGER)
    public Collection<ProblemEntity> getProblems() {
        return problems;
    }

    public void setProblems(Collection<ProblemEntity> problems) {
        this.problems = problems;
    }
}
