import { Component, OnInit } from '@angular/core';
import { DomainService } from 'src/app/domain/services/domain.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  public domains: any;

  constructor(
    public domainService: DomainService
  ) { }

  ngOnInit(): void {
    this.domainService.getAllDomains().subscribe(response => {
      this.domains = response;
      console.log(this.domains);
    });
  }

}
