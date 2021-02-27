-- -----------------------------------------------------
-- Schema upusa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `upusa`;
USE `upusa` ;

-- -----------------------------------------------------
-- Table `upusa`.`biller_entity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`biller_entity` ;

CREATE TABLE IF NOT EXISTS `upusa`.`biller_entity` (
  `biller_id` INT NOT NULL AUTO_INCREMENT,
  `biller_entity_name` VARCHAR(45) NOT NULL,
  `biller_address_street1` VARCHAR(45) NOT NULL,
  `biller_address_street2` VARCHAR(45) NULL,
  `biller_address_city` VARCHAR(45) NOT NULL,
  `biller_address_state` VARCHAR(45) NOT NULL,
  `biller_address_zip` VARCHAR(45) NOT NULL,
  `biller_contact` BIGINT(20) NOT NULL,
  `biller_email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`biller_id`),
  UNIQUE INDEX `biller_id_UNIQUE` (`biller_id` ASC) VISIBLE,
  UNIQUE INDEX `biller_contact_UNIQUE` (`biller_contact` ASC) VISIBLE,
  UNIQUE INDEX `biller_email_UNIQUE` (`biller_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`upusa_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`upusa_user` ;

CREATE TABLE IF NOT EXISTS `upusa`.`upusa_user` (
  `upusa_SSN` INT(11) NOT NULL,
  `full_name` VARCHAR(45) NULL DEFAULT NULL,
  `user_address_street1` VARCHAR(45) NULL DEFAULT NULL,
  `user_address_street2` VARCHAR(45) NULL DEFAULT NULL,
  `user_address_city` VARCHAR(45) NULL DEFAULT NULL,
  `user_address_state` VARCHAR(45) NULL DEFAULT NULL,
  `user_email` VARCHAR(45) NOT NULL DEFAULT 'TEST1@TEST.COM',
  `user_contact` BIGINT(20) NOT NULL DEFAULT ((now() + 0) / 10000),
  `user_name` VARCHAR(50) NOT NULL DEFAULT 'GROUP 2 FROM BOSTON',
  `password` VARCHAR(50) NOT NULL DEFAULT '123',
  PRIMARY KEY (`upusa_SSN`),
  UNIQUE INDEX `upusa_SSN_UNIQUE` (`upusa_SSN` ASC) VISIBLE,
  UNIQUE INDEX `userName_UNIQUE` (`user_name` ASC) VISIBLE,
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE,
  UNIQUE INDEX `user_contact_UNIQUE` (`user_contact` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`bill_payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`bill_payments` ;

CREATE TABLE IF NOT EXISTS `upusa`.`bill_payments` (
  `bill_unique_index` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `biller_bill_id` BIGINT(20) NOT NULL,
  `bill_amount` INT(11) NOT NULL,
  `bill_paid` TINYINT(4) NOT NULL,
  `bill_payment_date` DATETIME NULL DEFAULT NULL,
  `bill_payment_due_dt` DATETIME NOT NULL,
  `bill_payment_delay_allowed` TINYINT(1) NOT NULL,
  `biller_id` INT NOT NULL,
  `service_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bill_unique_index`),
  UNIQUE INDEX `biller_bill_id_UNIQUE` (`biller_bill_id` ASC) VISIBLE,
  UNIQUE INDEX `unique_index_UNIQUE` (`bill_unique_index` ASC) VISIBLE,
  INDEX `biller_id_fk_idx` (`biller_id` ASC) VISIBLE,
  INDEX `user_id_fk_bill_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `biller_id_fk`
    FOREIGN KEY (`biller_id`)
    REFERENCES `upusa`.`biller_entity` (`biller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_fk_bill`
    FOREIGN KEY (`user_id`)
    REFERENCES `upusa`.`upusa_user` (`upusa_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`payment_entity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`payment_entity` ;

CREATE TABLE IF NOT EXISTS `upusa`.`payment_entity` (
  `payment_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `payment_entity_name` VARCHAR(45) NOT NULL,
  `payment_address_street1` VARCHAR(45) NOT NULL,
  `payment_address_street2` VARCHAR(45) NULL,
  `payment_address_city` VARCHAR(45) NOT NULL,
  `payment_address_state` VARCHAR(45) NOT NULL,
  `payment_address_zip` INT NOT NULL,
  `payment_contact` BIGINT(20) NOT NULL,
  `payment_email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `bank_id_UNIQUE` (`payment_id` ASC) VISIBLE,
  UNIQUE INDEX `payment_contact_UNIQUE` (`payment_contact` ASC) VISIBLE,
  UNIQUE INDEX `payment_email_UNIQUE` (`payment_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`payment_account_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`payment_account_info` ;

CREATE TABLE IF NOT EXISTS `upusa`.`payment_account_info` (
  `user_id` INT(11) NULL,
  `payment_account_number` BIGINT(20) NOT NULL,
  `payment_id` BIGINT(20) NOT NULL,
  `biller_id` INT NULL,
  UNIQUE INDEX `bank_account_number_UNIQUE` (`payment_account_number` ASC) VISIBLE,
  INDEX `upusa_SSN_idx` (`user_id` ASC) VISIBLE,
  INDEX `bank_id_fk` (`payment_id` ASC) VISIBLE,
  INDEX `biller_id_fk_idx` (`biller_id` ASC) VISIBLE,
  CONSTRAINT `bank_id_fk`
    FOREIGN KEY (`payment_id`)
    REFERENCES `upusa`.`payment_entity` (`payment_id`),
  CONSTRAINT `upusa_SSN_reference`
    FOREIGN KEY (`user_id`)
    REFERENCES `upusa`.`upusa_user` (`upusa_SSN`),
  CONSTRAINT `biller_id_fk_payment`
    FOREIGN KEY (`biller_id`)
    REFERENCES `upusa`.`biller_entity` (`biller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`transaction` ;

CREATE TABLE IF NOT EXISTS `upusa`.`transaction` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `bill_id` INT NOT NULL,
  `user_payment_acc_no` BIGINT(20) NOT NULL,
  INDEX `user_id_fk_idx` (`user_id` ASC) VISIBLE,
  INDEX `bill_id_fk_idx` (`bill_id` ASC) VISIBLE,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE,
  INDEX `bank_acc_no_fk_idx` (`user_payment_acc_no` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `upusa`.`upusa_user` (`upusa_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bill_id_fk`
    FOREIGN KEY (`bill_id`)
    REFERENCES `upusa`.`bill_payments` (`bill_unique_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bank_acc_no_fk`
    FOREIGN KEY (`user_payment_acc_no`)
    REFERENCES `upusa`.`payment_account_info` (`payment_account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`biller_entity_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`biller_entity_services` ;

CREATE TABLE IF NOT EXISTS `upusa`.`biller_entity_services` (
  `biller_services_id` INT NOT NULL AUTO_INCREMENT,
  `biller_service_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`biller_services_id`),
  UNIQUE INDEX `idbiller_services_id_UNIQUE` (`biller_services_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`biller_routing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`biller_routing` ;

CREATE TABLE IF NOT EXISTS `upusa`.`biller_routing` (
  `biller_id` INT NOT NULL,
  `API_call` VARCHAR(45) NOT NULL,
  `biller_service_id` INT NOT NULL,
  INDEX `biller_id_fk_idx` (`biller_id` ASC) VISIBLE,
  INDEX `biller_service_id_fk_idx` (`biller_service_id` ASC) VISIBLE,
  CONSTRAINT `biller_id_fk_routing`
    FOREIGN KEY (`biller_id`)
    REFERENCES `upusa`.`biller_entity` (`biller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `biller_service_id_fk`
    FOREIGN KEY (`biller_service_id`)
    REFERENCES `upusa`.`biller_entity_services` (`biller_services_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`payment_entity_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`payment_entity_services` ;

CREATE TABLE IF NOT EXISTS `upusa`.`payment_entity_services` (
  `payment_service_id` INT NOT NULL AUTO_INCREMENT,
  `payment_service_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_service_id`),
  UNIQUE INDEX `payment_service_id_UNIQUE` (`payment_service_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upusa`.`bank_routing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `upusa`.`payment_routing` ;

CREATE TABLE IF NOT EXISTS `upusa`.`payment_routing` (
  `payment_id` BIGINT(20) NOT NULL,
  `API_call` VARCHAR(45) NOT NULL,
  `payment_service_id` INT NOT NULL,
  INDEX `bank_id_fk_idx` (`payment_id` ASC) VISIBLE,
  INDEX `payment_service_id_fk_idx` (`payment_service_id` ASC) VISIBLE,
  CONSTRAINT `bank_id_fk_routing`
    FOREIGN KEY (`payment_id`)
    REFERENCES `upusa`.`payment_entity` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `payment_service_id_fk`
    FOREIGN KEY (`payment_service_id`)
    REFERENCES `upusa`.`payment_entity_services` (`payment_service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `upusa` ;

-- -----------------------------------------------------
-- procedure check_user
-- -----------------------------------------------------

USE `upusa`;
DROP procedure IF EXISTS `upusa`.`check_user`;

DELIMITER $$
USE `upusa`$$
CREATE PROCEDURE `check_user`(
in username varchar(255),
in password varchar(255),
out result boolean
)
begin
declare userExistence int;

select count(*)
into userExistence
from upusa_user
where upusa_user.user_name = username and upusa_user.password = password;

if userExistence > 0 then
set result = true;
else
set result = false;
end if;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure check_user_credentials
-- -----------------------------------------------------

USE `upusa`;
DROP procedure IF EXISTS `upusa`.`check_user_credentials`;

DELIMITER $$
USE `upusa`$$
CREATE PROCEDURE `check_user_credentials`(
in ssn int,
in address_street1 varchar(45),
in address_city varchar(45),
in address_state varchar(45)
)
begin

declare user_validity tinyint default true;
DECLARE CONTINUE HANDLER FOR 1062
SET user_validity = FALSE;

insert into upusa_user(upusa_ssn, user_address_street1, user_address_city, user_address_state) values (ssn, address_street1,
address_city, address_state);
 
if user_validity = TRUE then
select 'Successful validation' as message;
else
select 'Unsuccessful validation' as message;
end if;

end$$

DELIMITER ;


use upusa;

INSERT INTO payment_entity(payment_entity_name,payment_address_street1,payment_address_street2,payment_address_city,payment_address_state,
 payment_address_zip, payment_contact, payment_email,password)
VALUES
	('Bank Of America Savings Account', '100 North Tryon Street', NULL, 'Charlotte', 'NC', '28255', 8666071234, 'customer_support@bankofAmericas.com', '123'),
    ('Bank Of America Checkings Account', '100 North Tryon Street', NULL, 'Charlotte', 'NC', '28255', 8666071134, 'customer_support@bankofAmericac.com', '123'),
    ('Santandar Bank Savings Account', '800 Boylston St', NULL, 'Boston', 'MA', '02199', 6172362901, 'customer_support@Santandars.com', 'password'),
    ('Santandar Bank Checkings Account', '800 Boylston St', NULL, 'Boston', 'MA', '02199', 6172362903, 'customer_support@Santandarc.com', 'password'),
    ('TD Bank Savings Accountt', ' 535 Boylston St ', 'Floor 1', 'Boston', 'MA', '02166', 6173694590, 'customer_support@TDbanks.com', 'Changeme'),
    ('TD Bank Checkings Account', ' 535 Boylston St ', 'Floor 1', 'Boston', 'MA', '02166', 6173692590, 'customer_support@TDbankc.com', 'Changeme'),
    ('VISA', 'Total VISA', 'P.O. Box 85710', 'Sioux Falls', 'SD', '57118', 8445489721, 'info@totalcardvisa.com', '123'),
    ('MASTERCARD', '114 5th Ave', NULL, 'New York', 'NY', '10011', 9142492000, 'customer_support@mastercards.com', 'Mastercard123'),
    ('Google Pay', '1600 Amphitheatre Parkway', NULL, 'Mountain View', 'CA', '94043', 1236079765, 'support@googlepay.com', 'Google'),
    ('PayPal', '2211 N 1st St', NULL, 'San Jose', 'CA', '95131', 4089671000, 'customer_support@paypal.com', 'paypal');
    
    select *
    from payment_entity;
    
    
    INSERT INTO upusa.biller_entity (biller_entity_name, biller_address_street1, biller_address_street2,
 biller_address_city, biller_address_state, biller_address_zip, biller_contact, biller_email, password) VALUES 
  ('EverSource', '800 Boylston St', null, 'Boston', 'MA','02199' ,'8005922000','eversource@gmail.com', 'electricity'),
  ('Atom', '456 Mayfair Cir', null, 'Orlando', 'FL','32789' ,'6719876623','atom.movies@gmail.com', 'freemovies'),
  ('National Grid', '1 Lilco Rd', null, 'Shoreham', 'NY','11786' ,'9877906623','grid.national@hotmail.com', 'grid123'),
  ('Expedia', ' 950 W John Carpenter ', null, 'Irving', 'TX','75039' ,'8762996623','expediahelp@gmail.com', 'khoury.A'),
  ('Cambridge City Hall', '795 Massachusetts Ave', null, 'Cambridge', 'MA','02139' ,'5710006623','city@cambridge.com', 'peopleare'),
  ('AMC', '2425 Olympic Blvd', null, 'Santa Monica', 'CA','90404' ,'89011237823','help@amc.com', 'movieforfree');
  
   -- new values
   INSERT INTO upusa.biller_entity (biller_entity_name, biller_address_street1, biller_address_street2,
 biller_address_city, biller_address_state, biller_address_zip, biller_contact, biller_email, password) VALUES 
 ('Boston Transit Police', '12 Roxbury', null, 'Boston', 'MA', '02120', '8424226745', 'speedBoston@gmail.com', '1234567'),
 ('Target', '1100 West Dr', null, 'Seattle', 'WA', '37485', '18005672987', 'target.shop@gmail.com', '12345667');
  
  select * from biller_entity;
  
  INSERT INTO upusa_user VALUES
(123456789, 'John Smith', '20 Shwmut St', null, 'Boston', 'MA', 'john25@gmail.com', 8572309178, 'jsmith',123),
(748293657, 'Sheila Dsousa', '1173 Cave St', 'Opp Macys 20', 'Los Angeles', 'CA', 'sweetsheiladsouza@yahoo.in', 6175326734, 'sdsousa',123),
(592638263, 'Rachel P Green', '7B32 Edison Road', null, 'Edison', 'NJ', 'green.r@gmail.com', 6172308776, 'rpg',123),
(390309093, 'Joey Tribbiani', '82C 32nd St', null, 'New York Ciy', 'NY', 'joeyhwd@gmail.com', 8743128920, 'jtribb',123),
(195685762, 'Ross Geller', '70A 33rd St', null, 'New York City', 'NY', 'profgeller.ross@gmail.com', 6172387437, 'rgeller',123), 
(569236284, 'Jason D Stathom', '177 Dallas Ave', '7th cross road', 'Dallas', 'TX', 'stathom.j@yahoo.in', 6171234567, 'jds',123),
(628465728, 'Harold Pavlo', '693 Parker St', null, 'Boston', 'MA', 'harold1995@hsuky.neu.edu', 8167263389, 'hpavlo',123), 
(628462719, 'Dianne Pavlo', '693 Parker St', null, 'Boston', 'MA', 'dianne1993@northeastern.edu', 8174658266, 'dpavlo',123), 
(291748267, 'Rachel Longbottom', '85 DragonStone', '5th Avenue St', 'Jacksonville', 'FL', 'rachel.tcs@gmail.com', 8572301834, 'rlbottom',123),
(836492489, 'Amin Khoury', '2 The Hamptons', null, 'Long Island', 'NY', 'khoury.amin@gmail.com', '6717776623', 'khoury.A',123);

-- new values
INSERT INTO upusa_user VALUES
(215636151, 'Jacob Boss', '642 Boulevard Dr', null, 'Houston', 'TX', 'jacob@gmail.com', 8573209178, 'jman',123),
(456786545, 'Harley Quinn', '5F Hemenway St', 'near Northeastern University', 'Boston', 'MA', 'harleyq@gmail.com', 8263475826, 'hquinn', 123),
(509316436, 'Ben Affleck', 'KBL Apts', 'Central Square', 'Boston', 'MA', 'benbatman@gmail.com', 6173846273, 'benaff', 123),
(215421903, 'Matt Damon', '3 Smith St', null, 'Boston', 'MA', 'matt@gmail.com', 7125356678, 'matt', 123),
(379843426, 'Aishwary Shukla', '108 Pterborough St', null, 'Boston', 'MA', 'a.shukla@husky.neu.edu', 8126639287, 'a.shukla', 123),
(345678963, 'Rahat Bedi', '22B Hill Dr', null, 'Los Angeles', 'CA', 'rahat.b@gmail.com', 8672309156, 'rbedi', 123),
(827364927, 'Burhan S', '1189 Malibu County', null, 'San Diego', 'CA', 'b.s@gmail.com', 7172623434, 'bs', 123),
(991273646, 'Surendra Lama', '3X Cross St', null, 'Los Angeles', 'CA', 'surendra.l@gmail.com', 2386725364, 'lama.s', 123),
(337827351, 'Ojas Thanawala', '18 Hollywood', null, 'Los Angeles', 'CA', 'ojas.t@gmail.com', 8572309190, 'oj', 123),
(837648722, 'Bradd Pitt', 'Mona 33rd St', null, 'Neww York', 'NY', 'pitt.angelina@gmail.com', 2783572351, 'bpitt', 123);

select * from upusa.upusa_user;
  
  
select * from payment_account_info;
INSERT INTO payment_account_info VALUES
(123456789, 8273972847, 1, null),
(123456789, 1005078235300127, 7, null),
(748293657, 6483266185, 4, null),
(592638263, 4117803099456718, 8, null),
(592638263, 9473625138369322, 7, null),
(390309093, 667251, 10, null),
(195685762, 6172387437, 9, null),
(195685762, 5628176392, 5, null),
(195685762, 7739273646, 2, null),
(195685762, 4237642387468374, 7, null),
(569236284, 4435273642, 3, null), 
(628465728, 7346134763, 5, null),
(628465728, 8976578665, 6, null),
(628462719, 3287463276, 5, null),
(628462719, 8976547656, 6, null),
(628462719, 8732443764736441, 7, null),
(291748267, 8572301834, 9, null),
(291748267, 2109738261, 1, null),
(836492489, 5678657513864920, 8, null),
(836492489, 5678257513864921, 7, null),
(null, 8273972812, 1, 1),
(null, 1005074235320127, 7, 2),
(null, 6483255185, 4, 3),
(null, 4117803099456658, 8, 4),
(null, 4473625138369322, 7, 5),
(null, 667231, 10, 6);



insert into upusa.bill_payments (user_id, biller_bill_id, bill_amount, bill_paid,bill_payment_date,
 bill_payment_due_dt, bill_payment_delay_allowed, biller_id, service_type_name) values 
(123456789 , 6501 , 287 , 0, null , '20190718103009' , 0, 4,'Flight' ),
(123456789 , 6502 , 34 , 1, '20190722123409' , '20190722123409' , 0, 2,'Movie'),
(123456789 , 6503 , 290 , 0, null , '20190810140000' , 1, 1,'Electricity'),
(748293657 , 6504 , 789 , 1, '20190705163500' , '20190715163500' , 1, 1, 'Gas Bill'),
(592638263 , 6505 , 19 , 1, '20190720105400' , '20190720105400' , 0, 6,'Movie'),
(390309093 , 6506 , 87 , 1, '20190714223000' , '20190718103000' , 1, 3, 'Electricity'),
(390309093 , 6507 , 190 , 0, null , '20190730201409' , 1, 3,'Gas Bill'),
(390309093 , 6508 , 238 , 1, '20190620235500' , '20190620235500' , 0, 4, 'Flight'),
(195685762 , 6509 , 654 , 1, '20190630070000' , '20190730065959' , 1, 3,'Gas Bill'),
(195685762 , 6510 , 120 , 1, '20190704153000' , '20190704153000' , 0, 4, 'Flight'),
(569236284 , 6511 , 190 , 0, null , '20190710100000' , 1, 1,'Electricity'),
(628465728 , 6512 , 398 , 1, '20190712200000' , '20190730195959' , 1, 3, 'Gas Bill'),
(628465728 , 6513 , 657 , 1, '20190724130000' , '20190724130000' , 0, 3,'Flight'),
(628465728 , 6514 , 475 , 1, '20190702163700' , '20190801140000' , 1, 1, 'Electricity'),
(628465728 , 6515 , 908 , 0, null , '20190720120000' , 0, 4, 'Flight'),
(628462719 , 6516 , 80 , 1, '20190725120000' , '20190725120000' , 0, 5,'Parking Ticket'),
(123456789 , 6517 , 8 , 1, '20190721170000' , '20190721170000' , 0, 4, 'Flight'),
(291748267 , 6518 , 105 , 0, null , '20190720190000' , 1, 1, 'Electricity' ),
(836492489 , 6519 , 55 , 1, '20190720190000' , '20190720190000' , 0, 4, 'Flight'),
(836492489 , 6520 , 6 , 1, '20190711100000' , '20190721100000' , 1, 5, 'Speed Ticket');


-- new entries

insert into upusa.bill_payments (user_id, biller_bill_id, bill_amount, bill_paid,bill_payment_date,
 bill_payment_due_dt, bill_payment_delay_allowed, biller_id, service_type_name) values 
(337827351 , 6521 , 99 , 1, '20190704103409' , '20190704103409' , 0, 8,'Shopping' ),
(991273646 , 6522 , 299 , 1, '20190704133409' , '20190704133409' , 0, 8,'Shopping' ),
(827364927 , 6523 , 1099 , 1, '20190704153409' , '20190704153409' , 0, 8,'Shopping' ),
(509316436 , 6524 , 4300 , 1, '20190704173000' , '20190704103000' , 0, 8,'Shopping' ),
(215421903 , 6525 , 148 , 1, '20190704093839' , '20190704093839' , 0, 8,'Shopping' ),
(379843426 , 6526 , 550 , 1, '20190704190709' , '20190704190709' , 0, 8,'Shopping' ),
(345678963 , 6527 , 303 , 1, '20190704225443' , '20190704225443' , 0, 8,'Flight' ),
(345678963 , 6528 , 287 , 1, '20181225104828' , '20181225104828' , 0, 8,'Shopping' ),
(123456789 , 6529 , 768 , 1, '20181225175828' , '20181225175828' , 0, 8,'Shopping' ),
(379843426 , 6530 , 912 , 1, '20181225212828' , '20181225212828' , 0, 8,'Shopping' ),
(215636151 , 6531 , 807 , 1, '20181225231809' , '20181225231809' , 0, 8,'Shopping' ),
(345678963 , 6532 , 754  , 1, '20190108103409' , '20190108103409' , 0, 4,'Flight' ),
(509316436 , 6533 , 987  , 1, '20190101103409' , '20190101103409' , 0, 4,'Flight' ),
(456786545 , 6534 , 1367 , 1, '20190102103409' , '20190102103409' , 0, 4,'Flight' ),
(827364927 , 6535 , 780  , 1, '20190118103409' , '20190118103409' , 0, 4,'Flight' ),
(456786545 , 6536 , 345 , 0, null , '20190818104414' , 1, 3,'Gas Bill' ),
(379843426 , 6537 , 890 , 0, null , '20190814195501' , 1, 1,'Gas Bill' ),
(456786545 , 6538 , 201 , 0, null , '20190819131004' , 1, 1,'Electricity' ),
(215636151 , 6539 , 809 , 0, null , '20190821142009' , 1, 3,'Electricity' ),
(827364927 , 6540 , 110 , 1, '20190731233410' , '20190818233409' , 1, 7,'Speed Ticket' ),
(215636151 , 6541 , 90  , 1, '20190729103409' , '20190815103409' , 1, 7,'Speed Ticket' ),
(195685762 , 6542 , 109 , 1, '20190728232415' , '20190731100000' , 1, 1,'Electricity' ),
(195685762 , 6543 , 87  , 0,  null            , '20190810123000' , 1, 5,'Speed Ticket' ),
(195685762 , 6544 , 34  , 1, '20190801165456' , '20190801165456' , 0, 6,'Movie' ),
(837648722 , 6545 , 235 , 1, '20190318234423' , '20190328103039' , 1, 3,'Electricity' ),
(837648722 , 6546 , 505 , 1, '20190418013449' , '20190428110000' , 1, 1,'Gas Bill' ),
(837648722 , 6547 , 12  , 1, '20190518231419' , '20190518231419' , 0, 6,'Movie' ),
(837648722 , 6548 , 45  , 1, '20190609003408' , '20190629130000' , 1, 7,'Speed Ticket' ),
(837648722 , 6549 , 8   , 1, '20190702235600' , '20190702235600' , 0, 2,'Movie' );


select * from bill_payments;

INSERT INTO upusa.biller_entity_services (biller_service_name) VALUES
('notify biller');

select * from biller_entity_services;

INSERT INTO upusa.biller_routing VALUES
(1 , '' , 1),
(2 , '' , 1),
(3 , '' , 1),
(4 , '' , 1),
(5 , '' , 1),
(6 , '' , 1);

select * from biller_routing;

INSERT INTO payment_entity_services(payment_service_name)
	VALUES
    ('credit'),
    ('debit');	
    
    select * from payment_entity_services;
    
    INSERT INTO payment_routing(payment_id, API_call, payment_service_id)
	VALUES
    ('1', '', '1'),
    ('1', '', '2'),
    ('2', '', '1'),
    ('2', '', '2'),
    ('3', '', '1'),
    ('3', '', '2'),
    ('4', '', '1'),
    ('4', '', '2'),
    ('5', '', '1'),
    ('5', '', '2'),
    ('6', '', '1'),
    ('6', '', '2');
    
    select * from payment_routing;

select * from upusa.transaction;

INSERT INTO transaction(user_id, bill_id, user_payment_acc_no) VALUES
(123456789, 1, 8273972847),
(123456789, 17, 1005078235300127),
(123456789, 2, 1005078235300127),
(123456789, 3, 8273972847),
(291748267, 18, 8572301834);
