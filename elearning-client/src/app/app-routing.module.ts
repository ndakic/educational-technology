import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ShellComponent } from './core/components/shell/shell.component';

const routes: Routes = [
  {
    path: '',
    component: ShellComponent,
    canActivate: [],
    children: [
      { path: '', redirectTo: '/home', pathMatch: 'full' },
      {
        path: 'home',
        canActivate: [],
        loadChildren: () => import('./home/home.module').then(m => m.HomeModule)
      },
      {
        path: 'test',
        canActivate: [],
        loadChildren: () => import('./test/test.module').then(m => m.TestModule)
      },
      {
        path: 'domain',
        canActivate: [],
        loadChildren: () => import('./domain/domain.module').then(m => m.DomainModule)
      },
      {
        path: 'ks',
        canActivate: [],
        loadChildren: () => import('./knowledge-space/ks.module').then(m => m.KSModule)
      },
      {
        path: 'compare-graphs',
        canActivate: [],
        loadChildren: () => import('./compare-graphs/compare-graphs.module').then(m => m.CompareGraphModule)
      },
     ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
