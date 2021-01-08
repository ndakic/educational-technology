import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA} from '@angular/material/dialog';
import { Domain } from '../../models/domain';

@Component({
  selector: 'app-domain-create-dialog',
  templateUrl: './domain-create-dialog.component.html',
  styleUrls: ['./domain-create-dialog.component.css']
})
export class DomainCreateDialogComponent {

  constructor(
    public dialogRef: MatDialogRef<DomainCreateDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public domain: Domain) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

}
