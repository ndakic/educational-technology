package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.model.TestEntity;
import uns.ac.rs.elearningserver.repository.TestRepository;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import java.io.File;

@Service
@RequiredArgsConstructor
public class ExportService {

    @NonNull
    private final TestRepository testRepository;

    public File exportToMsiQti(String testId){
        TestEntity testEntity = testRepository.getOnyByMd5H(testId).get();
        try {
            File file = new File("MSI-QTI-Test.xml");
            JAXBContext jaxbContext = JAXBContext.newInstance(TestEntity.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            // output pretty printed
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            jaxbMarshaller.marshal(testEntity, file);
            jaxbMarshaller.marshal(testEntity, System.out);
            return file;
        } catch (JAXBException e) {
            e.printStackTrace();
        }
        return null;
    }
}
