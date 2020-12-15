import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { GraphComponent } from './components/graph/graph.component';
import { DomainResolver } from './resolvers/domain.resolver';


const routes: Routes = [
    { path: ':domainId', component: GraphComponent, resolve: {data: DomainResolver } },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DomainRoutingModule { }