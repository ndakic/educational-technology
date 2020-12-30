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

  deleteTest(testId: string): void {
    this.testService.deleteTest(testId).subscribe(response => {
      var index = this.tests.map(x => {
        return x.Id;
      }).indexOf(testId);
      
      this.tests.splice(index, 1);
    });
  }

}
