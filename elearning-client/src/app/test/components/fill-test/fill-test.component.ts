import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Router } from '@angular/router';
import { AnswerService } from '../../services/answer.service';
import { QuestionService } from '../../services/question.service';
import { Location } from '@angular/common';

class Answer {
  public answerId: string;
  public userId: string;
  public questionId: string;

  constructor(answerId: string, userId: string, questionId: string){
    this.answerId = answerId;
    this.userId = userId;
    this.questionId = questionId;
  }
}

@Component({
  selector: 'app-fill-test',
  templateUrl: './fill-test.component.html',
  styleUrls: ['./fill-test.component.css']
})
export class FillTestComponent implements OnInit {

  public test: any;
  public currentQuestion: any;
  public selectedAnswer: any;
  public testFinishedMessage = false;

  constructor(
    private answerService: AnswerService, 
    private route: ActivatedRoute, 
    private router: Router, 
    private _location: Location,
    private questionService: QuestionService) {
  }

  ngOnInit(): void {
    this.test = this.route.snapshot.data["data"]["test"];
    this.loadNextQuestion();
  }

  back() {
    this._location.back();
  }

  setAnswer(checked, answer){
    if(checked) {
      this.selectedAnswer = answer;
      console.log(checked, answer);
    }
  }

  submitAnswer(){
    this.answerService.submitAnswer(new Answer(this.selectedAnswer.answerId, this.test.mockedUser.id, this.currentQuestion.id))
                      .subscribe(() => this.loadNextQuestion())
  }

  /*
    Deprecated
  */
  removeSubQuestions(title: string){
    this.test.questions.forEach(question => {
      if(question['problem']['knowledgeState'].includes(title) && question['id'] !== this.selectedAnswer['questionId']) {
        this.answerService.rejectedQuestion(question['id'], '5bc67bef74afd2fb0f5a370d72b1c913').subscribe(response => {
          const index = this.test.questions.indexOf(question);
          this.test.questions.splice(index, 1);
        });
      }
    });
  }

  loadNextQuestion(){
    this.questionService.getQuestion(this.test.id, this.test.mockedUser.id).subscribe(question => {
      this.currentQuestion = question
      if(!question) {
        this.testFinishedMessage = true;
      }
    });
  }
}
