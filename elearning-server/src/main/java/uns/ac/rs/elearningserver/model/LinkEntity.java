package uns.ac.rs.elearningserver.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "link")
@SequenceGenerator(name = "link_id_seq", sequenceName = "link_id_seq", allocationSize = 1)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LinkEntity {

    private long id;
    private ProblemEntity source;
    private ProblemEntity target;
    private Boolean left;
    private Boolean right;
    private StatusEntity status;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "link_id_seq")
    @Column(name = "link_id_seq")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "source_problem_id", referencedColumnName = "problem_id")
    public ProblemEntity getSource() {
        return source;
    }

    public void setSource(ProblemEntity source) {
        this.source = source;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "target_problem_id", referencedColumnName = "problem_id")
    public ProblemEntity getTarget() {
        return target;
    }

    public void setTarget(ProblemEntity target) {
        this.target = target;
    }

    public Boolean getLeft() {
        return left;
    }

    public void setLeft(Boolean left) {
        this.left = left;
    }

    public Boolean getRight() {
        return right;
    }

    public void setRight(Boolean right) {
        this.right = right;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id", referencedColumnName = "status_id", nullable = false)
    public StatusEntity getStatus() {
        return status;
    }

    public void setStatus(StatusEntity status) {
        this.status = status;
    }
}
