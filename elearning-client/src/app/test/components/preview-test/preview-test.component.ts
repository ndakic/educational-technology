import { Component, OnInit } from '@angular/core';
import { TestService } from '../../services/test.service';

@Component({
  selector: 'app-preview-test',
  templateUrl: './preview-test.component.html',
  styleUrls: ['./preview-test.component.css']
})
export class PreviewTestComponent implements OnInit {

  public tests: any;

  constructor(
    private testService: TestService) { }

  ngOnInit(): void {
    this.testService.getAllTests().subscribe(response => this.tests = response);
  }

}
