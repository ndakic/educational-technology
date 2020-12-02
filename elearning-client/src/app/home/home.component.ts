import { Component, OnInit } from '@angular/core';
import { TestService } from 'src/app/services/test.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  tests: any;

  constructor(
    private testService: TestService
  ) { }

  ngOnInit(): void {
    this.testService.getAllTests().subscribe(response => {this.tests = response});
  }

}
