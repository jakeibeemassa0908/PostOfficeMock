import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot } from '@angular/router';
import { AuthService } from './auth.service';
import decode from 'jwt-decode';


@Injectable({
  providedIn: 'root'
})

export class RoleGuardService implements CanActivate {
  constructor(public auth: AuthService, public router: Router) { }

  canActivate(route: ActivatedRouteSnapshot): boolean {
    // this will be passed from the route config
    // on the data property
    const expectedRole = route.data.expectedRole;
    console.log("expected role:" + expectedRole)

    const token = sessionStorage.getItem('token');
    console.log("token:" + token)

    if (!this.auth.isAuthenticated() || expectedRole.indexOf(token) < 0) {
      this.router.navigate(["login"]); 
      console.log("route to login");
      return false;
    }
    return true;
  }
}
