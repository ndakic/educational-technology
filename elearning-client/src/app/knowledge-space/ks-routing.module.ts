import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { KnowledgeSpaceComponent } from './components/knowledge-space/knowledge-space.component';
import { KSResolver } from './resolvers/ks.resolver';


const routes: Routes = [
    { path: ':testId', component: KnowledgeSpaceComponent, resolve: {data: KSResolver } },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class KSRoutingModule { }