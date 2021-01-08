import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';

@Component({
  selector: 'app-details-test',
  templateUrl: './details-test.component.html',
  styleUrls: ['./details-test.component.css']
})
export class DetailsTestComponent implements OnInit {

  public test: any;

  constructor(
    private route: ActivatedRoute,
    private _location: Location
  ) { }

  ngOnInit(): void {
    this.test = this.route.snapshot.data["data"]["test"];
  }

  back() {
    this._location.back();
  }
}
