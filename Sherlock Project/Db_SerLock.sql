-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mapp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mapp` DEFAULT CHARACTER SET utf8 ;
USE `mapp` ;

-- -----------------------------------------------------
-- Table `mapp`.`image_url`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`image_url` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(2083) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`enrolled_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`enrolled_user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `dateofbirth` DATE NOT NULL,
  `postalcode` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `municipality` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(45) NOT NULL,
  `image_url_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_enrolled_user_image_url1_idx` (`image_url_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrolled_user_image_url1`
    FOREIGN KEY (`image_url_id`)
    REFERENCES `mapp`.`image_url` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `admission` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`ordering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`ordering` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderdate` DATETIME NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `enrolled_user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ordering_enrolled_user1_idx` (`enrolled_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_ordering_enrolled_user1`
    FOREIGN KEY (`enrolled_user_id`)
    REFERENCES `mapp`.`enrolled_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`company` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `cname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `postalcode` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `municipality` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(45) NOT NULL,
  `vatnumber` VARCHAR(45) NOT NULL,
  `vatservice` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `representative` VARCHAR(45) NOT NULL,
  `rating` INT UNSIGNED NULL,
  `iban` VARCHAR(45) NULL,
  `image_url_id` INT UNSIGNED NOT NULL,
  `profile` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_company_image_url1_idx` (`image_url_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_image_url1`
    FOREIGN KEY (`image_url_id`)
    REFERENCES `mapp`.`image_url` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`postal_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`postal_code` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `postal_code` VARCHAR(45) NOT NULL,
  `municipality` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`area_of_service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`area_of_service` (
  `postal_code_id` INT UNSIGNED NOT NULL,
  `company_id` INT UNSIGNED NOT NULL,
  INDEX `fk_area_of_service_postal_code1_idx` (`postal_code_id` ASC) VISIBLE,
  INDEX `fk_area_of_service_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_area_of_service_postal_code1`
    FOREIGN KEY (`postal_code_id`)
    REFERENCES `mapp`.`postal_code` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_area_of_service_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`category` (
  `id` INT UNSIGNED NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`subcategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`subcategory` (
  `id` INT UNSIGNED NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subcategory_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_subcategory_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mapp`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`product` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  `subcategory_id` INT UNSIGNED NOT NULL,
  `company_id` INT UNSIGNED NOT NULL,
  `rating` INT UNSIGNED NULL,
  `duration` INT UNSIGNED NOT NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_subcategory1_idx` (`subcategory_id` ASC) VISIBLE,
  INDEX `fk_product_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_subcategory1`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `mapp`.`subcategory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`orderlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`orderlist` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` INT UNSIGNED NOT NULL,
  `ordering_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orderlist_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_orderlist_ordering1_idx` (`ordering_id` ASC) VISIBLE,
  CONSTRAINT `fk_orderlist_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mapp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderlist_ordering1`
    FOREIGN KEY (`ordering_id`)
    REFERENCES `mapp`.`ordering` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`review` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ratingDate` DATETIME NULL,
  `product_comment` VARCHAR(100) NULL,
  `product_rating` TINYINT(5) UNSIGNED NOT NULL,
  `orderlist_id` INT UNSIGNED NOT NULL,
  `company_rating` TINYINT(5) NULL,
  `comment_company` VARCHAR(100) NULL,
  `company_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `enrolled_user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_reviews_orderlist1_idx` (`orderlist_id` ASC) VISIBLE,
  INDEX `fk_reviews_company1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_review_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_review_enrolled_user1_idx` (`enrolled_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_reviews_orderlist1`
    FOREIGN KEY (`orderlist_id`)
    REFERENCES `mapp`.`orderlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reviews_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mapp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_enrolled_user1`
    FOREIGN KEY (`enrolled_user_id`)
    REFERENCES `mapp`.`enrolled_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`appointment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderlist_id` INT UNSIGNED NOT NULL,
  `company_id` INT UNSIGNED NOT NULL,
  `enddate` TINYINT(49) NULL,
  `startdate` TINYINT(49) NULL,
  `appointment_date` DATE NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `enrolled_user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_appointment_orderlist1_idx` (`orderlist_id` ASC) VISIBLE,
  INDEX `fk_appointment_company1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_appointment_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_appointment_enrolled_user1_idx` (`enrolled_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_orderlist1`
    FOREIGN KEY (`orderlist_id`)
    REFERENCES `mapp`.`orderlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mapp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_enrolled_user1`
    FOREIGN KEY (`enrolled_user_id`)
    REFERENCES `mapp`.`enrolled_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`schedule` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `day` INT NOT NULL,
  `opentime` TINYINT(49) UNSIGNED NOT NULL,
  `closetime` TINYINT(49) UNSIGNED NOT NULL,
  `company_id` INT UNSIGNED NOT NULL,
  `reopentime` TINYINT(49) UNSIGNED NULL,
  `reclosetime` TINYINT(49) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`company_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`company_image` (
  `image_url_id` INT UNSIGNED NOT NULL,
  `company_id` INT UNSIGNED NOT NULL,
  INDEX `fk_table1_image_url1_idx` (`image_url_id` ASC) VISIBLE,
  INDEX `fk_table1_company2_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_image_url1`
    FOREIGN KEY (`image_url_id`)
    REFERENCES `mapp`.`image_url` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_company2`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`product_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`product_image` (
  `product_id` INT UNSIGNED NOT NULL,
  `image_url_id` INT UNSIGNED NOT NULL,
  INDEX `fk_product_image_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_product_image_image_url1_idx` (`image_url_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_image_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mapp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_image_image_url1`
    FOREIGN KEY (`image_url_id`)
    REFERENCES `mapp`.`image_url` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`user_role` (
  `enrolled_user_id` INT UNSIGNED NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  INDEX `fk_user_role_enrolled_user1_idx` (`enrolled_user_id` ASC) VISIBLE,
  INDEX `fk_user_role_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role_enrolled_user1`
    FOREIGN KEY (`enrolled_user_id`)
    REFERENCES `mapp`.`enrolled_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mapp`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`favorite` (
  `enrolled_user_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  INDEX `fk_favorite_list_enrolled_user1_idx` (`enrolled_user_id` ASC) VISIBLE,
  INDEX `fk_favorite_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_favorite_list_enrolled_user1`
    FOREIGN KEY (`enrolled_user_id`)
    REFERENCES `mapp`.`enrolled_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorite_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mapp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`paid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`paid` (
  `company_id` INT UNSIGNED NOT NULL,
  `orderlist_id` INT UNSIGNED NOT NULL,
  INDEX `fk_paid_company1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_paid_orderlist1_idx` (`orderlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_paid_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paid_orderlist1`
    FOREIGN KEY (`orderlist_id`)
    REFERENCES `mapp`.`orderlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mapp`.`company_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mapp`.`company_role` (
  `company_id` INT UNSIGNED NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  INDEX `fk_company_role_company1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_company_role_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_role_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mapp`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_role_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mapp`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
