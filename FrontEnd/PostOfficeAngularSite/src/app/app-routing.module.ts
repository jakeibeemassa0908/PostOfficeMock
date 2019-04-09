import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { RoleGuardService as RoleGuard } from './_services/role-guard.service';


//not logged in
import { HomeComponent } from './home/home.component';
import { TrackingComponent } from './tracking/tracking.component';
import { FindLocationComponent } from './find-location/find-location.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';

//user
import { MyPackagesComponent } from './my-packages/my-packages.component';
import { UserAccountComponent } from './user-account/user-account.component';
import { ShopComponent } from './shop/shop.component';

//employee
import { CreatePackageComponent } from './create-package/create-package.component';
import { UpdateTrackingComponent } from './update-tracking/update-tracking.component';

//employee & manager
import { EmployeeAccountComponent } from './employee-account/employee-account.component';
import { UserLookupComponent } from './user-lookup/user-lookup.component';

//manager
import { EmployeeLookupComponent } from './employee-lookup/employee-lookup.component';
import { LocationEmployeesComponent } from './location-employees/location-employees.component';
import { LocationDashboardComponent } from './location-dashboard/location-dashboard.component';

const routes: Routes = [
  //not logged in
  { path: 'home', component: HomeComponent },
  { path: 'tracking', component: TrackingComponent },
  { path: 'findlocation', component: FindLocationComponent },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },

  //user
  { path: 'mypackages', component: MyPackagesComponent, canActivate: [RoleGuard], data: { expectedRole: ['user'] } },
  { path: 'userAccount', component: UserAccountComponent, canActivate: [RoleGuard], data: { expectedRole: ['user'] } },
  { path: 'shop', component: ShopComponent, canActivate: [RoleGuard], data: { expectedRole: ['user'] } },

  //employee
  { path: 'shipPackage', component: CreatePackageComponent, canActivate: [RoleGuard], data: { expectedRole: ['employee'] } },
  { path: 'scanPackage', component: UpdateTrackingComponent, canActivate: [RoleGuard], data: { expectedRole: ['employee'] } },

  //employee & manager
  { path: 'employeeAccount', component: EmployeeAccountComponent, canActivate: [RoleGuard], data: { expectedRole: ['employee', 'manager'] } },
  { path: 'customerLookup', component: UserLookupComponent, canActivate: [RoleGuard], data: { expectedRole: ['employee', 'manager'] } },

  //manager
  { path: 'employeeLookup', component: EmployeeLookupComponent, canActivate: [RoleGuard], data: { expectedRole: ['manager'] } },
  { path: 'locationEmployees', component: LocationEmployeesComponent, canActivate: [RoleGuard], data: { expectedRole: ['manager'] } },
  { path: 'locationDashboard', component: LocationDashboardComponent, canActivate: [RoleGuard], data: { expectedRole: ['manager'] } },


  //not routes, go home
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: '**', redirectTo: '/home', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
