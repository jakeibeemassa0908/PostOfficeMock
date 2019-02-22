-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `MobileNumber` INT NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `MobileNumber_UNIQUE` (`MobileNumber` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Location` (
  `LocationID` INT NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Hours` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Package Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Package Payment` (
  `PaymentID` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `CardNumber` INT(16) NULL,
  `CCV` INT(3) NULL,
  `ExpirationDate` DATE NULL,
  `CardHolder` VARCHAR(255) NULL,
  PRIMARY KEY (`PaymentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `RolesID` INT NOT NULL,
  `Name` VARCHAR(255) NULL,
  PRIMARY KEY (`RolesID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `EmployeeID` INT NOT NULL,
  `LocationID` INT NOT NULL,
  `RoleID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `MobliePhone` INT NOT NULL,
  `WorkPhone` INT NULL,
  `Wage` INT NOT NULL,
  `HiredOn` DATE NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeesID_UNIQUE` (`EmployeeID` ASC),
  INDEX `fk_Employee_Location1_idx` (`LocationID` ASC),
  INDEX `fk_Employee_Roles1_idx` (`RoleID` ASC),
  UNIQUE INDEX `MobliePhone_UNIQUE` (`MobliePhone` ASC),
  CONSTRAINT `fk_Employee_Location1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `mydb`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Roles1`
    FOREIGN KEY (`RoleID`)
    REFERENCES `mydb`.`Roles` (`RolesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Package Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Package Transactions` (
  `TransactionID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `PaymentID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Price` DOUBLE NOT NULL,
  PRIMARY KEY (`TransactionID`),
  UNIQUE INDEX `TransactionID_UNIQUE` (`TransactionID` ASC),
  INDEX `fk_Package Transactions_Package Payment1_idx` (`PaymentID` ASC),
  INDEX `fk_Package Transactions_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Package Transactions_Employee1_idx` (`EmployeeID` ASC),
  CONSTRAINT `fk_Package Transactions_Package Payment1`
    FOREIGN KEY (`PaymentID`)
    REFERENCES `mydb`.`Package Payment` (`PaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package Transactions_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package Transactions_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Package`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Package` (
  `PackageID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `TransactionID` INT NOT NULL,
  `Weight` DOUBLE NOT NULL,
  `Size` DOUBLE NOT NULL,
  `Cost` DOUBLE NOT NULL,
  `Type` INT NOT NULL,
  `To` VARCHAR(255) NOT NULL,
  `FromLocationID` INT NOT NULL,
  `SentDate` DATE NOT NULL,
  `ETA` DATE NOT NULL,
  `Delivered` TINYINT NOT NULL,
  PRIMARY KEY (`PackageID`),
  UNIQUE INDEX `PackageID_UNIQUE` (`PackageID` ASC),
  INDEX `fk_Package_Customer1_idx` (`CustomerID` ASC),
  INDEX `fk_Package_Location1_idx` (`FromLocationID` ASC),
  INDEX `fk_Package_Package Transactions1_idx` (`TransactionID` ASC),
  CONSTRAINT `fk_Package_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package_Location1`
    FOREIGN KEY (`FromLocationID`)
    REFERENCES `mydb`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Package_Package Transactions1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `mydb`.`Package Transactions` (`TransactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trucks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trucks` (
  `TruckID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`TruckID`),
  INDEX `fk_Trucks_Employee1_idx` (`EmployeeID` ASC),
  CONSTRAINT `fk_Trucks_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tracking` (
  `PackageID` INT NOT NULL,
  `TruckID` INT NOT NULL,
  `HandlerID` INT NOT NULL,
  `CurrentLocationID` INT NOT NULL,
  `GoingToHouse` VARCHAR(255) NULL,
  `GoingToLocationID` INT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`PackageID`),
  INDEX `fk_Tracking_Trucks1_idx` (`TruckID` ASC),
  INDEX `fk_Tracking_Employee1_idx` (`HandlerID` ASC),
  INDEX `fk_Tracking_Location1_idx` (`CurrentLocationID` ASC),
  INDEX `fk_Tracking_Location2_idx` (`GoingToLocationID` ASC),
  CONSTRAINT `fk_Tracking_Package1`
    FOREIGN KEY (`PackageID`)
    REFERENCES `mydb`.`Package` (`PackageID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Trucks1`
    FOREIGN KEY (`TruckID`)
    REFERENCES `mydb`.`Trucks` (`TruckID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Employee1`
    FOREIGN KEY (`HandlerID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Location1`
    FOREIGN KEY (`CurrentLocationID`)
    REFERENCES `mydb`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tracking_Location2`
    FOREIGN KEY (`GoingToLocationID`)
    REFERENCES `mydb`.`Location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Online Payement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Online Payement` (
  `PayementID` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `CardNumber` INT(16) NOT NULL,
  `CCV` INT(3) NOT NULL,
  `ExpirationDate` DATE NOT NULL,
  `CardHolder` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`PayementID`),
  UNIQUE INDEX `PayementID_UNIQUE` (`PayementID` ASC),
  UNIQUE INDEX `CardNumber_UNIQUE` (`CardNumber` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Online Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Online Transactions` (
  `TransactionID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `PayementID` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `TotalPrice` DOUBLE NOT NULL,
  PRIMARY KEY (`TransactionID`),
  UNIQUE INDEX `TransactionID_UNIQUE` (`TransactionID` ASC),
  INDEX `fk_Online Transactions_Online Payement1_idx` (`PayementID` ASC),
  INDEX `fk_Online Transactions_Customer1_idx` (`CustomerID` ASC),
  CONSTRAINT `fk_Online Transactions_Online Payement1`
    FOREIGN KEY (`PayementID`)
    REFERENCES `mydb`.`Online Payement` (`PayementID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Online Transactions_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Online Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Online Products` (
  `ProductID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `stock` INT NOT NULL,
  `Price` DOUBLE NOT NULL,
  `ReStock` DATE NOT NULL,
  `ImagePath` VARCHAR(255) NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE INDEX `ProductID_UNIQUE` (`ProductID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order Details` (
  `ProductID` INT NOT NULL,
  `TransactionID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `UnitPrice` DOUBLE NOT NULL,
  PRIMARY KEY (`ProductID`, `TransactionID`),
  INDEX `fk_Online Products_has_Online Transactions_Online Transacti_idx` (`TransactionID` ASC),
  INDEX `fk_Online Products_has_Online Transactions_Online Products1_idx` (`ProductID` ASC),
  CONSTRAINT `fk_Online Products_has_Online Transactions_Online Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `mydb`.`Online Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Online Products_has_Online Transactions_Online Transactions1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `mydb`.`Online Transactions` (`TransactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
