import { Component, OnInit } from '@angular/core';
import { TestService } from '../../services/test.service';
import { Router } from '@angular/router';

class Test {
  public title: string;
  public startDate: Date;
  public endDate: Date;
  public teacherId: string = "5bc67bef74afd2fb0f5a370d72b1c913";
  public questions: Array<Question> = [];
}

class Question {
  public text: string;
  public answers: Array<Answer> = [];
}

class Answer {
  public text: string;
  public isCorrect: boolean = false;
}

@Component({
  selector: 'app-create-test',
  templateUrl: './create-test.component.html',
  styleUrls: ['./create-test.component.css']
})
export class CreateTestComponent implements OnInit {

  public test: Test;

  constructor(private testService: TestService, private router: Router) {
  }

  ngOnInit(): void {
    this.test = new Test();
  }

  createTest(): void {
    this.testService.createTest(this.test).subscribe(
      response => {
        this.router.navigate(['/test/preview'])
        .then(success => console.log('navigation success?' , success))
        .catch(console.error); 
      },
      error => {
        alert("Error occured: " + error);
      });
  }

  addQuestion(): void {
    this.test.questions.push(new Question());
  }

  removeQuestion(questionIndex: number): void {
    this.test.questions.splice(questionIndex, 1);
  }

  addAnswer(question: Question): void {
    question.answers.push(new Answer());
  }

  removeAnswer(question: Question, answerIndex: number): void {
    question.answers.splice(answerIndex, 1);
  }

}
