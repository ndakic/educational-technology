import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { TestService } from './test/services/test.service';
import { HttpClientModule } from '@angular/common/http';
import { CreateTestComponent } from './test/components/create-test/create-test.component';
import { PreviewTestComponent } from './test/components/preview-test/preview-test.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    CreateTestComponent,
    PreviewTestComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [TestService],
  bootstrap: [AppComponent]
})
export class AppModule { }
