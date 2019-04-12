import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { APIService } from '../_services/api.service';

@Component({
  selector: 'app-tracking',
  templateUrl: './tracking.component.html',
  styleUrls: ['./tracking.component.css']
})

export class TrackingComponent implements OnInit {
  ID = '';
  IDForm = new FormControl('');
  hideAlert = true;
  hideTracking = true;
  panelOpenState = false;
  Response;

  constructor(public api: APIService) {}

  trackPackage() //validate the package id
  {
    this.api.packageTracking(this.IDForm.value)
      .subscribe((data: {}) => {
        //no package
        if (data[0] == undefined) {
          this.hideTracking = true;
          this.hideAlert = false;
          this.ID = '';
        }
        //found the package
        else if (data[0] != undefined) {
          this.Response = data;
          console.log(this.Response);
          this.hideAlert = true;
          this.hideTracking = false;
        }
  });;

      
  }

  closeAlert() {
    this.hideAlert = true;
  }

  ngOnInit() {
  }

}
