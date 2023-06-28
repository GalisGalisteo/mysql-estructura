CREATE SCHEMA IF NOT EXISTS `vegan_pizzeria`;

USE `vegan_pizzeria`;

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(10) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`location` (`location_id`, `name`, `address`, `city`, `zip`, `province`, `telefon`) 
VALUES 
	(DEFAULT, 'sol', 'calle sol, 1', 'Madrid', '28001', 'Madrid', '911728394'),
	(DEFAULT, 'lavapies', 'calle lavapies, 1', 'Madrid', '28010', 'Madrid', '911728399'),
	(DEFAULT, 'malasaña', 'calle malasaña, 1', 'Madrid', '28020', 'Madrid', '911728396');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(10) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`clients` (`client_id`, `first_name`, `last_name`, `address`, `city`, `zip`, `province`, `telefon`)
VALUES
	(DEFAULT, 'Laura', 'Rodriguez', 'Calle Mayor 19, 1o 1a', 'Madrid', 'Madrid', '28080', '629364850'),
	(DEFAULT, 'Amelia', 'Clark', '11 Maple Avenue', 'Madrid', 'Madrid', '28081', '1122334477'),
	(DEFAULT, 'William', 'Anderson', '12 Elm Avenue', 'Madrid', 'Madrid', '28010', '1122334466'),
	(DEFAULT, 'James', 'Taylor', '5 High Street', 'Madrid', 'Madrid', '28020', '447812345679'),
	(DEFAULT, 'Liam', 'Sanchez', '19 Calle Principal', 'Madrid', 'Madrid', '28003', '3466889900'),
	(DEFAULT, 'Mia', 'Garcia', '21 Calle Mayor', 'Madrid', 'Madrid', '28002', '3466778899'),
	(DEFAULT, 'Benjamin', 'Lopez', '33 Via Veneto', 'Madrid', 'Madrid', '28001', '3933344667'),
	(DEFAULT, 'Scarlett', 'Sullivan', '12 Via Napoli', 'Madrid', 'Madrid', '28083', '3933344778'),
	(DEFAULT, 'Daniel', 'Young', '4 Rue des Fleurs', 'Madrid', 'Madrid', '28080', '3366990011'),
	(DEFAULT, 'Harper', 'Mitchell', '32 High Street', 'Madrid', 'Madrid', '28060', '447812345680'),
	(DEFAULT, 'Oliver', 'Davis', '8 Smith Street', 'Madrid', 'Madrid', '28070', '6144778899'),
	(DEFAULT, 'Elijah', 'Baker', '8 Elm Street', 'Madrid', 'Madrid', '28080', '2123456809'),
	(DEFAULT, 'Charlotte', 'Harris', '29 Main Street', 'Madrid', 'Madrid', '28050', '2123456798'),
	(DEFAULT, 'Ava', 'Wilson', '17 Rue de la Liberté', 'Madrid', 'Madrid', '28080', '3366889900'),
	(DEFAULT, 'Sophia', 'Lee', '56 Oxford Road', 'Madrid', 'Madrid', '28083', '6144667788');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`job` (
  `job_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`job_id`))
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`job` (`job_id`, `description`) 
VALUES
	(DEFAULT, 'delivery'),
	(DEFAULT, 'cook');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `job_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefon` VARCHAR(20) NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `job_id_idx` (`job_id` ASC) VISIBLE,
  INDEX `location_id_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `vegan_pizzeria`.`job` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `vegan_pizzeria`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`employees` (`employee_id`, `job_id`, `first_name`, `last_name`, `nif`, `telefon`, `location_id`) 
VALUES 
    (DEFAULT, 2, 'Juan', 'Martinez', '628147392', '80192468H', 1),
	(DEFAULT, 2, 'Montse', 'Garcia', '634529671', '97631527J', 1),
	(DEFAULT, 1, 'Alicia', 'Mendoza', '609782145', '41289064M', 1),
	(DEFAULT, 1, 'Dani', 'Gonzalez', '612438790', '67893251R', 1),
    (DEFAULT, 2, 'Jose', 'Perez', '630947581', '34521789S', 2),
	(DEFAULT, 1, 'Ricardo', 'Porto', '623401856', '56381924T', 2),
	(DEFAULT, 2, 'Angeles', 'De La Torre', '645782913', '21893456N', 2),
	(DEFAULT, 1, 'Manuel', 'Priego', '627839467', '40283749G', 2);

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`order_type` (
  `order_type_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`order_type_id`))
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`order_type` (`order_type_id`, `description`) 
VALUES 
	(DEFAULT, 'delivery'),
    (DEFAULT, 'take-out'),
    (DEFAULT, 'dine-in');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `order_type_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `order_time` TIME NOT NULL,
  `total` DECIMAL(4,2) NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  INDEX `order_type_id_idx` (`order_type_id` ASC) VISIBLE,
  INDEX `location_id_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `vegan_pizzeria`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_type_id`
    FOREIGN KEY (`order_type_id`)
    REFERENCES `vegan_pizzeria`.`order_type` (`order_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_id_orders`
    FOREIGN KEY (`location_id`)
    REFERENCES `vegan_pizzeria`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`orders` (`order_id`, `client_id`, `order_type_id`, `order_date`, `order_time`, `total`, `location_id`) 
VALUES 
	(DEFAULT, 1, 1, '2022-01-15', '20:34', 22.00, 1),
	(DEFAULT, 2, 3, '2022-01-15', '20:54', 39.50, 1),
	(DEFAULT, 3, 1, '2022-01-16', '19:45', 17.00, 2),
	(DEFAULT, 4, 2, '2022-01-16', '21:10', 20.50, 2),
	(DEFAULT, 5, 1, '2022-01-17', '19:00', 23.00, 1),
	(DEFAULT, 6, 3, '2022-01-17', '20:40', 30.50, 1),
	(DEFAULT, 7, 1, '2022-01-18', '19:15', 19.00, 2),
	(DEFAULT, 8, 3, '2022-01-18', '20:20', 28.50, 2),
	(DEFAULT, 9, 1, '2022-01-19', '19:50', 10.00, 1),
	(DEFAULT, 10, 2, '2022-01-19', '21:05', 27.50, 1),
	(DEFAULT, 11, 1, '2022-01-20', '19:40', 34.50, 2),
	(DEFAULT, 12, 3, '2022-01-20', '21:25', 10.50, 2),
	(DEFAULT, 13, 1, '2022-01-21', '19:25', 25.50, 1),
	(DEFAULT, 14, 3, '2022-01-21', '20:45', 38.00, 1),
	(DEFAULT, 15, 1, '2022-01-22', '19:55', 27.50, 2),
	(DEFAULT, 1, 2, '2022-01-22', '21:00', 13.50, 2),
	(DEFAULT, 2, 1, '2022-01-23', '19:05', 31.50, 1),
	(DEFAULT, 3, 3, '2022-01-23', '20:15', 30.50, 1),
	(DEFAULT, 4, 1, '2022-01-24', '19:20', 12.50, 2),
	(DEFAULT, 5, 3, '2022-01-24', '20:35', 20.50, 2),
	(DEFAULT, 6, 1, '2022-01-25', '19:45', 26.00, 1),
	(DEFAULT, 7, 2, '2022-01-25', '20:55', 29.50, 1),
	(DEFAULT, 8, 1, '2022-01-26', '19:10', 24.00, 2),
	(DEFAULT, 9, 3, '2022-01-26', '20:20', 10.00, 2),
	(DEFAULT, 10, 1, '2022-01-27', '19:35', 11.50, 1),
	(DEFAULT, 11, 3, '2022-01-27', '20:25', 23.50, 1),
	(DEFAULT, 12, 1, '2022-01-28', '19:00', 10.00, 2),
	(DEFAULT, 13, 3, '2022-01-28', '20:40', 23.00, 2),
	(DEFAULT, 14, 1, '2022-01-29', '19:20', 12.50, 1),
	(DEFAULT, 15, 2, '2022-01-29', '21:05', 30.50, 1),
	(DEFAULT, 1, 1, '2022-01-30', '19:55', 11.00, 2),
	(DEFAULT, 2, 3, '2022-01-30', '20:45', 21.50, 2);


CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`delivery` (
  `delivery_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `delivered_date` DATE NOT NULL,
  `delivered_time` TIME NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `vegan_pizzeria`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `vegan_pizzeria`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`delivery` (`delivery_id`, `employee_id`, `order_id`, `delivered_date`, `delivered_time`) 
VALUES 
	(DEFAULT, 3, 1, '2022-01-15', '21:04'),
	(DEFAULT, 4, 3, '2022-01-16', '20:15'),
	(DEFAULT, 6, 5, '2022-01-17', '20:30'),
	(DEFAULT, 8, 7, '2022-01-18', '20:45'),
	(DEFAULT, 6, 9, '2022-01-19', '20:20'),
	(DEFAULT, 3, 11, '2022-01-20', '20:10'),
	(DEFAULT, 4, 13, '2022-01-21', '20:55'),
	(DEFAULT, 8, 15, '2022-01-22', '20:25'),
	(DEFAULT, 6, 17, '2022-01-23', '20:35'),
	(DEFAULT, 3, 19, '2022-01-24', '20:50'),
	(DEFAULT, 4, 21, '2022-01-25', '20:15'),
	(DEFAULT, 6, 23, '2022-01-26', '20:40'),
	(DEFAULT, 8, 25, '2022-01-27', '20:05'),
	(DEFAULT, 6, 27, '2022-01-28', '20:30'),
	(DEFAULT, 3, 29, '2022-01-29', '20:50'),
	(DEFAULT, 6, 31, '2022-01-30', '20:25');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`item_categories` (
  `item_category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_category_id`))
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`item_categories` (`item_category_id`, `name`) 
VALUES 
	(DEFAULT, 'Pizzas'),
    (DEFAULT, 'Burgers'),
    (DEFAULT, 'Drinks');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`pizza_categories` (
  `pizza_category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pizza_category_id`))
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`pizza_categories` (`pizza_category_id`, `name`) 
VALUES 
	(DEFAULT, 'wheat (white)'),
	(DEFAULT, 'wheat (whole)'),
	(DEFAULT, 'einkorn (whole)'),
	(DEFAULT, 'spelt (white)'),
	(DEFAULT, 'gluten-free');

CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`items` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `item_category_id` INT NOT NULL,
  `pizza_category_id` INT NULL DEFAULT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `picture` VARCHAR(255) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `item_category_id_idx` (`item_category_id` ASC) VISIBLE,
  INDEX `pizza_category_id_idx` (`pizza_category_id` ASC) VISIBLE,
  CONSTRAINT `item_category_id`
    FOREIGN KEY (`item_category_id`)
    REFERENCES `vegan_pizzeria`.`item_categories` (`item_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizza_category_id`
    FOREIGN KEY (`pizza_category_id`)
    REFERENCES `vegan_pizzeria`.`pizza_categories` (`pizza_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `check_pizza_category`
	CHECK (NOT (`item_category_id` = 1 AND `pizza_category_id` IS NULL)),
  CONSTRAINT `check_item_category`
    CHECK (NOT (`item_category_id` <> 1 AND `pizza_category_id` IS NOT NULL))
)
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`items` (`item_id`, `item_category_id`, `pizza_category_id`, `name`, `description`, `picture`, `price`) 
VALUES 
	(DEFAULT, 1, 1, 'margherita', 'tomato sauce, vegan mozzarella cheese', '/img/001_margherita.jpeg', '8.00'),
	(DEFAULT, 1, 2, 'margherita', 'tomato sauce, vegan mozzarella cheese', '/img/001_margherita.jpeg', '8.00'),
	(DEFAULT, 1, 3, 'margherita', 'tomato sauce, vegan mozzarella cheese', '/img/001_margherita.jpeg', '8.00'),
	(DEFAULT, 1, 4, 'margherita', 'tomato sauce, vegan mozzarella cheese', '/img/001_margherita.jpeg', '8.00'),
	(DEFAULT, 1, 5, 'margherita', 'tomato sauce, vegan mozzarella cheese', '/img/001_margherita.jpeg', '8.00'),
	(DEFAULT, 1, 1, 'funghi', 'tomato sauce, vegan mozzarella cheese, onions, mushrooms', '/img/002_funghi.jpeg', '8.50'),
	(DEFAULT, 1, 2, 'funghi', 'tomato sauce, vegan mozzarella cheese, onions, mushrooms', '/img/002_funghi.jpeg', '8.50'),
	(DEFAULT, 1, 3, 'funghi', 'tomato sauce, vegan mozzarella cheese, onions, mushrooms', '/img/002_funghi.jpeg', '8.50'),
	(DEFAULT, 1, 4, 'funghi', 'tomato sauce, vegan mozzarella cheese, onions, mushrooms', '/img/002_funghi.jpeg', '8.50'),
	(DEFAULT, 1, 5, 'funghi', 'tomato sauce, vegan mozzarella cheese, onions, mushrooms', '/img/002_funghi.jpeg', '8.50'),
	(DEFAULT, 1, 1, 'barbecue', 'tomato sauce, vegan mozzarella cheese, vegan beef, barbacue sauce, chilli', '/img/003_barbecue.jpeg', '9.50'),
	(DEFAULT, 1, 2, 'barbecue', 'tomato sauce, vegan mozzarella cheese, vegan beef, barbacue sauce, chilli', '/img/003_barbecue.jpeg', '9.50'),
	(DEFAULT, 1, 3, 'barbecue', 'tomato sauce, vegan mozzarella cheese, vegan beef, barbacue sauce, chilli', '/img/003_barbecue.jpeg', '9.50'),
	(DEFAULT, 1, 4, 'barbecue', 'tomato sauce, vegan mozzarella cheese, vegan beef, barbacue sauce, chilli', '/img/003_barbecue.jpeg', '9.50'),
	(DEFAULT, 1, 5, 'barbecue', 'tomato sauce, vegan mozzarella cheese, vegan beef, barbacue sauce, chilli', '/img/003_barbecue.jpeg', '9.50'),
	(DEFAULT, 2, NULL, 'vegan beef burger', 'vegan beef patty, onion, tomato, lettuce', '/img/004_beef_burger.jpeg', '6.50'),
	(DEFAULT, 2, NULL, 'vegan cheese burger', 'vegan beef patty, cheese, onion, tomato, lettuce', '/img/005_cheese_burger.jpeg', '7.50'),
	(DEFAULT, 2, NULL, 'vegan crispy chicken burger', 'vegan crispy chicken, cheese, tomato, lettuce', '/img/006_crispy_chicken_burger.jpeg', '8.00'),
    (DEFAULT, 3, NULL, 'mineral water', '50cl', '/img/007_water.jpeg', '1.50'),
	(DEFAULT, 3, NULL, 'sparkling water', '50cl', '/img/008_sparkling_water.jpeg', '1.50'),
	(DEFAULT, 3, NULL, 'coke', '33cl', '/img/009_coke.jpeg', '2.00'),
	(DEFAULT, 3, NULL, 'lemon soda', '33cl', '/img/010_lemon_soda.jpeg', '2.00'),
	(DEFAULT, 3, NULL, 'orange soda', '33cl', '/img/011_orange_soda.jpeg', '2.00'),
	(DEFAULT, 3, NULL, 'beer', '33cl', '/img/012_beer.jpeg', '2.00');
    
CREATE TABLE IF NOT EXISTS `vegan_pizzeria`.`order_items` (
  `order_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_id`, `item_id`),
  INDEX `item_id_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `vegan_pizzeria`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `vegan_pizzeria`.`items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `vegan_pizzeria`.`order_items` (`order_id`, `item_id`, `quantity`) 
VALUES 
	(1, 20, 2),
	(1, 14, 2),
	(2, 12, 1),
	(2, 21, 3),
	(2, 10, 3),
	(3, 22, 1),
	(3, 17, 2),
	(3, 23, 1),
	(4, 7, 1),
	(4, 23, 2),
	(4, 2, 1),
	(5, 11, 1),
	(5, 9, 1),
	(6, 16, 3),
	(6, 24, 1),
	(7, 4, 1),
	(7, 20, 2),
	(7, 1, 1),
	(8, 21, 3),
	(8, 4, 3),
	(9, 22, 1),
	(9, 5, 1),
	(10, 23, 2),
	(10, 6, 2),
	(10, 18, 1),
	(11, 24, 3),
	(11, 12, 3),
	(12, 8, 1),
	(13, 20, 2),
	(13, 18, 3),
	(14, 21, 3),
	(14, 3, 1),
	(14, 7, 3),
	(15, 22, 1),
	(15, 13, 1),
	(15, 3, 2),
	(16, 23, 2),
	(16, 14, 1),
	(17, 24, 3),
	(17, 11, 2),
	(17, 10, 1),
	(18, 13, 3),
	(19, 20, 2),
	(19, 15, 1),
	(20, 6, 2),
	(20, 21, 3),
	(21, 1, 3),
	(21, 22, 1),
	(22, 8, 3),
	(22, 23, 2),
	(23, 10, 1),
	(23, 24, 3),
	(23, 16, 1),
	(24, 19, 1),
	(25, 7, 1),
	(25, 20, 2),
	(26, 12, 2),
	(26, 21, 3),
	(27, 22, 1),
	(27, 4, 1),
	(28, 23, 2),
	(28, 13, 2),
	(29, 24, 3),
	(29, 17, 1),
	(30, 15, 3),
	(31, 20, 2),
	(31, 2, 1),
	(32, 21, 3),
	(32, 9, 2);