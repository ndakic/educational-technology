import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CompareGraphsComponent } from './components/compare-graphs/compare-graphs.component';
import { CompareGraphResolver } from './resolvers/compare-graphs.resolver';


const routes: Routes = [
    { path: ':testId', component: CompareGraphsComponent, resolve: {data: CompareGraphResolver } },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class CompareGraphsRoutingModule { }