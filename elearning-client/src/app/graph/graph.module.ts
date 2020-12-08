import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GraphComponent } from '../graph/components/graph/graph.component';
import { GraphRoutingModule } from './graph-routing.module';
import { MyReteEditorModule } from './components/rete/rete.module';


@NgModule({
  declarations: [GraphComponent],
  imports: [
    CommonModule,
    GraphRoutingModule,
    MyReteEditorModule
  ],
  exports: []
})
export class GraphModule { }
