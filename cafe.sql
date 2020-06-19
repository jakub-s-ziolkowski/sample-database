DROP DATABASE IF EXISTS `cafe`; # Usunięcie istniejącej bazy danych
CREATE DATABASE `cafe`; # Utworzenie nowej bazy danych

USE `cafe`; # Wybranie interesującej nas bazy, umożliwi to wykonywanie na niej wszelkich operacji

# Tworzenie tabel

DROP TABLE IF EXISTS `Employee`; # Usunięcie istniejącej tabeli
CREATE TABLE `Employee` ( # Utworzenie nowej tabeli
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

# Tworzenie relacji

ALTER TABLE
	`Employment`
		ADD FOREIGN KEY (`id`)
			REFERENCES `Employee` (`id`),
		ADD FOREIGN KEY (`estate id`)
			REFERENCES `Estate` (`id`);

ALTER TABLE
	`Estate`
		ADD FOREIGN KEY (`manager`)
			REFERENCES `Employee` (`id`);

ALTER TABLE
	`Reservation`
		ADD FOREIGN KEY (`table id`)
			REFERENCES `Table` (`id`);

ALTER TABLE
	`Table`
		ADD FOREIGN KEY (`estate id`)
			REFERENCES `Estate` (`id`);

ALTER TABLE
	`Settlement`
		ADD FOREIGN KEY (`employment id`)
			REFERENCES `Employment` (`id`);

ALTER TABLE
	`Bill order`
		ADD FOREIGN KEY (`bill id`)
			REFERENCES `Bill` (`id`),
		ADD FOREIGN KEY (`menu item id`)
			REFERENCES `Menu` (`id`);

ALTER TABLE
	`Ingredients list`
		ADD FOREIGN KEY (`menu item id`)
			REFERENCES `Menu` (`id`),
		ADD FOREIGN KEY (`ingredient id`)
			REFERENCES `Ingredient` (`id`);

# Dodawanie rekordów

INSERT INTO
	`Employee` (`pesel number`, `name`, `surname`, `sex`, `birth date`, `city of residence`, `street address`, `apartment number`, `phone number`)
		VALUES
			(99110139100, 'Zofia', 'Michalik', 'F', '1999-11-01', 'Kraków', 'Gołaśka 10', '23', '+48789070572'),
			(85050502348, 'Wiktoria', 'Przybylska', 'F', '1985-05-05', 'Lublin', 'Lipowa 10', '8', '+48792557494'),
			(93061564259, 'Jan', 'Czerwiński', 'M', '1993-06-15', 'Warszawa', 'Goworowska 6', '13', '+48608724642'),
			(85112613733, 'Stanisław', 'Nowak', 'M', '1985-11-26', 'Poznań', 'Nowogrodzka 4', '7a', '+48885074505'),
			(97122622656, 'Wojciech', 'Dudek', 'M', '1997-12-26', 'Kraków', 'Stefana Garczyńskiego 19', '10', '+48509840582'),
			(92063021942, 'Małgorzata', 'Górska', 'F', '1992-06-30', 'Gdańsk', 'Sochaczewska 16', '25', '+48791610857'),
			(90101208447, 'Patrycja', 'Malinowska', 'F', '1990-10-12', 'Warszawa', 'Kurhan 8', '5', '+48797764730'),
			(84072787870, 'Tadeusz', 'Ostrowski', 'M', '1984-07-27', 'Poznań', 'Podgórze 10', '23b', '+48600806538'),

			(96102353100, 'Dominika', 'Mazurek', 'F', '1996-10-23', 'Gdańsk', 'Michała Glinki 35', '8', '+48883050649'),
			(92030189220, 'Zuzanna', 'Mazur', 'F', '1992-03-01', 'Gdynia', 'Kapitańska 2', '9c', '+48694377631'),
			(91082939593, 'Hubert', 'Sawicki', 'M', '1991-08-29', 'Warszawa', 'Krypska 15', '1', '+48533825461'),
			(91070680414, 'Krystian', 'Jaworski', 'M', '1991-07-06', 'Lublin', '3 Maja 33', '14', '+48505375408'),
			(89061247076, 'Michał', 'Piasecki', 'M', '1989-06-12', 'Gdańsk', 'Józefa Kotarbińskiego 6', '1', '+48604677643'),
			(97122048331, 'Oliwier', 'Karpiński', 'M', '1997-12-20', 'Warszawa', 'Wytworna 35', '7', '+48725551266'),
			(97090968493, 'Szymon', 'Jarosz', 'M', '1997-09-09', 'Kraków', 'Murarska 22', '11', '+48507984706'),
			(98061712769, 'Anna', 'Marciniak', 'F', '1998-06-17', 'Lublin', 'Lotnicza 5', '2', '+48697992577'),
			(86051912385, 'Zuzanna', 'Makowska', 'F', '1986-05-19', 'Warszawa', 'Adolfa Dygasińskiego 20', '12', '+48696399861'),
			(81070145477, 'Michał', 'Witkowski', 'M', '1981-07-01', 'Świdnik', 'Racławicka 13', '19', '+48506620062'),
			(88050170722, 'Hanna', 'Wiśniewska', 'F', '1988-05-01', 'Kraków', 'Widna 24', '13', '+48792169523'),
			(86021901579, 'Kacper', 'Kamiński', 'M', '1986-02-19', 'Warszawa', 'Antoniego Ponikowskiego 4', '2', '+48883113942'),
			(97011996473, 'Stanisław', 'Pietrzak', 'M', '1997-01-19', 'Warszawa', 'Królowej Aldony 18', '25', '+48729851383'),

			(99090157905, 'Gabriela', 'Jaworska', 'F', '1999-09-01', 'Gdańsk', 'Strajku Dokerów 27', '14', '+48667857396'),
			(96102721091, 'Wiktor', 'Barański', 'M', '1996-10-27', 'Warszawa', 'Pilicka 4', '12', '+48502075833'),
			(99040787129, 'Weronika', 'Wilk', 'F', '1999-04-07', 'Lublin', 'Łęczyńska 17', '24', '+48782737439'),
			(87040176959, 'Maciej', 'Żak', 'M', '1987-04-01', 'Warszawa', 'Głubczycka 6', '20', '+48666079458'),
			(88073183101, 'Julia', 'Bukowska', 'F', '1988-07-31', 'Gdynia', 'Wacława Sieroszewskiego 24', '14', '+48606093341'),
			(87042059720, 'Maria', 'Wesołowska', 'F', '1987-04-20', 'Kraków', 'Bagrowa 29', '23', '+48733139605'),
			(86042432669, 'Aleksandra', 'Stankiewicz', 'F', '1986-04-24', 'Poznań', 'Barzyńskiego 16', '23', '+48501029363'),
			(93102524026, 'Oliwia', 'Wójtowicz', 'F', '1993-10-25', 'Lublin', 'Strzelecka 23', '14b', '+48737519089'),
			(92010527103, 'Natalia', 'Woźniak', 'F', '1992-01-05', 'Kraków', 'Słupska 26', '16', '+48666930158');

INSERT INTO
	`Estate` (`manager`, `city`, `street address`, `postcode`, `phone number`)
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

INSERT INTO
	`Employment` (`job`, `hourly wage`, `date of employment`, `estate id`)
		VALUES
			('cook', 32, '2015-01-06', 6),
			('manager', 51, '2015-02-02', 1),
			('cook', 25, '2015-08-11', 9),
			('waiter', 11, '2015-08-30', 5),
			('manager', 51, '2015-09-05', 4),
			('manager', 54, '2015-09-12', 7),
			('cook', 33, '2015-09-20', 8),
			('cook', 26, '2015-11-08', 5),

			('waiter', 17, '2016-03-28', 7),
			('cook', 33, '2016-03-30', 7),
			('waiter', 14, '2016-03-08', 3),
			('cook', 27, '2016-04-19', 1),
			('cook', 26, '2016-04-20', 10),
			('manager', 56, '2016-06-14', 8),
			('cook', 30, '2016-07-14', 4),
			('waiter', 12, '2016-07-27', 2),
			('waiter', 10, '2016-09-17', 9),
			('waiter', 11, '2016-10-03', 1),
			('waiter', 12, '2016-11-24', 4),
			('manager', 55, '2016-11-28', 9),
			('cook', 28, '2016-12-12', 3),

			('waiter', 14, '2017-01-06', 10),
			('manager', 52, '2017-03-10', 3),
			('cook', 31, '2017-04-12', 2),
			('waiter', 18, '2017-04-28', 8),
			('manager', 57, '2017-05-18', 10),
			('manager', 50, '2017-06-29', 6),
			('manager', 54, '2017-07-25', 5),
			('manager', 51, '2017-10-10', 2),
			('waiter', 14, '2017-10-27', 6);

INSERT INTO
	`Settlement` (`employment id`, `shift start`, `shift end`)
		VALUES
			(7, '2020-05-01 07:43:09', '2020-05-01 16:18:01'),
			(21, '2020-05-01 08:45:49', '2020-05-01 18:13:33'),
			(28, '2020-05-01 07:50:05', '2020-05-01 16:15:25'),
			(22, '2020-05-02 07:47:35', '2020-05-02 16:14:59'),
			(30, '2020-05-03 08:48:14', '2020-05-03 18:10:48'),
			(12, '2020-05-03 08:49:10', '2020-05-03 18:12:30'),
			(15, '2020-05-03 08:50:01', '2020-05-03 18:15:30'),
			(29, '2020-05-04 08:42:13', '2020-05-04 18:18:18'),
			(6, '2020-05-05 08:44:57', '2020-05-05 18:16:17'),
			(22, '2020-05-05 07:47:21', '2020-05-05 16:10:23'),
			(1, '2020-05-06 07:43:10', '2020-05-06 16:15:46'),
			(8, '2020-05-06 08:43:51', '2020-05-06 18:11:39'),
			(2, '2020-05-06 08:45:49', '2020-05-06 18:10:57'),
			(2, '2020-05-06 08:46:22', '2020-05-06 18:10:36'),
			(4, '2020-05-07 07:45:59', '2020-05-07 16:17:43'),
			(29, '2020-05-08 08:43:32', '2020-05-08 18:18:07'),
			(23, '2020-05-08 08:45:41', '2020-05-08 18:14:52'),
			(15, '2020-05-08 08:46:13', '2020-05-08 18:15:23'),
			(18, '2020-05-08 08:46:30', '2020-05-08 18:10:48'),
			(11, '2020-05-08 08:49:21', '2020-05-08 18:16:47'),
			(10, '2020-05-09 07:47:22', '2020-05-09 16:10:09'),
			(9, '2020-05-09 08:48:12', '2020-05-09 18:13:21'),

			(10, '2020-05-10 07:42:45', '2020-05-10 16:17:16'),
			(4, '2020-05-10 07:48:32', '2020-05-10 16:13:44'),
			(13, '2020-05-10 07:48:55', '2020-05-10 16:12:43'),
			(23, '2020-05-10 08:49:54', '2020-05-10 18:12:47'),
			(26, '2020-05-10 08:50:03', '2020-05-10 18:17:07'),
			(3, '2020-05-11 08:45:41', '2020-05-11 18:17:45'),
			(24, '2020-05-11 08:48:51', '2020-05-11 18:16:55'),
			(30, '2020-05-11 08:48:52', '2020-05-11 18:13:07'),
			(11, '2020-05-12 08:45:11', '2020-05-12 18:14:55'),
			(25, '2020-05-13 07:46:54', '2020-05-13 16:13:01'),
			(9, '2020-05-13 08:48:22', '2020-05-13 18:17:41'),

			(21, '2020-06-01 08:42:01', '2020-06-01 18:16:56'),
			(24, '2020-06-01 08:43:27', '2020-06-01 18:12:53'),
			(8, '2020-06-01 08:43:32', '2020-06-01 18:11:09'),
			(20, '2020-06-01 08:44:05', '2020-06-01 18:10:12'),
			(12, '2020-06-02 08:42:10', '2020-06-02 18:12:24'),
			(26, '2020-06-02 08:47:28', '2020-06-02 18:17:07'),
			(14, '2020-06-02 08:50:47', '2020-06-02 18:10:27'),
			(20, '2020-06-03 08:49:04', '2020-06-03 18:10:03'),
			(25, '2020-06-04 07:50:42', '2020-06-04 16:11:29'),
			(1, '2020-06-05 07:46:02', '2020-06-05 16:11:14'),
			(5, '2020-06-05 08:46:06', '2020-06-05 18:11:44'),
			(13, '2020-06-05 07:48:29', '2020-06-05 16:12:24'),
			(7, '2020-06-06 07:43:08', '2020-06-06 16:18:10'),
			(14, '2020-06-06 08:43:14', '2020-06-06 18:16:30'),
			(5, '2020-06-07 08:46:07', '2020-06-07 18:10:55'),
			(18, '2020-06-08 08:45:54', '2020-06-08 18:15:46'),
			(17, '2020-06-08 08:48:14', '2020-06-08 18:12:26'),
			(3, '2020-06-08 08:50:20', '2020-06-08 18:17:40'),
			(6, '2020-06-09 08:46:55', '2020-06-09 18:14:29'),

			(27, '2020-06-10 08:42:02', '2020-06-10 18:12:30'),
			(16, '2020-06-11 07:42:09', '2020-06-11 16:13:31'),
			(28, '2020-06-11 07:42:50', '2020-06-11 16:13:57'),
			(19, '2020-06-13 07:43:05', '2020-06-13 16:12:13'),
			(19, '2020-06-13 07:43:55', '2020-06-13 16:10:46'),
			(16, '2020-06-13 07:49:02', '2020-06-13 16:14:28'),
			(27, '2020-06-13 08:47:01', '2020-06-13 18:14:07'),
			(17, '2020-06-13 08:48:25', '2020-06-13 18:16:20');

INSERT INTO
	`Table` (`spots number`, `estate id`)
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

INSERT INTO
	`Reservation` (`reservation start`, `table id`)
		VALUES
			('2020-05-01 13:00:00', 6),
			('2020-05-03 10:00:00', 6),
			('2020-05-04 10:30:00', 10),
			('2020-05-04 15:00:00', 8),
			('2020-05-04 15:00:00', 4),
			('2020-05-06 11:30:00', 13),
			('2020-05-07 13:00:00', 23),
			('2020-05-08 12:00:00', 28),
			('2020-05-11 12:30:00', 29),
			('2020-05-11 14:00:00', 11),
			('2020-05-12 13:00:00', 30),
			('2020-05-13 10:30:00', 17),
			('2020-05-13 15:00:00', 22),

			('2020-06-04 11:30:00', 13),
			('2020-06-04 13:00:00', 2),
			('2020-06-05 12:00:00', 30),
			('2020-06-07 10:00:00', 12),
			('2020-06-07 11:00:00', 16),
			('2020-06-07 11:00:00', 11),
			('2020-06-07 13:00:00', 29),
			('2020-06-07 13:30:00', 22),
			('2020-06-08 11:30:00', 5),
			('2020-06-08 14:00:00', 21),
			('2020-06-11 10:00:00', 15),
			('2020-06-12 12:00:00', 1),
			('2020-06-12 14:00:00', 3),
			('2020-06-12 15:00:00', 5),
			('2020-06-13 12:30:00', 7),
			('2020-06-21 10:00:00', 10),
			('2020-06-27 16:30:00', 19);

INSERT INTO
	`Menu` (`name`, `category`, `price`)
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

INSERT INTO
	`Ingredient` (`name`)
		VALUES
			('nabiał'),
			('gluten'),
			('mięso');

INSERT INTO
	`Ingredients list` (`menu item id`, `ingredient id`)
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

INSERT INTO
	`Bill` (`purchase type`, `payment method`, `purchase time`)
		VALUES
			('at location', 'card', '2020-05-04 12:30:16'),
			('at location', 'cash', '2020-05-04 12:54:18'),
			('at location', 'cash', '2020-05-05 10:57:45'),
			('at location', 'card', '2020-05-08 12:02:10'),
			('takeaway', 'cash', '2020-05-12 10:39:18'),

			('at location', 'card', '2020-06-02 15:25:03'),
			('at location', 'card', '2020-06-03 16:17:55'),
			('at location', 'card', '2020-06-03 17:08:21'),
			('at location', 'cash', '2020-06-04 14:46:10'),
			('takeaway', 'card', '2020-06-05 11:45:03'),
			('at location', 'cash', '2020-06-05 15:23:58'),
			('takeaway', 'card', '2020-06-06 15:38:10'),
			('takeaway', 'card', '2020-06-08 11:38:45'),
			('at location', 'card', '2020-06-12 11:44:52'),
			('at location', 'cash', '2020-06-13 17:17:53');

INSERT INTO
	`Bill order` (`bill id`, `menu item id`, `quantity`)
		VALUES
			(1, 14, 2),
			(1, 15, 2),
			(2, 11, 2),
			(2, 6, 3),
			(3, 2, 1),
			(4, 1, 1),
			(5, 1, 2),
			(6, 7, 2),
			(6, 5, 2),
			(7, 13, 1),
			(8, 15, 1),
			(8, 5, 1),
			(8, 8, 1),
			(9, 8, 3),
			(10, 6, 2),
			(11, 5, 1),
			(11, 12, 1),
			(11, 8, 1),
			(11, 7, 2),
			(12, 4, 1),
			(13, 9, 1),
			(13, 14, 1),
			(14, 14, 2),
			(14, 1, 1),
			(15, 2, 1);

# Uaktualnienia danych

UPDATE # Określa niedostępność trzeciej pozycji z menu
	`Menu`
		SET `available` = false
			WHERE `id` = 3;

UPDATE # Określa niedostępność dziesiątej pozycji z menu
	`Menu`
		SET `available` = false
			WHERE `id` = 10;

SET SQL_SAFE_UPDATES = 0; # Dezaktywacja trybu bezpiecznego narzucającego konieczność odwołania się do klucza przy klauzuli "WHERE"
UPDATE # Potwierdza zakończenie rezerwacji starszych niż doba
	`Reservation`
		SET `reservation finished` = true
			WHERE  `reservation finished` = false AND `reservation start` < SUBDATE(NOW(), 1);
SET SQL_SAFE_UPDATES = 1; # Aktywacja trybu bezpiecznego

# Projekcje

SELECT # Zwraca czas rezerwacji oraz ich stan
	`reservation start`,
    `reservation finished`
		FROM `Reservation`;

SELECT # Zwraca podstawowe dane pozycji z menu wraz z jej dostępnością
	`name`,
    `category`,
    `price`,
    `available`
		FROM `Menu`;

SELECT # Zwraca dane osobowe i dane kontaktowe pracowników
	CONCAT(`name`, ' ', `surname`) AS 'employee',
    `city of residence`,
    `street address`,
    `apartment number`,
    `phone number`
		FROM `Employee`;

SELECT # Zwraca dane kontaktowe poszczególnych lokali
	`city`,
    `street address`,
    `postcode`,
    `phone number`
		FROM `Estate`;

SELECT # Zwraca średnią cenę pozycji z menu względem jej kategorii
	`category`,
	ROUND(AVG(`price`), 2) AS 'price'
		FROM `Menu`
			GROUP BY `category`
				ORDER BY `category`;

SELECT # Zwraca średnią stawkę godzinową w zależności od wykonywanego zawodu
	`job`,
    ROUND(AVG(`hourly wage`), 2) AS 'hourly wage'
		FROM `Employment`
			GROUP BY `job`
				ORDER BY `job`;

SELECT # Zwraca ilość stolików ze względu na ilość miejsc
	`spots number`,
    COUNT(id) AS 'tables number'
		FROM `Table`
			GROUP BY `spots number`;

SELECT # Zwraca ilość zamówień ze względu na ich typ
	`purchase type`,
    COUNT(`id`) AS 'quantity'
		FROM `Bill`
			GROUP BY `purchase type`
				ORDER BY `purchase type`;

SELECT # Zwraca ilość zamówień ze względu na typ płatności
	`payment method`,
    COUNT(`id`) AS 'quantity'
		FROM `Bill`
			GROUP BY `payment method`
				ORDER BY `payment method`;

SELECT # Zwraca średnią ilość pozycji z menu na jedno zamówienie
    ROUND(SUM(`quantity`) / COUNT(DISTINCT `bill id`), 2) AS 'orders'
		FROM `Bill order`;

# Selekcje

SELECT # Zwraca rachunki zamówień na miejscu
	*
		FROM `Bill`
			WHERE `purchase type` = 'at location';

SELECT # Zwraca rachunki zamówień na wynos
	*
		FROM `Bill`
			WHERE `purchase type` = 'takeaway';

SELECT # Zwraca rachunki zamówień opłaconych kartą
	*
		FROM `Bill`
			WHERE `payment method` = 'card';

SELECT # Zwraca rachunki zamówień opłaconych gotówką
	*
		FROM `Bill`
			WHERE `payment method` = 'cash';

SELECT # Zwraca dostępne pozycje z menu
	*
		FROM `Menu`
			WHERE `available` = true;

SELECT # Zwraca niedostępne pozycje z menu
	*
		FROM `Menu`
			WHERE `available` = false;

SELECT # Zwraca napoje z menu
	*
		FROM `Menu`
			WHERE `category` = 'drink';

SELECT # Zwraca przystawki z menu
	*
		FROM `Menu`
			WHERE `category` = 'appetizer';

SELECT # Zwraca desery z menu
	*
		FROM `Menu`
			WHERE `category` = 'dessert';

SELECT # Zwraca niezakończone rezerwacje
	*
		FROM `Reservation`
			WHERE `reservation finished` = false;

# Zapytania łączące dwie tabele

SELECT # Zwraca wartości rachunków
	SUM(`Menu`.`price` * `Bill order`.`quantity`) AS 'price'
		FROM (`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
					GROUP BY `Bill order`.`bill id`
						ORDER BY SUM(`Menu`.`price` * `Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość zamówień danych napojów
	`Menu`.`name`,
    SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM (`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				WHERE `Menu`.`category` = 'drink'
					GROUP BY `Menu`.`name`
						ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość zamówień danych przystawek
	`Menu`.`name`,
    SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM (`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				WHERE `Menu`.`category` = 'appetizer'
					GROUP BY `Menu`.`name`
						ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość zamówień danych deserów
	`Menu`.`name`,
    SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM (`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				WHERE `Menu`.`category` = 'dessert'
					GROUP BY `Menu`.`name`
						ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość zamówień z zeszłego miesiąca ze względu na typ zamówienia
	`Bill`.`purchase type`,
    SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM (`Bill order`
			INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
				WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
					GROUP BY `Bill`.`purchase type`
						ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość zamówień z zeszłego miesiąca ze względu na metodę płatności
	`Bill`.`payment method`,
    SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM (`Bill order`
			INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
				WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
					GROUP BY `Bill`.`payment method`
						ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca wartość wynagrodzeń należnych za poprzedni miesiąc ze względu na wykonywany zawód
    `Employment`.`job`,
	ROUND(SUM((TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) * `Employment`.`hourly wage`), 2) as 'payment'
		FROM (`Employment`
			INNER JOIN `Settlement` ON `Employment`.`id` = `Settlement`.`employment id`)
				WHERE MONTH(`Settlement`.`shift start`) = MONTH(CURRENT_DATE()) - 1
					GROUP BY `Employment`.`job`
						ORDER BY ROUND(SUM((TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) * `Employment`.`hourly wage`), 2) DESC;

SELECT # Zwraca ilość godzin przepracowanych w poprzednim miesiącu ze względu na wykonywany zawód
    `Employment`.`job`,
	SUM(TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600)  AS `hours`
		FROM (`Employment`
			INNER JOIN `Settlement` ON `Employment`.`id` = `Settlement`.`employment id`)
				WHERE MONTH(`Settlement`.`shift start`) = MONTH(CURRENT_DATE()) - 1
					GROUP BY `Employment`.`job`
						ORDER BY SUM(TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) DESC;

SELECT # Zwraca liczbę rezerwacji z poprzedniego miesiąca ze względu na ilość miejsc
	`Table`.`spots number`,
    COUNT(`Reservation`.`id`) AS 'quantity'
		FROM (`Table`
			INNER JOIN `Reservation` ON `Table`.`id` = `Reservation`.`table id`)
				WHERE MONTH(`Reservation`.`reservation start`) = MONTH(CURRENT_DATE()) - 1
					GROUP BY `Table`.`spots number`
						ORDER BY COUNT(`Reservation`.`id`) DESC;

SELECT # Zwraca liczbę rezerwacji z poprzedniego miesiąca ze względu na lokal
	`Table`.`estate id`,
    COUNT(`Reservation`.`id`) AS 'quantity'
		FROM (`Table`
			INNER JOIN `Reservation` ON `Table`.`id` = `Reservation`.`table id`)
				WHERE MONTH(`Reservation`.`reservation start`) = MONTH(CURRENT_DATE()) - 1
					GROUP BY `Table`.`estate id`
						ORDER BY COUNT(`Reservation`.`id`) DESC;

# Zapytania łączące trzy tabele

SELECT # Zwraca wartości rachunków z zeszłego miesiąca
	SUM(`Menu`.`price` * `Bill order`.`quantity`) AS 'price'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Bill`.`id`
							ORDER BY SUM(`Menu`.`price` * `Bill order`.`quantity`) DESC;

SELECT # Zwraca wartości rachunków z zeszłego miesiąca ze względu na typ zamówienia
    `Bill`.`purchase type`,
	SUM(`Menu`.`price` * `Bill order`.`quantity`) AS 'price'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Bill`.`purchase type`
							ORDER BY SUM(`Menu`.`price` * `Bill order`.`quantity`) DESC;

SELECT # Zwraca wartości rachunków z zeszłego miesiąca ze względu na metodę płatności
    `Bill`.`payment method`,
	SUM(`Menu`.`price` * `Bill order`.`quantity`) AS 'price'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Bill`.`payment method`
							ORDER BY SUM(`Menu`.`price` * `Bill order`.`quantity`) DESC;

SELECT # Zwraca wartość zamówień z zeszłego miesiąca ze względu na ich kategorię
	`Menu`.`category`,
    SUM(`Menu`.`price`) as 'price'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Menu`.`category`
							ORDER BY SUM(`Menu`.`price`) DESC;

SELECT # Zwraca ilości zamówień z zeszłego miesiąca ze względu na ich kategorię
	`Menu`.`category`,
    SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Menu`.`category`
							ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość danych napojów zamówionych w poprzednim miesiącu
	`Menu`.`name`,
	SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE `Menu`.`category` = 'drink' AND MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Menu`.`name`
							ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość danych przystawek zamówionych w poprzednim miesiącu
	`Menu`.`name`,
	SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE `Menu`.`category` = 'appetizer' AND MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Menu`.`name`
							ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca ilość danych deserów zamówionych w poprzednim miesiącu
	`Menu`.`name`,
	SUM(`Bill order`.`quantity`) AS 'quantity'
		FROM ((`Bill order`
			INNER JOIN `Menu` ON `Bill order`.`menu item id` = `Menu`.`id`)
				INNER JOIN `Bill` ON `Bill order`.`bill id` = `Bill`.`id`)
					WHERE `Menu`.`category` = 'dessert' AND MONTH(`Bill`.`purchase time`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Menu`.`name`
							ORDER BY SUM(`Bill order`.`quantity`) DESC;

SELECT # Zwraca dane osobowe, wykonywany zawód oraz ilość godzin przepracowanych w zeszłym miesiącu
	CONCAT(`Employee`.`name`, ' ', `Employee`.`surname`) AS 'employee',
    `Employment`.`job`,
	SUM(TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) AS `hours`
		FROM ((`Employment`
			INNER JOIN `Settlement` ON `Employment`.`id` = `Settlement`.`employment id`)
				INNER JOIN `Employee` ON `Employment`.`id` = `Employee`.`id`)
					WHERE MONTH(`Settlement`.`shift start`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Employee`.`id`
							ORDER BY SUM(TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) DESC;

SELECT # Zwraca dane osobowe, stawkę godzinową, ilość godzin przepracowanych w zeszłym miesiącu oraz wynagrodzenie należne za poprzedni miesiąc
	CONCAT(`Employee`.`name`, ' ', `Employee`.`surname`) AS 'employee',
    `Employment`.`hourly wage`,
	SUM(TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) AS `hours`,
	ROUND(SUM((TIMESTAMPDIFF(SECOND, `Settlement`.`shift start`, `Settlement`.`shift end`) / 3600) * `Employment`.`hourly wage`), 2) as 'payment'
		FROM ((`Employment`
			INNER JOIN `Settlement` ON `Employment`.`id` = `Settlement`.`employment id`)
				INNER JOIN `Employee` ON `Employment`.`id` = `Employee`.`id`)
					WHERE MONTH(`Settlement`.`shift start`) = MONTH(CURRENT_DATE()) - 1
						GROUP BY `Employee`.`id`
							ORDER BY `Employment`.`job`;
