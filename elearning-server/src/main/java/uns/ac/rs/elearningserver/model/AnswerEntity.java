package uns.ac.rs.elearningserver.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "answer")
@SequenceGenerator(name = "answer_id_seq", sequenceName = "answer_id_seq", allocationSize = 1)
@NoArgsConstructor
@AllArgsConstructor
@Builder
@XmlRootElement
public class AnswerEntity {

    private long id;
    private String md5H;
    private String text;
    private QuestionEntity question;
    private StatusEntity status;
    private Boolean isCorrect;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "answer_id_seq")
    @Column(name = "answer_id")
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
    @XmlElement(name = "qti-simple-choice")
    public void setText(String text) {
        this.text = text;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", referencedColumnName = "question_id", nullable = false)
    public QuestionEntity getQuestion() {
        return question;
    }

    @XmlTransient
    public void setQuestion(QuestionEntity question) {
        this.question = question;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id", referencedColumnName = "status_id", nullable = false)
    public StatusEntity getStatus() {
        return status;
    }
    @XmlTransient
    public void setStatus(StatusEntity status) {
        this.status = status;
    }

    public Boolean getCorrect() {
        return isCorrect;
    }
    @XmlElement(name = "qti-correct-response")
    public void setCorrect(Boolean correct) {
        isCorrect = correct;
    }
}
