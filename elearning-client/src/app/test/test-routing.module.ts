import { Routes, RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CreateTestComponent } from './components/create-test/create-test.component';
import { PreviewTestComponent } from './components/preview-test/preview-test.component';

const routes: Routes = [
    { path: 'create', component: CreateTestComponent },
    { path: 'preview', component: PreviewTestComponent },
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class TestRoutingModule { }