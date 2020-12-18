
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ProblemService {

  constructor(
    private http: HttpClient
  ) {}

  save(problem: any){
    return this.http.post(environment.apiUrlPrefix + `/problem`, problem);
  }

  delete(problemId: string){
    return this.http.delete(environment.apiUrlPrefix + `/problem/${problemId}`);
  }

}



