import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { environment } from 'src/environments/environment';
import { Location } from '@angular/common';


@Component({
  selector: 'app-domain-details',
  templateUrl: './domain-details.component.html',
  styleUrls: ['./domain-details.component.css']
})
export class DomainDetailsComponent implements OnInit {

  public domain: any;

  constructor(
    private route: ActivatedRoute,
    private _location: Location
  ) { }

  ngOnInit(): void {
    this.domain = this.route.snapshot.data["data"]['domain'];
    console.log('details: ', this.domain);
  }


  export(testId){
    window.open(environment.apiUrlPrefix + `/export/${testId}`, '_blank');
  }

  back() {
    this._location.back();
  }

}
