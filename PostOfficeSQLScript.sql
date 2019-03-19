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
-- Table `PostOffice`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `MobileNumber` VARCHAR(20) NOT NULL,
  `Address` VARCHAR(30) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `MobileNumber_UNIQUE` (`MobileNumber` ASC),
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;
ALTER TABLE `Customer` AUTO_INCREMENT=10001;



-- -----------------------------------------------------
-- Table `PostOffice`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Location` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `Address` VARCHAR(30) NOT NULL,
  `Hours` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`LocationID`),
  UNIQUE INDEX `LocationID_UNIQUE` (`LocationID` ASC))
ENGINE = InnoDB;
ALTER TABLE `Location` AUTO_INCREMENT=101;

-- -----------------------------------------------------
-- Table `PostOffice`.`Payment type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Payment type` (
  `typeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`typeID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PostOffice`.`Package Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Package Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `type` INT NOT NULL,
  `CardNumber` VARCHAR(19) NULL,
  `CCV` INT(3) NULL,
  `ExpirationDate` DATE NULL,
  `CardHolder` VARCHAR(20) NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `fk_Package Payment_Payment type1_idx` (`type` ASC),
  UNIQUE INDEX `CardNumber_UNIQUE` (`CardNumber` ASC),
  CONSTRAINT `fk_Package Payment_Payment type1`
    FOREIGN KEY (`type`)
    REFERENCES `PostOffice`.`Payment type` (`typeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Package Payment` AUTO_INCREMENT=101;


-- -----------------------------------------------------
-- Table `PostOffice`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Roles` (
  `RolesID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`RolesID`),
  UNIQUE INDEX `RolesID_UNIQUE` (`RolesID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PostOffice`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `LocationID` INT NOT NULL,
  `RoleID` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `MobliePhone` INT NOT NULL,
  `WorkPhone` INT NULL,
  `WorkEmail` VARCHAR(45) NOT NULL,
  `PersonalEmail` VARCHAR(45),
  `Wage` INT NOT NULL,
  `HiredOn` DATE NOT NULL,
  `Address` VARCHAR(30) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeesID_UNIQUE` (`EmployeeID` ASC),
  INDEX `fk_Employee_Location1_idx` (`LocationID` ASC),
  INDEX `fk_Employee_Roles1_idx` (`RoleID` ASC),
  UNIQUE INDEX `MobliePhone_UNIQUE` (`MobliePhone` ASC),
  UNIQUE INDEX `WorkEmail_UNIQUE` (`WorkEmail` ASC),
  UNIQUE INDEX `PersonalEmail_UNIQUE` (`PersonalEmail` ASC),
  CONSTRAINT `fk_Employee_Location1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Roles1`
    FOREIGN KEY (`RoleID`)
    REFERENCES `PostOffice`.`Roles` (`RolesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Employee` AUTO_INCREMENT=10001;


-- -----------------------------------------------------
-- Table `PostOffice`.`Package Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Package Transactions` (
  `TransactionID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `PaymentID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Price` DOUBLE UNSIGNED NOT NULL,
  PRIMARY KEY (`TransactionID`),
  UNIQUE INDEX `TransactionID_UNIQUE` (`TransactionID` ASC),
  INDEX `fk_Package Transactions_Package Payment1_idx` (`PaymentID` ASC),
  INDEX `fk_Package Transactions_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Package Transactions_Employee1_idx` (`EmployeeID` ASC),
  CONSTRAINT `fk_Package Transactions_Package Payment1`
    FOREIGN KEY (`PaymentID`)
    REFERENCES `PostOffice`.`Package Payment` (`PaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package Transactions_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `PostOffice`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package Transactions_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Package Transactions` AUTO_INCREMENT=10001;


-- -----------------------------------------------------
-- Table `PostOffice`.`Package`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Package` (
  `PackageID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `TransactionID` INT NOT NULL,
  `Weight` DOUBLE UNSIGNED NOT NULL,
  `Size` DOUBLE UNSIGNED NOT NULL,
  `Type` INT NOT NULL,
  `ToCustomerID` INT NULL,
  `FromLocationID` INT NULL,
  `SentDate` DATE NOT NULL,
  `ETA` DATE NOT NULL,
  `Delivered` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`PackageID`),
  UNIQUE INDEX `PackageID_UNIQUE` (`PackageID` ASC),
  INDEX `fk_Package_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Package_Location1_idx` (`FromLocationID` ASC),
  INDEX `fk_Package_Package Transactions1_idx` (`TransactionID` ASC),
  INDEX `fk_Package_Customer2_idx` (`ToCustomerID` ASC),
  CONSTRAINT `fk_Package_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `PostOffice`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package_Location1`
    FOREIGN KEY (`FromLocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package_Package Transactions1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `PostOffice`.`Package Transactions` (`TransactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package_Customer2`
    FOREIGN KEY (`ToCustomerID`)
    REFERENCES `PostOffice`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Package` AUTO_INCREMENT=10001;


-- -----------------------------------------------------
-- Table `PostOffice`.`Trucks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Trucks` (
  `TruckID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`TruckID`),
  INDEX `fk_Trucks_Employee1_idx` (`EmployeeID` ASC),
  UNIQUE INDEX `TruckID_UNIQUE` (`TruckID` ASC),
  CONSTRAINT `fk_Trucks_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Trucks` AUTO_INCREMENT=101;


-- -----------------------------------------------------
-- Table `PostOffice`.`Tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Tracking` (
  `PackageID` INT NOT NULL,
  `TruckID` INT NOT NULL,
  `HandlerID` INT NOT NULL,
  `CurrentLocationID` INT NOT NULL,
  `GoingToHouse` VARCHAR(30) NULL,
  `GoingToLocationID` INT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`PackageID`),
  INDEX `fk_Tracking_Trucks1_idx` (`TruckID` ASC),
  INDEX `fk_Tracking_Employee1_idx` (`HandlerID` ASC),
  INDEX `fk_Tracking_Location1_idx` (`CurrentLocationID` ASC),
  INDEX `fk_Tracking_Location2_idx` (`GoingToLocationID` ASC),
  CONSTRAINT `fk_Tracking_Package1`
    FOREIGN KEY (`PackageID`)
    REFERENCES `PostOffice`.`Package` (`PackageID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Trucks1`
    FOREIGN KEY (`TruckID`)
    REFERENCES `PostOffice`.`Trucks` (`TruckID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Employee1`
    FOREIGN KEY (`HandlerID`)
    REFERENCES `PostOffice`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Location1`
    FOREIGN KEY (`CurrentLocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Location2`
    FOREIGN KEY (`GoingToLocationID`)
    REFERENCES `PostOffice`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PostOffice`.`Online Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Online Payment` (
  `OnlinePaymentID` INT NOT NULL AUTO_INCREMENT,
  `type` INT NOT NULL,
  `CardNumber` VARCHAR(19) NOT NULL,
  `CCV` INT(3) NOT NULL,
  `ExpirationDate` DATE NOT NULL,
  `CardHolder` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`OnlinePaymentID`),
  UNIQUE INDEX `PayementID_UNIQUE` (`OnlinePaymentID` ASC),
  UNIQUE INDEX `CardNumber_UNIQUE` (`CardNumber` ASC),
  INDEX `fk_Online Payment_Payment type1_idx` (`type` ASC),
  CONSTRAINT `fk_Online Payment_Payment type1`
    FOREIGN KEY (`type`)
    REFERENCES `PostOffice`.`Payment type` (`typeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Online Payment` AUTO_INCREMENT=101;


-- -----------------------------------------------------
-- Table `PostOffice`.`Online Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Online Transactions` (
  `TransactionID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `OnlinePayementID` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `TotalPrice` DOUBLE UNSIGNED NOT NULL,
  PRIMARY KEY (`TransactionID`),
  UNIQUE INDEX `TransactionID_UNIQUE` (`TransactionID` ASC),
  INDEX `fk_Online Transactions_Online Payement1_idx` (`OnlinePayementID` ASC),
  INDEX `fk_Online Transactions_Customer1_idx` (`CustomerID` ASC),
  CONSTRAINT `fk_Online Transactions_Online Payement1`
    FOREIGN KEY (`OnlinePayementID`)
    REFERENCES `PostOffice`.`Online Payment` (`OnlinePaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Online Transactions_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `PostOffice`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
ALTER TABLE `Online Transactions` AUTO_INCREMENT=10001;


-- -----------------------------------------------------
-- Table `PostOffice`.`Online Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Online Products` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  `stock` INT UNSIGNED NOT NULL,
  `Price` DOUBLE UNSIGNED NOT NULL,
  `ReStock` DATE NOT NULL,
  `ImagePath` VARCHAR(70) NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE INDEX `ProductID_UNIQUE` (`ProductID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PostOffice`.`Order Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PostOffice`.`Order Details` (
  `ProductID` INT NOT NULL,
  `TransactionID` INT NOT NULL,
  `Quantity` INT UNSIGNED NOT NULL,
  `UnitPrice` DOUBLE UNSIGNED NOT NULL,
  PRIMARY KEY (`ProductID`, `TransactionID`),
  INDEX `fk_Online Products_has_Online Transactions_Online Transacti_idx` (`TransactionID` ASC),
  INDEX `fk_Online Products_has_Online Transactions_Online Products1_idx` (`ProductID` ASC),
  CONSTRAINT `fk_Online Products_has_Online Transactions_Online Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `PostOffice`.`Online Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Online Products_has_Online Transactions_Online Transactions1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `PostOffice`.`Online Transactions` (`TransactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;