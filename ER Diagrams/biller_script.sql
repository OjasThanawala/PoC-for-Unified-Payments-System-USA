-- Schema biller
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `biller`;
-- USE `biller` ;

-- -- -----------------------------------------------------
-- -- Table `biller`.`service_type`
-- -- -----------------------------------------------------
-- DROP TABLE IF EXISTS `biller`.`service_type` ;

-- CREATE TABLE IF NOT EXISTS `biller`.`service_type` (
--   `service_id` INT(11) NOT NULL,
--   `service_name` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`service_id`),
--   UNIQUE INDEX `service_id_UNIQUE` (`service_id` ASC) VISIBLE)
-- ENGINE = InnoDB;


-- -- -----------------------------------------------------
-- -- Table `biller`.`user`
-- -- -----------------------------------------------------
-- DROP TABLE IF EXISTS `biller`.`user` ;

-- CREATE TABLE IF NOT EXISTS `biller`.`user` (
--   `acc_no` INT(11) NOT NULL,
--   `user_name` VARCHAR(45) NOT NULL,
--   `password` VARCHAR(30) NOT NULL,
--   `address_section_1` VARCHAR(45) NOT NULL,
--   `address_section_2` VARCHAR(45) NULL DEFAULT NULL,
--   `city` VARCHAR(20) NOT NULL,
--   `state` VARCHAR(20) NOT NULL,
--   `zipcode` INT(11) NOT NULL,
--   `dob` DATE NOT NULL,
--   `email_id` VARCHAR(45) NOT NULL,
--   `contact_number` BIGINT(20) NOT NULL,
--   `user_ssn` INT(11) NOT NULL,
--   PRIMARY KEY (`acc_no`),
--   UNIQUE INDEX `acc_no_UNIQUE` (`acc_no` ASC) VISIBLE,
--   UNIQUE INDEX `ssn_UNIQUE` (`user_ssn` ASC) VISIBLE)
-- ENGINE = InnoDB;


-- -- -----------------------------------------------------
-- -- Table `biller`.`bill`
-- -- -----------------------------------------------------
-- DROP TABLE IF EXISTS `biller`.`bill` ;

-- CREATE TABLE IF NOT EXISTS `biller`.`bill` (
--   `bill_id` INT(11) NOT NULL AUTO_INCREMENT,
--   `bill_amount` DECIMAL(5,2) NOT NULL,
--   `bill_generation_dt` DATETIME NOT NULL,
--   `payment_dt` DATETIME NULL DEFAULT NULL,
--   `due_dt` DATETIME NOT NULL,
--   `service_id` INT(11) NULL DEFAULT NULL,
--   `acc_number_fk` INT(11) NULL DEFAULT NULL,
--   `payment_delay_allowed` TINYINT(1) NOT NULL,
--   PRIMARY KEY (`bill_id`),
--   UNIQUE INDEX `bil_id_UNIQUE` (`bill_id` ASC) VISIBLE,
--   INDEX `service_id_idx` (`service_id` ASC) VISIBLE,
--   INDEX `user_acc_no_fk_idx` (`acc_number_fk` ASC) VISIBLE,
--   CONSTRAINT `service_id`
--     FOREIGN KEY (`service_id`)
--     REFERENCES `biller`.`service_type` (`service_id`),
--   CONSTRAINT `user_acc_no_fk`
--     FOREIGN KEY (`acc_number_fk`)
--     REFERENCES `biller`.`user` (`acc_no`))
-- ENGINE = InnoDB;

-- -----------------------------------------------------
-- Schema biller
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `biller`;
CREATE SCHEMA IF NOT EXISTS `biller`;
USE `biller` ;

-- -----------------------------------------------------
-- Table `biller`.`service_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biller`.`service_type` ;

CREATE TABLE IF NOT EXISTS `biller`.`service_type` (
  `service_id` INT(11) NOT NULL,
  `service_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`service_id`),
  UNIQUE INDEX `service_id_UNIQUE` (`service_id` ASC) VISIBLE)
ENGINE = InnoDB;


INSERT INTO service_type VALUES (1, 'ELECTRICITY');

-- -----------------------------------------------------
-- Table `biller`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biller`.`user` ;

CREATE TABLE IF NOT EXISTS `biller`.`user` (
  `acc_no` INT(11) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `address_section_1` VARCHAR(45) NOT NULL,
  `address_section_2` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(20) NOT NULL,
  `state` VARCHAR(20) NOT NULL,
  `zipcode` INT(11) NOT NULL,
  `dob` DATE NOT NULL,
  `email_id` VARCHAR(45) NOT NULL,
  `contact_number` BIGINT(20) NOT NULL,
  `user_ssn` INT(11) NOT NULL,
  PRIMARY KEY (`acc_no`),
  UNIQUE INDEX `acc_no_UNIQUE` (`acc_no` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`user_ssn` ASC) VISIBLE)
ENGINE = InnoDB;

INSERT INTO user VALUES (1, 'tony', 'stark', 'addr', 'addr', 'Boston', 'MA', 02115, '20190224', 'tony@stark.com', 976543210, 12345678);

-- -----------------------------------------------------
-- Table `biller`.`bill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biller`.`bill` ;

CREATE TABLE IF NOT EXISTS `biller`.`bill` (
  `bill_id` INT(11) NOT NULL AUTO_INCREMENT,
  `bill_amount` DECIMAL(5,2) NOT NULL,
  `bill_generation_dt` DATETIME NOT NULL,
  `payment_dt` DATETIME NULL DEFAULT NULL,
  `due_dt` DATETIME NOT NULL,
  `service_id` INT(11) NULL DEFAULT NULL,
  `acc_number_fk` INT(11) NULL DEFAULT NULL,
  `payment_delay_allowed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`bill_id`),
  UNIQUE INDEX `bill_id_UNIQUE` (`bill_id` ASC) VISIBLE,
  INDEX `service_id_idx` (`service_id` ASC) VISIBLE,
  INDEX `user_acc_no_fk_idx` (`acc_number_fk` ASC) VISIBLE,
  CONSTRAINT `service_id`
    FOREIGN KEY (`service_id`)
    REFERENCES `biller`.`service_type` (`service_id`),
  CONSTRAINT `user_acc_no_fk`
    FOREIGN KEY (`acc_number_fk`)
    REFERENCES `biller`.`user` (`acc_no`))
ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS generateBill;

delimiter //
CREATE PROCEDURE generateBill
(
	IN user_acc_no_param INT,
    IN bill_amount_param DECIMAL(7,2),
	IN due_dt_param DATETIME,
    IN service_id_param INT,
    IN payment_delay_allowed_param TINYINT(1)
)
BEGIN
	DECLARE new_bill_id INT;

	INSERT INTO biller.bill (bill_amount, bill_generation_dt, due_dt, service_id, acc_number_fk, payment_delay_allowed)
    VALUES (
		bill_amount_param, NOW(), due_dt_param, service_id_param, user_acc_no_param, payment_delay_allowed_param
    );
    
    SET new_bill_id =  LAST_INSERT_ID();
    
    SELECT 
		user.user_ssn `upusa_id`,
        bill.bill_id `bill_id`,
		bill.bill_amount `amount`, 
        bill.bill_generation_dt `bill_gen_dt`,
        bill.due_dt `bill_due_dt`,
        bill.payment_delay_allowed `delayed`,
        service_type.service_name `service`
	FROM bill
    INNER JOIN user ON (user.acc_no = bill.acc_number_fk)
    INNER JOIN service_type USING (service_id)
    WHERE bill.bill_id = new_bill_id;
    
END //
delimiter ;

CALL generateBill(1, 156, '20191008000000', 1, 1);

delimiter //
CREATE PROCEDURE billPaid
(
	IN bill_id_param INT,
    IN payment_dt_param DATETIME
)
BEGIN
	UPDATE biller.bill 
    SET payment_dt = payment_dt_param 
    WHERE bill_id = bill_id_param;
    
    
    SELECT * FROM bill WHERE bill_id = bill_id_param;
END //
delimiter ;



use biller;
show tables;
desc biller.user;
select * from user;

INSERT INTO biller.user VALUES
(7348756, 'jsmith','jsmith@90', '20 Shwmut St', null, 'Boston', 'MA', 02122, '1980-08-10', 'john25@gmail.com', 8572309178, 123456789),
(8229862, 'sdsousa', 'sousa@870','1173 Cave St', 'Opp Macys 20', 'Los Angeles', 'CA', 12467, '1990-12-12', 'sweetsheiladsouza@yahoo.in', 6175326734, 748293657),
(3686953, 'rpg','gpr#$89', '7B32 Edison Road', null, 'Edison', 'NJ', 29109, '1996-10-09', 'green.r@gmail.com', 6172308776, 592638263),
(2945234, 'jtribb','joey0988', '82C 32nd St', null, 'New York Ciy', 'NY', 28174, '1978-01-15', 'joeyhwd@gmail.com', 8743128920, 390309093),
(7456845, 'rgeller','password', '70A 33rd St', null, 'New York City', 'NY', 28176, '1979-05-11', 'profgeller.ross@gmail.com', 6172387437, 195685762),
(6678568, 'jds','dallas@1966', '177 Dallas Ave', '7th cross road', 'Dallas', 'TX', 31108, '1966-03-14', 'stathom.j@yahoo.in', 6171234567, 569236284),
(9789897, 'hpavlo','parker_redsox', '693 Parker St', null, 'Boston', 'MA', 02116, '2000-06-30', 'harold1995@hsuky.neu.edu', 8167263389, 628465728),
(2446648, 'dpavlo','dianne_celtics', '693 Parker St', null, 'Boston', 'MA', 02116, '2000-06-30', 'dianne1993@northeastern.edu', 8174658266, 628462719),
(1524349, 'rlbottom','rachel-floridA', '85 DragonStone', '5th Avenue St', 'Jacksonville', 'FL', 00815, '1940-02-28', 'rachel.tcs@gmail.com', 8572301834, 291748267),
(1082642, 'khoury.A','neu2019', '2 The Hamptons', null, 'Long Island', 'NY', 28110, '1955-11-19', 'khoury.amin@gmail.com', '6717776623', 836492489);


INSERT INTO  biller.`service_type` VALUES 
(1 , 'Electricity'),
(2 , 'Gas'),
(3 , 'Wifi');

INSERT INTO biller.bill(bill_amount, bill_generation_dt, payment_dt, due_dt, service_id, acc_number_fk, payment_delay_allowed) VALUES
(290.00 ,20190720140000, null , '20190810140000' , 1, 8229862, 1 ),   
(789.00 ,'20190625163500','20190710193500','20190715163500', 2, 2945234, 1 ),
(87.00  ,'20190628223000','20190714223000','20190718103000', 1, 1082642, 1 ),
(190.00 ,'20190710201409', null , '20190730201409', 2, 6678568, 1 ),
(654.00 ,'20190630070000' , '20190724085954', '20190730065959' , 2,9789897, 1 ),
(190.00 ,'20190620105000', null , '20190710100000', 1, 9789897, 1 ),
(398.00 ,'20190710165230','20190712200000' , '20190730195959', 2, 7348756, 1 ),
(475.00 ,'20190711140000','20190702163700' , '20190801140000', 1,6678568 , 1 ),
(105.00 ,'20190701190000',null , '20190720190000', 1,2446648 , 1 );

select * from biller.bill;
