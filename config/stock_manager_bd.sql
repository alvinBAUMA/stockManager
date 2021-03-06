
/**
 * Author:  Alvin
 * Created: 16 mai 2017
 */
-- MySQL Script generated by Team Tezzou
-- Tue May 16 23:07:42 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema stockmanager
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stockmanager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stockmanager` DEFAULT CHARACTER SET utf8 ;
USE `stockmanager` ;

-- -----------------------------------------------------
-- Table `stockmanager`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`users` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  `motdepasse` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`type_abonnement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`type_abonnement` (
  `id_abon` INT NOT NULL AUTO_INCREMENT,
  `nom_abon` VARCHAR(45) NOT NULL,
  `prix_abon` INT NOT NULL,
  PRIMARY KEY (`id_abon`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`boutiques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`boutiques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `rccm` VARCHAR(45) NULL,
  `id_nationnal` VARCHAR(45) NULL,
  `date_creation` DATETIME NULL,
  `user_id` INT NOT NULL,
  `type_abon_id` INT NOT NULL,
  `date_expiration` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_boutiques_users1_idx` (`user_id` ASC),
  INDEX `fk_boutiques_abonnements1_idx` (`type_abon_id` ASC),
  CONSTRAINT `fk_boutiques_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boutiques_abonnements1`
    FOREIGN KEY (`type_abon_id`)
    REFERENCES `stockmanager`.`type_abonnement` (`id_abon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`categories_produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`categories_produit` (
  `id_cat` INT NOT NULL AUTO_INCREMENT,
  `nom_cat` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `boutique_id` INT NOT NULL,
  PRIMARY KEY (`id_cat`),
  INDEX `fk_categories_produit_boutiques1_idx` (`boutique_id` ASC),
  CONSTRAINT `fk_categories_produit_boutiques1`
    FOREIGN KEY (`boutique_id`)
    REFERENCES `stockmanager`.`boutiques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`produits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`produits` (
  `id_prod` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NULL,
  `quantite` INT NOT NULL,
  `code_barre` VARCHAR(100) NULL,
  `couleur` VARCHAR(45) NULL,
  `mesure` VARCHAR(45) NULL,
  `description` TEXT(2000) NULL,
  `etat` VARCHAR(45) NULL,
  `categorie_id` INT NOT NULL,
  `boutique_id` INT NOT NULL,
  `photo` VARCHAR(255) NULL,
  PRIMARY KEY (`id_prod`),
  INDEX `fk_produits_categories_produit1_idx` (`categorie_id` ASC),
  INDEX `fk_produits_boutiques1_idx` (`boutique_id` ASC),
  CONSTRAINT `fk_produits_categories_produit1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `stockmanager`.`categories_produit` (`id_cat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produits_boutiques1`
    FOREIGN KEY (`boutique_id`)
    REFERENCES `stockmanager`.`boutiques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`fournisseurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`fournisseurs` (
  `id_four` INT NOT NULL AUTO_INCREMENT,
  `nom_four` VARCHAR(45) NULL,
  `adresse_four` VARCHAR(45) NULL,
  `mail_four` VARCHAR(45) NULL,
  `telephone_four` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_four`),
  INDEX `fk_fournisseurs_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_fournisseurs_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom_client` VARCHAR(45) NOT NULL,
  `adresse_client` VARCHAR(45) NULL,
  `telephone_client` VARCHAR(45) NULL,
  `mail_client` VARCHAR(45) NULL,
  `id_tezzou` INT NULL,
  `type` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_clients_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_clients_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`prix_produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`prix_produit` (
  `id_prix` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL,
  `montant` VARCHAR(45) NULL,
  `devise` VARCHAR(45) NULL,
  `produit_id` INT NOT NULL,
  PRIMARY KEY (`id_prix`),
  INDEX `fk_prix_produit_produits_idx` (`produit_id` ASC),
  CONSTRAINT `fk_prix_produit_produits`
    FOREIGN KEY (`produit_id`)
    REFERENCES `stockmanager`.`produits` (`id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`sortie_produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`sortie_produit` (
  `id_sortie` INT NOT NULL AUTO_INCREMENT,
  `prix` VARCHAR(45) NULL,
  `cash` VARCHAR(45) NULL,
  `quantite` INT NULL,
  `libelle` VARCHAR(45) NULL,
  `produit_id` INT NOT NULL,
  `user_id_vendeur` INT NOT NULL,
  `date_sortie` DATETIME NULL,
  PRIMARY KEY (`id_sortie`),
  INDEX `fk_sortie_produit_produits1_idx` (`produit_id` ASC),
  INDEX `fk_sortie_produit_users1_idx` (`user_id_vendeur` ASC),
  CONSTRAINT `fk_sortie_produit_produits1`
    FOREIGN KEY (`produit_id`)
    REFERENCES `stockmanager`.`produits` (`id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sortie_produit_users1`
    FOREIGN KEY (`user_id_vendeur`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`historiques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`historiques` (
  `id_hist` INT NOT NULL AUTO_INCREMENT,
  `id_user_subjet` INT NULL,
  `type` VARCHAR(45) NULL,
  `date_creation` DATETIME NULL,
  `description` VARCHAR(45) NULL,
  `id_produit` INT NULL,
  `id_sortie` INT NULL,
  `boutique_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_hist`),
  INDEX `fk_historiques_boutiques1_idx` (`boutique_id` ASC),
  INDEX `fk_historiques_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_historiques_boutiques1`
    FOREIGN KEY (`boutique_id`)
    REFERENCES `stockmanager`.`boutiques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historiques_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`notifications` (
  `id_notif` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `message` VARCHAR(245) NOT NULL,
  `date_creation` DATETIME NOT NULL,
  `id_user` INT NULL,
  `id_subjet` INT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_notif`),
  INDEX `fk_notifications_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`paiement_sortie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`paiement_sortie` (
  `id_pay` INT NOT NULL AUTO_INCREMENT,
  `date_pay` DATETIME NULL,
  `id_client` INT NULL,
  `credit` INT NULL,
  `sortie_id` INT NOT NULL,
  PRIMARY KEY (`id_pay`),
  INDEX `fk_paiement_sortie_sortie_produit1_idx` (`sortie_id` ASC),
  CONSTRAINT `fk_paiement_sortie_sortie_produit1`
    FOREIGN KEY (`sortie_id`)
    REFERENCES `stockmanager`.`sortie_produit` (`id_sortie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`permission_admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`permission_admin` (
  `user_id` INT NOT NULL,
  `boutique_id` INT NOT NULL,
  `admis_sortie` VARCHAR(45) NULL,
  `admis_entree` VARCHAR(45) NULL,
  `admis_historique` VARCHAR(45) NULL,
  `admis_notification` VARCHAR(45) NULL,
  `admis_abonnement` VARCHAR(45) NULL,
  `admis_fournisseur` VARCHAR(45) NULL,
  INDEX `fk_permission_admin_users1_idx` (`user_id` ASC),
  INDEX `fk_permission_admin_boutiques1_idx` (`boutique_id` ASC),
  CONSTRAINT `fk_permission_admin_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockmanager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permission_admin_boutiques1`
    FOREIGN KEY (`boutique_id`)
    REFERENCES `stockmanager`.`boutiques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stockmanager`.`caracteristiques_produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stockmanager`.`caracteristiques_produit` (
  `caracteristique` VARCHAR(255) NULL,
  `valeur` VARCHAR(255) NULL,
  `produit_id` INT NOT NULL,
  INDEX `fk_caracteristiques_produit_produits1_idx` (`produit_id` ASC),
  CONSTRAINT `fk_caracteristiques_produit_produits1`
    FOREIGN KEY (`produit_id`)
    REFERENCES `stockmanager`.`produits` (`id_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
