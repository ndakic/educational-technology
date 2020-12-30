import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { GraphComponent } from './components/graph-editor/graph.component';
import { DomainResolver } from './resolvers/domain.resolver';
import { DomainDetailsComponent } from './components/domain-details/domain-details.component';


const routes: Routes = [
    { path: ':domainId', component: DomainDetailsComponent, resolve: {data: DomainResolver }},
    { path: 'graph/:domainId', component: GraphComponent, resolve: {data: DomainResolver }},
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DomainRoutingModule { }