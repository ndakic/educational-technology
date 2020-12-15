import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Router } from '@angular/router';
import { AnswerService } from '../../services/answer.service';

class Answer {
  public answerId: string;
  public userId: string = "5bc67bef74afd2fb0f5a370d72b1c913";
}

@Component({
  selector: 'app-fill-test',
  templateUrl: './fill-test.component.html',
  styleUrls: ['./fill-test.component.css']
})
export class FillTestComponent implements OnInit {

  public test: any;
  public answers: Array<string> = [];

  constructor(private answerService: AnswerService, private route: ActivatedRoute, private router: Router) {
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
        this.router.navigate(['/test/preview'])
        .then(success => console.log('navigation success?' , success))
        .catch(console.error); 
      },
      error => {
        console.log(error)
        alert("Error occured: " + error);
      });
  }

}