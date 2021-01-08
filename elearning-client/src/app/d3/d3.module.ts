import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { D3Component } from '../d3/components/d3/d3.component';
import { FormsModule } from '@angular/forms';
import { MaterialModule } from '../shared/material/material.module';


@NgModule({
  declarations: [D3Component],
  imports: [
    CommonModule,
    FormsModule,
    MaterialModule
  ],
  exports: [D3Component]
})
export class D3Module { }
