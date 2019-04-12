import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../_services/auth.service';
import { APIService } from '../_services/api.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;

  constructor(private formBuilder: FormBuilder, public auth: AuthService, public api: APIService, public myRoute: Router) { }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      email: ['', [Validators.required, Validators.minLength(4)]],
      password: ['', [Validators.required, Validators.minLength(4)]]
    });
  }

  login() {
    //if a real login, ie in DB then
    //this.auth.sendToken(this.loginForm.value.email)
    var data = this.api.userLoginAuth(this.loginForm.value.email, this.loginForm.value.password)
      .subscribe((data: {}) => {
        //we have logged in a nd API returns user ID
        if (data[0] != undefined) {
          console.log("User: " + data[0].CustomerID + " has logged in");
          this.auth.sendToken("user", data[0].CustomerID);

          this.myRoute.navigate(["home"]);
        }
        else console.log("fail to login");
    });;
    //update navbar
  }
}
