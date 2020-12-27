package uns.ac.rs.elearningserver.exception;

import lombok.Getter;
import uns.ac.rs.elearningserver.constant.ErrorCode;

@Getter
public class ResourceException extends RuntimeException {

    private final ErrorCode errorCode;

    public ResourceException(String message, ErrorCode errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
