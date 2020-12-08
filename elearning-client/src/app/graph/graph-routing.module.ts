import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { GraphComponent } from '../graph/components/graph/graph.component';


const routes: Routes = [
    { path: '', component: GraphComponent }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class GraphRoutingModule { }