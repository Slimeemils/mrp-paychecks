CREATE TABLE IF NOT EXISTS `paychecks` (
  `citizenid` varchar(250) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `collectamount` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;