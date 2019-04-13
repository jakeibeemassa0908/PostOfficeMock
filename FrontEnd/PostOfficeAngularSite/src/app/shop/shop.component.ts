import { Component, OnInit, ViewChild } from '@angular/core';

export interface Item {
  title: string;
  description: string;
  image: string;
  price: string;
  quantity: number;
}

@Component({
  selector: 'app-shop',
  templateUrl: './shop.component.html',
  styleUrls: ['./shop.component.css']
})
export class ShopComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  items: Item[] = [
    {title:       'Thingamajig',
     description: '4 out of 5 experts agree: it does something',
     image:       'assets/shop_images/box1.jpg',
     price:       '$500'},
    {title:       'Foobar',
     description: 'It foos the bars',
     image:       'assets/shop_images/box2.jpg',
     price:       '$500'},
    {title:       'Placeholder',
     description: 'Lorem ipsum latin stuff blah blah',
     image:       'assets/shop_images/box3.jpg',
     price:       '$500'},
    {title:       'Whocares',
     description: 'Stop reading this',
     image:       'assets/shop_images/box4.jpg',
     price:       '$500'},
  ];

}
