package uns.ac.rs.elearningserver.util;

import lombok.experimental.UtilityClass;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@UtilityClass
public class FileUtil {

    /*
        WARNING: THIS CAN BE USED ONLY FOR pisa.txt file
     */
    public Map<String, int[]> readFromInputStream(InputStream inputStream) throws IOException {
        Map<String, int[]> result = new HashMap<>();
        List<Integer> a = new ArrayList<>(), b = new ArrayList<>(), c = new ArrayList<>(), d = new ArrayList<>(), e = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream))) {
            br.readLine(); // skip first line
            String line;
            while ((line = br.readLine()) != null) {
                String [] data = line.split(" ");
                a.add(Integer.parseInt(data[1].trim()));
                b.add(Integer.parseInt(data[2].trim()));
                c.add(Integer.parseInt(data[3].trim()));
                d.add(Integer.parseInt(data[4].trim()));
                e.add(Integer.parseInt(data[5].trim()));
            }
            result.put("a", a.stream().mapToInt(i->i).toArray());
            result.put("b", b.stream().mapToInt(i->i).toArray());
            result.put("c", c.stream().mapToInt(i->i).toArray());
            result.put("d", d.stream().mapToInt(i->i).toArray());
            result.put("e", e.stream().mapToInt(i->i).toArray());
        }
        return result;
    }
}
