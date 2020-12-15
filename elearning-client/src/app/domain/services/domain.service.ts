import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DomainService {

  constructor(
    private http: HttpClient
  ) {}

  getAllProblems(domainId: string){
    return this.http.get(environment.apiUrlPrefix + `/problems/domain/${domainId}/all`);
  }

  getAllLinks(domainId: string){
    return this.http.get(environment.apiUrlPrefix + `/link/domain/${domainId}/all`);
  }

  getDomainById(domainId: string) {
    return this.http.get(environment.apiUrlPrefix + `/domain/${domainId}`);
  }
}
