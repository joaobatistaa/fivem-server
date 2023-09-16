-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               10.4.8-MariaDB - mariadb.org binary distribution
-- Serwer OS:                    Win64
-- HeidiSQL Wersja:              10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Zrzut struktury bazy danych chuj
CREATE DATABASE IF NOT EXISTS `chuj` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `chuj`;

-- Zrzut struktury tabela chuj.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_polish_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli chuj.fine_types: ~52 rows (około)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(105, 'Nadużywanie klaksonu', 30, 0),
	(106, 'Przekroczenie lini ciągłej', 40, 0),
	(107, 'Jechanie po złej stronie drogi', 250, 0),
	(108, 'Nieprawidłowe zawracanie', 250, 0),
	(109, 'Nielegalna jazda Off-road', 170, 0),
	(110, 'Niedostosowanie się do poleceń Policji', 30, 0),
	(111, 'Nieprawidłowe zatrzymanie pojazdu', 150, 0),
	(112, 'Nieprawidłowe parkownie', 70, 0),
	(113, 'Niezastosowanie się do ruchu prawostronnego (jazda lewym pasem)', 70, 0),
	(114, 'Brak informacji o pojeździe', 90, 0),
	(115, 'Niezastosowanie się do znaku SOTP', 105, 0),
	(116, 'Niezatrzymanie się na czerwonym świetle', 130, 0),
	(117, 'Przechodzenie w niedozwolonym miejscu', 100, 0),
	(118, 'Jazda nielegalnym pojazdem', 100, 0),
	(119, 'Brak prawa jazdy', 1500, 0),
	(120, 'Ucieczka z miejsca zdarzenia', 800, 0),
	(121, 'Przekroczenie prędkości < 5 mph', 90, 0),
	(122, 'Przekroczenie prędkości 5-15 mph', 120, 0),
	(123, 'Przekroczenie prędkości 15-30 mph', 180, 0),
	(124, 'Przekroczenie prędkości > 30 mph', 300, 0),
	(125, 'Utrudnianie przemieszczania się', 110, 1),
	(126, 'Publiczne zgorszenie', 90, 1),
	(127, 'Niepoprawne zachowanie', 90, 1),
	(128, 'Utrudnianie postępowania', 130, 1),
	(129, 'Obraza cywilów', 75, 1),
	(130, 'Obraza graczy', 110, 1),
	(131, 'Groźby werbalne', 90, 1),
	(132, 'Przeklinanie na graczy', 150, 1),
	(133, 'Dostarczanie fałszywych informacji', 250, 1),
	(134, 'Próba korupcji', 1500, 1),
	(135, 'Wymachiwanie bronią w mieście', 120, 2),
	(136, 'Wymachiwanie niebezpieczną bronią w mieście', 300, 2),
	(137, 'Brak pozwolenia na broń', 600, 2),
	(138, 'Posiadanie nielegalnej broni', 700, 2),
	(139, 'Posiadanie narzędzi do włamań', 300, 2),
	(140, 'Złodziej - recydywista', 1800, 2),
	(141, 'Rozprowadzanie nielegalnych substancji', 1500, 2),
	(142, 'Wytwarzanie nielegalnych substancji', 1500, 2),
	(143, 'Posiadanie zakazanych substancji', 650, 2),
	(144, 'Porwanie cywila', 1500, 2),
	(145, 'Porwanie gracza', 2000, 2),
	(146, 'Rabunek', 650, 2),
	(147, 'Kradzież z bronią w ręku', 650, 2),
	(148, 'Napad na Bank', 1500, 2),
	(149, 'Atak na cywila', 2000, 3),
	(150, 'Atak na gracza', 2500, 3),
	(151, 'Próba morderstwa cywila', 3000, 3),
	(152, 'Próba morderstwa gracza', 5000, 3),
	(153, 'Zabójstwo cywila z premedytacją', 10000, 3),
	(154, 'Zabójstwo gracza z premedytacją', 30000, 3),
	(155, 'Nieumyślne spowodowanie śmierci', 1800, 3),
	(156, 'Oszustwo', 2000, 2);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
