-- MySQL Script generated by MySQL Workbench
-- 04/23/16 12:41:59
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Sekretarka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sekretarka` (
  `id_Sekretarka` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(32) NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `telefon` INT NOT NULL,
  `adres` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Sekretarka`, `mail`),
  UNIQUE INDEX `id_UNIQUE` (`id_Sekretarka` ASC),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lekarz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lekarz` (
  `id_Lekarz` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(32) NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `telefon` INT NOT NULL,
  `adres` VARCHAR(45) NOT NULL,
  `id_Sekretarka` INT NOT NULL,
  `godzinyPrzyjecOd` DATETIME NOT NULL,
  `godzinyPrzyjecDo` DATETIME NOT NULL,
  `urlop` TINYINT(1) NOT NULL,
  `urlopOd` DATETIME NULL,
  `urlopDo` DATETIME NULL,
  PRIMARY KEY (`id_Lekarz`, `mail`),
  UNIQUE INDEX `id_UNIQUE` (`id_Lekarz` ASC),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC),
  INDEX `id_Sekretarka_idx` (`id_Sekretarka` ASC),
  CONSTRAINT `id_SekretarkaId`
    FOREIGN KEY (`id_Sekretarka`)
    REFERENCES `mydb`.`Sekretarka` (`id_Sekretarka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pacjent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacjent` (
  `id_Pacjent` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(32) NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `telefon` INT NOT NULL,
  `adres` VARCHAR(45) NOT NULL,
  `pesel` INT NOT NULL,
  PRIMARY KEY (`id_Pacjent`),
  UNIQUE INDEX `id_UNIQUE` (`id_Pacjent` ASC),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SpecjalizacjaLekarzTyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SpecjalizacjaLekarzTyp` (
  `id_SpecjalizacjaLekarzTyp` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_SpecjalizacjaLekarzTyp`),
  UNIQUE INDEX `Nazwa_UNIQUE` (`nazwa` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SpecjalizacjaLekarz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SpecjalizacjaLekarz` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_Lekarz` INT NOT NULL,
  `id_SpecjalizacjaLekarzTyp` INT NOT NULL,
  INDEX `id_Lekarz_idx` (`id_Lekarz` ASC),
  INDEX `id_SpecjalizacjaTyp_idx` (`id_SpecjalizacjaLekarzTyp` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `id_LekarzId`
    FOREIGN KEY (`id_Lekarz`)
    REFERENCES `mydb`.`Lekarz` (`id_Lekarz`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_SpecjalizacjaLekarzTypId`
    FOREIGN KEY (`id_SpecjalizacjaLekarzTyp`)
    REFERENCES `mydb`.`SpecjalizacjaLekarzTyp` (`id_SpecjalizacjaLekarzTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ZabiegTyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ZabiegTyp` (
  `id_ZabiegTyp` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `opis` VARCHAR(250) NULL,
  PRIMARY KEY (`id_ZabiegTyp`, `nazwa`),
  UNIQUE INDEX `id_ZabiegTyp_UNIQUE` (`id_ZabiegTyp` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SpecjalizacjaZabieg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SpecjalizacjaZabieg` (
  `id_SpecjalizacjaLekarzTyp` INT NOT NULL,
  `id_ZabiegTyp` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  INDEX `id_ZabiegTyp_idx` (`id_ZabiegTyp` ASC),
  INDEX `id_SpecjalizacjaLekarzTypId_idx2_idx` (`id_SpecjalizacjaLekarzTyp` ASC),
  CONSTRAINT `id_SpecjalizacjaLekarzTypId_idx2`
    FOREIGN KEY (`id_SpecjalizacjaLekarzTyp`)
    REFERENCES `mydb`.`SpecjalizacjaLekarzTyp` (`id_SpecjalizacjaLekarzTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_ZabiegTypId_idx2`
    FOREIGN KEY (`id_ZabiegTyp`)
    REFERENCES `mydb`.`ZabiegTyp` (`id_ZabiegTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zabieg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zabieg` (
  `id_Zabieg` INT NOT NULL AUTO_INCREMENT,
  `id_ZabiegTyp` INT NOT NULL,
  `id_SpecjalizacjaLekarzTyp` INT NOT NULL,
  `id_Lekarz` INT NOT NULL,
  `przedzialCzas` INT NOT NULL,
  `cena` VARCHAR(45) NOT NULL,
  `zabiegPomoc` INT NULL,
  PRIMARY KEY (`id_Zabieg`),
  UNIQUE INDEX `id_Zabieg_UNIQUE` (`id_Zabieg` ASC),
  INDEX `id_ZabiegTypId_idx_idx` (`id_ZabiegTyp` ASC),
  INDEX `id_LekarzId_idx_idx` (`id_Lekarz` ASC),
  INDEX `id_SpecjalizacjaLekarzTypId_idx_idx` (`id_SpecjalizacjaLekarzTyp` ASC),
  CONSTRAINT `id_ZabiegTypId_idx`
    FOREIGN KEY (`id_ZabiegTyp`)
    REFERENCES `mydb`.`ZabiegTyp` (`id_ZabiegTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_LekarzId_idx`
    FOREIGN KEY (`id_Lekarz`)
    REFERENCES `mydb`.`Lekarz` (`id_Lekarz`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_SpecjalizacjaLekarzTypId_idx`
    FOREIGN KEY (`id_SpecjalizacjaLekarzTyp`)
    REFERENCES `mydb`.`SpecjalizacjaLekarzTyp` (`id_SpecjalizacjaLekarzTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Wizyta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Wizyta` (
  `id_Wizyta` INT NOT NULL AUTO_INCREMENT,
  `id_Zabieg` INT NOT NULL,
  `id_Pacjent` INT NOT NULL,
  `WizytaDateOd` DATETIME NOT NULL,
  `WizytaDateDo` DATETIME NULL,
  `id_LekarzZastepczy` INT NULL,
  `opinia` TEXT(500) NULL,
  `akceptacja` TINYINT(1) NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`id_Wizyta`),
  UNIQUE INDEX `id_wizyta_UNIQUE` (`id_Wizyta` ASC),
  INDEX `id_Zabieg_idx` (`id_Zabieg` ASC),
  INDEX `id_Pacjent_idx` (`id_Pacjent` ASC),
  INDEX `id_LekarzZastepczy_idx` (`id_LekarzZastepczy` ASC),
  CONSTRAINT `id_ZabiegId`
    FOREIGN KEY (`id_Zabieg`)
    REFERENCES `mydb`.`Zabieg` (`id_Zabieg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_PacjentId`
    FOREIGN KEY (`id_Pacjent`)
    REFERENCES `mydb`.`Pacjent` (`id_Pacjent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_LekarzZastepczyId`
    FOREIGN KEY (`id_LekarzZastepczy`)
    REFERENCES `mydb`.`Lekarz` (`id_Lekarz`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PomocMedyczna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PomocMedyczna` (
  `id_PomocMedyczna` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(32) NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `telefon` INT NOT NULL,
  `adres` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_PomocMedyczna`, `mail`),
  UNIQUE INDEX `id_UNIQUE` (`id_PomocMedyczna` ASC),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  UNIQUE INDEX `telefon_UNIQUE` (`telefon` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SpecjalizacjaPomocMedycznaTyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SpecjalizacjaPomocMedycznaTyp` (
  `id_SpecjalizacjaPomocMedycznaTyp` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_SpecjalizacjaPomocMedycznaTyp`),
  UNIQUE INDEX `id_SpecjalizacjaTyp_UNIQUE` (`id_SpecjalizacjaPomocMedycznaTyp` ASC),
  UNIQUE INDEX `Nazwa_UNIQUE` (`nazwa` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SpecjalizacjaPomocMedyczna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SpecjalizacjaPomocMedyczna` (
  `id_PomocMedyczna` INT NOT NULL,
  `id_SpecjalizacjaPomocMedycznaTyp` INT NOT NULL,
  INDEX `id_PomoczMedyczna_idx` (`id_PomocMedyczna` ASC),
  INDEX `id_SpecjalizacjaPomocMedycznaTyp_idx` (`id_SpecjalizacjaPomocMedycznaTyp` ASC),
  PRIMARY KEY (`id_PomocMedyczna`, `id_SpecjalizacjaPomocMedycznaTyp`),
  CONSTRAINT `id_PomoczMedycznaId`
    FOREIGN KEY (`id_PomocMedyczna`)
    REFERENCES `mydb`.`PomocMedyczna` (`id_PomocMedyczna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_SpecjalizacjaPomocMedycznaTypId`
    FOREIGN KEY (`id_SpecjalizacjaPomocMedycznaTyp`)
    REFERENCES `mydb`.`SpecjalizacjaPomocMedycznaTyp` (`id_SpecjalizacjaPomocMedycznaTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WizytaPomocMedyczna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`WizytaPomocMedyczna` (
  `id_Wizyta` INT NOT NULL,
  `id_PomocMedyczna` INT NOT NULL,
  PRIMARY KEY (`id_Wizyta`, `id_PomocMedyczna`),
  INDEX `id_PomocMedyczna_idx` (`id_PomocMedyczna` ASC),
  CONSTRAINT `id_WizytaId`
    FOREIGN KEY (`id_Wizyta`)
    REFERENCES `mydb`.`Wizyta` (`id_Wizyta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_PomocMedycznaId`
    FOREIGN KEY (`id_PomocMedyczna`)
    REFERENCES `mydb`.`PomocMedyczna` (`id_PomocMedyczna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RelacjaSpecjalizacjiLekPomMed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RelacjaSpecjalizacjiLekPomMed` (
  `id_SpecjalizacjaLekarzTyp` INT NOT NULL,
  `id_SpecjalizacjaPomocMedycznaTyp` INT NOT NULL,
  PRIMARY KEY (`id_SpecjalizacjaLekarzTyp`, `id_SpecjalizacjaPomocMedycznaTyp`),
  INDEX `id_SpecjalizacjaPomocMedycznaTypId_idx3` (`id_SpecjalizacjaPomocMedycznaTyp` ASC),
  CONSTRAINT `id_SpecjalizacjaLekarzTypId_idx3`
    FOREIGN KEY (`id_SpecjalizacjaLekarzTyp`)
    REFERENCES `mydb`.`SpecjalizacjaLekarzTyp` (`id_SpecjalizacjaLekarzTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_SpecjalizacjaPomocMedycznaTypId_idx3`
    FOREIGN KEY (`id_SpecjalizacjaPomocMedycznaTyp`)
    REFERENCES `mydb`.`SpecjalizacjaPomocMedycznaTyp` (`id_SpecjalizacjaPomocMedycznaTyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
