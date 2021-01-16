import { Component, OnInit } from '@angular/core';
import { TestService } from '../../services/test.service';
import { DomainService } from 'src/app/domain/services/domain.service';
import { Router } from '@angular/router';
import { Location } from '@angular/common';

class Test {
  public title: string;
  public startDate: Date;
  public endDate: Date;
  public teacher: object = {id: "8d4aff29071ddee43ffa150a3c7aace8"};
  public domain: any;
  public questions: Array<Question> = [];
}

class Question {
  public text: string;
  public answers: Array<Answer> = [];
  public problem: any;
}

class Answer {
  public text: string;
  public correct: boolean = false;
}

@Component({
  selector: 'app-create-test',
  templateUrl: './create-test.component.html',
  styleUrls: ['./create-test.component.css']
})
export class CreateTestComponent implements OnInit {

  public test: Test;
  public domains: any = [];
  public problems: any = [];
  public testErrorMessage = false;

  constructor(private testService: TestService, private domainService: DomainService, private router: Router, private _location: Location) {
  }

  ngOnInit(): void {
    this.test = new Test();
    this.domainService.getAll().subscribe(response => {
      this.domains = response
      this.testErrorMessage = this.domains[0]['problems'].length < 5 ? true: false;
    });
  }

  loadProblems(domain: any) {
    this.problems = domain.problems;
  }

  createTest(): void {
    if (this.test.domain) {
      this.test.domain = {id: this.test.domain.id};
    }
    this.test.questions.forEach(q => {
      if (q.problem)
        q.problem = {md5h: q.problem.md5h};
    });
    if(this.domains[0]['problems'].length >= 5) {
      this.testService.createTest(this.test).subscribe(
        response => {
          this.router.navigate([`/domain/${this.test.domain.id}`])
          .then(success => console.log('navigation success?' , success))
          .catch(console.error); 
        },
        error => {
          alert("Error occured: " + error);
        });
    }
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

  back() {
    this._location.back();
  }

}
