/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 10.4.22-MariaDB : Database - directory
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`directory` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `directory`;

/*Table structure for table `classification` */

DROP TABLE IF EXISTS `classification`;

CREATE TABLE `classification` (
  `classificationid` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `deletedby` int(11) DEFAULT NULL,
  `datedeleted` datetime DEFAULT NULL,
  PRIMARY KEY (`classificationid`),
  UNIQUE KEY `description` (`description`),
  KEY `addedby` (`addedby`),
  KEY `deletedby` (`deletedby`),
  CONSTRAINT `classification_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`),
  CONSTRAINT `classification_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Data for the table `classification` */

insert  into `classification`(`classificationid`,`description`,`addedby`,`dateadded`,`deleted`,`deletedby`,`datedeleted`) values (5,'Indiviual',2,'2021-12-20 08:51:50',1,2,'2021-12-20 09:18:57'),(8,'Corporate',2,'2021-12-20 08:53:49',0,NULL,NULL),(9,'Paterneship',2,'2021-12-20 08:53:56',0,NULL,NULL);

/*Table structure for table `customerbranches` */

DROP TABLE IF EXISTS `customerbranches`;

CREATE TABLE `customerbranches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL,
  `branchname` varchar(100) DEFAULT NULL,
  `lat` decimal(18,5) DEFAULT NULL,
  `longitude` decimal(18,5) DEFAULT NULL,
  `physicaladdress` varchar(500) DEFAULT NULL,
  `telephone` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerid` (`customerid`),
  CONSTRAINT `customerbranches_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customers` (`customerid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `customerbranches` */

insert  into `customerbranches`(`id`,`customerid`,`branchname`,`lat`,`longitude`,`physicaladdress`,`telephone`,`email`) values (1,8,'Nakuru Campus','-1.28754','36.81461','Ngengi House, Nakuru CBD opp Westside Mall',2147483647,'nakuru@jkuat.ac.ke'),(2,8,'Kisumu Campus','-0.08702','34.76856','Oginga Odinga Street Kisumu',2147483647,'kisumu.jkuat.ac.ke'),(3,8,'Mombasa Branch','-4.06354','39.67243','Majengo MOMBASA TRADE CENTRE',2147483647,'mombasa@jkuat.ac.ke');

/*Table structure for table `customercharges` */

DROP TABLE IF EXISTS `customercharges`;

CREATE TABLE `customercharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerid` (`customerid`),
  CONSTRAINT `customercharges_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customers` (`customerid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `customercharges` */

insert  into `customercharges`(`id`,`customerid`,`date`,`amount`) values (5,25,'2022-01-15 13:45:04','5000.00');

/*Table structure for table `customerindustries` */

DROP TABLE IF EXISTS `customerindustries`;

CREATE TABLE `customerindustries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL,
  `industryid` int(11) DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` date DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerid` (`customerid`),
  KEY `industryid` (`industryid`),
  KEY `addedby` (`addedby`),
  KEY `deletedby` (`deletedby`),
  CONSTRAINT `customerindustries_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customers` (`customerid`),
  CONSTRAINT `customerindustries_ibfk_2` FOREIGN KEY (`industryid`) REFERENCES `industries` (`industryid`),
  CONSTRAINT `customerindustries_ibfk_3` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`),
  CONSTRAINT `customerindustries_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `customerindustries` */

insert  into `customerindustries`(`id`,`customerid`,`industryid`,`addedby`,`dateadded`,`deleted`,`datedeleted`,`deletedby`) values (3,9,3,2,'2022-01-08 13:16:32',0,NULL,NULL),(4,9,1,2,'2022-01-08 13:16:32',0,NULL,NULL),(6,4,4,2,'2022-01-08 13:21:20',0,NULL,NULL),(7,8,3,2,'2022-01-14 11:13:37',0,NULL,NULL),(8,8,1,2,'2022-01-14 11:13:37',0,NULL,NULL),(14,25,4,2,'2022-01-15 13:45:04',0,NULL,NULL);

/*Table structure for table `customerpayments` */

DROP TABLE IF EXISTS `customerpayments`;

CREATE TABLE `customerpayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL,
  `paymentmode` varchar(50) DEFAULT NULL,
  `referenceno` varchar(50) DEFAULT NULL,
  `amountpaid` decimal(18,2) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `invoiceid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerid` (`customerid`),
  KEY `invoiceid` (`invoiceid`),
  CONSTRAINT `customerpayments_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customers` (`customerid`),
  CONSTRAINT `customerpayments_ibfk_2` FOREIGN KEY (`invoiceid`) REFERENCES `customercharges` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `customerpayments` */

insert  into `customerpayments`(`id`,`customerid`,`paymentmode`,`referenceno`,`amountpaid`,`date`,`invoiceid`) values (2,25,'MPESA','LGR219G3EY','5000.00','2022-01-15 14:34:07',5);

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customerid` int(11) NOT NULL AUTO_INCREMENT,
  `customerno` varchar(50) DEFAULT NULL,
  `customername` varchar(100) DEFAULT NULL,
  `classificationid` int(11) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `physicaladdress` varchar(255) DEFAULT NULL,
  `postaladdress` varchar(100) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `postalcode` varchar(50) DEFAULT NULL,
  `lat` decimal(18,6) DEFAULT NULL,
  `long` decimal(18,6) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL,
  `regdocid` int(11) DEFAULT NULL,
  `regno` varchar(50) DEFAULT NULL,
  `regdate` date DEFAULT NULL,
  `hasbranches` tinyint(1) DEFAULT 0,
  `image` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`customerid`),
  UNIQUE KEY `customerno` (`customerno`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `regno` (`regno`),
  KEY `classificationid` (`classificationid`),
  KEY `regdocid` (`regdocid`),
  KEY `addedby` (`addedby`),
  KEY `deletedby` (`deletedby`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`classificationid`) REFERENCES `classification` (`classificationid`),
  CONSTRAINT `customers_ibfk_2` FOREIGN KEY (`regdocid`) REFERENCES `regdocuments` (`regdocid`),
  CONSTRAINT `customers_ibfk_3` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`),
  CONSTRAINT `customers_ibfk_4` FOREIGN KEY (`deletedby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

/*Data for the table `customers` */

insert  into `customers`(`customerid`,`customerno`,`customername`,`classificationid`,`telephone`,`email`,`physicaladdress`,`postaladdress`,`town`,`postalcode`,`lat`,`long`,`dateadded`,`addedby`,`deleted`,`datedeleted`,`deletedby`,`regdocid`,`regno`,`regdate`,`hasbranches`,`image`) values (2,'CST00001/2019','Richard Onyango',5,'727709772','akellorich@yahoo.com','Haile Sellasie Av, Nairobi CBD','52420','Nairobi','00200','-1.290970','36.825650','2021-12-20 12:19:16',2,0,NULL,NULL,1,'23657524',NULL,0,'../customer_images/3788153_Kenyatta_University_Logo.png'),(4,'CST00002/2019','Makena Brenda',5,'791404218','makenaa.bk@yahoo.com','Haile Sellasie Av, Nairobi CBD','52420','Nairobi','00200','-1.290970','36.825650','2021-12-20 12:20:40',2,0,NULL,NULL,1,'37353934','2022-01-07',1,'../customer_images/9106178_Kenyatta_University_Logo.png'),(5,'CST00003/2019','The Technical University of Kenya',8,'20123456','info@tukenya.ac.ke','Haile Sellasie Avenue','52428','Nairobi','00200','-1.287540','36.814520','2022-01-05 11:02:45',2,0,NULL,NULL,1,'0000',NULL,0,'../customer_images/5144590_TUK_Logo.jpg'),(7,'CST00004/2019','University of Nairobi',8,'201234578','info@uon.ac.ke','Haile Sellasie Avenue','52428','Nairobi','00200','-1.287540','36.814520','2022-01-05 11:05:23',2,0,NULL,NULL,1,'0001',NULL,0,'../customer_images/7872693_UoN.png'),(8,'CST00005/2019','Jomo Kenyatta University',8,'2037454','info@jkuat.ac.ke','Thika Road, Near Juja','3872','Thika','401100','-1.287530','36.814750','2022-01-06 09:09:06',5,0,NULL,NULL,1,'475687645','2021-04-01',1,'../customer_images/2766551jkuat_logo.png'),(9,'CST00006/2019','Maseno University',8,'758567234','info@maseno.ac.ke','Maseno','38978','Kisumu','47600','-1.287530','36.814750','2022-01-06 09:51:37',5,0,NULL,NULL,1,'48976','2022-01-08',1,'../customer_images/maseno_logo.jpg'),(11,'CST00007/2019','Kisumu Polytechnic',8,'309475','cybetrackinternational@gmail.com','Kisumu','28937','Kisumu','40100','-1.287530','36.814970','2022-01-13 11:07:32',2,0,NULL,NULL,1,'3479856','2020-01-01',1,NULL),(25,'CST00012/2019','NIBS College',9,'2147483647','akellorich@gmail.com','Aghro House, 08 Moi Ave, Nairobi','52428','Nairobi','00200','-1.287180','36.827130','2022-01-15 13:45:04',2,0,NULL,NULL,1,'36487654','2022-01-15',1,NULL);

/*Table structure for table `emailconfig` */

DROP TABLE IF EXISTS `emailconfig`;

CREATE TABLE `emailconfig` (
  `smtpserver` varchar(100) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `emailaddress` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usessl` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `emailconfig` */

insert  into `emailconfig`(`smtpserver`,`port`,`emailaddress`,`password`,`usessl`) values ('smtp.office365.com',587,'lms@adriankenya.com','zbpzhpcdkbqbtdrc',0);

/*Table structure for table `industries` */

DROP TABLE IF EXISTS `industries`;

CREATE TABLE `industries` (
  `industryid` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `datedeleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`industryid`),
  UNIQUE KEY `description` (`description`),
  KEY `addedby` (`addedby`),
  KEY `deletedby` (`deletedby`),
  CONSTRAINT `industries_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`),
  CONSTRAINT `industries_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `industries` */

insert  into `industries`(`industryid`,`description`,`addedby`,`dateadded`,`deleted`,`datedeleted`,`deletedby`) values (1,'Manufacturing',2,'2021-12-20 09:33:02',0,NULL,NULL),(3,'Farming',2,'2021-12-20 09:33:22',1,'2021-12-20 09:43:11',2),(4,'Service',2,'2021-12-20 09:33:29',0,NULL,NULL),(5,'Training',2,'2021-12-20 09:33:35',0,NULL,NULL);

/*Table structure for table `pricelist` */

DROP TABLE IF EXISTS `pricelist`;

CREATE TABLE `pricelist` (
  `currentprice` decimal(18,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `pricelist` */

insert  into `pricelist`(`currentprice`) values ('5000.00');

/*Table structure for table `regdocuments` */

DROP TABLE IF EXISTS `regdocuments`;

CREATE TABLE `regdocuments` (
  `regdocid` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `deletedby` int(11) DEFAULT NULL,
  `datedeleted` datetime DEFAULT NULL,
  PRIMARY KEY (`regdocid`),
  UNIQUE KEY `description` (`description`),
  KEY `addedby` (`addedby`),
  KEY `deletedby` (`deletedby`),
  CONSTRAINT `regdocuments_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`),
  CONSTRAINT `regdocuments_ibfk_2` FOREIGN KEY (`deletedby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `regdocuments` */

insert  into `regdocuments`(`regdocid`,`description`,`dateadded`,`addedby`,`deleted`,`deletedby`,`datedeleted`) values (1,'National ID','2021-12-20 11:17:41',2,0,NULL,NULL),(2,'Passport','2021-12-20 11:17:50',2,0,NULL,NULL),(3,'Allien Card','2021-12-20 11:17:57',2,0,NULL,NULL),(4,'Work Permit','2021-12-20 11:18:05',2,0,NULL,NULL);

/*Table structure for table `serials` */

DROP TABLE IF EXISTS `serials`;

CREATE TABLE `serials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `currentno` int(11) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `serials` */

insert  into `serials`(`id`,`description`,`prefix`,`currentno`,`suffix`) values (1,'customer no','CST',13,'2019');

/*Table structure for table `tempcustomerindustries` */

DROP TABLE IF EXISTS `tempcustomerindustries`;

CREATE TABLE `tempcustomerindustries` (
  `refno` varchar(10) DEFAULT NULL,
  `industryid` int(11) DEFAULT NULL,
  KEY `industryid` (`industryid`),
  CONSTRAINT `tempcustomerindustries_ibfk_1` FOREIGN KEY (`industryid`) REFERENCES `industries` (`industryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tempcustomerindustries` */

insert  into `tempcustomerindustries`(`refno`,`industryid`) values ('99253',4),('99253',5),('65484',3),('65484',1),('96375',5),('94436',5),('44732',5),('48403',5),('54212',5),('71821',5),('94695',5),('36112',5),('30222',5),('71080',5),('63085',5),('39416',5),('44236',5);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `mobile` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `accountactive` tinyint(1) DEFAULT NULL,
  `systemadmin` tinyint(1) DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `activationcode` int(11) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `email` (`email`),
  KEY `addedby` (`addedby`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`),
  CONSTRAINT `check_gender` CHECK (`gender` in ('Male','Female'))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `users` */

insert  into `users`(`userid`,`username`,`password`,`firstname`,`lastname`,`gender`,`mobile`,`email`,`accountactive`,`systemadmin`,`addedby`,`dateadded`,`activationcode`) values (2,'Admin','4a201ba563fa8c652c6c9bd4a04a40f7','System','Admin','Male',727709772,'akellorich@yahoo.com',1,1,NULL,NULL,NULL),(3,'richard','1c986a5f526fda89666cdb2a9547a436','Richard','Onyango','male',727709773,'akellorich@gmail.com',1,0,2,'2021-12-21 11:30:36',NULL),(4,'makena','827ccb0eea8a706c4c34a16891f84e7b','Makena','Brenda','female',791404218,'makenaa.bk@gmail.com',1,0,2,'2021-12-21 11:36:45',NULL),(5,'Matano','1c986a5f526fda89666cdb2a9547a436','Richard','Matano','male',725123456,'matano@yahoo.com',0,0,2,'2022-01-04 09:16:07',NULL),(7,'cybertrack','c8cd8bcf2de00ae75d21a7c170663bd0','Cybertrack','International','male',2147483647,'cybetrackinternational@gmail.com',0,0,2,'2022-01-13 11:21:47',99802);

/* Function  structure for function  `fn_generatecustomerno` */

/*!50003 DROP FUNCTION IF EXISTS `fn_generatecustomerno` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generatecustomerno`() RETURNS varchar(50) CHARSET utf8mb4
BEGIN
	declare $customerno varchar(50);
	
	set $customerno=(select concat(`prefix`, 
		CASE CHAR_LENGTH(`currentno`) 
			when 1 then '0000'
			when 2 then '000'
			when 3 then '00'
			when 4 then '0'
		else
			''
		end, `currentno`,'/',suffix)
	From `serials` where `description`='customer no'
	);
	return $customerno;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_addclassification` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_addclassification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addclassification`($classificationid int,$description varchar(40),$userid int)
BEGIN
	if $classificationid=0 then
		insert into `classification`(`description`,`addedby`,`dateadded`)
		values($description,$userid,now());
	else
		update `classification` set `description`=$description
		where `classificationid`=$classificationid;
	
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_addindustry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_addindustry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addindustry`($industryid int,$description varchar(50), $addedby int)
BEGIN
	if $industryid=0 then
		insert into `industries`(`description`,`addedby`,`dateadded`)
		values($description,$addedby,now());
	else
		update `industries` 
		set `description`=$description 
		where `industryid`=$industryid;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_addregistrationdocument` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_addregistrationdocument` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addregistrationdocument`($regdocid int, $description varchar(50), $addedby int)
BEGIN
	if $regdocid=0 then
		insert into `regdocuments`(`description`,`dateadded`,`addedby`)
		values($description,now(),$addedby);
	else	
		update `regdocuments` 
		set `description`=$description
		where `regdocid`=$regdocid;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_changecustomerlogo` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_changecustomerlogo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_changecustomerlogo`($customerid int,$imagepath varchar(1000))
BEGIN
	update `customers` set `image`=$imagepath
	where `customerid`=$customerid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_changeuserpassword` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_changeuserpassword` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_changeuserpassword`($userid int,$userpassword varchar(50))
BEGIN
	update `users` set `password`=$userpassword where `userid`=$userid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checktransactioncode` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checktransactioncode` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checktransactioncode`($referenceno varchar(50))
BEGIN
	select * from `customerpayments` where `referenceno`=$referenceno;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checkuserexists` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkuserexists` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkuserexists`($userid int,$checkfield varchar(50),$checkvalue varchar(50))
BEGIN
	if $checkfield='username' then
		select * from `users` where `username`=$checkvalue and `userid`!=$userid;
	elseif $checkfield='email' then 
		SELECT * FROM `users` WHERE `email`=$checkvalue AND `userid`!=$userid;
	elseif $checkfield='mobile' then 
		SELECT * FROM `users` WHERE `mobile`=convert($checkvalue, int) AND `userid`!=$userid;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteclassification` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteclassification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteclassification`($classificationid int,$deletedby int)
BEGIN
	update `classification` 
	set `deleted`=1,`deletedby`=$deletedby, `datedeleted`=now()
	where `classificationid`=$classificationid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteindustry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteindustry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteindustry`($industryid int,$deletedby int)
BEGIN
	update `industries` 
	set `deleted`=1,`deletedby`=$deletedby, `datedeleted`=now()
	where `industryid`=$industryid ;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteregistrationdocument` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteregistrationdocument` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteregistrationdocument`($regdocid int,$deletedby int)
BEGIN
	update `regdocuments` 
	set `deleted`=1, `deletedby`=$deletedby, `datedeleted`=now()
	where `regdocid`=$regdocid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_filtercustomers` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_filtercustomers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_filtercustomers`($customername varchar(50))
BEGIN
	SELECT c.customerid,c.`customerno`,c.`customername`,c.`telephone`,c.`email`,c.`physicaladdress`,c.`postaladdress`,c.`town`,c.`postalcode`,c.`lat`,c.`long`,
	IFNULL(GROUP_CONCAT(`description`),'') AS tags,
	ifnull((select count(customerid) from `customerbranches` cb where cb.`customerid`=c.customerid),0) branches,image
	FROM `customers` c
	LEFT OUTER JOIN `customerindustries` ci ON c.`customerid`=ci.`customerid`
	LEFT OUTER JOIN `industries` i ON ci.`industryid`=i.`industryid`
	WHERE `customername` LIKE CONCAT('%',$customername,'%')
	GROUP BY c.customerid,c.`customerno`,c.`customername`,c.`telephone`,c.`email`,c.`physicaladdress`,c.`postaladdress`,c.`town`,c.`postalcode`,c.`lat`,c.`long`,image
	ORDER BY c.`customername`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getclassificationdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getclassificationdetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getclassificationdetails`($classificationid int)
BEGIN
	select * 
	from `classification` 
	where `classificationid`=$classificationid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcustomerbalance` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcustomerbalance` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcustomerbalance`($customerid int)
BEGIN
    
	set @customerbalance=(select `amount` from `customercharges` where `customerid`=$customerid and `id` not in( 
		select `invoiceid` from `customerpayments` where `customerid`=$customerid) order by `id` limit 1);
		
	select `customerid`,`customerno`,`customername`,`email`,`telephone`,@customerbalance as customerbalance
	from `customers` where customerid=$customerid;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcustomerbranches` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcustomerbranches` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcustomerbranches`($customerid int)
BEGIN
	select 'Head Office' as branch, `lat`,`long` from `customers` where `customerid`=$customerid
	
	union
	
	select `branchname`,`lat`,`longitude` as `long` from `customerbranches` where `customerid`=$customerid;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcustomerbyclassification` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcustomerbyclassification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcustomerbyclassification`()
BEGIN
	select `description` as categoryname, count(`customerid`) as `appears` 
	from `customers` c, `classification` ci
	where c.`classificationid`=ci.`classificationid`
	group by `description`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcustomerdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcustomerdetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcustomerdetails`($customerid int)
BEGIN
	select *,date_format(`regdate`,'%d-%b-%Y') registrationdate from `customers` where `customerid`=$customerid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcustomerindustries` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcustomerindustries` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcustomerindustries`($customerid int)
BEGIN
	select * from `customerindustries` where `customerid`=$customerid and ifnull(`deleted`,0)=0;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getemailconfig` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getemailconfig` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getemailconfig`()
BEGIN
	select * from `emailconfig`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getexistingclassifications` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getexistingclassifications` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getexistingclassifications`($returnall boolean)
BEGIN
	if $returnall=1 then
		select * 
		from `classification` 
		order by `description`;
	else
		SELECT * 
		FROM `classification` 
		where `deleted`=0
		ORDER BY `description`;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getexistingindustries` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getexistingindustries` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getexistingindustries`( $returnall boolean)
BEGIN
	if $returnall=1 then
		select * 
		from `industries`
		order by `description`;
	else
		SELECT * 
		FROM `industries`
		where `deleted`=0
		ORDER BY `description`;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getexistingregistrationdocuments` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getexistingregistrationdocuments` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getexistingregistrationdocuments`($returnall boolean)
BEGIN
	if $returnall=1 then
		select * 
		from `regdocuments`
		order by `description`;	
	else
		SELECT * 
		FROM `regdocuments`
		where deleted=0
		ORDER BY `description`;	
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getindustrydetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getindustrydetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getindustrydetails`($industryid int)
BEGIN
	select * 
	from `industries` 
	where `industryid`=$industryid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getregistrationdocumentdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getregistrationdocumentdetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getregistrationdocumentdetails`($regdocid int)
BEGIN
	select * 
	from `regdocuments` 
	where `regdocid`=$regdocid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getuserdetailswithemail` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getuserdetailswithemail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getuserdetailswithemail`($emailaddress varchar(50))
BEGIN
	select * from `users` where `email`=$emailaddress;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getuserlogindetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getuserlogindetails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getuserlogindetails`($logindata varchar(50),$userpassword varchar(40))
BEGIN
	select * from `users`
	where (`username`=$logindata 
	or `mobile`=convert($logindata, int) 
	or `email`=$logindata) and `password`=$userpassword;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecustomer` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecustomer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecustomer`($customerid int, $customerno varchar(50), $customername varchar(100),$classificationid int,
	$telephone int,$email varchar(50),$physicaladdress varchar(100),$postaladdress varchar(100),$town varchar(50),$postalcode varchar(50),$lat decimal(18,5),$longitude decimal(18,5),
	$regdocid int, $regno varchar(50),$addedby int,$regdate date,$hasbranches boolean,$refno varchar(10))
BEGIN
	-- declare $billableamount decimal(18,2);
	if $customerid=0 then
		
		start transaction;
			-- Generate the cutomer no
			set $customerno=`fn_generatecustomerno`();
			-- Save the customer
			insert into `customers`(`customerno`,`customername`,`classificationid`,`telephone`,`email`,`physicaladdress`,`postaladdress`,`town`,`postalcode`,
				`lat`,`long`,`dateadded`,`addedby`,`regdocid`,`regno`,`regdate`,`hasbranches`)
			values($customerno,$customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
				$lat,$longitude,now(),$addedby,$regdocid,$regno,$regdate,$hasbranches);
			-- Get the generated customer id
			set $customerid=(select max(`customerid`) from `customers`);
			-- Save the customer Industries
			insert into `customerindustries`(`customerid`,`industryid`,`addedby`,`dateadded`)
			select $customerid,`industryid`,$addedby,now() from `tempcustomerindustries` where `refno`=$refno;
			-- Increment the serials table for our counter
			update `serials` 
			set `currentno`=`currentno`+1 
			where `description`='Customer no';
			-- Bill the customer initial amount
			set @billableamount=(select `currentprice` from `pricelist`);
			insert into `customercharges`(`customerid`,`date`,`amount`)
			values($customerid,now(),@billableamount);
			-- Remove temporary data i.e. customer industries
			delete from `tempcustomerindustries` where `refno`=$refno;
			-- Get customer details
			select $customerid as customerid, @billableamount as billedamount;
		commit;
	else
		-- Update customers details
		update `customers` set `customername`=$customername,`classificationid`=$classificationid,`telephone`=$telephone,`email`=$email,`physicaladdress`=$physicaladdress,
		`postaladdress`=$postaladdress,`town`=$town,`postalcode`=$postalcode,`lat`=$lat,`long`=$longitude,`regdocid`=$regdocid,`regno`=$regno, `regdate`=$regdate, 
		`hasbranches`=$hasbranches
		where `customerid`=$customerid;
		-- remove existing industries
		delete from `customerindustries` where `customerid`=$customerid;
		-- add new industries
		INSERT INTO `customerindustries`(`customerid`,`industryid`,`addedby`,`dateadded`)
		SELECT $customerid,`industryid`,$addedby,NOW() FROM `tempcustomerindustries` WHERE `refno`=$refno;
		-- Remove temporary data i.e. customer industries
		DELETE FROM `tempcustomerindustries` WHERE `refno`=$refno;
		-- Get Customer Details
		SELECT $customerid AS customerid, 0 AS billedamount;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecustomerbranch` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecustomerbranch` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecustomerbranch`($branchid int,$customerid int, $branchname varchar(100),$physicaladdress varchar(500),
	$lat decimal(18,5), $lon decimal(18,5), $telephone int,$email varchar(100))
BEGIN
	if $branchid=0 then
		insert into `customerbranches`(`customerid`,`branchname`,`lat`,`longitude`,`physicaladdress`,`telephone`,`email`)
		values($customerid,$branchname, $lat,$lon,$physicaladdress, $telephone,$email);
	else
		update `customerbranches` 
		set `customerid`=$customerid, `branchname`=$branchname, `lat`=$lat, `longitude`=$lon, 
		`physicaladdress`=$physicaladdress, `telephone`=$telephone, `email`=$email
		where `id`=$branchid;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecustomerpayment` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecustomerpayment` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecustomerpayment`($customerid int,$paymentmode varchar(50),$referenceno varchar(50),$amount decimal(18,2))
BEGIN
	-- Set a variable that gets the last unpaid charge
	set @invoiceid=(select `id` from `customercharges` where id not in
		(select `invoiceid` from `customerpayments` where `customerid`=$customerid) order by `id` limit 1);
	insert into `customerpayments`(`customerid`,`paymentmode`,`referenceno`,`amountpaid`,`date`,`invoiceid`)
	values($customerid,$paymentmode,$referenceno,$amount,now(),@invoiceid);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveemailconfig` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveemailconfig` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveemailconfig`($emailport int,$smtpserver varchar(100),$emailaddress varchar(100),$emailpassword varchar(100),$usessl boolean)
BEGIN
	if exists(select * from `emailconfig`) then 
		-- Update
		update `emailconfig` set `smtpserver`=$smtpserver,`port`=$emailport,`emailaddress`=$emailaddress,
		`password`=$emailpassword,`usessl`=$usessl;
	else
		-- Insert
		insert into `emailconfig`(`smtpserver`,`port`,`emailaddress`,`password`,`usessl`)
		values($smtpserver,$emailport,$emailaddress,$emailpassword,$usessl);
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savetempcustomerindustry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savetempcustomerindustry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savetempcustomerindustry`($refno varchar(10),$industryid int)
BEGIN
	insert into `tempcustomerindustries`(`refno`,`industryid`)
	values($refno,$industryid);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveuser` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveuser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveuser`($userid int, $username varchar(50),$userpassword varchar(50),$firstname varchar(50),$lastname varchar(50),
	$gender varchar(50),$mobile int, $email varchar(50),$accountactive boolean,$systemadmin boolean,$addedby int,$activationcode int)
BEGIN
	if $userid=0 then
		insert into `users`(`username`,`password`,`firstname`,`lastname`,`gender`,`mobile`,`email`,`accountactive`,`systemadmin`,`addedby`,`dateadded`,`activationcode`)
		values($username,$userpassword,$firstname,$lastname,$gender,$mobile,$email,$accountactive,$systemadmin,$addedby,now(),$activationcode);
	else
		update `users` 
		set `username`=$username,`firstname`=$firstname,`lastname`=$lastname,`gender`=$gender,`mobile`=$mobile,`email`=$email,
		`accountactive`=$accountactive,`systemadmin`=$systemadmin
		where `userid`=$userid;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_summarizecustomerbyindustry` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_summarizecustomerbyindustry` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_summarizecustomerbyindustry`()
BEGIN
	select `description` as industry, count(`customerid`) as appears
	from `industries` i, `customerindustries` ci
	where i.`industryid`=ci.`industryid`
	group by `description`;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
