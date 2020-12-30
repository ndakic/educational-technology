package uns.ac.rs.elearningserver.model;

import jdk.nashorn.internal.ir.annotations.Ignore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "test")
@SequenceGenerator(name = "test_id_seq", sequenceName = "test_id_seq", allocationSize = 1)
@NoArgsConstructor
@AllArgsConstructor
@Builder
@XmlRootElement
public class TestEntity implements Serializable {

    private long id;
    private String md5H;
    private String title;
    private UserEntity teacher;
    private Timestamp creationDate;
    private Timestamp startDate;
    private Timestamp endDate;
    private StatusEntity status;
    private DomainEntity domain;
    private Set<QuestionEntity> questions;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "test_id_seq")
    @Column(name = "test_id")
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
    @XmlElement
    public void setTitle(String title) {
        this.title = title;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "euser_id", referencedColumnName = "euser_id", nullable = false)
    public UserEntity getTeacher() {
        return teacher;
    }
    @XmlElement
    public void setTeacher(UserEntity teacher) {
        this.teacher = teacher;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }
    @XmlElement
    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public Timestamp getStartDate() {
        return startDate;
    }
    @XmlElement
    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }
    @XmlElement
    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    @OneToMany(mappedBy = "test", fetch = FetchType.EAGER)
    public Set<QuestionEntity> getQuestions() {
        return questions;
    }
    @XmlElement(name = "qti-questions")
    public void setQuestions(Set<QuestionEntity> questions) {
        this.questions = questions;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "status_id", referencedColumnName = "status_id", nullable = false)
    public StatusEntity getStatus() {
        return status;
    }

    public void setStatus(StatusEntity status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "domain_id", referencedColumnName = "domain_id")
    public DomainEntity getDomain() {
        return domain;
    }
    @Ignore
    @XmlTransient
    public void setDomain(DomainEntity domain) {
        this.domain = domain;
    }
}
