package uns.ac.rs.elearningserver.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "question")
@SequenceGenerator(name = "question_id_seq", sequenceName = "question_id_seq", allocationSize = 1)
@NoArgsConstructor
@AllArgsConstructor
@Builder
@XmlRootElement
public class QuestionEntity implements Serializable {

    private long id;
    private String md5H;
    private String text;
    private Integer position;
    private TestEntity test;
    private ProblemEntity problem;
    private StatusEntity status;
    private Set<AnswerEntity> answers;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "question_id_seq")
    @Column(name = "question_id")
    public long getId() {
        return id;
    }
    @XmlTransient
    public void setId(long id) {
        this.id = id;
    }

    public String getMd5H() {
        return md5H;
    }
    @XmlTransient
    public void setMd5H(String md5H) {
        this.md5H = md5H;
    }

    public String getText() {
        return text;
    }

    @XmlElement(name = "p")
    public void setText(String text) {
        this.text = text;
    }

    public Integer getPosition() {
        return position;
    }
    @XmlTransient
    public void setPosition(Integer position) {
        this.position = position;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "test_id", referencedColumnName = "test_id", nullable = false)
    public TestEntity getTest() {
        return test;
    }

    @XmlTransient
    public void setTest(TestEntity test) {
        this.test = test;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "problem_id", referencedColumnName = "problem_id")
    public ProblemEntity getProblem() {
        return problem;
    }
    @XmlTransient
    public void setProblem(ProblemEntity problem) {
        this.problem = problem;
    }

    @OneToMany(mappedBy = "question", fetch = FetchType.EAGER)
    public Set<AnswerEntity> getAnswers() {
        return answers;
    }
    @XmlElement(name = "qti-choice-interaction")
    public void setAnswers(Set<AnswerEntity> answers) {
        this.answers = answers;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "status_id", referencedColumnName = "status_id", nullable = false)
    public StatusEntity getStatus() {
        return status;
    }
    @XmlTransient
    public void setStatus(StatusEntity status) {
        this.status = status;
    }
}
