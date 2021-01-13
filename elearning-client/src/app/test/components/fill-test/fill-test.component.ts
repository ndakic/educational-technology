import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Router } from '@angular/router';
import { AnswerService } from '../../services/answer.service';
import { Location } from '@angular/common';


class Answer {
  public answerId: string;
  public userId: string = "5bc67bef74afd2fb0f5a370d72b1c913";
  public questionId: string;
}

@Component({
  selector: 'app-fill-test',
  templateUrl: './fill-test.component.html',
  styleUrls: ['./fill-test.component.css']
})
export class FillTestComponent implements OnInit {

  public test: any;
  public answers: Array<string> = [];
  public selectedAnswer: any;

  constructor(private answerService: AnswerService, private route: ActivatedRoute, private router: Router, private _location: Location) {
  }

  ngOnInit(): void {
    this.test = this.route.snapshot.data["data"]["test"];
  }

  addOrRemoveAnswer(event: any, answerId: string): void {
    if (event.checked) {
      this.answers.push(answerId);
    } else {
      const index = this.answers.indexOf(answerId);
      if (index > -1) {
        this.answers.splice(index, 1);
      }
    }
  }

  submitAnswers(): void {
    var answers = [];
    for (let i=0; i< this.answers.length; i++) {
      var answer = new Answer();
      answer.answerId = this.answers[i];
      answers.push(answer);
    }
    this.answerService.submitAnswers(answers).subscribe(
      response => {
        this.router.navigate(['/'])
        .then(success => console.log('navigation success?' , success))
        .catch(console.error); 
      },
      error => {
        console.log(error)
        alert("Error occured: " + error);
      });
  }

  setAnswer(checked, answer){
    if(checked) {
      this.selectedAnswer = answer;
      console.log(checked, answer);
    }
  }

  submitAnswer(question){
    var answer = new Answer();
    answer.answerId = this.selectedAnswer.answerId;
    answer.questionId = question.id;
    this.answerService.submitAnswer(answer).subscribe((response: any) => {
      /*
        if answer is wrong, remove questions
      */
      if(!response.correct) {
        this.removeSubQuestions(response['problem']['title']);
      }
      question.answered = true;
    })
  }

  removeSubQuestions(title: string){
    this.test.questions.forEach(question => {
      console.log("\t ", question['problem']['knowledgeState'], " ", title)
      if(question['problem']['knowledgeState'].includes(title) && question['id'] !== this.selectedAnswer['questionId']) {
        this.answerService.rejectedQuestion(question['id'], '5bc67bef74afd2fb0f5a370d72b1c913').subscribe(response => {
          const index = this.test.questions.indexOf(question);
          this.test.questions.splice(index, 1);
        });
      }
    });
  }

  back() {
    this._location.back();
  }

}
