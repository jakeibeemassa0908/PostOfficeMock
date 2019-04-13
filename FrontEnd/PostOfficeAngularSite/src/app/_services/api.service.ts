import { Injectable } from '@angular/core';
import { HttpClientModule, HttpHeaders, HttpErrorResponse, HttpParams, HttpClient  } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';

const endpoint = 'http://localhost:3000/api/';
const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
};

@Injectable({
  providedIn: 'root'
})
export class APIService {

  constructor(private http: HttpClient) {}

  private extractData(res: Response) {
    let body = res;
    return body || {};
  }

  //USER LOGIN WITH EMAIL & PASSWORD
  userLoginAuth(email : string, password : string): Observable<any> {
    const params = new HttpParams().set('email', email).set('password', password);
    return this.http.get('http://localhost:3000/api/userLogin', { params });
  }

  //tracking package with ID
  packageTracking(id: string): Observable<any> {
    const params = new HttpParams().set('id', id);
    return this.http.get('http://localhost:3000/api/packageTracking', { params });
  }

  //myPackages by user id
  myPackages(id: string): Observable<any> {
    const params = new HttpParams().set('id', id);
    return this.http.get('http://localhost:3000/api/myPackages', { params });
  }

  //packages to address by user id
  packagesToAddress(id: string): Observable<any> {
    const params = new HttpParams().set('id', id);
    return this.http.get('http://localhost:3000/api/packagesToAddress', { params });
  }

  //closest location based on zip
  findLocation(zip: string): Observable<any> {
    const params = new HttpParams().set('zip', zip);
    return this.http.get('http://localhost:3000/api/findLocation', { params });
  }

  //register User in Customer Table
  registerUser(Fname: string, MInit: string, Lname: string, Email: string, MobileNumber: string, HouseNumber: string, Street: string, City: string, State: string, ZipCode: string): Observable<any> {
    const params = new HttpParams().set('Fname', Fname).set('MInit', MInit).set('Lname', Lname).set('Email', Email).set('MobileNumber', MobileNumber).set('HouseNumber', HouseNumber).set('Street', Street).set('City', City).set('State', State).set('ZipCode', ZipCode);
    return this.http.get('http://localhost:3000/api/registerUser', { params });
  }


  //user to Login table
  registerUserLogin(Email: string, Password: string): Observable<any> {
    const params = new HttpParams().set('Email', Email).set('Password', Password);
    return this.http.get('http://localhost:3000/api/registerUserLogin', { params });
  }




}




