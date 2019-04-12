-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PostOffice
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PostOffice
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PostOffice` DEFAULT CHARACTER SET utf8 ;
USE `PostOffice` ;

-- -----------------------------------------------------
-- Table `PostOffice`.`Authentication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Authentication` (
  `AuthenticationID` INT(11) NOT NULL AUTO_INCREMENT,
  `AuthenticationLevel` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`AuthenticationID`),
  UNIQUE INDEX `AUTHID_UNIQUE` (`AuthenticationID` ASC),
  UNIQUE INDEX `AUTHLevel_UNIQUE` (`AuthenticationLevel` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Customer` (
  `CustomerID` INT(11) NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(25) NOT NULL,
  `MInit` VARCHAR(1) NOT NULL,
  `Lname` VARCHAR(25) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  `MobileNumber` VARCHAR(20) NOT NULL,
  `HouseNumber` VARCHAR(10) NOT NULL,
  `Street` VARCHAR(40) NOT NULL,
  `ZipCode` VARCHAR(10) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `State` VARCHAR(20) NOT NULL,
  `Country` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CustomerID`, `Email`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `MobileNumber_UNIQUE` (`MobileNumber` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10002
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`CustomerLogin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`CustomerLogin` (
  `CustomerEmail` VARCHAR(60) NOT NULL,
  `CustomerPassword` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`CustomerEmail`),
  UNIQUE INDEX `Customer_Email_UNIQUE` (`CustomerEmail` ASC),
  INDEX `fk_CustomerLogin_Customer1_idx` (`CustomerEmail` ASC),
  CONSTRAINT `fk_CustomerLogin_Customer1`
    FOREIGN KEY (`CustomerEmail`)
    REFERENCES `PostOffice`.`Customer` (`Email`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Location` (
  `LocationID` INT(11) NOT NULL AUTO_INCREMENT,
  `Hours` VARCHAR(10) NOT NULL,
  `BuildingNumber` VARCHAR(10) NOT NULL,
  `Street` VARCHAR(40) NOT NULL,
  `ZipCode` VARCHAR(10) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `State` VARCHAR(20) NOT NULL,
  `Country` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`LocationID`),
  UNIQUE INDEX `LocationID_UNIQUE` (`LocationID` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 103
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Roles` (
  `RolesID` INT(11) NOT NULL AUTO_INCREMENT,
  `RoleName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`RolesID`),
  UNIQUE INDEX `RolesID_UNIQUE` (`RolesID` ASC),
  UNIQUE INDEX `RoleName_UNIQUE` (`RoleName` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Employee` (
  `EmployeeID` INT(11) NOT NULL AUTO_INCREMENT,
  `LocationID` INT(11) NOT NULL,
  `RoleID` INT(11) NOT NULL,
  `AuthID` INT(11) NOT NULL,
  `Fname` VARCHAR(25) NOT NULL,
  `MInit` VARCHAR(1) NOT NULL,
  `Lname` VARCHAR(25) NOT NULL,
  `MobliePhone` VARCHAR(20) NOT NULL,
  `WorkPhone` VARCHAR(20) NULL DEFAULT NULL,
  `Wage` DOUBLE NOT NULL,
  `HiredOn` DATE NOT NULL,
  `WorkEmail` VARCHAR(60) NOT NULL,
  `PersonalEmail` VARCHAR(60) NULL DEFAULT NULL,
  `HouseNumber` VARCHAR(10) NOT NULL,
  `Street` VARCHAR(40) NOT NULL,
  `ZipCode` VARCHAR(10) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `State` VARCHAR(20) NOT NULL,
  `Country` VARCHAR(20) NOT NULL,
  `CurrentlyEmployed` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeesID_UNIQUE` (`EmployeeID` ASC),
  UNIQUE INDEX `MobliePhone_UNIQUE` (`MobliePhone` ASC),
  UNIQUE INDEX `WorkEmail_UNIQUE` (`WorkEmail` ASC),
  UNIQUE INDEX `PersonalEmail_UNIQUE` (`PersonalEmail` ASC),
  UNIQUE INDEX `WorkPhone_UNIQUE` (`WorkPhone` ASC),
  INDEX `fk_Employee_Location1_idx` (`LocationID` ASC),
  INDEX `fk_Employee_Roles1_idx` (`RoleID` ASC),
  INDEX `fk_Employee_AUTH1_idx` (`AuthID` ASC),
  CONSTRAINT `fk_Employee_AUTH1`
    FOREIGN KEY (`AuthID`)
    REFERENCES `PostOffice`.`Authentication` (`AuthenticationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Employee_Location1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Employee_Roles1`
    FOREIGN KEY (`RoleID`)
    REFERENCES `PostOffice`.`Roles` (`RolesID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10005
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`EmployeeLogin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`EmployeeLogin` (
  `EmployeeID` INT(11) NOT NULL,
  `EmployeePassword` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC),
  CONSTRAINT `fk_EmployeeLogin_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Online Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Online Products` (
  `ProductID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(20) NOT NULL,
  `Stock` INT(10) UNSIGNED NOT NULL,
  `Price` DOUBLE UNSIGNED NOT NULL,
  `ReStockDate` DATE NOT NULL,
  `Available` TINYINT(1) NOT NULL DEFAULT '1',
  `ImagePath` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE INDEX `ProductID_UNIQUE` (`ProductID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Payment type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Payment type` (
  `typeID` INT(11) NOT NULL AUTO_INCREMENT,
  `PaymentTypeName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`typeID`),
  UNIQUE INDEX `Name_UNIQUE` (`PaymentTypeName` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Transactions` (
  `TransactionID` INT(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` INT(11) NOT NULL,
  `DateOfSale` DATETIME NOT NULL,
  `TotalPrice` DOUBLE UNSIGNED NOT NULL,
  `FirstFourCC` VARCHAR(4) NULL DEFAULT NULL,
  `FnameCC` VARCHAR(25) NULL DEFAULT NULL,
  `LnameCC` VARCHAR(25) NULL DEFAULT NULL,
  `MInitCC` VARCHAR(1) NULL DEFAULT NULL,
  `PaymentTypeID` INT(11) NOT NULL,
  `EmployeeID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  UNIQUE INDEX `TransactionID_UNIQUE` (`TransactionID` ASC),
  INDEX `fk_Online Transactions_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Transactions_Payment type1_idx` (`PaymentTypeID` ASC),
  INDEX `fk_Transactions_Employee1_idx` (`EmployeeID` ASC),
  CONSTRAINT `fk_Online Transactions_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `PostOffice`.`Customer` (`CustomerID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Transactions_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Transactions_Payment type1`
    FOREIGN KEY (`PaymentTypeID`)
    REFERENCES `PostOffice`.`Payment type` (`typeID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10002
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Order Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Order Details` (
  `ProductID` INT(11) NOT NULL,
  `TransactionID` INT(11) NOT NULL,
  `Quantity` INT(10) UNSIGNED NOT NULL,
  `UnitPrice` DOUBLE UNSIGNED NOT NULL,
  PRIMARY KEY (`ProductID`, `TransactionID`),
  INDEX `fk_Online Products_has_Online Transactions_Online Transacti_idx` (`TransactionID` ASC),
  INDEX `fk_Online Products_has_Online Transactions_Online Products1_idx` (`ProductID` ASC),
  CONSTRAINT `fk_Online Products_has_Online Transactions_Online Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `PostOffice`.`Online Products` (`ProductID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Online Products_has_Online Transactions_Online Transactions1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `PostOffice`.`Transactions` (`TransactionID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Package State`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Package State` (
  `PackageStateID` INT(11) NOT NULL AUTO_INCREMENT,
  `State` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`PackageStateID`),
  UNIQUE INDEX `PackageStateID_UNIQUE` (`PackageStateID` ASC),
  UNIQUE INDEX `State_UNIQUE` (`State` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Package`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Package` (
  `PackageID` INT(11) NOT NULL AUTO_INCREMENT,
  `TransactionID` INT(11) NOT NULL,
  `CustomerID` INT(11) NOT NULL,
  `SendToHouseNumber` VARCHAR(10) NOT NULL,
  `SendToStreet` VARCHAR(40) NOT NULL,
  `SendToZipCode` VARCHAR(10) NOT NULL,
  `SendToCity` VARCHAR(20) NOT NULL,
  `SendToState` VARCHAR(20) NOT NULL,
  `SendToCountry` VARCHAR(20) NOT NULL,
  `PackageWeight` DOUBLE UNSIGNED NOT NULL,
  `PackageSize` DOUBLE UNSIGNED NOT NULL,
  `SentDate` DATE NOT NULL,
  `ETA` DATE NOT NULL,
  `PackageStateID` INT(11) NOT NULL,
  `Subscribed` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`PackageID`),
  UNIQUE INDEX `PackageID_UNIQUE` (`PackageID` ASC),
  INDEX `fk_Package_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Package_Package State1_idx` (`PackageStateID` ASC),
  INDEX `fk_Package_Transactions1_idx` (`TransactionID` ASC),
  CONSTRAINT `fk_Package_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `PostOffice`.`Customer` (`CustomerID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Package_Package State1`
    FOREIGN KEY (`PackageStateID`)
    REFERENCES `PostOffice`.`Package State` (`PackageStateID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Package_Transactions1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `PostOffice`.`Transactions` (`TransactionID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10002
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Trucks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Trucks` (
  `TruckID` INT(11) NOT NULL AUTO_INCREMENT,
  `EmployeeID` INT(11) NOT NULL,
  PRIMARY KEY (`TruckID`),
  UNIQUE INDEX `TruckID_UNIQUE` (`TruckID` ASC),
  INDEX `fk_Trucks_Employee1_idx` (`EmployeeID` ASC),
  CONSTRAINT `fk_Trucks_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 102
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `PostOffice`.`Tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Tracking` (
  `ROW` INT(11) NOT NULL AUTO_INCREMENT,
  `PackageID` INT(11) NOT NULL,
  `TruckID` INT(11) NOT NULL,
  `HandlerID` INT(11) NOT NULL,
  `CurrentLocationID` INT(11) NOT NULL,
  `GoingToHouseNumber` VARCHAR(10) NULL DEFAULT NULL,
  `GoingToStreet` VARCHAR(40) NULL DEFAULT NULL,
  `GoingToZipCode` VARCHAR(10) NULL DEFAULT NULL,
  `GoingToCity` VARCHAR(20) NULL DEFAULT NULL,
  `GoingToState` VARCHAR(20) NULL DEFAULT NULL,
  `GoingToCountry` VARCHAR(20) NULL DEFAULT NULL,
  `GoingToLocationID` INT(11) NULL DEFAULT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`ROW`),
  UNIQUE INDEX `ROW_UNIQUE` (`ROW` ASC),
  INDEX `fk_Tracking_Package1` (`PackageID` ASC),
  INDEX `fk_Tracking_Trucks1_idx` (`TruckID` ASC),
  INDEX `fk_Tracking_Employee1_idx` (`HandlerID` ASC),
  INDEX `fk_Tracking_Location1_idx` (`CurrentLocationID` ASC),
  INDEX `fk_Tracking_Location2_idx` (`GoingToLocationID` ASC),
  CONSTRAINT `fk_Tracking_Employee1`
    FOREIGN KEY (`HandlerID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tracking_Location1`
    FOREIGN KEY (`CurrentLocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tracking_Location2`
    FOREIGN KEY (`GoingToLocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tracking_Package1`
    FOREIGN KEY (`PackageID`)
    REFERENCES `PostOffice`.`Package` (`PackageID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tracking_Trucks1`
    FOREIGN KEY (`TruckID`)
    REFERENCES `PostOffice`.`Trucks` (`TruckID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
