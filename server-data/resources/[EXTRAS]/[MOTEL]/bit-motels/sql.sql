CREATE TABLE IF NOT EXISTS `bit_motels` (
  `room` int(10) DEFAULT NULL,
  `motel` varchar(50) DEFAULT NULL,
  `renter` varchar(50) DEFAULT NULL,
  `rentername` varchar(200) DEFAULT NULL,
  `amount` int(20) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `bit_motels_owners` (
  `motel` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `balance` int(200) DEFAULT NULL
);

