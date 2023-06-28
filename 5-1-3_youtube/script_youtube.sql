CREATE SCHEMA IF NOT EXISTS `youtube`;

USE `youtube`;

CREATE TABLE IF NOT EXISTS `youtube`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `birth` DATE NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

INSERT INTO `youtube`.`users` (`user_id`, `email`, `password`, `user_name`, `birth`, `gender`, `country`, `zip`) 
VALUES 
    (DEFAULT, 'user1@example.com', 'password1', 'User1', '1990-01-01', 'Male', 'Country 1', '12345'),
    (DEFAULT, 'user2@example.com', 'password2', 'User2', '1991-02-02', 'Female', 'Country 2', '23456'),
    (DEFAULT, 'user3@example.com', 'password3', 'User3', '1992-03-03', 'Male', 'Country 3', '34567'),
    (DEFAULT, 'user4@example.com', 'password4', 'User4', '1993-04-04', 'Female', 'Country 4', '45678'),
    (DEFAULT, 'user5@example.com', 'password5', 'User5', '1994-05-05', 'Male', 'Country 5', '56789');

CREATE TABLE IF NOT EXISTS `youtube`.`status` (
  `status_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB;

INSERT INTO `youtube`.`status` (`status_id`, `name`) 
VALUES 
	(DEFAULT, 'public'),
    (DEFAULT, 'private'),
    (DEFAULT, 'hidden');
    
CREATE TABLE IF NOT EXISTS `youtube`.`tags` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;

INSERT INTO `youtube`.`tags` (`tag_id`, `tag_name`) 
VALUES 
	(DEFAULT, 'cars'),
    (DEFAULT, 'cats'),
    (DEFAULT, 'dogs'),
    (DEFAULT, 'science'),
    (DEFAULT, 'recipes');

CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `status_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  `tittle` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `size` INT NOT NULL,
  `file_name` VARCHAR(45) NOT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `thumbnail` VARCHAR(200) NOT NULL,
  `views` VARCHAR(45) NOT NULL,
  `likes` VARCHAR(45) NOT NULL,
  `dislikes` VARCHAR(45) NOT NULL,
  `datetime_posted` DATE NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `status_id_idx` (`status_id` ASC) VISIBLE,
  INDEX `tag_id_idx` (`tag_id` ASC) VISIBLE,
  CONSTRAINT `user_id_videos`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_id_videos`
    FOREIGN KEY (`status_id`)
    REFERENCES `youtube`.`status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tag_id_videos`
    FOREIGN KEY (`tag_id`)
    REFERENCES `youtube`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`videos` (`video_id`, `user_id`, `status_id`, `tag_id`, `tittle`, `description`, `size`, `file_name`, `duration`, `thumbnail`, `views`, `likes`, `dislikes`, `datetime_posted`) 
VALUES 
    (DEFAULT, 1, 1, 1, 'Video 1', 'Description for Video 1', '100', 'video1.mp4', '10:30', 'thumbnail1.jpg', 1000, 50, 5, '2022-01-01 12:00:00'),
    (DEFAULT, 2, 1, 2, 'Video 2', 'Description for Video 2', '150', 'video2.mp4', '15:45', 'thumbnail2.jpg', 500, 20, 2, '2022-01-02 14:30:00'),
    (DEFAULT, 3, 2, 3, 'Video 3', 'Description for Video 3', '80', 'video3.mp4', '08:15', 'thumbnail3.jpg', 800, 40, 3, '2022-01-03 09:45:00'),
    (DEFAULT, 4, 1, 4, 'Video 4', 'Description for Video 4', '200', 'video4.mp4', '20:00', 'thumbnail4.jpg', 1500, 70, 7, '2022-01-04 16:20:00'),
    (DEFAULT, 5, 3, 5, 'Video 5', 'Description for Video 5', '120', 'video5.mp4', '12:45', 'thumbnail5.jpg', 1200, 60, 6, '2022-01-05 11:10:00'),
    (DEFAULT, 1, 1, 1, 'Video 6', 'Description for Video 6', '90', 'video6.mp4', '09:20', 'thumbnail6.jpg', 700, 30, 4, '2022-01-06 13:55:00'),
    (DEFAULT, 2, 2, 2, 'Video 7', 'Description for Video 7', '130', 'video7.mp4', '13:30', 'thumbnail7.jpg', 900, 45, 4, '2022-01-07 10:40:00'),
    (DEFAULT, 3, 1, 3, 'Video 8', 'Description for Video 8', '110', 'video8.mp4', '11:00', 'thumbnail8.jpg', 1100, 55, 5, '2022-01-08 15:25:00'),
    (DEFAULT, 4, 1, 4, 'Video 9', 'Description for Video 9', '170', 'video9.mp4', '16:15', 'thumbnail9.jpg', 1300, 65, 6, '2022-01-09 17:50:00'),
    (DEFAULT, 5, 3, 5, 'Video 10', 'Description for Video 10', '140', 'video10.mp4', '14:00', 'thumbnail10.jpg', 1000, 50, 3, '2022-01-10 18:15:00');

CREATE TABLE IF NOT EXISTS `youtube`.`playlists` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date_created` DATE NOT NULL,
  `status_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `status_id_idx` (`status_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id_playlists`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_id_playlists`
    FOREIGN KEY (`status_id`)
    REFERENCES `youtube`.`status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`playlists` (`playlist_id`, `name`, `date_created`, `status_id`, `user_id`) 
VALUES 
    (DEFAULT, 'Playlist 1', '2022-01-01', 1, 1),
    (DEFAULT, 'Playlist 2', '2022-01-02', 1, 2),
    (DEFAULT, 'Playlist 3', '2022-01-03', 2, 3),
    (DEFAULT, 'Playlist 4', '2022-01-04', 1, 4),
    (DEFAULT, 'Playlist 5', '2022-01-05', 2, 5);
    
CREATE TABLE IF NOT EXISTS `youtube`.`playlist_videos` (
  `playlist_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_id`),
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `playlist_id_playlist_videos`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlists` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_id_playlist_videos`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`playlist_videos` (`playlist_id`, `video_id`) 
VALUES 
	(1, 1), (1, 2), (1, 3),
    (2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
    (3, 6), (3, 7), (3, 8), (3, 9), (3, 10),
    (4, 3), (4, 4), (4, 7), (4, 8), (4, 9),
    (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10);

CREATE TABLE IF NOT EXISTS `youtube`.`comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `text` VARCHAR(45) NOT NULL,
  `datetime` DATE NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `video_id_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `user_id_comments`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_id_comments`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`comments` (`comment_id`, `user_id`, `video_id`, `text`, `datetime`) 
VALUES 
    (DEFAULT, 1, 1, 'Comment 1', '2023-06-07 09:30:00'),
    (DEFAULT, 2, 2, 'Comment 2', '2023-06-08 10:15:00'),
    (DEFAULT, 3, 3, 'Comment 3', '2023-06-09 11:05:00'),
    (DEFAULT, 4, 4, 'Comment 4', '2023-06-10 12:20:00'),
    (DEFAULT, 5, 5, 'Comment 5', '2023-06-11 13:45:00'),
    (DEFAULT, 1, 6, 'Comment 6', '2023-06-12 14:30:00'),
    (DEFAULT, 2, 7, 'Comment 7', '2023-06-13 15:50:00'),
    (DEFAULT, 3, 8, 'Comment 8', '2023-06-14 16:25:00'),
    (DEFAULT, 4, 9, 'Comment 9', '2023-06-15 17:10:00'),
    (DEFAULT, 5, 10, 'Comment 10', '2023-06-16 18:40:00');

CREATE TABLE IF NOT EXISTS `youtube`.`comment_likes` (
  `comment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `like` TINYINT NULL,
  `like_datetime` DATE NULL DEFAULT NULL,
  `dislike` TINYINT NULL DEFAULT NULL,
  `dislike_datetime` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `comment_id_comment_likes`
    FOREIGN KEY (`comment_id`)
    REFERENCES `youtube`.`comments` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_comment_likes`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `check_like_dislike`
	CHECK (NOT (`like` = 1 AND `dislike` = 1))
    )
ENGINE = InnoDB;

INSERT INTO `youtube`.`comment_likes` (`comment_id`, `user_id`, `like`, `like_datetime`, `dislike`, `dislike_datetime`) 
VALUES 
    (1, 1, 1, '2023-06-07 09:30:00', 0, NULL),
    (1, 2, 1, '2023-06-08 10:15:00', 0, NULL),
    (3, 3, 1, '2023-06-09 11:05:00', 0, NULL),
    (3, 4, 0, NULL, 1, '2023-06-10 12:20:00'),
    (5, 5, 0, NULL, 1, '2023-06-11 13:45:00'),
    (6, 1, 1, '2023-06-12 14:30:00', 0, NULL),
    (7, 2, 1, '2023-06-13 15:50:00', 0, NULL),
    (7, 3, 0, NULL, 1, '2023-06-14 16:25:00'),
    (9, 4, 1, '2023-06-15 17:10:00', 0, NULL),
    (10, 5, 0, NULL, 1, '2023-06-16 18:40:00');
    
CREATE TABLE IF NOT EXISTS `youtube`.`video_likes` (
  `video_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `like` TINYINT NULL,
  `like_datetime` DATE NULL DEFAULT NULL,
  `dislike` TINYINT NULL DEFAULT NULL,
  `dislike_datetime` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`video_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `video_id_video_likes`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_video_likes`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`video_likes` (`video_id`, `user_id`, `like`, `like_datetime`, `dislike`, `dislike_datetime`) 
VALUES 
    (1, 1, 1, '2023-06-17 09:30:00', 0, NULL),
    (2, 2, 0, NULL, 1, '2023-06-18 10:15:00'),
    (3, 3, 1, '2023-06-19 11:05:00', 0, NULL),
    (3, 4, 1, '2023-06-20 12:20:00', 0, NULL),
    (5, 5, 0, NULL, 1, '2023-06-21 13:45:00'),
    (5, 1, 1, '2023-06-22 14:30:00', 0, NULL),
    (7, 2, 1, '2023-06-23 15:50:00', 0, NULL),
    (8, 3, 0, NULL, 1, '2023-06-24 16:25:00'),
    (9, 4, 1, '2023-06-25 17:10:00', 0, NULL),
    (9, 5, 0, NULL, 1, '2023-06-26 18:40:00');

CREATE TABLE IF NOT EXISTS `youtube`.`channels` (
  `channel_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `date_created` DATE NOT NULL,
  PRIMARY KEY (`channel_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id_channels`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`channels` (`channel_id`, `user_id`, `name`, `description`, `date_created`) 
VALUES 
    (DEFAULT, 1, 'Channel 1', 'Description for Channel 1', '2023-06-07'),
    (DEFAULT, 2, 'Channel 2', 'Description for Channel 2', '2023-06-08'),
    (DEFAULT, 3, 'Channel 3', 'Description for Channel 3', '2023-06-09'),
    (DEFAULT, 4, 'Channel 4', 'Description for Channel 4', '2023-06-10'),
    (DEFAULT, 5, 'Channel 5', 'Description for Channel 5', '2023-06-11');
    
CREATE TABLE IF NOT EXISTS `youtube`.`channel_subscriptions` (
  `channel_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`channel_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `channel_id_channel_subscriptions`
    FOREIGN KEY (`channel_id`)
    REFERENCES `youtube`.`channels` (`channel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id_channel_subscriptions`
    FOREIGN KEY (`user_id`)
    REFERENCES `youtube`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `youtube`.`channel_subscriptions` (`channel_id`, `user_id`) 
VALUES 
    (1, 1), (1, 2),
    (2, 2), (2, 3),
    (3, 3), (3, 4),
    (4, 4), (4, 5),
    (5, 5), (5, 1);