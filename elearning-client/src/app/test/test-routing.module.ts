import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CreateTestComponent } from './components/create-test/create-test.component';
import { PreviewTestComponent } from './components/preview-test/preview-test.component';
import { DetailsTestComponent } from './components/details-test/details-test.component';
import { TestDetailsResolver } from './resolvers/test-details.resolver';

const routes: Routes = [
    { path: 'create', component: CreateTestComponent },
    { path: 'preview', component: PreviewTestComponent },
    { path: ':testId/details', component: DetailsTestComponent, resolve: {data :TestDetailsResolver } }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class TestRoutingModule { }