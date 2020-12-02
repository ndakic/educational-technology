package uns.ac.rs.elearningserver.util;

import lombok.experimental.UtilityClass;
import uns.ac.rs.elearningserver.constant.DateTimeConstant;

import java.sql.Timestamp;
import java.time.ZonedDateTime;

@UtilityClass
public class DateUtil {

    public Timestamp nowSystemTime() {
        return Timestamp.valueOf(ZonedDateTime.now(DateTimeConstant.SYSTEM_TIMEZONE).toLocalDateTime());
    }
}
