import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LocationEmployeesComponent } from './location-employees.component';

describe('LocationEmployeesComponent', () => {
  let component: LocationEmployeesComponent;
  let fixture: ComponentFixture<LocationEmployeesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LocationEmployeesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LocationEmployeesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
