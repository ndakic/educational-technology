import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CompareGraphsService {

  constructor(
    private http: HttpClient
  ) {}

  getComparedGraphByTestId(testId: string) {
    return this.http.get(environment.apiUrlPrefix + `/knowledge-space/compare/${testId}`);
  }

}
