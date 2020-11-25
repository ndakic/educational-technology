package uns.ac.rs.elearningserver.constant;

import lombok.Getter;

@Getter
public enum Md5Salt {

    USER("ElearningUserSalt444"),
    TEST("ElearningTestSalt332"),
    QUESTION("ElearningQuestionSalt843"),
    ANSWER("ElearningAnswerSalt221");

    private final String salt;

    Md5Salt(String salt) {
        this.salt = salt;
    }
}
