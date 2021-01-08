import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GraphComponent } from './components/graph-editor/graph.component';
import { DomainRoutingModule } from './domain-routing.module';
import { FormsModule } from '@angular/forms';
import { D3Module } from '../d3/d3.module';
import { DomainDetailsComponent } from './components/domain-details/domain-details.component';
import { MaterialModule } from '../shared/material/material.module';
import { DomainCreateDialogComponent } from './components/domain-create-dialog/domain-create-dialog.component';


@NgModule({
  declarations: [GraphComponent, DomainDetailsComponent, DomainCreateDialogComponent],
  imports: [
    CommonModule,
    DomainRoutingModule,
    FormsModule,
    D3Module,
    MaterialModule
  ],
  exports: []
})
export class DomainModule { }
