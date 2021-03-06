package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.*;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.AnswerEntity;
import uns.ac.rs.elearningserver.model.ProblemEntity;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.model.TestEntity;
import uns.ac.rs.elearningserver.model.UserEntity;
import uns.ac.rs.elearningserver.repository.*;
import uns.ac.rs.elearningserver.rest.resource.*;
import uns.ac.rs.elearningserver.util.DateUtil;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.Comparator;
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
    private final DomainRepository domainRepository;
    @NonNull
    private final ProblemRepository problemRepository;
    @NonNull
    private final AnswerRepository answerRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final UserRepository userRepository;

    @Transactional
    public TestResource get(String testId){
        TestEntity testEntity = testRepository.getOnyByMd5H(testId).orElseThrow(() -> new ResourceNotExistException(String.format("Test with %s not found!", testId), ErrorCode.NOT_FOUND));
        return TestResource.builder()
                .id(testEntity.getMd5H())
                .title(testEntity.getTitle())
                .startDate(testEntity.getStartDate())
                .endDate(testEntity.getEndDate())
                .teacher(UserResource.entityToResource(testEntity.getTeacher()))
                .questions(testEntity.getQuestions()
                        .stream()
                        .map(questionEntity -> QuestionResource.builder()
                                .id(questionEntity.getMd5H())
                                .text(questionEntity.getText())
                                .testId(questionEntity.getTest().getMd5H())
                                .probability(questionEntity.getProblem().getProbability())
                                .problem(ProblemResource.entityToResource(questionEntity.getProblem()))
                                .answers(questionEntity.getAnswers()
                                        .stream()
                                        .map(answerEntity -> AnswerResource.builder()
                                                .answerId(answerEntity.getMd5H())
                                                .text(answerEntity.getText())
                                                .questionId(answerEntity.getQuestion().getMd5H())
                                                .build())
                                        .collect(Collectors.toList()))
                                .build())
                        .sorted(Comparator.comparingDouble(QuestionResource::getProbability).reversed())
                        .collect(Collectors.toList()))
                .domain(DomainResource.entityToResource(testEntity.getDomain()))
                .mockedUser(mockNewUser())
                .build();
    }

    @Transactional
    public void delete(String testId){
        TestEntity testEntity = testRepository.getOnyByMd5H(testId).get();
        for (QuestionEntity q: testEntity.getQuestions()) {
            for (AnswerEntity a : q.getAnswers()) {
                answerRepository.deleteByMd5H(a.getMd5H());
            }
            questionRepository.deleteByMd5H(q.getMd5H());
        }
        testRepository.deleteByMd5H(testId);
    }

    public List<TestResource> getAll(){
        return testRepository.findAll()
                .stream()
                .map(testEntity -> TestResource.builder()
                            .id(testEntity.getMd5H())
                            .title(testEntity.getTitle())
                            .startDate(testEntity.getStartDate())
                            .endDate(testEntity.getEndDate())
                            .teacher(UserResource.entityToResource(testEntity.getTeacher()))
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
                .teacher(userRepository.findOneByMd5HAndUserType(resource.getTeacher().getId(), UserType.TEACHER).get())
                .status(statusRepository.getOne(TestStatus.ACTIVE.getId()))
                .domain(domainRepository.findOneByMd5H(resource.getDomain().getId()).get())
                .creationDate(DateUtil.nowSystemTime())
                .startDate(resource.getStartDate())
                .endDate(resource.getEndDate())
                .build();
        testRepository.save(test);
        test.setMd5H(Md5Generator.generateHash(test.getId(), Md5Salt.TEST));
        for (QuestionResource qResource : resource.getQuestions()) {
            QuestionEntity question = QuestionEntity.builder()
                    .text(qResource.getText())
                    .status(statusRepository.getOne(QuestionStatus.ACTIVE.getId()))
                    .problem(problemRepository.findByMd5H(qResource.getProblem().getMd5h()).get())
                    .test(test)
                    .build();
            questionRepository.save(question);
            question.setMd5H(Md5Generator.generateHash(question.getId(), Md5Salt.QUESTION));
            for (AnswerResource aResource: qResource.getAnswers()) {
                AnswerEntity answer = AnswerEntity.builder()
                        .text(aResource.getText())
                        .isCorrect(aResource.isCorrect())
                        .status(statusRepository.getOne(AnswerStatus.ACTIVE.getId()))
                        .question(question)
                        .build();
                answerRepository.save(answer);
                answer.setMd5H(Md5Generator.generateHash(answer.getId(), Md5Salt.ANSWER));
            }
        }
        resource.setId(test.getMd5H());
        return resource;
    }


    public UserResource mockNewUser(){
        UserEntity mockedUser = UserEntity.builder()
                .firstName("FirstName")
                .lastName("LastName")
                .email("Email")
                .password("1234")
                .registrationDate(DateUtil.nowSystemTime())
                .userType(UserType.STUDENT)
                .status(statusRepository.getOne(UserStatus.ACTIVE.getId()))
                .build();
        userRepository.save(mockedUser);
        mockedUser.setMd5H(Md5Generator.generateHash(mockedUser.getId(), Md5Salt.USER));
        return UserResource.entityToResource(mockedUser);
    }
}
