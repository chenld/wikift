CREATE DATABASE wikift DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE wikift;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `a_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a_title` varchar(255) NOT NULL,
  `a_content` text NOT NULL,
  `a_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fabulou_count` bigint(255) DEFAULT NULL,
  `view_count` binary(50) DEFAULT NULL,
  `comments_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `at_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `at_title` varchar(255) NOT NULL,
  `at_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`at_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `article_tag_relation`;
CREATE TABLE `article_tag_relation` (
  `atr_article_id` bigint(20) NOT NULL,
  `atr_article_tag_id` bigint(20) NOT NULL,
  KEY `FK_atr_article_1_relation_id` (`atr_article_id`),
  KEY `FK_atr_article_tag_relation_id` (`atr_article_tag_id`),
  CONSTRAINT `FK_atr_article_1_relation_id` FOREIGN KEY (`atr_article_id`) REFERENCES `article` (`a_id`),
  CONSTRAINT `FK_atr_article_tag_relation_id` FOREIGN KEY (`atr_article_tag_id`) REFERENCES `article_tag` (`at_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `article_type`;
CREATE TABLE `article_type` (
  `at_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `at_code` varchar(255) NOT NULL,
  `at_title` varchar(255) NOT NULL,
  `at_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`at_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `article_type_relation`;
CREATE TABLE `article_type_relation` (
  `atr_article_id` bigint(20) NOT NULL,
  `atr_article_type_id` bigint(20) NOT NULL,
  KEY `FK_atr_article_relation_id` (`atr_article_id`),
  KEY `FK_atr_article_type_relation_id` (`atr_article_type_id`),
  CONSTRAINT `FK_atr_article_relation_id` FOREIGN KEY (`atr_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_atr_article_type_relation_id` FOREIGN KEY (`atr_article_type_id`) REFERENCES `article_type` (`at_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `c_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `c_content` longtext COMMENT '评论内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论内容时间',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `comments_article_relation`;
CREATE TABLE `comments_article_relation` (
  `car_comments_id` bigint(20) NOT NULL,
  `car_article_id` bigint(20) NOT NULL,
  KEY `FK_car_article_relation_id` (`car_article_id`),
  KEY `FK_car_comments_relation_id` (`car_comments_id`),
  CONSTRAINT `FK_car_article_relation_id` FOREIGN KEY (`car_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_car_comments_relation_id` FOREIGN KEY (`car_comments_id`) REFERENCES `comments` (`c_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `comments_users_relation`;
CREATE TABLE `comments_users_relation` (
  `cur_comments_id` bigint(20) NOT NULL,
  `cur_users_id` bigint(20) NOT NULL,
  KEY `FK_cur_comments_relation_id` (`cur_comments_id`),
  KEY `FK_cur_users_relation_id` (`cur_users_id`),
  CONSTRAINT `FK_cur_comments_relation_id` FOREIGN KEY (`cur_comments_id`) REFERENCES `comments` (`c_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_cur_users_relation_id` FOREIGN KEY (`cur_users_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `g_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `g_name` varchar(255) NOT NULL,
  `g_description` varchar(255) NOT NULL,
  `g_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `remind`;
CREATE TABLE `remind` (
  `r_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '提醒信息id',
  `r_title` varchar(200) NOT NULL COMMENT '提醒信息标题',
  `r_content` text NOT NULL COMMENT '提醒信息内容',
  `r_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提醒信息创建时间',
  `r_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `r_read` tinyint(1) DEFAULT '0' COMMENT '是否阅读',
  `r_read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `remind_article_relation`;
CREATE TABLE `remind_article_relation` (
  `rar_remind_id` bigint(20) NOT NULL,
  `rar_article_id` bigint(20) NOT NULL,
  KEY `FK_rar_remind_relation_id` (`rar_remind_id`),
  KEY `FK_rar_article_relation_id` (`rar_article_id`),
  CONSTRAINT `FK_rar_article_relation_id` FOREIGN KEY (`rar_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_rar_remind_relation_id` FOREIGN KEY (`rar_remind_id`) REFERENCES `remind` (`r_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `remind_type`;
CREATE TABLE `remind_type` (
  `rt_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '信息类型',
  `rt_code` varchar(20) NOT NULL COMMENT '类型code,唯一标识',
  `rt_title` varchar(20) NOT NULL COMMENT '类型名称',
  `rt_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '类型创建时间',
  `rt_disabled` tinyint(1) DEFAULT '1' COMMENT '是否启用该类型',
  `rt_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`rt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `remind_type_relation`;
CREATE TABLE `remind_type_relation` (
  `rtr_remind_id` bigint(20) NOT NULL,
  `rtr_remind_type_id` bigint(20) NOT NULL,
  `rtr_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `FK_rtr_remind_relation_id` (`rtr_remind_id`),
  KEY `FK_rtr_remind_type_relation_id` (`rtr_remind_type_id`),
  CONSTRAINT `FK_rtr_remind_relation_id` FOREIGN KEY (`rtr_remind_id`) REFERENCES `remind` (`r_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_rtr_remind_type_relation_id` FOREIGN KEY (`rtr_remind_type_id`) REFERENCES `remind_type` (`rt_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `remind_users_relation`;
CREATE TABLE `remind_users_relation` (
  `rur_remind_id` bigint(20) NOT NULL,
  `rur_user_id` bigint(20) NOT NULL,
  KEY `FK_rur_remind_relation_id` (`rur_remind_id`),
  KEY `FK_rur_user_relation_id` (`rur_user_id`),
  CONSTRAINT `FK_rur_remind_relation_id` FOREIGN KEY (`rur_remind_id`) REFERENCES `remind` (`r_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_rur_user_relation_id` FOREIGN KEY (`rur_user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `r_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_name` varchar(255) DEFAULT NULL,
  `r_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`r_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `space`;
CREATE TABLE `space` (
  `s_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `s_name` varchar(20) NOT NULL COMMENT '空间名称',
  `s_code` varchar(20) NOT NULL COMMENT '空间标识',
  `s_private` tinyint(1) DEFAULT '1' COMMENT '空间是否私有, 默认是',
  `s_description` text COMMENT '空间描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '空间创建时间',
  `s_avatar` longtext,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `space_article_relation`;
CREATE TABLE `space_article_relation` (
  `sar_space_id` bigint(20) NOT NULL,
  `sar_article_id` bigint(20) NOT NULL,
  KEY `FK_sar_space_relation_id` (`sar_space_id`),
  KEY `FK_sar_article_relation_id` (`sar_article_id`),
  CONSTRAINT `FK_sar_article_relation_id` FOREIGN KEY (`sar_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_sar_space_relation_id` FOREIGN KEY (`sar_space_id`) REFERENCES `space` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `space_users_relation`;
CREATE TABLE `space_users_relation` (
  `sur_space_id` bigint(20) NOT NULL,
  `sur_users_id` bigint(20) NOT NULL,
  KEY `FK_sur_space_relation_id` (`sur_space_id`),
  KEY `FK_sur_users_relation_id` (`sur_users_id`),
  CONSTRAINT `FK_sur_space_relation_id` FOREIGN KEY (`sur_space_id`) REFERENCES `space` (`s_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_sur_users_relation_id` FOREIGN KEY (`sur_users_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `u_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `u_username` varchar(25) NOT NULL,
  `u_password` varchar(255) NOT NULL,
  `u_avatar` varchar(255) DEFAULT NULL,
  `u_alias_name` varchar(25) DEFAULT NULL,
  `u_signature` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users_article_fabulous_relation`;
CREATE TABLE `users_article_fabulous_relation` (
  `uafr_user_id` bigint(20) NOT NULL,
  `uafr_article_id` bigint(20) NOT NULL,
  `uafr_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `FK_uafr_users_fabulous_relation_id` (`uafr_user_id`),
  KEY `FK_uafr_article_fabulous_relation_id` (`uafr_article_id`),
  CONSTRAINT `FK_uafr_article_fabulous_relation_id` FOREIGN KEY (`uafr_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_uafr_users_fabulous_relation_id` FOREIGN KEY (`uafr_user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users_article_relation`;
CREATE TABLE `users_article_relation` (
  `uar_user_id` bigint(20) NOT NULL,
  `uar_article_id` bigint(20) NOT NULL,
  KEY `FK_uar_users_relation_id` (`uar_user_id`),
  KEY `FK_uar_article_relation_id` (`uar_article_id`),
  CONSTRAINT `FK_uar_article_relation_id` FOREIGN KEY (`uar_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_uar_users_relation_id` FOREIGN KEY (`uar_user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users_article_view_relation`;
CREATE TABLE `users_article_view_relation` (
  `uavr_user_id` bigint(20) NOT NULL,
  `uavr_article_id` bigint(20) NOT NULL,
  `uavr_view_count` bigint(200) NOT NULL,
  `uavr_view_device` varchar(50) NOT NULL,
  `uavr_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `FK_uavr_users_view_relation_id` (`uavr_user_id`),
  KEY `FK_uavr_article_view_relation_id` (`uavr_article_id`),
  CONSTRAINT `FK_uavr_article_view_relation_id` FOREIGN KEY (`uavr_article_id`) REFERENCES `article` (`a_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_uavr_users_view_relation_id` FOREIGN KEY (`uavr_user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users_follow_relation`;
CREATE TABLE `users_follow_relation` (
  `ufr_user_id_follw` bigint(20) NOT NULL COMMENT '关注者用户id',
  `ufr_user_id_cover` bigint(20) NOT NULL COMMENT '被关注用户id',
  `ufr_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users_groups_relation`;
CREATE TABLE `users_groups_relation` (
  `ugr_user_id` bigint(20) NOT NULL,
  `ugr_group_id` bigint(20) NOT NULL,
  KEY `FK_ugr_group_relation_id` (`ugr_group_id`),
  KEY `FK_ugr_user_relation_id` (`ugr_user_id`),
  CONSTRAINT `FK_ugr_group_relation_id` FOREIGN KEY (`ugr_group_id`) REFERENCES `groups` (`g_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ugr_user_relation_id` FOREIGN KEY (`ugr_user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `users_role_relation`;
CREATE TABLE `users_role_relation` (
  `urr_user_id` bigint(20) NOT NULL,
  `urr_role_id` bigint(20) NOT NULL,
  KEY `FK_role_id` (`urr_role_id`),
  KEY `FK_user_id` (`urr_user_id`),
  CONSTRAINT `FK_role_id` FOREIGN KEY (`urr_role_id`) REFERENCES `role` (`r_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_id` FOREIGN KEY (`urr_user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
