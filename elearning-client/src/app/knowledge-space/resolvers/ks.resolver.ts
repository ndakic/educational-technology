import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { KsService } from '../services/ks.service';

@Injectable({
  providedIn: 'root'
})
export class KSResolver implements Resolve<any> {

  constructor(
    private ksService: KsService) { }

  resolve(route: ActivatedRouteSnapshot) {
    const testId = route.paramMap.get('testId');
    const response = forkJoin([
      this.ksService.getRealKnowledgeSpaceByTestId(testId)
    ]);
    return new Observable(observer => {
      response.subscribe((data: any) => {
        observer.next({
          ks: data[0],
        });
        observer.complete();
      });
    });
  }
}
