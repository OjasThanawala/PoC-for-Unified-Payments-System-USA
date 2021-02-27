CREATE SCHEMA IF NOT EXISTS `bank` ;
USE `BANK` ;

-- -----------------------------------------------------
-- Table `bank`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bank`.`User` ;

CREATE TABLE IF NOT EXISTS `bank`.`User` (
  `user_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `street1` VARCHAR(45) NOT NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip code` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `email_id` VARCHAR(45) NOT NULL,
  `contact_number` BIGINT(20) NOT NULL,
  `user_ssn` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_id_UNIQUE` (`email_id` ASC) VISIBLE,
  UNIQUE INDEX `user_ssn_UNIQUE` (`user_ssn` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bank`.`Account_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bank`.`Account_Type` ;

CREATE TABLE IF NOT EXISTS `bank`.`Account_Type` (
  `type_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  PRIMARY KEY (`type_id`),
  UNIQUE INDEX `type_id_UNIQUE` (`type_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bank`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bank`.`Account` ;

CREATE TABLE IF NOT EXISTS `bank`.`Account` (
  `account_number` BIGINT(20) NOT NULL,
  `amount` DECIMAL(2) NULL,
  `type_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`account_number`, `type_id`),
  UNIQUE INDEX `account_number_UNIQUE` (`account_number` ASC) VISIBLE,
  INDEX `type_id_idx` (`type_id` ASC) VISIBLE,
  INDEX `user_id_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `type_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `bank`.`Account_Type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `bank`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

alter table bank.account
modify amount decimal(9,2) null;
-- -----------------------------------------------------
-- Table `bank`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bank`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `bank`.`Transaction` (
  `transaction_id` INT NOT NULL,
  `amount_debited` DECIMAL(2) NOT NULL,
  `date_of_payment` DATETIME NOT NULL,
  `account_number` BIGINT(20) NOT NULL,
  PRIMARY KEY (`transaction_id`, `account_number`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE,
  INDEX `account_number_idx` (`account_number` ASC) VISIBLE,
  CONSTRAINT `account_number`
    FOREIGN KEY (`account_number`)
    REFERENCES `bank`.`Account` (`account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SELECT * FROM BANK.USER;
INSERT INTO bank.user VALUES
(1, 'jsmith', '20 Shwmut St', null, 'Boston', 'MA', 02122, '1980-08-10', 'john25@gmail.com', 8572309178, 123456789),
(2, 'sdsousa', '1173 Cave St', 'Opp Macys 20', 'Los Angeles', 'CA', 12467, '1990-12-12', 'sweetsheiladsouza@yahoo.in', 6175326734, 748293657),
(3, 'rpg', '7B32 Edison Road', null, 'Edison', 'NJ', 29109, '1996-10-09', 'green.r@gmail.com', 6172308776, 592638263),
(4, 'jtribb', '82C 32nd St', null, 'New York Ciy', 'NY', 28174, '1978-01-15', 'joeyhwd@gmail.com', 8743128920, 390309093),
(5, 'rgeller', '70A 33rd St', null, 'New York City', 'NY', 28176, '1979-05-11', 'profgeller.ross@gmail.com', 6172387437, 195685762),
(6, 'jds', '177 Dallas Ave', '7th cross road', 'Dallas', 'TX', 31108, '1966-03-14', 'stathom.j@yahoo.in', 6171234567, 569236284),
(7, 'hpavlo', '693 Parker St', null, 'Boston', 'MA', 02116, '2000-06-30', 'harold1995@hsuky.neu.edu', 8167263389, 628465728),
(8, 'dpavlo', '693 Parker St', null, 'Boston', 'MA', 02116, '2000-06-30', 'dianne1993@northeastern.edu', 8174658266, 628462719),
(9, 'rlbottom', '85 DragonStone', '5th Avenue St', 'Jacksonville', 'FL', 00815, '1940-02-28', 'rachel.tcs@gmail.com', 8572301834, 291748267),
(10, 'khoury.A', '2 The Hamptons', null, 'Long Island', 'NY', 28110, '1955-11-19', 'khoury.amin@gmail.com', '6717776623', 836492489);

SELECT * FROM Account_Type;
INSERT INTO Account_Type VALUES
(1, 'Savings'),
(2, 'Checkings');

select * from bank.account;
INSERT INTO account values
(8273972847, 20500.11, 1, 1),
(6546787651, 301.43, 2, 1),
(7739273646, 1003.56, 2, 5),
(2109738261, 1003283.00, 1, 9),
(9123836387, 38.65, 1, 2),
(1109825392, 97857.98, 2, 4),
(8715387487, 6413.01, 1, 7);

select * from transaction;


