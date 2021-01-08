import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CreateTestComponent } from './components/create-test/create-test.component';
import { PreviewTestComponent } from './components/preview-test/preview-test.component';
import { FillTestComponent } from './components/fill-test/fill-test.component';
import { TestRoutingModule } from './test-routing.module';
import { FormsModule } from '@angular/forms';
import { DetailsTestComponent } from './components/details-test/details-test.component';
import { MaterialModule } from '../shared/material/material.module';



@NgModule({
  declarations: [CreateTestComponent, PreviewTestComponent, DetailsTestComponent, FillTestComponent],
  imports: [
    CommonModule,
    TestRoutingModule,
    FormsModule,
    MaterialModule
  ],
  exports: []
})
export class TestModule { }
