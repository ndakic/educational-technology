import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { D3Module } from '../d3/d3.module';
import { CompareGraphsComponent } from './components/compare-graphs/compare-graphs.component';
import { CompareGraphsRoutingModule } from './compare-graphs-routing.module';


@NgModule({
  declarations: [CompareGraphsComponent],
  imports: [
    CommonModule,
    FormsModule,
    D3Module,
    CompareGraphsRoutingModule
  ],
  exports: []
})
export class CompareGraphModule { }
