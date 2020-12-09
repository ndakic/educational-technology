import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AnswerService {

  constructor(
    private http: HttpClient,
  ) {}

  submitAnswers(answers: Array<any>): Observable<any>{
    return this.http.post(environment.apiUrlPrefix + `/answer/history/test`, answers);
  }

}
