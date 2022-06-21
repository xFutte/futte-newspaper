CREATE TABLE IF NOT EXISTS `newsstands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `story_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `header` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `body` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `datetime` text,
  `jailed_player` varchar(50) DEFAULT NULL,
  `jailed_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
