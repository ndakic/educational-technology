import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class KsService {

  constructor(
    private http: HttpClient
  ) {}

  getRealKnowledgeSpaceByTestId(testId: string) {
    return this.http.get(environment.apiUrlPrefix + `/knowledge-space/${testId}`);
  }

  getDefaultKnowledgeSpaceByTestId(testId: string) {
    return this.http.get(environment.apiUrlPrefix + `/knowledge-space/default/${testId}`);
  }

}
