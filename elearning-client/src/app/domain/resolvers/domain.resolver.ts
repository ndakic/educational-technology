import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { DomainService } from '../services/domain.service';

@Injectable({
  providedIn: 'root'
})
export class DomainResolver implements Resolve<any> {

  constructor(
    private domainService: DomainService) { }

  resolve(route: ActivatedRouteSnapshot) {
    const domainId = route.paramMap.get('domainId');
    const response = forkJoin([
      this.domainService.getDomainById(domainId)
    ]);

    return new Observable(observer => {
      response.subscribe((data: any) => {
        observer.next({
          domain: data[0],
        });
        observer.complete();
      });
    });
  }
}
