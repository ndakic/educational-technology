import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { KnowledgeSpaceComponent } from './components/knowledge-space/knowledge-space.component';
import { D3Module } from '../d3/d3.module';
import { KSRoutingModule } from '../knowledge-space/ks-routing.module';


@NgModule({
  declarations: [KnowledgeSpaceComponent],
  imports: [
    CommonModule,
    FormsModule,
    KSRoutingModule,
    D3Module
  ],
  exports: []
})
export class KSModule { }
