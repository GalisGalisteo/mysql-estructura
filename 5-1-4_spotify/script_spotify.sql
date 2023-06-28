CREATE SCHEMA IF NOT EXISTS `spotify`;

USE `spotify`;

CREATE TABLE IF NOT EXISTS `spotify`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_type` ENUM('free', 'premium') NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `birth_date` DATE NOT NULL,
  `gender` ENUM('male', 'female', 'other', 'prefer not to say') NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

INSERT INTO `spotify`.`users` (`user_id`, `user_type`, `email`, `password`, `user_name`, `birth_date`, `gender`, `country`, `zip`) 
VALUES 
	(DEFAULT, 'free', 'user1@example.com', 'password1', 'User 1', '1990-01-01', 'male', 'Country 1', '12345'),
	(DEFAULT, 'premium', 'user2@example.com', 'password2', 'User 2', '1991-02-02', 'female', 'Country 2', '23456'),
	(DEFAULT, 'free', 'user3@example.com', 'password3', 'User 3', '1992-03-03', 'other', 'Country 3', '34567'),
	(DEFAULT, 'premium', 'user4@example.com', 'password4', 'User 4', '1993-04-04', 'prefer not to say', 'Country 4', '45678'),
	(DEFAULT, 'free', 'user5@example.com', 'password5', 'User 5', '1994-05-05', 'male', 'Country 5', '56789'),
	(DEFAULT, 'premium', 'user6@example.com', 'password6', 'User 6', '1995-06-06', 'female', 'Country 6', '67890');

CREATE TABLE IF NOT EXISTS `spotify`.`payment_methods` (
  `payment_method_id` INT NOT NULL,
  `name` ENUM('credit card', 'paypal') NOT NULL COMMENT 'credit_card, paypal',
  PRIMARY KEY (`payment_method_id`))
ENGINE = InnoDB;

INSERT INTO `spotify`.`payment_methods` (`payment_method_id`, `name`) 
VALUES 
(1, 'credit card'),
(2, 'paypal');

CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `paypal_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(254) NOT NULL,
  PRIMARY KEY (`paypal_id`))
ENGINE = InnoDB;

INSERT INTO `spotify`.`paypal` (`paypal_id`, `user_name`) 
VALUES 
    (DEFAULT, 'User1'),
    (DEFAULT, 'User2'),
    (DEFAULT, 'User3'),
    (DEFAULT, 'User4'),
    (DEFAULT, 'User5');
    
CREATE TABLE IF NOT EXISTS `spotify`.`credit_cards` (
  `credit_card_id` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(19) NOT NULL,
  `expiration_date` DATE NOT NULL,
  `security_code` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`credit_card_id`))
ENGINE = InnoDB;

INSERT INTO `spotify`.`credit_cards` (`credit_card_id`, `number`, `expiration_date`, `security_code`) 
VALUES 
    (DEFAULT, '378282246310005', '2025-06-01', '1234'),
    (DEFAULT, '4111111111111111', '2024-09-01', '567'),
    (DEFAULT, '5555555555554444', '2025-12-01', '789'),
    (DEFAULT, '378734493671000', '2026-04-01', '234'),
    (DEFAULT, '4012888888881881', '2027-08-01', '901');
    
CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `subscription_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `join_date` DATE NOT NULL,
  `renewal_date` DATE NOT NULL,
  `payment_method_id` INT NOT NULL,
  `credit_card_id` INT NULL,
  `paypal_id` INT NULL,
  PRIMARY KEY (`subscription_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `payment_method_id_idx` (`payment_method_id` ASC) VISIBLE,
  CONSTRAINT `user_id_subscriptions`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `payment_method_id_subscriptions`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `spotify`.`payment_methods` (`payment_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `paypal_id_subscriptions`
    FOREIGN KEY (`paypal_id`)
    REFERENCES `spotify`.`paypal` (`paypal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `credit_card_id_subscriptions`
    FOREIGN KEY (`credit_card_id`)
    REFERENCES `spotify`.`credit_cards` (`credit_card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `check_payment_method_subscriptions`
	CHECK (
			NOT(`payment_method_id` = 1 AND `credit_card_id` = NULL) OR
            NOT(`payment_method_id` = 2 AND `paypal_id` = NULL)
          )
)
ENGINE = InnoDB;

INSERT INTO `spotify`.`subscriptions` (`subscription_id`, `user_id`, `join_date`, `renewal_date`, `payment_method_id`, `credit_card_id`, `paypal_id`) 
VALUES
    (DEFAULT, 2, '2023-01-01', '2024-01-01', 1, 1, NULL),
    (DEFAULT, 4, '2023-02-02', '2024-02-02', 2, NULL, 2),
    (DEFAULT, 6, '2023-03-03', '2024-03-03', 1, 3, NULL);

CREATE TABLE IF NOT EXISTS `spotify`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `subscription_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `total` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `subscription_id_idx` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `subscription_id_orders`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `spotify`.`subscriptions` (`subscription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`orders` (`order_id`, `subscription_id`, `date`, `total`) 
VALUES 
    (DEFAULT, 1, '2023-01-01', 10.00),
    (DEFAULT, 1, '2023-02-02', 15.00),
    (DEFAULT, 2, '2023-03-03', 20.00),
    (DEFAULT, 2, '2023-04-04', 25.00),
    (DEFAULT, 3, '2023-05-05', 30.00),
    (DEFAULT, 3, '2023-06-06', 35.00);
    
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `songs_number` INT NOT NULL,
  `date_created` DATE NOT NULL,
  `erased` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`playlist_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id_playlist`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`playlist` (`playlist_id`, `user_id`, `name`, `songs_number`, `date_created`, `erased`) 
VALUES 
	(DEFAULT, 1, 'Playlist 1', 10, '2023-01-01', 0),
	(DEFAULT, 2, 'Playlist 2', 8, '2023-02-02', 0),
	(DEFAULT, 3, 'Playlist 3', 15, '2023-03-03', 1),
	(DEFAULT, 4, 'Playlist 4', 12, '2023-04-04', 1),
	(DEFAULT, 5, 'Playlist 5', 20, '2023-05-05', 0),
	(DEFAULT, 6, 'Playlist 6', 5, '2023-06-06', 0);

CREATE TABLE IF NOT EXISTS `spotify`.`erased_playlists` (
  `playlist_id` INT NOT NULL,
  `date_erased` DATE NOT NULL,
  PRIMARY KEY (`playlist_id`),
  CONSTRAINT `playlist_id_erased_playlists`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`erased_playlists` (`playlist_id`, `date_erased`) 
VALUES 
(3, '2023-04-03'),
(4, '2023-04-03');

CREATE TABLE IF NOT EXISTS `spotify`.`artists` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;

INSERT INTO `spotify`.`artists` (`artist_id`, `name`, `image`) 
VALUES 
  (DEFAULT, 'Artist 1', 'image1.jpg'),
  (DEFAULT, 'Artist 2', 'image2.jpg'),
  (DEFAULT, 'Artist 3', 'image3.jpg'),
  (DEFAULT, 'Artist 4', 'image4.jpg'),
  (DEFAULT, 'Artist 5', 'image5.jpg');
  
CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `year` YEAR NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `artist_id_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `artist_id_albums`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`albums` (`album_id`, `artist_id`, `name`, `year`, `image`) 
VALUES 
  (DEFAULT, 1, 'Album 1', '2020', '/path/to/image1.jpg'),
  (DEFAULT, 1, 'Album 2', '2018', '/path/to/image2.jpg'),
  (DEFAULT, 2, 'Album 3', '2019', '/path/to/image3.jpg'),
  (DEFAULT, 3, 'Album 4', '2021', '/path/to/image4.jpg'),
  (DEFAULT, 3, 'Album 5', '2017', '/path/to/image5.jpg'),
  (DEFAULT, 4, 'Album 6', '2022', '/path/to/image6.jpg'),
  (DEFAULT, 5, 'Album 7', '2016', '/path/to/image7.jpg'),
  (DEFAULT, 5, 'Album 8', '2020', '/path/to/image8.jpg');
  
CREATE TABLE IF NOT EXISTS `spotify`.`songs` (
  `song_id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `duration` TIME NOT NULL,
  `times_played` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`song_id`),
  INDEX `artist_id_idx` (`artist_id` ASC) VISIBLE,
  INDEX `album_id_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `artist_id_songs`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `album_id_songs`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`songs` (`song_id`, `artist_id`, `album_id`, `name`, `duration`, `times_played`) 
VALUES 
  (DEFAULT, 1, 1, 'Song 1', '03:45', 10),
  (DEFAULT, 1, 1, 'Song 2', '04:20', 5),
  (DEFAULT, 1, 2, 'Song 3', '02:55', 20),
  (DEFAULT, 1, 2, 'Song 4', '03:10', 15),
  (DEFAULT, 2, 3, 'Song 5', '05:15', 8),
  (DEFAULT, 2, 3, 'Song 6', '03:30', 3),
  (DEFAULT, 2, 4, 'Song 7', '04:05', 12),
  (DEFAULT, 2, 4, 'Song 8', '03:50', 6),
  (DEFAULT, 3, 5, 'Song 9', '03:25', 18),
  (DEFAULT, 3, 5, 'Song 10', '04:40', 7),
  (DEFAULT, 3, 6, 'Song 11', '03:15', 14),
  (DEFAULT, 3, 6, 'Song 12', '04:00', 9),
  (DEFAULT, 4, 7, 'Song 13', '03:55', 22),
  (DEFAULT, 4, 7, 'Song 14', '03:20', 4),
  (DEFAULT, 4, 8, 'Song 15', '04:30', 16),
  (DEFAULT, 4, 8, 'Song 16', '03:35', 11),
  (DEFAULT, 5, 1, 'Song 17', '04:15', 6),
  (DEFAULT, 5, 1, 'Song 18', '03:40', 19),
  (DEFAULT, 5, 2, 'Song 19', '04:25', 13),
  (DEFAULT, 5, 2, 'Song 20', '03:50', 8);

CREATE TABLE IF NOT EXISTS `spotify`.`active_playlists` (
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  `added_by` INT NOT NULL,
  `date_added` DATE NOT NULL,
  PRIMARY KEY (`playlist_id`, `song_id`),
  INDEX `song_id_idx` (`song_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`added_by` ASC) VISIBLE,
  CONSTRAINT `playlist_id_active_playlists`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `song_id_active_playlists`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_active_playlists`
    FOREIGN KEY (`added_by`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`active_playlists` (`playlist_id`, `song_id`, `added_by`, `date_added`) 
VALUES 
  (1, 1, 1, '2023-01-01'),
  (1, 2, 2, '2023-01-02'),
  (1, 3, 3, '2023-01-03'),
  (2, 4, 4, '2023-01-04'),
  (2, 5, 5, '2023-01-05'),
  (2, 6, 6, '2023-01-06'),
  (5, 7, 1, '2023-01-07'),
  (5, 8, 2, '2023-01-08'),
  (5, 9, 3, '2023-01-09'),
  (6, 10, 4, '2023-01-10'),
  (6, 11, 5, '2023-01-11'),
  (6, 12, 6, '2023-01-12'),
  (1, 13, 1, '2023-01-13'),
  (1, 14, 2, '2023-01-14'),
  (1, 15, 3, '2023-01-15'),
  (2, 16, 4, '2023-01-16'),
  (2, 17, 5, '2023-01-17'),
  (2, 18, 6, '2023-01-18'),
  (5, 19, 1, '2023-01-19'),
  (5, 20, 2, '2023-01-20');
  
CREATE TABLE IF NOT EXISTS `spotify`.`user_favorite_songs` (
  `user_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `song_id`),
  INDEX `song_id_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `user_id_user_favorite_songs`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `song_id_user_favorite_songs`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`user_favorite_songs` (`user_id`, `song_id`) 
VALUES 
  (1, 3),
  (2, 10),
  (3, 5),
  (4, 17),
  (5, 9),
  (6, 13),
  (1, 19),
  (2, 6),
  (3, 14),
  (4, 8);

CREATE TABLE IF NOT EXISTS `spotify`.`user_favorite_albums` (
  `user_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `album_id`),
  INDEX `album_id_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `user_id_user_favorite_albums`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `album_id_user_favorite_albums`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`user_favorite_albums` (`user_id`, `album_id`) 
VALUES 
  (1, 3),
  (2, 7),
  (3, 5),
  (4, 1),
  (5, 6),
  (6, 2),
  (1, 8),
  (2, 4),
  (3, 1),
  (4, 5);
  
CREATE TABLE IF NOT EXISTS `spotify`.`artist_followers` (
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `artist_id`),
  INDEX `artist_id_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `user_id_artist_followers`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artist_id_artist_followers`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`artist_followers` (`user_id`, `artist_id`) 
VALUES 
  (1, 2),
  (2, 4),
  (3, 1),
  (4, 3),
  (5, 5),
  (6, 1),
  (1, 5),
  (2, 3),
  (3, 2),
  (4, 4);
  
CREATE TABLE IF NOT EXISTS `spotify`.`related_artists` (
  `artist_id` INT NOT NULL,
  `related_to_id` INT NOT NULL,
  PRIMARY KEY (`artist_id`, `related_to_id`),
  INDEX `related_to_idx` (`related_to_id` ASC) VISIBLE,
  CONSTRAINT `artist_id_related_artists`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `related_to_related_artists`
    FOREIGN KEY (`related_to_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `spotify`.`related_artists` (`artist_id`, `related_to_id`) 
VALUES 
  (1, 2),
  (1, 3),
  (1, 4),
  (2, 3),
  (3, 4),
  (4, 5),
  (5, 1);