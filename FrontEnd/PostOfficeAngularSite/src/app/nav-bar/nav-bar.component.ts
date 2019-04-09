import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../_services/auth.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
  logged: boolean = false;
  user: boolean = false;
  employee: boolean = true;
  manager: boolean = false;
  admin: boolean = false;

  constructor(private auth: AuthService, public myRoute: Router) {

    //for nav bar on page change.
    this.logged = this.auth.isAuthenticated();
    this.user = this.auth.isUser();
    this.employee = this.auth.isEmployee();
    this.manager = this.auth.isManager();
    this.admin = this.auth.isAdmin();

    //on login emitter
    this.auth.onLogin().subscribe((role) => {
      this.logged = this.auth.isAuthenticated();
      this.user = this.auth.isUser();
      this.employee = this.auth.isEmployee();
      this.manager = this.auth.isManager();
      this.admin = this.auth.isAdmin();
    });

  }
 
  ngOnInit() {   
  }

  //clear token on logout, reset the nav-bar
  logout() {
    console.log("logout");
    this.auth.clearToken();
    this.myRoute.navigate(["home"]);

    //clear navHiders
    this.logged = false;
    this.user = false;
    this.employee = false;
    this.manager = false;
    this.admin = false;
  }




}
