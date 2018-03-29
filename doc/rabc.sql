/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.40 : Database - rbac
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`rbac` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `rbac`;

/*Table structure for table `permission` */

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `resource` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `permission` */

insert  into `permission`(`id`,`name`,`resource`) values (1,'客户管理','khgl'),(2,'客户管理：客户信息管理','khgl/customer/index.action'),(3,'客户管理：客户流失管理','khgl/customerLoss/index.action'),(4,'营销管理','yxgl'),(5,'营销管理:营销机会管理','yxgl/saleChance/index.action'),(6,'营销管理:客户开发计划','yxgl/saleChance/cusDevPlan.action'),(7,'统计报表','tjbb');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sn` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`name`,`sn`) values (1,'系统管理员','admin'),(5,'普通用户','normal'),(9,'经理','jingli'),(10,'后勤','houqin');

/*Table structure for table `role_permission` */

DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  KEY `FK_role_permission_1` (`role_id`),
  KEY `FK_role_permission_2` (`permission_id`),
  CONSTRAINT `FK_role_permission_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FK_role_permission_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_permission` */

insert  into `role_permission`(`role_id`,`permission_id`) values (10,1),(10,2),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(9,4),(9,5),(9,6);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `real_name` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL COMMENT '0:正常 1：离职',
  `admin` tinyint(1) DEFAULT NULL COMMENT '1：超级管理员 0：普通',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`real_name`,`password`,`tel`,`email`,`state`,`admin`) values (1,'12','12',NULL,'12','12',NULL,NULL),(2,'13',NULL,'13','13','13',NULL,NULL),(3,'2',NULL,NULL,'2','2',NULL,NULL),(4,'345',NULL,NULL,'34','34',NULL,NULL),(5,'12',NULL,NULL,'1','1',NULL,NULL),(6,'11',NULL,NULL,'11','11',NULL,NULL),(7,'zhangsan','1212','123','343','3243',NULL,NULL),(8,'aa',NULL,NULL,'12','a',NULL,NULL);

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  KEY `FK_user_role_1` (`user_id`),
  KEY `FK_user_role_2` (`role_id`),
  CONSTRAINT `FK_user_role_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_role_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_role` */

insert  into `user_role`(`user_id`,`role_id`) values (8,10),(8,9),(7,10),(1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
