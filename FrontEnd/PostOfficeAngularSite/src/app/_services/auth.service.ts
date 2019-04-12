import { Injectable, Output, EventEmitter } from '@angular/core';
import { JwtHelperService } from '@auth0/angular-jwt';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  public jwtHelper = new JwtHelperService();
  @Output() IsLoggedIn: EventEmitter<any> = new EventEmitter<any>();
  constructor() { }

  onLogin() {
    return this.IsLoggedIn;
  }
  // ...
  //login 
  sendToken(token: string, ID: string) {
    sessionStorage.setItem('token', token);
    sessionStorage.setItem('ID', ID);
    this.IsLoggedIn.emit(token);
  }

  clearToken() {
    sessionStorage.clear();
  }

  //logged in
  isAuthenticated(): boolean {
    const token = sessionStorage.getItem('token');
    if (token != null && (<any>token).length > 0) {
      return true;
    }
    return false;
    //return !this.jwtHelper.isTokenExpired(token);
  }

  //has user role
  isUser(): boolean {
    const token = sessionStorage.getItem('token');
    if (token != null && (<any>token).length > 0 && token == "user") {
      return true;
    }
    return false;
    //return !this.jwtHelper.isTokenExpired(token);
  } 

  //has employee role
  isEmployee(): boolean {
    const token = sessionStorage.getItem('token');
    if (token != null && (<any>token).length > 0 && token == "employee") {
      return true;
    }
    return false;
    //return !this.jwtHelper.isTokenExpired(token);
  }

  //has manager role
  isManager(): boolean {
    const token = sessionStorage.getItem('token');
    if (token != null && (<any>token).length > 0 && token == "manager") {
      return true;
    }
    return false;
    //return !this.jwtHelper.isTokenExpired(token);
  }


  //has admin role
  isAdmin(): boolean {
    const token = sessionStorage.getItem('token');
    if (token != null && (<any>token).length > 0 && token == "admin") {
      return true;
    }
    return false;
    //return !this.jwtHelper.isTokenExpired(token);
  } 


}
