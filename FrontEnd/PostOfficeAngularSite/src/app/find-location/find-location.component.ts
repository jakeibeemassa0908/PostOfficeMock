import { Component, OnInit } from '@angular/core';
import { APIService } from '../_services/api.service';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-find-location',
  templateUrl: './find-location.component.html',
  styleUrls: ['./find-location.component.css']
})
export class FindLocationComponent implements OnInit {
  Locations;

  Zip = new FormControl('');
  constructor(public api: APIService) { }

  ngOnInit() {

  }

  //ABS (location zip - intered zip)
  findLocation()
  {
    var data = this.api.findLocation(this.Zip.value)
      .subscribe((data: {}) => {
        this.Locations = data;
      });;
  }

}
