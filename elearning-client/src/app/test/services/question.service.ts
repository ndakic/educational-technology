import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class QuestionService {

  constructor(
    private http: HttpClient,
  ) {}

  getQuestion(testId: string, userId: string): Observable<any>{
    return this.http.get(environment.apiUrlPrefix + `/question/${testId}/${userId}`);
  }

}
