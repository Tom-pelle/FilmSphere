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
-- Table `FormatoVideo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FormatoVideo` ;

CREATE TABLE IF NOT EXISTS `FormatoVideo` (
  `Codice` INT NOT NULL,
  `Qualita` VARCHAR(45) NOT NULL,
  `BitRate` INT NOT NULL,
  `Risoluzione` VARCHAR(45) NOT NULL,
  `RapportoDAspetto` VARCHAR(45) NOT NULL,
  `DataRilascio` DATE NOT NULL,
  PRIMARY KEY (`Codice`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Regista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Regista` ;

CREATE TABLE IF NOT EXISTS `Regista` (
  `IdRegista` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdRegista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Film` ;

CREATE TABLE IF NOT EXISTS `Film` (
  `IdFilm` INT NOT NULL,
  `Anno` INT NOT NULL,
  `Titolo` VARCHAR(250) NOT NULL,
  `Durata` INT NOT NULL,
  `PaeseProd` VARCHAR(45) NOT NULL,
  `PunteggioGlobale` FLOAT NULL,
  `NumeroDiVisualizzazioni` INT NOT NULL DEFAULT 0,
  `Regista_IdRegista` INT NOT NULL,
  PRIMARY KEY (`IdFilm`),
  INDEX `fk_Film_Regista1_idx` (`Regista_IdRegista` ASC) VISIBLE,
  CONSTRAINT `fk_Film_Regista1`
    FOREIGN KEY (`Regista_IdRegista`)
    REFERENCES `Regista` (`IdRegista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FormatoAudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FormatoAudio` ;

CREATE TABLE IF NOT EXISTS `FormatoAudio` (
  `Codice` INT NOT NULL,
  `DataRilascio` DATE NOT NULL,
  `BitRate` INT NOT NULL,
  `Qualita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codice`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Versione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Versione` ;

CREATE TABLE IF NOT EXISTS `Versione` (
  `Anno` INT NOT NULL,
  `Dimensione` INT NOT NULL,
  `FormatoVideo_Codice` INT NOT NULL,
  `CodiceVersione` INT NOT NULL,
  `Film_IdFilm` INT NOT NULL,
  `FormatoAudio_Codice` INT NOT NULL,
  INDEX `fk_Versione_FormatoVideo_idx` (`FormatoVideo_Codice` ASC) VISIBLE,
  PRIMARY KEY (`CodiceVersione`),
  INDEX `fk_Versione_Film1_idx` (`Film_IdFilm` ASC) VISIBLE,
  INDEX `fk_Versione_FormatoAudio1_idx` (`FormatoAudio_Codice` ASC) VISIBLE,
  CONSTRAINT `fk_Versione_FormatoVideo`
    FOREIGN KEY (`FormatoVideo_Codice`)
    REFERENCES `FormatoVideo` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Versione_Film1`
    FOREIGN KEY (`Film_IdFilm`)
    REFERENCES `Film` (`IdFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Versione_FormatoAudio1`
    FOREIGN KEY (`FormatoAudio_Codice`)
    REFERENCES `FormatoAudio` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Genere`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Genere` ;

CREATE TABLE IF NOT EXISTS `Genere` (
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Appartenenza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Appartenenza` ;

CREATE TABLE IF NOT EXISTS `Appartenenza` (
  `Film_IdFilm` INT NOT NULL,
  `Genere_Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Film_IdFilm`, `Genere_Nome`),
  INDEX `fk_Film_has_Genere_Genere1_idx` (`Genere_Nome` ASC) VISIBLE,
  INDEX `fk_Film_has_Genere_Film1_idx` (`Film_IdFilm` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Genere_Film1`
    FOREIGN KEY (`Film_IdFilm`)
    REFERENCES `Film` (`IdFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_Genere_Genere1`
    FOREIGN KEY (`Genere_Nome`)
    REFERENCES `Genere` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Critico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Critico` ;

CREATE TABLE IF NOT EXISTS `Critico` (
  `IdCritico` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdCritico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RecensioneCritico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RecensioneCritico` ;

CREATE TABLE IF NOT EXISTS `RecensioneCritico` (
  `Critico_IdCritico` INT NOT NULL,
  `Film_IdFilm` INT NOT NULL,
  `Voto` INT NOT NULL,
  `Data` DATE NOT NULL,
  PRIMARY KEY (`Critico_IdCritico`, `Film_IdFilm`),
  INDEX `fk_Critico_has_Film_Film1_idx` (`Film_IdFilm` ASC) VISIBLE,
  INDEX `fk_Critico_has_Film_Critico1_idx` (`Critico_IdCritico` ASC) VISIBLE,
  CONSTRAINT `fk_Critico_has_Film_Critico1`
    FOREIGN KEY (`Critico_IdCritico`)
    REFERENCES `Critico` (`IdCritico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Critico_has_Film_Film1`
    FOREIGN KEY (`Film_IdFilm`)
    REFERENCES `Film` (`IdFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Attore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Attore` ;

CREATE TABLE IF NOT EXISTS `Attore` (
  `IdAttore` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdAttore`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Interpretazione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Interpretazione` ;

CREATE TABLE IF NOT EXISTS `Interpretazione` (
  `Film_IdFilm` INT NOT NULL,
  `Attore_IdAttore` INT NOT NULL,
  PRIMARY KEY (`Film_IdFilm`, `Attore_IdAttore`),
  INDEX `fk_Film_has_Attore_Attore1_idx` (`Attore_IdAttore` ASC) VISIBLE,
  INDEX `fk_Film_has_Attore_Film1_idx` (`Film_IdFilm` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_Attore_Film1`
    FOREIGN KEY (`Film_IdFilm`)
    REFERENCES `Film` (`IdFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_Attore_Attore1`
    FOREIGN KEY (`Attore_IdAttore`)
    REFERENCES `Attore` (`IdAttore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PremioAttore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PremioAttore` ;

CREATE TABLE IF NOT EXISTS `PremioAttore` (
  `Codice` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Ente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codice`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PremioRegista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PremioRegista` ;

CREATE TABLE IF NOT EXISTS `PremioRegista` (
  `Codice` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Ente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codice`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PremiazioneAttore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PremiazioneAttore` ;

CREATE TABLE IF NOT EXISTS `PremiazioneAttore` (
  `Attore_IdAttore` INT NOT NULL,
  `PremioAttore_Codice` INT NOT NULL,
  `Anno` INT NOT NULL,
  PRIMARY KEY (`Attore_IdAttore`, `PremioAttore_Codice`),
  INDEX `fk_Attore_has_PremioAttore_PremioAttore1_idx` (`PremioAttore_Codice` ASC) VISIBLE,
  INDEX `fk_Attore_has_PremioAttore_Attore1_idx` (`Attore_IdAttore` ASC) VISIBLE,
  CONSTRAINT `fk_Attore_has_PremioAttore_Attore1`
    FOREIGN KEY (`Attore_IdAttore`)
    REFERENCES `Attore` (`IdAttore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Attore_has_PremioAttore_PremioAttore1`
    FOREIGN KEY (`PremioAttore_Codice`)
    REFERENCES `PremioAttore` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PremiazioneRegista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PremiazioneRegista` ;

CREATE TABLE IF NOT EXISTS `PremiazioneRegista` (
  `Regista_IdRegista` INT NOT NULL,
  `PremioRegista_Codice` INT NOT NULL,
  `Anno` INT NOT NULL,
  PRIMARY KEY (`Regista_IdRegista`, `PremioRegista_Codice`),
  INDEX `fk_Regista_has_PremioRegista_PremioRegista1_idx` (`PremioRegista_Codice` ASC) VISIBLE,
  INDEX `fk_Regista_has_PremioRegista_Regista1_idx` (`Regista_IdRegista` ASC) VISIBLE,
  CONSTRAINT `fk_Regista_has_PremioRegista_Regista1`
    FOREIGN KEY (`Regista_IdRegista`)
    REFERENCES `Regista` (`IdRegista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Regista_has_PremioRegista_PremioRegista1`
    FOREIGN KEY (`PremioRegista_Codice`)
    REFERENCES `PremioRegista` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PremioFilm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PremioFilm` ;

CREATE TABLE IF NOT EXISTS `PremioFilm` (
  `Codice` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Ente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codice`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PremiazioneFilm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PremiazioneFilm` ;

CREATE TABLE IF NOT EXISTS `PremiazioneFilm` (
  `Film_IdFilm` INT NOT NULL,
  `PremioFilm_Codice` INT NOT NULL,
  `Anno` INT NOT NULL,
  PRIMARY KEY (`Film_IdFilm`, `PremioFilm_Codice`),
  INDEX `fk_Film_has_PremioFilm_PremioFilm1_idx` (`PremioFilm_Codice` ASC) VISIBLE,
  INDEX `fk_Film_has_PremioFilm_Film1_idx` (`Film_IdFilm` ASC) VISIBLE,
  CONSTRAINT `fk_Film_has_PremioFilm_Film1`
    FOREIGN KEY (`Film_IdFilm`)
    REFERENCES `Film` (`IdFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_has_PremioFilm_PremioFilm1`
    FOREIGN KEY (`PremioFilm_Codice`)
    REFERENCES `PremioFilm` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Server`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Server` ;

CREATE TABLE IF NOT EXISTS `Server` (
  `IdServer` INT NOT NULL,
  `Longitudine` FLOAT NOT NULL,
  `Latitudine` FLOAT NOT NULL,
  `CapacitaMax` INT NOT NULL,
  `LarghezzaDiBanda` INT NOT NULL,
  `CapacitaRimanente` INT NOT NULL,
  PRIMARY KEY (`IdServer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Memorizzazione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Memorizzazione` ;

CREATE TABLE IF NOT EXISTS `Memorizzazione` (
  `Server_IdServer` INT NOT NULL,
  `Versione_CodiceVersione` INT NOT NULL,
  `Inizio` TIMESTAMP(6) NOT NULL,
  `Fine` TIMESTAMP(6) NULL,
  PRIMARY KEY (`Server_IdServer`, `Versione_CodiceVersione`, `Inizio`),
  INDEX `fk_Server_has_Versione_Versione1_idx` (`Versione_CodiceVersione` ASC) VISIBLE,
  INDEX `fk_Server_has_Versione_Server1_idx` (`Server_IdServer` ASC) VISIBLE,
  CONSTRAINT `fk_Server_has_Versione_Server1`
    FOREIGN KEY (`Server_IdServer`)
    REFERENCES `Server` (`IdServer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Server_has_Versione_Versione1`
    FOREIGN KEY (`Versione_CodiceVersione`)
    REFERENCES `Versione` (`CodiceVersione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Servizio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Servizio` ;

CREATE TABLE IF NOT EXISTS `Servizio` (
  `IdServizio` INT NOT NULL,
  `Inizio` TIMESTAMP(6) NOT NULL,
  `Fine` TIMESTAMP(6) NULL,
  `Versione_CodiceVersione` INT NOT NULL,
  `Server_IdServer` INT NOT NULL,
  PRIMARY KEY (`IdServizio`),
  INDEX `fk_Servizio_Versione1_idx` (`Versione_CodiceVersione` ASC) VISIBLE,
  INDEX `fk_Servizio_Server1_idx` (`Server_IdServer` ASC) VISIBLE,
  CONSTRAINT `fk_Servizio_Versione1`
    FOREIGN KEY (`Versione_CodiceVersione`)
    REFERENCES `Versione` (`CodiceVersione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servizio_Server1`
    FOREIGN KEY (`Server_IdServer`)
    REFERENCES `Server` (`IdServer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dispositivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dispositivo` ;

CREATE TABLE IF NOT EXISTS `Dispositivo` (
  `Id` INT NOT NULL,
  `Modello` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Abbonamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Abbonamento` ;

CREATE TABLE IF NOT EXISTS `Abbonamento` (
  `Nome` VARCHAR(45) NOT NULL,
  `Tariffa` INT NOT NULL,
  `FunzionalitaAggiuntive` VARCHAR(45) NOT NULL,
  `MaxOre` INT NOT NULL,
  `MaxGb` INT NOT NULL,
  `EtaMinima` INT NOT NULL,
  `Durata` INT NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Paese`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Paese` ;

CREATE TABLE IF NOT EXISTS `Paese` (
  `Nome` VARCHAR(45) NOT NULL,
  `Longitudine` FLOAT NOT NULL,
  `Latitudine` FLOAT NOT NULL,
  `Ip` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Utente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Utente` ;

CREATE TABLE IF NOT EXISTS `Utente` (
  `Codice` INT NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `IndirizzoEmail` VARCHAR(45) NOT NULL,
  `DataNascita` DATE NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Abbonamento_Nome` VARCHAR(45) NULL,
  `Paese_Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codice`),
  INDEX `fk_Utente_Abbonamento1_idx` (`Abbonamento_Nome` ASC) VISIBLE,
  INDEX `fk_Utente_Paese1_idx` (`Paese_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Utente_Abbonamento1`
    FOREIGN KEY (`Abbonamento_Nome`)
    REFERENCES `Abbonamento` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utente_Paese1`
    FOREIGN KEY (`Paese_Nome`)
    REFERENCES `Paese` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Connessione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Connessione` ;

CREATE TABLE IF NOT EXISTS `Connessione` (
  `Inizio` TIMESTAMP(6) NOT NULL,
  `Ip` VARCHAR(12) NOT NULL,
  `Fine` TIMESTAMP(6) NULL,
  `Servizio_IdServizio` INT NOT NULL,
  `Dispositivo_Id` INT NOT NULL,
  `Utente_Codice` INT NOT NULL,
  PRIMARY KEY (`Inizio`, `Dispositivo_Id`),
  INDEX `fk_Connessione_Servizio1_idx` (`Servizio_IdServizio` ASC) VISIBLE,
  INDEX `fk_Connessione_Dispositivo1_idx` (`Dispositivo_Id` ASC) VISIBLE,
  INDEX `fk_Connessione_Utente1_idx` (`Utente_Codice` ASC) VISIBLE,
  CONSTRAINT `fk_Connessione_Servizio1`
    FOREIGN KEY (`Servizio_IdServizio`)
    REFERENCES `Servizio` (`IdServizio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Connessione_Dispositivo1`
    FOREIGN KEY (`Dispositivo_Id`)
    REFERENCES `Dispositivo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Connessione_Utente1`
    FOREIGN KEY (`Utente_Codice`)
    REFERENCES `Utente` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RecensioneUtente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RecensioneUtente` ;

CREATE TABLE IF NOT EXISTS `RecensioneUtente` (
  `Utente_Codice` INT NOT NULL,
  `Film_IdFilm` INT NOT NULL,
  `Voto` INT NOT NULL,
  `Data` DATE NOT NULL,
  PRIMARY KEY (`Utente_Codice`, `Film_IdFilm`),
  INDEX `fk_Utente_has_Film_Film1_idx` (`Film_IdFilm` ASC) VISIBLE,
  INDEX `fk_Utente_has_Film_Utente1_idx` (`Utente_Codice` ASC) VISIBLE,
  CONSTRAINT `fk_Utente_has_Film_Utente1`
    FOREIGN KEY (`Utente_Codice`)
    REFERENCES `Utente` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utente_has_Film_Film1`
    FOREIGN KEY (`Film_IdFilm`)
    REFERENCES `Film` (`IdFilm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RestrizioneAbbonamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RestrizioneAbbonamento` ;

CREATE TABLE IF NOT EXISTS `RestrizioneAbbonamento` (
  `Paese_Nome` VARCHAR(45) NOT NULL,
  `Abbonamento_Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Paese_Nome`, `Abbonamento_Nome`),
  INDEX `fk_Paese_has_Abbonamento_Abbonamento1_idx` (`Abbonamento_Nome` ASC) VISIBLE,
  INDEX `fk_Paese_has_Abbonamento_Paese1_idx` (`Paese_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Paese_has_Abbonamento_Paese1`
    FOREIGN KEY (`Paese_Nome`)
    REFERENCES `Paese` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Paese_has_Abbonamento_Abbonamento1`
    FOREIGN KEY (`Abbonamento_Nome`)
    REFERENCES `Abbonamento` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RestrizioneVersione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RestrizioneVersione` ;

CREATE TABLE IF NOT EXISTS `RestrizioneVersione` (
  `Versione_CodiceVersione` INT NOT NULL,
  `Paese_Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Versione_CodiceVersione`, `Paese_Nome`),
  INDEX `fk_Versione_has_Paese_Paese1_idx` (`Paese_Nome` ASC) VISIBLE,
  INDEX `fk_Versione_has_Paese_Versione1_idx` (`Versione_CodiceVersione` ASC) VISIBLE,
  CONSTRAINT `fk_Versione_has_Paese_Versione1`
    FOREIGN KEY (`Versione_CodiceVersione`)
    REFERENCES `Versione` (`CodiceVersione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Versione_has_Paese_Paese1`
    FOREIGN KEY (`Paese_Nome`)
    REFERENCES `Paese` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CartaDiCredito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CartaDiCredito` ;

CREATE TABLE IF NOT EXISTS `CartaDiCredito` (
  `Numero` VARCHAR(16) NOT NULL,
  `CVV` INT NOT NULL,
  `Intestatario` VARCHAR(45) NOT NULL,
  `AnnoScadenza` INT NOT NULL,
  `MeseScadenza` INT NOT NULL,
  `Attiva` TINYINT(1) NOT NULL,
  `Utente_Codice` INT NOT NULL,
  PRIMARY KEY (`Numero`),
  INDEX `fk_CartaDiCredito_Utente1_idx` (`Utente_Codice` ASC) VISIBLE,
  CONSTRAINT `fk_CartaDiCredito_Utente1`
    FOREIGN KEY (`Utente_Codice`)
    REFERENCES `Utente` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fattura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Fattura` ;

CREATE TABLE IF NOT EXISTS `Fattura` (
  `IdFattura` INT NOT NULL,
  `Saldo` INT NOT NULL,
  `Emissione` DATE NOT NULL,
  `Scadenza` DATE NOT NULL,
  `Utente_Codice` INT NOT NULL,
  `CartaDiCredito_Numero` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`IdFattura`),
  INDEX `fk_Fattura_Utente1_idx` (`Utente_Codice` ASC) VISIBLE,
  INDEX `fk_Fattura_CartaDiCredito1_idx` (`CartaDiCredito_Numero` ASC) VISIBLE,
  CONSTRAINT `fk_Fattura_Utente1`
    FOREIGN KEY (`Utente_Codice`)
    REFERENCES `Utente` (`Codice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fattura_CartaDiCredito1`
    FOREIGN KEY (`CartaDiCredito_Numero`)
    REFERENCES `CartaDiCredito` (`Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Distanza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Distanza` ;

CREATE TABLE IF NOT EXISTS `Distanza` (
  `Paese_Nome` VARCHAR(45) NOT NULL,
  `Server_IdServer` INT NOT NULL,
  `Valore` INT NOT NULL,
  PRIMARY KEY (`Paese_Nome`, `Server_IdServer`),
  INDEX `fk_Paese_has_Server_Server1_idx` (`Server_IdServer` ASC) VISIBLE,
  INDEX `fk_Paese_has_Server_Paese1_idx` (`Paese_Nome` ASC) VISIBLE,
  CONSTRAINT `fk_Paese_has_Server_Paese1`
    FOREIGN KEY (`Paese_Nome`)
    REFERENCES `Paese` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Paese_has_Server_Server1`
    FOREIGN KEY (`Server_IdServer`)
    REFERENCES `Server` (`IdServer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;