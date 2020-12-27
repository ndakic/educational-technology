import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { D3Component } from '../d3/components/d3/d3.component';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [D3Component],
  imports: [
    CommonModule,
    FormsModule
  ],
  exports: [D3Component]
})
export class D3Module { }
