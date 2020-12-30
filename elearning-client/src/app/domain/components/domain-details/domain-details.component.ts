import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-domain-details',
  templateUrl: './domain-details.component.html',
  styleUrls: ['./domain-details.component.css']
})
export class DomainDetailsComponent implements OnInit {

  public domain: any;

  constructor(
    private route: ActivatedRoute,
  ) { }

  ngOnInit(): void {
    this.domain = this.route.snapshot.data["data"]['domain'];
    console.log('details: ', this.domain);
  }

}
