import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class TestService {

  constructor(
    private http: HttpClient,
  ) {}

  getAllTests(): Observable<any>{
    return this.http.get(environment.apiUrlPrefix + `/test/all`);
  }
}
