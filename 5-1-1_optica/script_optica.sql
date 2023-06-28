CREATE SCHEMA IF NOT EXISTS `cul-d-ampolla`;

USE `cul-d-ampolla`;

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`suppliers` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(20) NOT NULL,
  `fax` VARCHAR(20) NULL,
  `NIF` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;

INSERT INTO suppliers
VALUES
	(DEFAULT, 'tusgafas', 'Poligono industrial Can Serra, calle A, 34', 'Sabadell', '08212', 'Spain', '936457283', '936457284', 'ES46283048G'),
	(DEFAULT, 'veoveo', 'Calle Industrial, 14', 'Terrassa', '08583', 'Spain', '936320943', DEFAULT, 'ES72930475X'),
	(DEFAULT, 'hermanos gafunos', 'Poligono industrial Can Riba, calle C, 57', 'Martorell', '08903', 'Spain', '932638495', '932638495', 'ES73950375V');

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;

INSERT INTO employees
VALUES
(DEFAULT, 'Juan', 'Martinez'),
(DEFAULT, 'Montse', 'Garcia'),
(DEFAULT, 'Alicia', 'Mendoza'),
(DEFAULT, 'Dani', 'Gonzalez');

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`brand_id`),
  INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `supplier_id`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `cul-d-ampolla`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO brand
VALUES
	(DEFAULT, 'RayBan', 3),
	(DEFAULT, 'Libbey', 1),
	(DEFAULT, 'Waterford', 3),
	(DEFAULT, 'Schott Zwiesel', 2),
	(DEFAULT, 'Riedel', 2),
	(DEFAULT, 'Bormioli Rocco', 1);

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`glasses` (
  `glasses_id` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `frame_type` VARCHAR(20) NOT NULL,
  `frame_color` VARCHAR(20) NOT NULL,
  `lens_gradation` DECIMAL(4,2) NOT NULL DEFAULT 0.00,
  `lens_color` VARCHAR(20) NOT NULL DEFAULT 'transparent',
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`glasses_id`),
  INDEX `brand_id_idx` (`brand_id` ASC) VISIBLE,
  INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `brand_id`
    FOREIGN KEY (`brand_id`)
    REFERENCES `cul-d-ampolla`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `supplier_glasses_id`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `cul-d-ampolla`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO glasses
VALUES
	(DEFAULT, 2, 1, 'horn-rimmed', 'black', '2.50', DEFAULT, 350.00),
	(DEFAULT, 3, 3, 'floating', 'silver', '1.75', 'mirrored', 250.00),
	(DEFAULT, 1, 3, 'metal', 'gold', '3.00', DEFAULT, 450.00),
	(DEFAULT, 4, 2, 'horn-rimmed', 'brown', '2.00', 'brown', 300.00),
	(DEFAULT, 6, 1, 'floating', 'blue', '1.50', DEFAULT, 200.00),
	(DEFAULT, 3, 3, 'metal', 'silver', '2.25', DEFAULT, 400.00),
	(DEFAULT, 1, 3, 'horn-rimmed', 'red', '2.75', 'black', 375.00),
	(DEFAULT, 4, 2, 'floating', 'gold', '1.25', DEFAULT, 225.00),
	(DEFAULT, 2, 1, 'metal', 'black', '2.50', DEFAULT, 350.00),
	(DEFAULT, 5, 2, 'horn-rimmed', 'purple', '2.25', 'polarized', 325.00);

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `registration_date` DATE NOT NULL,
  `recomended_by` INT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `clients_id_idx` (`recomended_by` ASC) VISIBLE,
  CONSTRAINT `clients_id`
    FOREIGN KEY (`recomended_by`)
    REFERENCES `cul-d-ampolla`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO clients
VALUES 
(DEFAULT, 'Laura', 'Rodriguez', 'Calle Mayor 19, 1o 1a', 'Madrid', '28080', 'Spain', '629364850', 'laurarodriguez@gmail.com', '2021-11-08', DEFAULT),
(DEFAULT, 'Amelia', 'Clark', '11 Maple Avenue', 'Los Angeles', '90003', 'USA', '1122334477', 'amelia.clark@example.com', '2021-11-10', DEFAULT),
(DEFAULT, 'William', 'Anderson', '12 Elm Avenue', 'Los Angeles', '90002', 'USA', '1122334466', 'william.anderson@example.com', '2021-12-01', DEFAULT),
(DEFAULT, 'James', 'Taylor', '5 High Street', 'London', 'W1K 2PN', 'United Kingdom', '447812345679', 'james.taylor@example.com', '2022-09-30', 1),
(DEFAULT, 'Liam', 'Sanchez', '19 Calle Principal', 'Madrid', '28003', 'Spain', '3466889900', 'liam.sanchez@example.com', '2022-03-05', DEFAULT),
(DEFAULT, 'Mia', 'Garcia', '21 Calle Mayor', 'Madrid', '28002', 'Spain', '3466778899', 'mia.garcia@example.com', '2022-05-09', DEFAULT),
(DEFAULT, 'Benjamin', 'Lopez', '33 Via Veneto', 'Rome', '00120', 'Italy', '3933344667', 'benjamin.lopez@example.com', '2022-06-15', 2),
(DEFAULT, 'Scarlett', 'Sullivan', '12 Via Napoli', 'Rome', '00130', 'Italy', '3933344778', 'scarlett.sullivan@example.com', '2022-07-25', DEFAULT),
(DEFAULT, 'Daniel', 'Young', '4 Rue des Fleurs', 'Paris', '75003', 'France', '3366990011', 'daniel.young@example.com', '2022-10-25', 2),
(DEFAULT, 'Harper', 'Mitchell', '32 High Street', 'London', 'W1K 3PN', 'United Kingdom', '447812345680', 'harper.mitchell@example.com', '2022-12-15', 3),
(DEFAULT, 'Oliver', 'Davis', '8 Smith Street', 'Melbourne', '3000', 'Australia', '6144778899', 'oliver.davis@example.com', '2022-08-10', DEFAULT),
(DEFAULT, 'Elijah', 'Baker', '8 Elm Street', 'New York', '10003', 'USA', '2123456809', 'elijah.baker@example.com', '2023-03-01', DEFAULT),
(DEFAULT, 'Charlotte', 'Harris', '29 Main Street', 'New York', '10002', 'USA', '2123456798', 'charlotte.harris@example.com', '2023-02-20', 2),
(DEFAULT, 'Ava', 'Wilson', '17 Rue de la Liberté', 'Paris', '75002', 'France', '3366889900', 'ava.wilson@example.com', '2023-03-18', 1),
(DEFAULT, 'Sophia', 'Lee', '56 Oxford Road', 'Sydney', '2001', 'Australia', '6144667788', 'sophia.lee@example.com', '2023-04-05', DEFAULT);

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `sale_date` DATE NOT NULL,
  `sold_by` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`sold_by` ASC) VISIBLE,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `cul-d-ampolla`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`sold_by`)
    REFERENCES `cul-d-ampolla`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO orders
VALUES
	(DEFAULT, 1, '2022-05-15', 2),
	(DEFAULT, 2, '2022-06-20', 1),
	(DEFAULT, 3, '2022-07-28', 1),
	(DEFAULT, 4, '2022-09-12', 3),
	(DEFAULT, 5, '2022-09-25', 4),
	(DEFAULT, 6, '2022-10-05', 2),
	(DEFAULT, 7, '2022-10-28', 1),
	(DEFAULT, 8, '2022-11-15', 4),
	(DEFAULT, 9, '2022-12-10', 2),
	(DEFAULT, 10, '2022-12-22', 1),
	(DEFAULT, 11, '2023-01-05', 3),
	(DEFAULT, 12, '2023-02-10', 2),
	(DEFAULT, 13, '2023-03-08', 1),
	(DEFAULT, 14, '2023-04-20', 4),
	(DEFAULT, 15, '2023-04-25', 4);

CREATE TABLE IF NOT EXISTS `cul-d-ampolla`.`order_glasses` (
  `order_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_id`, `glasses_id`),
  INDEX `glasses_id_idx` (`glasses_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `cul-d-ampolla`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `glasses_id`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `cul-d-ampolla`.`glasses` (`glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO order_glasses
VALUES
	(1, 3, 1),
	(1, 7, 2),
	(2, 9, 1),
	(3, 2, 1),
	(3, 6, 2),
	(3, 1, 1),
	(4, 8, 1),
	(5, 5, 1),
	(6, 4, 1),
	(7, 10, 1),
	(7, 3, 2),
	(8, 7, 1),
	(9, 9, 2),
	(10, 2, 1),
	(11, 6, 1),
	(11, 1, 2),
	(12, 8, 1),
	(13, 5, 1),
	(14, 4, 2),
	(14, 10, 1),
	(15, 10, 2);