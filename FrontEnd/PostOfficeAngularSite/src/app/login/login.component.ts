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
  hideAlert = true;
  errorMessage = '';

  constructor(private formBuilder: FormBuilder, public auth: AuthService, public api: APIService, public myRoute: Router) { }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      email: ['', Validators.compose([Validators.required])],
      password: ['', Validators.compose([Validators.required])]
    });
  }

  login() {
    //login forms were filled out
    if (this.loginForm.valid) {
      var data = this.api.userLoginAuth(this.loginForm.value.email, this.loginForm.value.password)
        .subscribe((data: {}) => {
          //we have logged in a nd API returns user ID
          if (data[0] != undefined) {
            console.log("User: " + data[0].CustomerID + " has logged in");
            this.auth.sendToken("user", data[0].CustomerID);
            this.myRoute.navigate(["home"]);
          }
          else {
            this.hideAlert = false;
            this.errorMessage = "Incorect Email or Passowrd";
          }
        });;
    }
    //something was missing.
    else {
      this.errorMessage = "One of the fields is missing!";
      this.hideAlert = false;
    }
  }

  closeAlert() {
    this.hideAlert = true;
  }
}
