import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { GraphComponent } from './components/graph-editor/graph.component';
import { DomainRoutingModule } from './domain-routing.module';
import { FormsModule } from '@angular/forms';
import { D3Module } from '../d3/d3.module';
import { DomainDetailsComponent } from './components/domain-details/domain-details.component';
import { MatCardModule } from '@angular/material/card';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';


@NgModule({
  declarations: [GraphComponent, DomainDetailsComponent],
  imports: [
    CommonModule,
    DomainRoutingModule,
    FormsModule,
    D3Module,
    MatCardModule,
    MatInputModule,
    MatFormFieldModule,
    MatSelectModule,
    MatIconModule,
    MatButtonModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatCheckboxModule
  ],
  exports: []
})
export class DomainModule { }
