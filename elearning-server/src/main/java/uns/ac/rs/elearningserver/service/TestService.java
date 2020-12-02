package uns.ac.rs.elearningserver.service;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import uns.ac.rs.elearningserver.constant.ErrorCode;
import uns.ac.rs.elearningserver.exception.ResourceNotExistException;
import uns.ac.rs.elearningserver.model.QuestionEntity;
import uns.ac.rs.elearningserver.model.TestEntity;
import uns.ac.rs.elearningserver.repository.TestRepository;
import uns.ac.rs.elearningserver.rest.resource.Answer;
import uns.ac.rs.elearningserver.rest.resource.Question;
import uns.ac.rs.elearningserver.rest.resource.Test;

import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TestService {

    @NonNull
    private final TestRepository testRepository;

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

}
