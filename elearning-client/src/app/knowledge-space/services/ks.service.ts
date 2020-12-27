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

  getKnowledgeSpaceByTestId(testId: string) {
    return this.http.get(environment.apiUrlPrefix + `/knowledge-space/${testId}`);
  }

}
