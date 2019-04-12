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

  myPackages(id: string): Observable<any> {
    const params = new HttpParams().set('id', id);
    return this.http.get('http://localhost:3000/api/myPackages', { params });
  }

  packagesToAddress(id: string): Observable<any> {
    const params = new HttpParams().set('id', id);
    return this.http.get('http://localhost:3000/api/packagesToAddress', { params });
  }

}




