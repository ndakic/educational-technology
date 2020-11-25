package uns.ac.rs.elearningserver.exception;

import lombok.Getter;
import uns.ac.rs.elearningserver.constant.ErrorCode;

@Getter
public class ResourceNotExistException extends RuntimeException {

    private ErrorCode errorCode;

    public ResourceNotExistException(String message, ErrorCode errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
