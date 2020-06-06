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

INSERT INTO `Employee` (`pesel number`, `name`, `surname`, `sex`, `birth date`, `city of residence`, `street address`, `apartment number`, `phone number`)
	VALUES
		(85050502348, 'Wiktoria', 'Przybylska', 'F', '1985-05-05', 'Lublin', 'Lipowa 10', '8', '+48792557494'),
		(91070680414, 'Krystian', 'Jaworski', 'M', '1991-07-06', 'Lublin', '3 Maja 33', '14', '+48505375408'),
		(81070145477, 'Michał', 'Witkowski', 'M', '1981-07-01', 'Świdnik', 'Racławicka 13', '19', '+48506620062'),
		(93102524026, 'Oliwia', 'Wójtowicz', 'F', '1993-10-25', 'Lublin', 'Strzelecka 23', '14b', '+48737519089'),
		(99040787129, 'Weronika', 'Wilk', 'F', '1999-04-07', 'Lublin', 'Łęczyńska 17', '24', '+48782737439'),
		(98061712769, 'Anna', 'Marciniak', 'F', '1998-06-17', 'Lublin', 'Lotnicza 5', '2', '+48697992577'),
		(96102721091, 'Wiktor', 'Barański', 'M', '1996-10-27', 'Warszawa', 'Pilicka 4', '12', '+48502075833'),
		(97011996473, 'Stanisław', 'Pietrzak', 'M', '1997-01-19', 'Warszawa', 'Królowej Aldony 18', '25', '+48729851383'),
		(91082939593, 'Hubert', 'Sawicki', 'M', '1991-08-29', 'Warszawa', 'Krypska 15', '1', '+48533825461'),
		(97122622656, 'Wojciech', 'Dudek', 'M', '1997-12-26', 'Kraków', 'Stefana Garczyńskiego 19', '10', '+48509840582'),
		(97090968493, 'Szymon', 'Jarosz', 'M', '1997-09-09', 'Kraków', 'Murarska 22', '11', '+48507984706'),
		(88050170722, 'Hanna', 'Wiśniewska', 'F', '1988-05-01', 'Kraków', 'Widna 24', '13', '+48792169523'),
		(86042432669, 'Aleksandra', 'Stankiewicz', 'F', '1986-04-24', 'Poznań', 'Barzyńskiego 16', '23', '+48501029363'),
		(84072787870, 'Tadeusz', 'Ostrowski', 'M', '1984-07-27', 'Poznań', 'Podgórze 10', '23b', '+48600806538'),
		(85112613733, 'Stanisław', 'Nowak', 'M', '1985-11-26', 'Poznań', 'Nowogrodzka 4', '7a', '+48885074505'),
		(87042059720, 'Maria', 'Wesołowska', 'F', '1987-04-20', 'Kraków', 'Bagrowa 29', '23', '+48733139605'),
		(99110139100, 'Zofia', 'Michalik', 'F', '1999-11-01', 'Kraków', 'Gołaśka 10', '23', '+48789070572'),
		(92010527103, 'Natalia', 'Woźniak', 'F', '1992-01-05', 'Kraków', 'Słupska 26', '16', '+48666930158'),
		(92063021942, 'Małgorzata', 'Górska', 'F', '1992-06-30', 'Gdańsk', 'Sochaczewska 16', '25', '+48791610857'),
		(92030189220, 'Zuzanna', 'Mazur', 'F', '1992-03-01', 'Gdynia', 'Kapitańska 2', '9c', '+48694377631'),
		(96102353100, 'Dominika', 'Mazurek', 'F', '1996-10-23', 'Gdańsk', 'Michała Glinki 35', '8', '+48883050649'),
		(97122048331, 'Oliwier', 'Karpiński', 'M', '1997-12-20', 'Warszawa', 'Wytworna 35', '7', '+48725551266'),
		(90101208447, 'Patrycja', 'Malinowska', 'F', '1990-10-12', 'Warszawa', 'Kurhan 8', '5', '+48797764730'),
		(87040176959, 'Maciej', 'Żak', 'M', '1987-04-01', 'Warszawa', 'Głubczycka 6', '20', '+48666079458'),
		(86021901579, 'Kacper', 'Kamiński', 'M', '1986-02-19', 'Warszawa', 'Antoniego Ponikowskiego 4', '2', '+48883113942'),
		(93061564259, 'Jan', 'Czerwiński', 'M', '1993-06-15', 'Warszawa', 'Goworowska 6', '13', '+48608724642'),
		(86051912385, 'Zuzanna', 'Makowska', 'F', '1986-05-19', 'Warszawa', 'Adolfa Dygasińskiego 20', '12', '+48696399861'),
		(88073183101, 'Julia', 'Bukowska', 'F', '1988-07-31', 'Gdynia', 'Wacława Sieroszewskiego 24', '14', '+48606093341'),
		(89061247076, 'Michał', 'Piasecki', 'M', '1989-06-12', 'Gdańsk', 'Józefa Kotarbińskiego 6', '1', '+48604677643'),
		(99090157905, 'Gabriela', 'Jaworska', 'F', '1999-09-01', 'Gdańsk', 'Strajku Dokerów 27', '14', '+48667857396');

INSERT INTO `Estate` (`manager`, `city`, `street address`, `postcode`, `phone number`)
	VALUES
		(1, 'Lublin', 'Idziego Radziszewskiego 16', '20-031', '+48707026624'),
		(4, 'Lublin', 'Krakowskie Przedmieście 4', '20-002', '+48698253087'),
		(7, 'Warszawa', 'plac Thomasa Woodrowa Wilsona 2', '01-615', '+48764230974'),
		(10, 'Kraków', 'plac Szczepański 2', '31-011', '+48750945082'),
		(13, 'Poznań', 'Krysiewicza 6', '61-825', '+48936501845'),
		(16, 'Kraków', 'Rakowicka 17', '31-511', '+48942375933'),
		(19, 'Gdańsk', 'Szafarnia 6', '80-755', '+48572405435'),
		(22, 'Warszawa', 'Żelazna 32', '00-832', '+48567249614'),
		(25, 'Warszawa', 'aleja Wyzwolenia 18', '00-570', '+48593647246'),
		(28, 'Sopot', 'Powstańców Warszawy 10', '81-718', '+48924724073');

INSERT INTO `Employment` (`job`, `hourly wage`, `date of employment`, `estate id`)
	VALUES
		('manager', 51, '2015-02-02', 1),
		('cook', 27, '2016-04-19', 1),
		('waiter', 11, '2016-10-03', 1),
		('manager', 51, '2017-10-10', 2),
		('cook', 31, '2017-04-12', 2),
		('waiter', 12, '2016-07-27', 2),
		('manager', 52, '2017-03-10', 3),
		('cook', 28, '2016-12-12', 3),
		('waiter', 14, '2016-03-08', 3),
		('manager', 51, '2015-09-05', 4),
		('cook', 30, '2016-07-14', 4),
		('waiter', 12, '2016-11-24', 4),
		('manager', 54, '2017-07-25', 5),
		('cook', 26, '2015-11-08', 5),
		('waiter', 11, '2015-08-30', 5),
		('manager', 50, '2017-06-29', 6),
		('cook', 32, '2015-01-06', 6),
		('waiter', 14, '2017-10-27', 6),
		('manager', 54, '2015-09-12', 7),
		('cook', 33, '2016-03-30', 7),
		('waiter', 17, '2016-03-28', 7),
		('manager', 56, '2016-06-14', 8),
		('cook', 33, '2015-09-20', 8),
		('waiter', 18, '2017-04-28', 8),
		('manager', 55, '2016-11-28', 9),
		('cook', 25, '2015-08-11', 9),
		('waiter', 10, '2016-09-17', 9),
		('manager', 57, '2017-05-18', 10),
		('cook', 26, '2016-04-20', 10),
		('waiter', 14, '2017-01-06', 10);

INSERT INTO `Settlement` (`employment id`, `shift start`, `shift end`)
	VALUES
		(1, '2020-05-06 07:43:10', '2020-05-06 16:15:46'),
        (1, '2020-06-05 07:46:02', '2020-06-05 16:11:14'),
        (2, '2020-05-06 08:46:22', '2020-05-06 18:10:36'),
        (2, '2020-05-06 08:45:49', '2020-05-06 18:10:57'),
        (3, '2020-06-08 08:50:20', '2020-06-08 18:17:40'),
        (3, '2020-05-11 08:45:41', '2020-05-11 18:17:45'),
        (4, '2020-05-10 07:48:32', '2020-05-10 16:13:44'),
        (4, '2020-05-07 07:45:59', '2020-05-07 16:17:43'),
        (5, '2020-06-07 08:46:07', '2020-06-07 18:10:55'),
        (5, '2020-06-05 08:46:06', '2020-06-05 18:11:44'),
        (6, '2020-06-09 08:46:55', '2020-06-09 18:14:29'),
        (6, '2020-05-05 08:44:57', '2020-05-05 18:16:17'),
        (7, '2020-06-06 07:43:08', '2020-06-06 16:18:10'),
        (7, '2020-05-01 07:43:09', '2020-05-01 16:18:01'),
        (8, '2020-05-06 08:43:51', '2020-05-06 18:11:39'),
        (8, '2020-06-01 08:43:32', '2020-06-01 18:11:09'),
        (9, '2020-05-09 08:48:12', '2020-05-09 18:13:21'),
        (9, '2020-05-13 08:48:22', '2020-05-13 18:17:41'),
        (10, '2020-05-09 07:47:22', '2020-05-09 16:10:09'),
        (10, '2020-05-10 07:42:45', '2020-05-10 16:17:16'),
        (11, '2020-05-08 08:49:21', '2020-05-08 18:16:47'),
        (11, '2020-05-12 08:45:11', '2020-05-12 18:14:55'),
        (12, '2020-06-02 08:42:10', '2020-06-02 18:12:24'),
        (12, '2020-05-03 08:49:10', '2020-05-03 18:12:30'),
        (13, '2020-05-10 07:48:55', '2020-05-10 16:12:43'),
        (13, '2020-06-05 07:48:29', '2020-06-05 16:12:24'),
        (14, '2020-06-06 08:43:14', '2020-06-06 18:16:30'),
        (14, '2020-06-02 08:50:47', '2020-06-02 18:10:27'),
        (15, '2020-05-08 08:46:13', '2020-05-08 18:15:23'),
        (15, '2020-05-03 08:50:01', '2020-05-03 18:15:30'),
        (16, '2020-06-11 07:42:09', '2020-06-11 16:13:31'),
        (16, '2020-06-13 07:49:02', '2020-06-13 16:14:28'),
        (17, '2020-06-13 08:48:25', '2020-06-13 18:16:20'),
        (17, '2020-06-08 08:48:14', '2020-06-08 18:12:26'),
        (18, '2020-05-08 08:46:30', '2020-05-08 18:10:48'),
        (18, '2020-06-08 08:45:54', '2020-06-08 18:15:46'),
        (19, '2020-06-13 07:43:55', '2020-06-13 16:10:46'),
        (19, '2020-06-13 07:43:05', '2020-06-13 16:12:13'),
        (20, '2020-06-03 08:49:04', '2020-06-03 18:10:03'),
        (20, '2020-06-01 08:44:05', '2020-06-01 18:10:12'),
        (21, '2020-06-01 08:42:01', '2020-06-01 18:16:56'),
        (21, '2020-05-01 08:45:49', '2020-05-01 18:13:33'),
        (22, '2020-05-05 07:47:21', '2020-05-05 16:10:23'),
        (22, '2020-05-02 07:47:35', '2020-05-02 16:14:59'),
        (23, '2020-05-08 08:45:41', '2020-05-08 18:14:52'),
        (23, '2020-05-10 08:49:54', '2020-05-10 18:12:47'),
        (24, '2020-05-11 08:48:51', '2020-05-11 18:16:55'),
        (24, '2020-06-01 08:43:27', '2020-06-01 18:12:53'),
        (25, '2020-06-04 07:50:42', '2020-06-04 16:11:29'),
        (25, '2020-05-13 07:46:54', '2020-05-13 16:13:01'),
        (26, '2020-05-10 08:50:03', '2020-05-10 18:17:07'),
        (26, '2020-06-02 08:47:28', '2020-06-02 18:17:07'),
        (27, '2020-06-13 08:47:01', '2020-06-13 18:14:07'),
        (27, '2020-06-10 08:42:02', '2020-06-10 18:12:30'),
        (28, '2020-06-11 07:42:50', '2020-06-11 16:13:57'),
        (28, '2020-05-01 07:50:05', '2020-05-01 16:15:25'),
        (29, '2020-05-04 08:42:13', '2020-05-04 18:18:18'),
        (29, '2020-05-08 08:43:32', '2020-05-08 18:18:07'),
        (30, '2020-05-03 08:48:14', '2020-05-03 18:10:48'),
        (30, '2020-05-11 08:48:52', '2020-05-11 18:13:07');

INSERT INTO `Table` (`spots number`, `estate id`)
	VALUES
		(2, 1),
		(3, 1),
		(4, 1),
		(2, 2),
		(3, 2),
		(4, 2),
		(2, 3),
		(3, 3),
		(4, 3),
		(2, 4),
		(3, 4),
		(4, 4),
		(2, 5),
		(3, 5),
		(4, 5),
		(2, 6),
		(3, 6),
		(4, 6),
		(2, 7),
		(3, 7),
		(4, 7),
		(2, 8),
		(3, 8),
		(4, 8),
		(2, 9),
		(3, 9),
		(4, 9),
		(2, 10),
		(3, 10),
		(4, 10);

INSERT INTO `Reservation` (`reservation start`, `reservation finished`, `table id`)
	VALUES
		('2020-06-04 13:00:00', true, 3),
		('2020-06-12 12:00:00', true, 1),
		('2020-06-11 10:00:00', true, 8),
		('2020-05-06 11:30:00', true, 5),
		('2020-05-12 13:00:00', true, 2),
		('2020-05-11 12:30:00', true, 4),
		('2020-05-04 15:00:00', true, 6),
		('2020-05-03 10:00:00', true, 2),
		('2020-05-08 12:00:00', true, 4),
		('2020-05-04 10:30:00', true, 2),
		('2020-05-13 15:00:00', true, 7),
		('2020-06-08 11:30:00', true, 2),
		('2020-06-05 12:00:00', true, 4),
		('2020-05-13 10:30:00', true, 10),
		('2020-06-07 13:30:00', true, 10),
		('2020-06-13 10:00:00', true, 2),
		('2020-05-07 13:00:00', true, 4),
		('2020-06-07 11:00:00', true, 4),
		('2020-06-08 14:00:00', true, 1),
		('2020-06-12 15:00:00', true, 10),
		('2020-06-07 13:30:00', true, 3),
		('2020-05-11 14:00:00', true, 5),
		('2020-06-07 11:00:00', true, 3),
		('2020-06-13 12:30:00', true, 1),
		('2020-05-04 15:00:00', true, 7),
		('2020-05-01 13:00:00', true, 6),
		('2020-06-07 10:00:00', true, 1),
		('2020-06-04 11:30:00', true, 1),
		('2020-06-12 14:00:00', true, 9),
		('2020-06-03 10:30:00', true, 2);

INSERT INTO `Menu` (`name`, `category`, `price`, `available`)
	VALUES
		('Latte', 1, 11.40),
		('Americano', 1, 11.40),
		('Cappuccino', 1, 14.40),
		('Frappe', 1, 14.40),
		('Espresso', 1, 14.40),
		('Sałatka grecka', 2, 24.20),
		('Sałatka nicejska', 2, 24.20),
		('Sałatka Cezar', 2, 26.20),
		('Sałatka Caprese', 2, 26.20),
		('Sałatka Coleslaw', 2, 22.20),
		('Tiramisu', 3, 16.90),
		('Panna Cotta', 3, 16.90),
		('Crème brûlée', 3, 22.90),
		('Poire belle Hélène', 3, 24.90),
		('Pastéis de Belém', 3, 24.90);

INSERT INTO `Ingredient` (`name`)
	VALUES
		('nabiał'),
		('gluten'),
        ('mięso');

INSERT INTO `Ingredients list` (`menu item id`, `ingredient id`)
	VALUES
		(1, 1),
		(2, 1),
		(3, 1),
		(4, 1),
		(6, 1),
		(7, 1),
		(7, 2),
		(8, 1),
		(8, 2),
		(8, 3),
		(9, 1),
		(10, 1),
		(10, 2),
		(11, 1),
		(11, 2),
		(12, 1),
		(13, 1),
		(14, 2),
		(15, 2);