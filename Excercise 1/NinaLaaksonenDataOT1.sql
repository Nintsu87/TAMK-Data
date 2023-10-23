-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `company` DEFAULT CHARACTER SET utf8 ;
USE `company` ;

-- -----------------------------------------------------
-- Table `company`.`drone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`drone` ;

CREATE TABLE IF NOT EXISTS `company`.`drone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(16) NULL,
  `make` VARCHAR(16) NULL,
  `model` VARCHAR(16) NULL,
  `info` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`user` ;

CREATE TABLE IF NOT EXISTS `company`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `token` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `token_UNIQUE` (`token` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`drone_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`drone_log` ;

CREATE TABLE IF NOT EXISTS `company`.`drone_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `drone_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  `status` VARCHAR(45) NULL COMMENT 'cancel/done/upcoming/repair',
  `details` VARCHAR(200) NULL COMMENT 'Insident detail / difficulties to use / something not working as should / what was repaired',
  INDEX `fk_drone_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_drone_has_user_drone_idx` (`drone_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_drone_has_user_drone`
    FOREIGN KEY (`drone_id`)
    REFERENCES `company`.`drone` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drone_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `company`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`.`picture_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`picture_log` ;

CREATE TABLE IF NOT EXISTS `company`.`picture_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `drone_log_id` INT NOT NULL,
  `picture` VARCHAR(256) NULL,
  `analysis` LONGTEXT NULL,
  `lat` DECIMAL(10,6) NULL,
  `lon` DECIMAL(10,6) NULL,
  `timestamp` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_picture_log_drone_log1_idx` (`drone_log_id` ASC) VISIBLE,
  CONSTRAINT `fk_picture_log_drone_log1`
    FOREIGN KEY (`drone_log_id`)
    REFERENCES `company`.`drone_log` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO user (fname, lname, username, password, token) 
VALUES ('Joku', 'Lentäjä', 'Lentsu', 'script-koodi-1', 'Fb4XCKJhv9s7zRHU');
INSERT INTO user (fname, lname, username, password, token) 
VALUES ('Jaana', 'Ropelli', 'Jaana85', 'script-koodi-2', 'tpGuIUmwLP5khAcn');
INSERT INTO user (fname, lname, username, password, token) 
VALUES ('Niilo', 'Kiitorata', 'Kiitis', 'script-koodi-3', '39X7AkiZ82DO81RE');
INSERT INTO user (fname, lname, username, password, token) 
VALUES ('Kalle', 'Huoltaja', 'Kahu', 'script-koodi-4', 'xiSZo6tML6Wkusgu');
INSERT INTO user (fname, lname, username, password, token) 
VALUES ('Ansa', 'Asentaja', 'Asa', 'script-koodi-5', 'L87C3UgbIjk8yTFT');

INSERT INTO drone (name, make, model, info) 
VALUES ('Liitelijä', 'Samsung', 'A-8-joku', NULL);
INSERT INTO drone (name, make, model, info) 
VALUES ('Veteraani', 'Nokia', 'B-2001', NULL);
INSERT INTO drone (name, make, model, info) 
VALUES ('Jekuttaja', 'Xiomi', 'A-B-C', 'HUOM! Jos kääntö vasemmalle ei toimi, ohjaa oikealle 3 kertaa nopeasti niin alkaa toimiin');
INSERT INTO drone (name, make, model, info) 
VALUES ('Tankki', 'Erikson', 'MAX-123', NULL);
INSERT INTO drone (name, make, model, info) 
VALUES ('Kiitäjä', 'Saab', 'DghG 10', NULL);

INSERT INTO drone_log (drone_id, user_id, start_time, end_time, status) 
VALUES (1, 2, '2023-11-23 12:00:00', '2023-11-23 13:00:00', 'upcoming');
INSERT INTO drone_log (drone_id, user_id, start_time, end_time, status) 
VALUES (1, 2, '2023-11-24 12:00:00', '2023-11-24 13:00:00', 'canceled by Kiit-is');
INSERT INTO drone_log (drone_id, user_id, start_time, end_time, status) 
VALUES (4, 1, '2023-10-23 08:00:00', '2023-10-23 12:00:00', 'ongoing');
INSERT INTO drone_log (drone_id, user_id, start_time, end_time, status) 
VALUES (2, 2, '2023-10-22 08:00:00', '2023-10-22 12:00:00', 'done');
INSERT INTO drone_log (drone_id, user_id, start_time, end_time, status) 
VALUES (5, 5, '2023-10-21 08:00:00', '2023-10-21 12:00:00', 'repair');

INSERT INTO picture_log (drone_log_id, picture, analysis, lat, lon, timestamp) 
VALUES (3, '/pictures/2/1', 'very many cars here and there', 61.497860, 23.759630, '2023-10-23 09:42:27');
INSERT INTO picture_log (drone_log_id, picture, analysis, lat, lon, timestamp) 
VALUES (3, '/pictures/2/2', 'very many cars here and there and trees also', 61.478260, 23.511009, '2023-10-23 09:50:25');
INSERT INTO picture_log (drone_log_id, picture, analysis, lat, lon, timestamp) 
VALUES (3, '/pictures/2/3', 'very many cars here and there and trees also', 61.46125, 23.63228, '2023-10-23 10:12:20');
INSERT INTO picture_log (drone_log_id, picture, analysis, lat, lon, timestamp) 
VALUES (3, '/pictures/2/4', 'very many cars here and there and trees also and few cows', 61.469212, 24.039923, '2023-10-23 10:34:00');
INSERT INTO picture_log (drone_log_id, picture, analysis, lat, lon, timestamp) 
VALUES (3, '/pictures/2/5', 'Trees and some animals', 62.310810, 26.641310, '2023-10-23 10:42:27');

CREATE OR REPLACE VIEW free_drones AS
SELECT DISTINCT d.name AS 'Vapaat dronet' FROM drone d 
INNER JOIN drone_log dl
ON d.id = dl.drone_id
WHERE NOW() 
NOT BETWEEN dl.start_time AND dl.end_time 
AND dl.status != 'cancel';

CREATE OR REPLACE VIEW future_drone_appointments AS 
SELECT CONCAT(u.fname, ' ', u.lname) AS 'Käyttäjä', d.name AS 'Drone', dl.start_time AS 'Varauksen alkuaika'
FROM user u
INNER JOIN drone_log dl
ON dl.drone_id = u.id 
INNER JOIN drone d
ON dl.user_id = d.id
WHERE dl.end_time > NOW() AND dl.status != 'cancel';

CREATE OR REPLACE VIEW drone_pics_and_users AS
SELECT d.name, p.picture, CONCAT(u.fname, ' ', u.lname) AS 'Käyttäjä'
FROM drone d
INNER JOIN drone_log dl
ON d.id = dl.drone_id
INNER JOIN picture_log p
ON dl.id = p.drone_log_id
INNER JOIN user u
ON dl.user_id = u.id
WHERE d.id = 4;

CREATE OR REPLACE VIEW pic_details AS
SELECT d.name AS 'Drone', p.analysis AS 'Analyysi', CONCAT(u.fname, ' ', u.lname) AS 'Käyttäjä', p.timestamp AS 'Ajankohta', CONCAT('Lat: ', p.lat, ' Lon: ', p.lon) AS 'Paikka'
FROM drone d
INNER JOIN drone_log dl
ON d.id = dl.drone_id
INNER JOIN picture_log p
ON dl.id = p.drone_log_id
INNER JOIN user u
ON dl.user_id = u.id;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
