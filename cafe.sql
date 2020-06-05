DROP DATABASE IF EXISTS `cafe`;
CREATE DATABASE `cafe`;
USE `cafe`;

DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `pesel number` varchar (11) UNIQUE,
  `name` varchar (25) NOT NULL,
  `surname` varchar (25) NOT NULL,
  `sex` enum ('M', 'F') NOT NULL,
  `birth date` date NOT NULL,
  `city of residence` varchar (35) NOT NULL,
  `street address` varchar (40) NOT NULL,
  `apartment number` varchar (5) NOT NULL,
  `phone number` varchar (12) NOT NULL
);

DROP TABLE IF EXISTS `Employment`;
CREATE TABLE `Employment` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `job` enum ('manager', 'cook', 'waiter') NOT NULL,
  `hourly wage` decimal (5, 2) NOT NULL,
  `date of employment` date NOT NULL,
  `estate id` int NOT NULL
);

DROP TABLE IF EXISTS `Estate`;
CREATE TABLE `Estate` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `manager` int NOT NULL UNIQUE,
  `city` varchar (35) NOT NULL,
  `street address` varchar (40) NOT NULL,
  `postcode` varchar (6) NOT NULL,
  `phone number` varchar (12) NOT NULL
);

DROP TABLE IF EXISTS `Reservation`;
CREATE TABLE `Reservation` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `reservation start` timestamp NOT NULL,
  `reservation finished` boolean NOT NULL DEFAULT false,
  `table id` int NOT NULL
);

DROP TABLE IF EXISTS `Table`;
CREATE TABLE `Table` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `spots number` int NOT NULL,
  `estate id` int NOT NULL
);

DROP TABLE IF EXISTS `Settlement`;
CREATE TABLE `Settlement` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `employment id` int NOT NULL,
  `shift start` timestamp NOT NULL,
  `shift end` timestamp NOT NULL
);

DROP TABLE IF EXISTS `Bill`;
CREATE TABLE `Bill` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `purchase type` enum ('at location', 'takeaway') NOT NULL DEFAULT "at location",
  `payment method` enum ('cash', 'card') NOT NULL,
  `purchase time` timestamp NOT NULL
);

DROP TABLE IF EXISTS `Bill order`;
CREATE TABLE `Bill order` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `bill id` int NOT NULL,
  `menu item id` int NOT NULL,
  `quantity` int NOT NULL
);

DROP TABLE IF EXISTS `Menu`;
CREATE TABLE `Menu` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `name` varchar (25) NOT NULL,
  `category` enum ('drink', 'appetizer', 'dessert') NOT NULL,
  `diet type` enum ('vegan', 'keto') NOT NULL,
  `price` decimal (5, 2) NOT NULL,
  `available` boolean NOT NULL DEFAULT true
);

DROP TABLE IF EXISTS `Ingredients list`;
CREATE TABLE `Ingredients list` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `menu item id` int NOT NULL,
  `ingredient id` int NOT NULL
);

DROP TABLE IF EXISTS `Ingredient`;
CREATE TABLE `Ingredient` (
  `id` int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
  `name` varchar (25) NOT NULL
);

ALTER TABLE `Employment`
	ADD FOREIGN KEY (`id`) REFERENCES `Employee` (`id`),
	ADD FOREIGN KEY (`estate id`) REFERENCES `Estate` (`id`);

ALTER TABLE `Estate`
	ADD FOREIGN KEY (`manager`) REFERENCES `Employee` (`id`);

ALTER TABLE `Reservation`
	ADD FOREIGN KEY (`table id`) REFERENCES `Table` (`id`);

ALTER TABLE `Table`
	ADD FOREIGN KEY (`estate id`) REFERENCES `Estate` (`id`);

ALTER TABLE `Settlement`
	ADD FOREIGN KEY (`employment id`) REFERENCES `Employment` (`id`);

ALTER TABLE `Bill order`
	ADD FOREIGN KEY (`bill id`) REFERENCES `Bill` (`id`),
	ADD FOREIGN KEY (`menu item id`) REFERENCES `Menu` (`id`);

ALTER TABLE `Ingredients list`
	ADD FOREIGN KEY (`menu item id`) REFERENCES `Menu` (`id`),
	ADD FOREIGN KEY (`ingredient id`) REFERENCES `Ingredient` (`id`);
