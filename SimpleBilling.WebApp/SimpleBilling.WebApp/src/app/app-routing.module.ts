import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BillingDetailsComponent } from './billing-details/billing-details.component';
import { CounterComponent } from './counter/counter.component';
import { FetchDataComponent } from './fetch-data/fetch-data.component';

const routes: Routes = [
  //{ path: '', component: HomeComponent, pathMatch: 'full' },
  { path: 'counter', component: CounterComponent },
  { path: 'fetch-data', component: FetchDataComponent },
  { path: 'billing', component: BillingDetailsComponent },
  { path: '*', redirectTo: 'billing' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
