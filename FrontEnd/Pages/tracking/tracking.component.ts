import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-tracking',
  templateUrl: './tracking.component.html',
  styleUrls: ['./tracking.component.css']
})

export class TrackingComponent implements OnInit {
  ID = '';
  IDForm = new FormControl('');
  hideAlert = true;
  panelOpenState = false;

  constructor() { }

  trackPackage(){
    if (this.isValid()) //id is good.
    {
      this.hideAlert = true;
      this.ID = this.IDForm.value;
    }
    else //bad id
    {
      this.hideAlert = false;
      this.ID = '';
    }
  }

  isValid() //validate the package id
  {
    if (this.IDForm.value.length < 5) {
      return false;
    }
    else {
      return true;
    }
  }

  closeAlert() {
    this.hideAlert = true;
  }

  ngOnInit() {
  }

}
