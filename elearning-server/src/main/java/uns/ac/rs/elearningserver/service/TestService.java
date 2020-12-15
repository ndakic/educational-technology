package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.TestStatus;
import uns.ac.rs.elearningserver.constant.UserType;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.AnswerEntity;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.model.TestEntity;
import uns.ac.rs.elearningserver.repository.*;
import uns.ac.rs.elearningserver.rest.resource.AnswerResource;
import uns.ac.rs.elearningserver.rest.resource.QuestionResource;
import uns.ac.rs.elearningserver.rest.resource.TestResource;
import uns.ac.rs.elearningserver.util.DateUtil;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TestService {

    @NonNull
    private final TestRepository testRepository;
    @NonNull
    private final QuestionRepository questionRepository;
    @NonNull
    private final AnswerRepository answerRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final UserRepository userRepository;

    public TestResource get(String testId){
        TestEntity testEntity = testRepository.getOnyByMd5H(testId).orElseThrow(() ->
                new ResourceNotExistException(String.format("Test with %s not found!", testId), ErrorCode.NOT_FOUND));
        return TestResource.builder()
                .id(testEntity.getMd5H())
                .title(testEntity.getTitle())
                .startDate(testEntity.getStartDate())
                .endDate(testEntity.getEndDate())
                .teacherId(testEntity.getTeacher().getMd5H())
                .questions(testEntity.getQuestions()
                        .stream()
                        .map(questionEntity -> QuestionResource.builder()
                                .id(questionEntity.getMd5H())
                                .text(questionEntity.getText())
                                .testId(questionEntity.getTest().getMd5H())
                                .answers(questionEntity.getAnswers()
                                        .stream()
                                        .map(answerEntity -> AnswerResource.builder()
                                                .answerId(answerEntity.getMd5H())
                                                .text(answerEntity.getText())
                                                .questionId(answerEntity.getQuestion().getMd5H())
                                                .build())
                                        .collect(Collectors.toList()))
                                .build())
                        .collect(Collectors.toList()))
                .build();
    }

    public List<TestResource> getAll(){
        return testRepository.findAll()
                .stream()
                .map(testEntity -> TestResource.builder()
                            .id(testEntity.getMd5H())
                            .title(testEntity.getTitle())
                            .startDate(testEntity.getStartDate())
                            .endDate(testEntity.getEndDate())
                            .teacherId(testEntity.getTeacher().getMd5H())
                            .questions(testEntity.getQuestions()
                                    .stream()
                                    .map(questionEntity -> QuestionResource.builder()
                                            .id(questionEntity.getMd5H())
                                            .text(questionEntity.getText())
                                            .testId(questionEntity.getTest().getMd5H())
                                            .answers(questionEntity.getAnswers()
                                                    .stream()
                                                    .map(answerEntity -> AnswerResource.builder()
                                                            .answerId(answerEntity.getMd5H())
                                                            .text(answerEntity.getText())
                                                            .questionId(answerEntity.getQuestion().getMd5H())
                                                            .build())
                                                    .collect(Collectors.toList()))
                                            .build())
                                    .collect(Collectors.toList()))
                        .build())
                .collect(Collectors.toList());
    }

    @Transactional
    public TestResource create(TestResource resource){

        TestEntity test = TestEntity.builder()
                .title(resource.getTitle())
                .teacher(userRepository.findOneByMd5HAndUserType(resource.getTeacherId(), UserType.TEACHER).get())
                .status(statusRepository.getOne(TestStatus.ACTIVE.getId()))
                .creationDate(DateUtil.nowSystemTime())
                .startDate(resource.getStartDate())
                .endDate(resource.getEndDate())
                .build();
        testRepository.save(test);
        test.setMd5H(Md5Generator.generateHash(test.getId(), Md5Salt.TEST));

        for (QuestionResource qResource : resource.getQuestions()) {
            QuestionEntity question = QuestionEntity.builder()
                    .text(qResource.getText())
                    .status(statusRepository.getOne(TestStatus.ACTIVE.getId()))
                    .test(test)
                    .build();
            questionRepository.save(question);
            question.setMd5H(Md5Generator.generateHash(question.getId(), Md5Salt.TEST));
            for (AnswerResource aResource: qResource.getAnswers()) {
                AnswerEntity answer = AnswerEntity.builder()
                        .text(aResource.getText())
                        .isCorrect(aResource.isCorrect())
                        .status(statusRepository.getOne(TestStatus.ACTIVE.getId()))
                        .question(question)
                        .build();
                answerRepository.save(answer);
                answer.setMd5H(Md5Generator.generateHash(answer.getId(), Md5Salt.TEST));
            }
        }

        resource.setId(test.getMd5H());
        return resource;
    }

}
