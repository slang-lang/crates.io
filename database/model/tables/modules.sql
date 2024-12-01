CREATE TABLE `modules` (
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(80) NOT NULL,
  `architecture` varchar(32) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `version` varchar(32) NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;