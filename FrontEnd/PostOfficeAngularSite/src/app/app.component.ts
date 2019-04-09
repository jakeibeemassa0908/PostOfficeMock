import { Component } from '@angular/core';
import { HostListener } from "@angular/core";
import { AuthService } from './_services/auth.service';
import { Router } from '@angular/router';
import { NavBarComponent } from './nav-bar/nav-bar.component';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  title = 'Post Office 3308';
  @HostListener("window:onbeforeunload", ["$event"])
  clearLocalStorage(event) {
    sessionStorage.clear();
  }

}
