import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GraphComponent } from '../graph/components/graph/graph.component';
import { GraphRoutingModule } from './graph-routing.module';
import { MyReteEditorModule } from './components/rete/rete.module';
import { D3Component } from './components/d3/components/d3/d3.component';


@NgModule({
  declarations: [GraphComponent, D3Component],
  imports: [
    CommonModule,
    GraphRoutingModule,
    // MyReteEditorModule
  ],
  exports: []
})
export class GraphModule { }
