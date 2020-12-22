
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class LinkService {

  constructor(
    private http: HttpClient
  ) {}

  save(link: any){
    return this.http.post(environment.apiUrlPrefix + `/link`, link);
  }

  delete(linkId: string){
    return this.http.delete(environment.apiUrlPrefix + `/link/${linkId}`);
  }

  deleteLinksByProblemId(problemId: string){
    return this.http.delete(environment.apiUrlPrefix + `/link/problem/${problemId}`);
  }

  getLinksByDomainId(domainId: string){
    return this.http.get(environment.apiUrlPrefix + `/link/domain/${domainId}/all`);
  }

}



