import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class TestService {

  constructor(
    private http: HttpClient,
  ) {}

  createTest(test: object): Observable<any>{
    return this.http.post(environment.apiUrlPrefix + `/test`, test);
  }

  deleteTest(testId: string){
    return this.http.delete(environment.apiUrlPrefix + `/test/${testId}`);
  }
  
  getAllTests(): Observable<any>{
    return this.http.get(environment.apiUrlPrefix + `/test/all`);
  }

  getById(id: string){
    return this.http.get(environment.apiUrlPrefix + `/test/${id}`);
  }
}
