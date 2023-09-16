INSERT INTO `mdt_fines` (`id`, `code`, `name`, `amount`, `createdAt`) VALUES
(NULL, '1-100', 'Speed limit', 5000, NULL),
(NULL, '1-110', 'Reckless driving', 2500, NULL),
(NULL, '1-120', 'Seatbelt', 3000, NULL),
(NULL, '1-130', 'Violence', 2000, NULL),
(NULL, '1-140', 'Weapons in evidence', 3000, NULL),
(NULL, '1-150', 'Running on stop sign', 10000, NULL),
(NULL, '1-160', 'Ignoring a yield sign', 8000, NULL),
(NULL, '1-170', 'Speeding 1-10mph over limit', 2000, NULL),
(NULL, '1-180', 'Speeding 11-20mph over limit', 3000, NULL),
(NULL, '1-190', 'Speeding 21-30mph over limit', 4000, NULL),
(NULL, '1-200', 'Speeding 31-40mph over limit', 5000, NULL),
(NULL, '1-210', 'Speeding more than 40mph over limit', 8000, NULL);

INSERT INTO `mdt_jail` (`id`, `name`, `time`, `createdAt`) VALUES
(NULL, 'Murder', 30, NULL),
(NULL, 'Crime', 30, NULL),
(NULL, 'Thief', 15, NULL);