import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Domain } from '../../../domain/models/domain';
import { DomainCreateDialogComponent } from 'src/app/domain/components/domain-create-dialog/domain-create-dialog.component';
import { DomainService } from 'src/app/domain/services/domain.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  public domains: any;
  public domain = new Domain();

  constructor(
    public domainService: DomainService,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    this.domainService.getAllDomains().subscribe(response => {
      this.domains = response;
    });
  }

  delete(id: string){
    this.domainService.deleteById(id).subscribe(() => {
      this.domains = this.domains.filter(item => item.id !== id);
    });
  }

  createDialog(): void {
    const dialogRef = this.dialog.open(DomainCreateDialogComponent, {
      width: '250px',
      data: {name: this.domain.title}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.domain.title = result.title;
        this.domainService.saveDomain(this.domain).subscribe(reponse => {
          this.domain.id = reponse['id'];
          this.domains.push(this.domain);
        });
      }
    });
  }

}
