/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : es_extended

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2021-06-26 22:55:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `advanced_vehicles`
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles`;
CREATE TABLE `advanced_vehicles` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `km` double NOT NULL DEFAULT 0,
  `vehicle_handling` longtext NOT NULL DEFAULT '{}',
  `nitroAmount` int(11) NOT NULL DEFAULT 0,
  `nitroRecharges` int(11) NOT NULL DEFAULT 0,
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`plate`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles
-- ----------------------------


-- ----------------------------
-- Table structure for `advanced_vehicles_inspection`
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles_inspection`;
CREATE TABLE `advanced_vehicles_inspection` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `item` varchar(50) NOT NULL,
  `km` int(10) NOT NULL DEFAULT 0,
  `value` double NOT NULL DEFAULT 0,
  `timer` int(10) NOT NULL DEFAULT unix_timestamp(),
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`plate`,`user_id`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles_inspection
-- ----------------------------

-- ----------------------------
-- Table structure for `advanced_vehicles_services`
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles_services`;
CREATE TABLE `advanced_vehicles_services` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `item` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `km` int(11) NOT NULL DEFAULT 0,
  `img` varchar(255) NOT NULL DEFAULT '',
  `timer` int(10) NOT NULL DEFAULT unix_timestamp(),
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`id`,`plate`),
  KEY `vehicle` (`vehicle`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles_services
-- ----------------------------

-- ----------------------------
-- Table structure for `advanced_vehicles_upgrades`
-- ----------------------------
DROP TABLE IF EXISTS `advanced_vehicles_upgrades`;
CREATE TABLE `advanced_vehicles_upgrades` (
  `vehicle` varchar(50) NOT NULL,
  `user_id` varchar(55) NOT NULL,
  `class` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL,
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`vehicle`,`user_id`,`class`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of advanced_vehicles_upgrades
-- ----------------------------
