import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GraphComponent } from './components/graph/graph.component';
import { DomainRoutingModule } from './domain-routing.module';
import { D3Component } from './components/d3/components/d3/d3.component';


@NgModule({
  declarations: [GraphComponent, D3Component],
  imports: [
    CommonModule,
    DomainRoutingModule,
  ],
  exports: []
})
export class DomainModule { }
