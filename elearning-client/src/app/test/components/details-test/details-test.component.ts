import { Component, EventEmitter, OnInit, Output, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';
import { Subject } from 'rxjs';

export const KS = {
  default: "Default",
  real: "Real",
  compared: "Compared"
};

@Component({
  selector: 'app-details-test',
  templateUrl: './details-test.component.html',
  styleUrls: ['./details-test.component.css']
})
export class DetailsTestComponent implements OnInit {

  public test: any;
  public selected: string;
  public domainId: string;

  eventsSubject: Subject<any> = new Subject<any>();


  constructor(
    private route: ActivatedRoute,
    private _location: Location
  ) { }

  ngOnInit(): void {
    this.test = this.route.snapshot.data["data"]["test"];
    this.domainId = this.route.snapshot.data["data"]["test"]['domain']['id'];
  }

  back() {
    this._location.back();
  }

  emitEventToChild($event) {
    this.eventsSubject.next({ks: $event.value});
  }
}
