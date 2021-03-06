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

  getAll() {
    return this.http.get(environment.apiUrlPrefix + `/domain/all`);
  }

  getDomainById(domainId: string) {
    return this.http.get(environment.apiUrlPrefix + `/domain/${domainId}`);
  }

  saveDomain(domain: any){
    return this.http.post(environment.apiUrlPrefix + `/domain`, domain);
  }

  getAllDomains(){
    return this.http.get(environment.apiUrlPrefix + `/domain/all`);
  }

  deleteById(domainId: string) {
    return this.http.delete(environment.apiUrlPrefix + `/domain/${domainId}`);
  }
}
