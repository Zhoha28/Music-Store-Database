-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema MusicStore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MusicStore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MusicStore` DEFAULT CHARACTER SET utf8 ;
USE `MusicStore` ;

-- -----------------------------------------------------
-- Table `MusicStore`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`clients` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `client_email` VARCHAR(45) NOT NULL,
  `client_password` VARCHAR(45) NOT NULL,
  `client_phone` BIGINT NOT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE INDEX `client_password_UNIQUE` (`client_password` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `MusicStore`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`addresses` ;
CREATE TABLE IF NOT EXISTS `MusicStore`.`addresses` (
  `addresses_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `line1` VARCHAR(70) NOT NULL,
  `line2` VARCHAR(70) NULL DEFAULT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `city_id` INT NULL DEFAULT NULL,
  `province_id` INT NULL DEFAULT NULL,
  `country_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`addresses_id`),
  INDEX `fk_addresses_clients_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_addresses_clients_provine_idx` (`province_id` ASC) VISIBLE,
  INDEX `fk_addresses_clients_country_idx` (`country_id` ASC) VISIBLE,
  INDEX `fk_client_id_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_addresses_clients_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `MusicStore`.`City` (`City_Id`),
  CONSTRAINT `fk_addresses_clients_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `MusicStore`.`Country` (`Country_Id`),
  CONSTRAINT `fk_addresses_clients_provine`
    FOREIGN KEY (`province_id`)
    REFERENCES `MusicStore`.`Province` (`province_id`),
  CONSTRAINT `fk_client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `MusicStore`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MusicStore`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`genre` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`genre` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `MusicStore`.`singer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`singer` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`singer` (
  `singer_id` INT NOT NULL AUTO_INCREMENT,
  `singer_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`singer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `MusicStore`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`album` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`album` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `singer_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  `album_name` VARCHAR(45) NOT NULL,
  `album_code` VARCHAR(45) NOT NULL,
  `album_price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `num_of_copies_available` TINYINT NOT NULL DEFAULT '1',
  PRIMARY KEY (`album_id`),
  INDEX `fk_album_singer1_idx` (`singer_id` ASC) VISIBLE,
  INDEX `fk_album_genre1_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `MusicStore`.`genre` (`genre_id`),
  CONSTRAINT `fk_album_singer1`
    FOREIGN KEY (`singer_id`)
    REFERENCES `MusicStore`.`singer` (`singer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `MusicStore`.`card_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`card_type` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`card_type` (
  `card_id` INT NOT NULL,
  `card_type` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`card_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `MusicStore`.`order_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`order_status` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`order_status` (
  `order_status_id` INT NOT NULL,
  `order_status` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`order_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `MusicStore`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`orders` ;
CREATE TABLE IF NOT EXISTS `MusicStore`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `order_date` DATETIME NOT NULL,
  `ship_date` DATETIME NULL DEFAULT NULL,
  `order_total` DECIMAL(10,2) NOT NULL,
  
  `card_id` INT NOT NULL,
  `card_number` VARCHAR(20) NOT NULL,
  `card_expires` CHAR(7) NOT NULL,
  `order_status_id` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_clients1_idx` (`client_id` ASC) VISIBLE,
  INDEX `card_id` (`card_id` ASC) VISIBLE,
  INDEX `fk_orders_status_id_idx` (`order_status_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `MusicStore`.`clients` (`client_id`),
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`card_id`)
    REFERENCES `MusicStore`.`card_type` (`card_id`),
  CONSTRAINT `fk_orders_status_id`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `MusicStore`.`order_status` (`order_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;




-- -----------------------------------------------------
-- Table `MusicStore`.`order_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusicStore`.`order_item` ;

CREATE TABLE IF NOT EXISTS `MusicStore`.`order_item` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  `list_price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `discount_percent` DECIMAL(4,2) NOT NULL DEFAULT '0.00',
  `quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_item_id`),
  INDEX `fk_order_item_orders1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_item_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_item_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `MusicStore`.`album` (`album_id`),
  CONSTRAINT `fk_order_item_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `MusicStore`.`orders` (`order_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS `MusicStore`.`City` (
  `City_Id` INT NOT NULL,
  `city_name` VARCHAR(45) NULL,
  PRIMARY KEY (`City_Id`),
  UNIQUE INDEX `city_name_UNIQUE` (`city_name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `MusicStore`.`Province` (
  `province_id` INT NOT NULL,
  `Province_name` VARCHAR(45) NULL,
  PRIMARY KEY (`province_id`),
  UNIQUE INDEX `Province_name_UNIQUE` (`Province_name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `MusicStore`.`Country` (
  `Country_Id` INT NOT NULL,
  `Country_name` VARCHAR(45) NULL,
  PRIMARY KEY (`Country_Id`),
  UNIQUE INDEX `Country_name_UNIQUE` (`Country_name` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- populating database

-- singer table
insert into singer(singer_name)values("enrique");
insert into singer(singer_name)values("arijit singh");
insert into singer(singer_name)values("The Local Train");
insert into singer(singer_name)values("NF");
insert into singer(singer_name)values("Anu Jain");
insert into singer(singer_name)values("Prateek Kuhad");

-- checking
select * from singer;


-- genre table
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (1, 'Pop Music');
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (2, 'Hip Hop');
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (3, 'Jazz / Acoustic');
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (4, 'Acoustic blues');
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (5, 'Classic');
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (6, 'Country Folk');
INSERT INTO `MusicStore`.`genre` (`genre_id`, `genre_name`) VALUES (7, 'Rap');


-- album table

INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (1, 1, 1, 'addicted', '1', 199, 50);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (2, 1, 2, 'Tonight I\'m Loving You', '1', 299, 40);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (3, 1, 1, 'Bailando', '1', 150, 30);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (4, 2, 1, 'Aye dil hain mushkil', '2', 130, 20);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (5, 2, 5, 'Qafirana', '2', 200, 13);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (6, 2, 5, 'Raabta', '2', 140, 20);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (7, 3, 6, 'Aftaab', '3', 400, 40);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (8, 3, 1, 'Choo Loo', '3', 400, 23);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (9, 3, 1, 'Dil Mere', '3', 400, 20);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (10, 4, 7, 'Lie', '4', 199, 10);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (11, 4, 7, 'Let You Down', '4', 199, 10);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (12, 5, 4, 'Mishri', '5', 100, 79);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (13, 5, 4, 'Gul', '5', 100, 20);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (14, 6, 3, '100 words', '6', 299, 10);
INSERT INTO `MusicStore`.`album` (`album_id`, `singer_id`, `genre_id`, `album_name`, `album_code`, `album_price`, `num_of_copies_available`) VALUES (15, 5, 3, 'kho gaye ham kaha', '6', 299, 19);


-- checking
select * from album;



-- client table

INSERT INTO `MusicStore`.`clients` (`client_id`, `first_name`, `last_name`, `client_email`, `client_password`, `client_phone`) VALUES (1, 'Zhoha', 'Damani', 'zdamani0121@conestogac.on.ca', 'asbc123sdsjdbsbhjhjfh', 123456789);
INSERT INTO `MusicStore`.`clients` (`client_id`, `first_name`, `last_name`, `client_email`, `client_password`, `client_phone`) VALUES (2, 'YashKumar', 'Patel', 'ykumar9620@gmail.com', 'shdshjfbhjsfbjh', 234546462);
INSERT INTO `MusicStore`.`clients` (`client_id`, `first_name`, `last_name`, `client_email`, `client_password`, `client_phone`) VALUES (3, 'Aditya', 'Galiara', 'aditya@hotmail.com', 'vsvhshjd', 456234665);
INSERT INTO `MusicStore`.`clients` (`client_id`, `first_name`, `last_name`, `client_email`, `client_password`, `client_phone`) VALUES (4, 'NeelKumar', 'Patel', 'neel@yahoo.com', 'sbhdhjsbdhjshbjd', 987654321);
INSERT INTO `MusicStore`.`clients` (`client_id`, `first_name`, `last_name`, `client_email`, `client_password`, `client_phone`) VALUES (5, 'VipulKumar', 'Gupta', 'vips@gmail.com', 'shdhshjdbhjs', 456789023);

-- checking

select * from clients;

-- city table
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (1, 'Kitchener');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (2, 'Toronto');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (3, 'Brampton');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (4, 'Cambridge');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (5, 'London');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (6, 'Windsor');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (7, 'Kingston');
INSERT INTO `MusicStore`.`City` (`City_Id`, `city_name`) VALUES (8, 'Waterloo');


-- province table
INSERT INTO `MusicStore`.`Province` (`province_id`, `Province_name`) VALUES (1, 'Ontario');
INSERT INTO `MusicStore`.`Province` (`province_id`, `Province_name`) VALUES (2, 'Nova Scotia');
INSERT INTO `MusicStore`.`Province` (`province_id`, `Province_name`) VALUES (3, 'Alberta');
INSERT INTO `MusicStore`.`Province` (`province_id`, `Province_name`) VALUES (4, 'Quebec');
INSERT INTO `MusicStore`.`Province` (`province_id`, `Province_name`) VALUES (5, 'British Columbia');

-- country table
INSERT INTO `MusicStore`.`Country` (`Country_Id`, `Country_name`) VALUES (1, 'Canada');
INSERT INTO `MusicStore`.`Country` (`Country_Id`, `Country_name`) VALUES (2, 'India');
INSERT INTO `MusicStore`.`Country` (`Country_Id`, `Country_name`) VALUES (3, 'The United States Of America');



-- addresses table
INSERT INTO `MusicStore`.`addresses` (`addresses_id`, `client_id`, `line1`, `line2`, `postal_code`, `city_id`, `province_id`, `country_id`) VALUES (1, 1, '23 rutherford drive', 'south', 'N2A12P', 1, 1, 1);
INSERT INTO `MusicStore`.`addresses` (`addresses_id`, `client_id`, `line1`, `line2`, `postal_code`, `city_id`, `province_id`, `country_id`) VALUES (2, 2, '251 lester street', NULL, 'N2L3W6', 8, 1, 1);
INSERT INTO `MusicStore`.`addresses` (`addresses_id`, `client_id`, `line1`, `line2`, `postal_code`, `city_id`, `province_id`, `country_id`) VALUES (3, 3, '313 Freure Drive ', NULL, 'N1S0B5', 4, 1, 1);
INSERT INTO `MusicStore`.`addresses` (`addresses_id`, `client_id`, `line1`, `line2`, `postal_code`, `city_id`, `province_id`, `country_id`) VALUES (4, 4, '60 Reistwood Drive', NULL, 'N2R1O8', 1, 1, 1);
INSERT INTO `MusicStore`.`addresses` (`addresses_id`, `client_id`, `line1`, `line2`, `postal_code`, `city_id`, `province_id`, `country_id`) VALUES (5, 5, '76 Calmist Cres', NULL, 'L6Y4L5', 3, 1, 1);


-- check
select * from addresses;

-- card type

INSERT INTO `MusicStore`.`card_type` (`card_id`, `card_type`) VALUES (1, 'Visa');
INSERT INTO `MusicStore`.`card_type` (`card_id`, `card_type`) VALUES (2, 'Master Card');
INSERT INTO `MusicStore`.`card_type` (`card_id`, `card_type`) VALUES (3, 'Amex');


-- order status
INSERT INTO `MusicStore`.`order_status` (`order_status_id`, `order_status`) VALUES (1, 'delivered');
INSERT INTO `MusicStore`.`order_status` (`order_status_id`, `order_status`) VALUES (2, 'pending');
INSERT INTO `MusicStore`.`order_status` (`order_status_id`, `order_status`) VALUES (3, 'failed');
INSERT INTO `MusicStore`.`order_status` (`order_status_id`, `order_status`) VALUES (4, 'processed');

INSERT INTO `MusicStore`.`order_status` (`order_status_id`, `order_status`) VALUES (5, 'returned');



-- orders
INSERT INTO `MusicStore`.`orders` (`order_id`, `client_id`, `order_date`, `ship_date`, `order_total`, `card_id`, `card_number`, `card_expires`, `order_status_id`) VALUES (1, 1, '2021-01-03', '2021-01-12', 662.15, 1, '123456789', '0121', 1);
INSERT INTO `MusicStore`.`orders` (`order_id`, `client_id`, `order_date`, `ship_date`, `order_total`, `card_id`, `card_number`, `card_expires`, `order_status_id`) VALUES (2, 2, '2021-02-20', '2021-03-01', 330, 2, '456328880', '0827', 1);
INSERT INTO `MusicStore`.`orders` (`order_id`, `client_id`, `order_date`, `ship_date`, `order_total`, `card_id`, `card_number`, `card_expires`, `order_status_id`) VALUES (3, 3, '2021-03-21', '2021-04-01', 537.3, 3, '098763572', '0924', 1);


INSERT INTO `MusicStore`.`orders` (`order_id`, `client_id`, `order_date`, `ship_date`, `order_total`, `card_id`, `card_number`, `card_expires`, `order_status_id`) VALUES (4, 5, '2021-03-22', '2021-03-29', 200, 1, '123678947', '0125', 1);


INSERT INTO `MusicStore`.`orders` (`order_id`, `client_id`, `order_date`, `ship_date`, `order_total`, `card_id`, `card_number`, `card_expires`, `order_status_id`) VALUES (5, 5, '2021-03-14', '2021-03-20', 299, 1, '123678947', '0125', 1);

-- checking
select * from orders;

select * from album;



-- order items
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (1, 1, 1, 199, 5, 2);
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (2, 1, 2, 299, 5, 1);
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (3, 2, 4, 130, 0, 1);
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (4, 2, 5, 200, 0, 1);
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (5, 3, 10, 199, 10, 3);

INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (6, 4, 12, 100, 0, 1);
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (7, 4, 13, 100, 0, 1);


INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (8, 5, 12, 100, 0, 1);
INSERT INTO `MusicStore`.`order_item` (`order_item_id`, `order_id`, `album_id`, `list_price`, `discount_percent`, `quantity`) VALUES (9, 5, 10, 199, 0, 1);


-- checking

select * from order_item;

