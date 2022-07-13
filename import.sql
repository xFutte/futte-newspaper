CREATE TABLE `newsstands` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`story_type` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`header` VARCHAR(5000) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`body` VARCHAR(5000) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`date` VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`jailed_player` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`jailed_time` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`image` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)