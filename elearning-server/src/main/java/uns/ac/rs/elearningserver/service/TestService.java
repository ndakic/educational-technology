package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.constant.Md5Salt;
import uns.ac.rs.elearningserver.constant.QuestionStatus;
import uns.ac.rs.elearningserver.constant.TestStatus;
import uns.ac.rs.elearningserver.constant.UserType;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.model.TestEntity;
import uns.ac.rs.elearningserver.repository.StatusRepository;
import uns.ac.rs.elearningserver.repository.TestRepository;
import uns.ac.rs.elearningserver.repository.UserRepository;
import uns.ac.rs.elearningserver.rest.resource.Answer;
import uns.ac.rs.elearningserver.rest.resource.Question;
import uns.ac.rs.elearningserver.rest.resource.Test;
import uns.ac.rs.elearningserver.util.DateUtil;
import uns.ac.rs.elearningserver.util.Md5Generator;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TestService {

    @NonNull
    private final TestRepository testRepository;
    @NonNull
    private final StatusRepository statusRepository;
    @NonNull
    private final UserRepository userRepository;

    public Test.Resource get(String testId){
        TestEntity testEntity = testRepository.getOnyByMd5H(testId).orElseThrow(() -> new ResourceNotExistException(String.format("Test with %s not found!", testId), ErrorCode.NOT_FOUND));
        return Test.Resource.builder()
                .id(testEntity.getMd5H())
                .title(testEntity.getTitle())
                .startDate(testEntity.getStartDate())
                .endDate(testEntity.getEndDate())
                .teacherId(testEntity.getTeacher().getMd5H())
                .questions(testEntity.getQuestions()
                        .stream()
                        .map(questionEntity -> Question.Resource.builder()
                                .id(questionEntity.getMd5H())
                                .text(questionEntity.getText())
                                .testId(questionEntity.getTest().getMd5H())
                                .answers(questionEntity.getAnswers()
                                        .stream()
                                        .map(answerEntity -> Answer.Resource.builder()
                                                .answerId(answerEntity.getMd5H())
                                                .text(answerEntity.getText())
                                                .questionId(answerEntity.getQuestion().getMd5H())
                                                .build())
                                        .collect(Collectors.toList()))
                                .build())
                        .collect(Collectors.toList()))
                .build();
    }

    public List<Test.Resource> getAll(){
        return testRepository.findAll()
                .stream()
                .map(testEntity -> Test.Resource.builder()
                            .id(testEntity.getMd5H())
                            .title(testEntity.getTitle())
                            .startDate(testEntity.getStartDate())
                            .endDate(testEntity.getEndDate())
                            .teacherId(testEntity.getTeacher().getMd5H())
                            .questions(testEntity.getQuestions()
                                    .stream()
                                    .map(questionEntity -> Question.Resource.builder()
                                            .id(questionEntity.getMd5H())
                                            .text(questionEntity.getText())
                                            .testId(questionEntity.getTest().getMd5H())
                                            .answers(questionEntity.getAnswers()
                                                    .stream()
                                                    .map(answerEntity -> Answer.Resource.builder()
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
    public Test.Resource create(Test.Resource resource){
        TestEntity test = TestEntity.builder()
                .title(resource.getTitle())
                .teacher(userRepository.findOneByMd5HAndUserType(resource.getTeacherId(), UserType.TEACHER).get())
                .status(statusRepository.getOne(TestStatus.ACTIVE.getId()))
                .creationDate(DateUtil.nowSystemTime())
                .startDate(resource.getStartDate())
                .endDate(resource.getEndDate())
//                .questions() TODO: set questions
                .build();
        testRepository.save(test);
        test.setMd5H(Md5Generator.generateHash(test.getId(), Md5Salt.TEST));
        resource.setId(test.getMd5H());
        return resource;
    }

}
