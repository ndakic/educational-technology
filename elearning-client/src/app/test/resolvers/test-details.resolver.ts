import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { TestService } from '../services/test.service';



@Injectable({
  providedIn: 'root'
})
export class TestDetailsResolver implements Resolve<any> {

  constructor(
    private testService: TestService) { }

  resolve(route: ActivatedRouteSnapshot) {
    const testId = route.paramMap.get('testId');
    const response = forkJoin([
      this.testService.getById(testId)
    ]);

    return new Observable(observer => {
      response.subscribe((data: any) => {
        observer.next({
          test: data[0],
        });
        observer.complete();
      });
    });
  }
}
