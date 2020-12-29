import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { CompareGraphsService } from '../services/compare-graph.service';

@Injectable({
  providedIn: 'root'
})
export class CompareGraphResolver implements Resolve<any> {

  constructor(
    private compareGraphsService: CompareGraphsService) { }

  resolve(route: ActivatedRouteSnapshot) {
    const testId = route.paramMap.get('testId');
    const response = forkJoin([
      this.compareGraphsService.getComparedGraphByTestId(testId)
    ]);
    return new Observable(observer => {
      response.subscribe((data: any) => {
        observer.next({
          compare: data[0],
        });
        observer.complete();
      });
    });
  }
}
