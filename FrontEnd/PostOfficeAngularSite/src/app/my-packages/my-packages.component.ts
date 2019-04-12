import { Component, OnInit } from '@angular/core';
import { APIService } from '../_services/api.service';

@Component({
  selector: 'app-my-packages',
  templateUrl: './my-packages.component.html',
  styleUrls: ['./my-packages.component.css']
})
export class MyPackagesComponent implements OnInit {
  MyPackages;
  ExpectedPackages;

  constructor(public api: APIService) { }

  ngOnInit() {

  var data = this.api.myPackages(sessionStorage.getItem("ID"))
      .subscribe((data: {}) => {
        this.MyPackages = data;
      });;

      var data = this.api.packagesToAddress(sessionStorage.getItem("ID"))
        .subscribe((data: {}) => {
          this.ExpectedPackages = data;
        });;
    
  }

}
