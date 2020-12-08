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
        path: 'test',
        canActivate: [],
        loadChildren: () => import('./test/test.module').then(m => m.TestModule)
      },
     ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
