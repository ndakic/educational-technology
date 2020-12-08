import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CreateTestComponent } from './components/create-test/create-test.component';
import { PreviewTestComponent } from './components/preview-test/preview-test.component';
import { TestRoutingModule } from './test-routing.module';
import { MatCardModule } from '@angular/material/card';
import { DetailsTestComponent } from './components/details-test/details-test.component';



@NgModule({
  declarations: [CreateTestComponent, PreviewTestComponent, DetailsTestComponent],
  imports: [
    CommonModule,
    TestRoutingModule,
    MatCardModule
  ],
  exports: []
})
export class TestModule { }
