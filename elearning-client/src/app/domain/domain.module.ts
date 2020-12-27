import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GraphComponent } from './components/graph-editor/graph.component';
import { DomainRoutingModule } from './domain-routing.module';
import { FormsModule } from '@angular/forms';
import { D3Module } from '../d3/d3.module';


@NgModule({
  declarations: [GraphComponent],
  imports: [
    CommonModule,
    DomainRoutingModule,
    FormsModule,
    D3Module
  ],
  exports: []
})
export class DomainModule { }
