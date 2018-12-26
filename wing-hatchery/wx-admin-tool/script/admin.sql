/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : admin

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2018-12-26 14:00:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bus_file
-- ----------------------------
DROP TABLE IF EXISTS `bus_file`;
CREATE TABLE `bus_file` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `upload_date` datetime DEFAULT NULL,
  `create_data` datetime DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `upload_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `doc_file_json_path` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `picture_file_json_path` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `other_file_json_path` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `state` int(32) NOT NULL,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件存储';

-- ----------------------------
-- Records of bus_file
-- ----------------------------
INSERT INTO `bus_file` VALUES ('359b466bba294236a0cb64d5802463dc', '1020', null, null, '测试', '合同测试', '[]', '[]', '[]', '1', '1', '2018-12-26 05:36:47', '1', '2018-12-26 05:37:02', null, '0');
INSERT INTO `bus_file` VALUES ('b86ea73e165c40d9a34464e483be4cce', '1021', null, null, '测试', '合同测试', '[]', '[]', '[]', '0', '1', '2018-12-26 05:37:00', '1', '2018-12-26 05:37:00', null, '0');

-- ----------------------------
-- Table structure for game_platform
-- ----------------------------
DROP TABLE IF EXISTS `game_platform`;
CREATE TABLE `game_platform` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '平台名',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `sign_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `game_platform_name` (`name`) USING BTREE,
  KEY `game_platform_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏平台表';

-- ----------------------------
-- Records of game_platform
-- ----------------------------

-- ----------------------------
-- Table structure for role_game_platform
-- ----------------------------
DROP TABLE IF EXISTS `role_game_platform`;
CREATE TABLE `role_game_platform` (
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `game_platform_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`role_id`,`game_platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_game_platform
-- ----------------------------

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所有父级编号',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域名称',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`) USING BTREE,
  KEY `sys_area_parent_ids` (`parent_ids`(255)) USING BTREE,
  KEY `sys_area_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES ('0896d017434f4744bc1e6cbb4774fff0', '3c78fa9133dd45d0a32ffee22c084370', '0,1,3c78fa9133dd45d0a32ffee22c084370,', '210101', '闸北区', '4', '2', '2014-10-20 10:37:35', '2', '2014-10-20 10:37:50', '', '0');
INSERT INTO `sys_area` VALUES ('1', '0', '0,', '100000', '中国', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('10', '8', '0,1,2,', '370532', '历城区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('11', '8', '0,1,2,', '370533', '历城区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('12', '8', '0,1,2,', '370534', '历下区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('13', '8', '0,1,2,', '370535', '天桥区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('14', '8', '0,1,2,', '370536', '槐荫区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('2', '1', '0,1,', '110000', '北京市', '2', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('3', '2', '0,1,2,', '110101', '东城区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('3c78fa9133dd45d0a32ffee22c084370', '1', '0,1,', '210000', '上海', '2', '2', '2014-10-20 10:35:05', '2', '2014-10-20 10:37:02', '', '0');
INSERT INTO `sys_area` VALUES ('4', '2', '0,1,2,', '110102', '西城区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('5', '2', '0,1,2,', '110103', '朝阳区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('6', '2', '0,1,2,', '110104', '丰台区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('7', '2', '0,1,2,', '110105', '海淀区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('8', '1', '0,1,', '370000', '山东省', '2', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('9', '8', '0,1,2,', '370531', '济南市', '3', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('d21855870feb47849b63717b3f4085a1', '3c78fa9133dd45d0a32ffee22c084370', '0,1,3c78fa9133dd45d0a32ffee22c084370,', '210102', '浦东区', '4', '2', '2014-10-20 10:38:09', '2', '2014-10-20 10:38:14', '', '0');

-- ----------------------------
-- Table structure for sys_daoliang
-- ----------------------------
DROP TABLE IF EXISTS `sys_daoliang`;
CREATE TABLE `sys_daoliang` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cpa` int(11) NOT NULL,
  `pid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_daoliang
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `international_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据值',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`label`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('02e7ae514ca84aadba45b0cd4be26a41', '已发送', 'dict1', '1', 'email_status', '系统邮件状态', '20', '104bc53879da4752b175acd55f10c1d3', '2014-11-07 09:32:59', '104bc53879da4752b175acd55f10c1d3', '2014-11-07 09:32:59', null, '1');
INSERT INTO `sys_dict` VALUES ('086dd1eb846640a88a8bbd7c9d4eb2a3', '托尔', 'dict2', 'hs004', 'huashen_type', '化神', '10', '1', '2015-07-30 16:14:22', '1', '2015-07-30 16:20:44', null, '1');
INSERT INTO `sys_dict` VALUES ('09aa06a35ebf40198cde97ea8f05808e', '游戏建议', 'dict3', '0', 'feedback_type', '反馈类型', '10', '1', '2014-11-20 14:56:57', '1', '2014-11-20 14:56:57', null, '1');
INSERT INTO `sys_dict` VALUES ('0a0654b4ce904a048c47190fe84b4203', '已取消', 'dict4', '2', 'recharge_status', '充值状态', '30', '1', '2014-11-13 16:05:58', '1', '2014-11-13 16:05:58', null, '1');
INSERT INTO `sys_dict` VALUES ('0d82e500ee084dcca2408d81320f5a37', '进行中', 'dict5', '2', 'notice_status', '公告状态', '30', '1', '2014-10-30 15:47:50', '1', '2014-10-30 15:47:50', null, '1');
INSERT INTO `sys_dict` VALUES ('1', '正常', 'dict6', '0', 'del_flag', '删除标记', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('10', '黄色', 'dict7', 'yellow', 'color', '颜色值', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('108f0c04c61d40a781a15b990cf4ac14', '维护', 'dict8', '1', 'server_status', '服务器状态', '11', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-21 10:29:18', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-21 10:29:18', null, '0');
INSERT INTO `sys_dict` VALUES ('11', '橙色', 'dict9', 'orange', 'color', '颜色值', '50', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('12', '默认主题', 'dict10', 'default', 'theme', '主题方案', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('129bc2f8083f48ac9958eacda355f25e', '守望者', 'dict126', 'A1', 'destiny_type', '天命', '20', '1', '2015-11-13 11:27:00', '1', '2015-11-13 11:27:00', '', '1');
INSERT INTO `sys_dict` VALUES ('13', '天蓝主题', 'dict11', 'cerulean', 'theme', '主题方案', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('14', '橙色主题', 'dict12', 'readable', 'theme', '主题方案', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('15', '红色主题', 'dict13', 'united', 'theme', '主题方案', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('15b3b77588b84993b85b0a4c52530bf8', '已取消', 'dict14', '4', 'notice_status', '公告状态', '50', '1', '2014-10-30 15:49:26', '1', '2014-10-30 15:49:26', null, '1');
INSERT INTO `sys_dict` VALUES ('16', 'Flat主题', 'dict15', 'flat', 'theme', '主题方案', '60', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('16d4e11583104006b364d0d97ae3f237', '帝释天', 'dict16', 'hs005', 'huashen_type', '化神', '20', '1', '2015-07-30 16:14:58', '1', '2015-07-30 16:21:21', null, '1');
INSERT INTO `sys_dict` VALUES ('16d8a27a70334c1d8c91c51deb89d1be', '战士', 'dict17', 'A', 'job_type', 'job_type', '10', '1', '2015-02-09 17:04:55', '1', '2015-02-09 17:04:55', null, '1');
INSERT INTO `sys_dict` VALUES ('17', '国家', 'dict18', '1', 'sys_area_type', '区域类型', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('18', '省份、直辖市', 'dict19', '2', 'sys_area_type', '区域类型', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('19', '地市', 'dict20', '3', 'sys_area_type', '区域类型', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('19839da7ecc740f9ac19a27a41e88515', '王钻至尊', 'dict21', '3', 'lv_type', '特权卡等级', '30', '1', '2015-08-31 16:33:23', '1', '2015-08-31 16:33:23', null, '1');
INSERT INTO `sys_dict` VALUES ('1b1c8d8fd3d640778ca74ac16cddc8c7', 'vip1用户', 'dict22', '1', 'log_type', '用户', '80', '1', '2015-08-03 13:29:19', '1', '2015-08-03 13:29:19', null, '1');
INSERT INTO `sys_dict` VALUES ('1e39de1f681845a29e381ed2521ec136', '流浪旅人', 'dict127', 'B0', 'destiny_type', '天命', '120', '1', '2015-11-13 11:34:00', '1', '2015-11-13 11:34:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2', '删除', 'dict23', '1', 'del_flag', '删除标记', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('20', '区县', 'dict24', '4', 'sys_area_type', '区域类型', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('21', '公司', 'dict25', '1', 'sys_office_type', '机构类型', '60', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('22', '部门', 'dict26', '2', 'sys_office_type', '机构类型', '70', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('23', '一级', 'dict27', '1', 'sys_office_grade', '机构等级', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('23c86cf467584759b6f0daa3af537efc', '审批中', 'dict28', '0', 'email_status', '系统邮件状态', '10', '104bc53879da4752b175acd55f10c1d3', '2014-11-07 09:31:29', '104bc53879da4752b175acd55f10c1d3', '2014-11-07 09:31:29', null, '1');
INSERT INTO `sys_dict` VALUES ('24', '二级', 'dict29', '2', 'sys_office_grade', '机构等级', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('24a27081853145e4b1660ccda45d7d08', '阿努比斯', 'dict30', 'hs002', 'huashen_type', '化神', '30', '1', '2015-07-30 16:13:33', '1', '2015-07-30 16:13:33', null, '1');
INSERT INTO `sys_dict` VALUES ('25', '三级', 'dict31', '3', 'sys_office_grade', '机构等级', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('26', '四级', 'dict32', '4', 'sys_office_grade', '机构等级', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('27', '所有数据', 'dict33', '1', 'sys_data_scope', '数据范围', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('28', '所在公司及以下数据', 'dict34', '2', 'sys_data_scope', '数据范围', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('29', '所在公司数据', 'dict35', '3', 'sys_data_scope', '数据范围', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('2a5271a364fe41efb38d54ab6197e897', '圣殿骑士', 'dict128', 'A4', 'destiny_type', '天命', '50', '1', '2015-11-13 11:29:00', '1', '2015-11-13 11:29:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3217', '神之突破', 'dict129', 'B9', 'destiny_type', '天命', '210', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:51:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3277', '神之突破', 'dict130', 'B11', 'destiny_type', '天命', '230', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:51:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf32w7', '银月贤者', 'dict131', 'C5', 'destiny_type', '天命', '290', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:53:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3377', '神之突破', 'dict132', 'B10', 'destiny_type', '天命', '220', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:51:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3476', '银月游侠', 'dict133', 'B3', 'destiny_type', '天命', '150', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:36:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3477', '卓越射手', 'dict134', 'B4', 'destiny_type', '天命', '160', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:50:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3478', '神圣射手', 'dict135', 'B5', 'destiny_type', '天命', '170', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:50:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3479', '风暴追逐者', 'dict136', 'B6', 'destiny_type', '天命', '180', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:50:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3480', '幻影支配者', 'dict137', 'B7', 'destiny_type', '天命', '190', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:51:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cf3490', '阿斯嘉德箭帝', 'dict138', 'B8', 'destiny_type', '天命', '200', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:51:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfa477', '流浪旅人', 'dict139', 'C0', 'destiny_type', '天命', '250', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:59:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfb2b7', '神圣魔导师', 'dict140', 'C7', 'destiny_type', '天命', '310', '1', '2015-11-13 11:36:00', '1', '2015-11-13 12:01:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfb2c7', '阿斯嘉德先知', 'dict141', 'C8', 'destiny_type', '天命', '320', '1', '2015-11-13 11:36:00', '1', '2015-11-13 12:01:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfb2d7', '神之突破', 'dict142', 'C9', 'destiny_type', '天命', '330', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:58:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfb2e7', '神之突破', 'dict143', 'C10', 'destiny_type', '天命', '340', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:58:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfb2p7', '神之突破', 'dict144', 'C11', 'destiny_type', '天命', '350', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:58:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfb478', '神圣射手', 'dict145', 'C1', 'destiny_type', '天命', '240', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:52:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfc479', '影刃法师', 'dict146', 'C2', 'destiny_type', '天命', '260', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:52:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfd490', '元素智者', 'dict147', 'C4', 'destiny_type', '天命', '280', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:52:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfg3a7', '灵魂掠夺者', 'dict148', 'C6', 'destiny_type', '天命', '300', '1', '2015-11-13 11:36:00', '1', '2015-11-13 12:01:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2b12a065a430492e8411e10464cfr480', '幻羽法师', 'dict149', 'C3', 'destiny_type', '天命', '270', '1', '2015-11-13 11:36:00', '1', '2015-11-13 11:52:00', '', '1');
INSERT INTO `sys_dict` VALUES ('2dd1d3b61a0b4cf08d31e277188bd7f4', '滚动公告', 'dict36', '2', 'notice_type', '公告类型', '20', '1', '2014-10-30 10:56:40', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-30 14:07:32', null, '1');
INSERT INTO `sys_dict` VALUES ('2e6b785c52ea4cc98df77d463a931952', 'vip10用户', 'dict37', '10', 'log_type', '用户', '170', '1', '2015-08-20 13:48:25', '1', '2015-08-20 13:48:25', null, '1');
INSERT INTO `sys_dict` VALUES ('3', '显示', 'dict38', '1', 'show_hide', '显示/隐藏', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('30', '所在部门及以下数据', 'dict39', '4', 'sys_data_scope', '数据范围', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('307f4c5a203e433a82b16f6f7cfd82e6', '怪物聊天', 'dict40', '6', 'chat_channel', '聊天频道', '70', '1', '2014-11-21 17:34:56', '1', '2014-11-21 17:34:56', null, '1');
INSERT INTO `sys_dict` VALUES ('31', '所在部门数据', 'dict41', '5', 'sys_data_scope', '数据范围', '50', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('314d435bbbe546438c10a2b01cb53a1a', '神圣骑士', 'dict150', 'A5', 'destiny_type', '天命', '60', '1', '2015-11-13 11:30:00', '1', '2015-11-13 11:30:00', '', '1');
INSERT INTO `sys_dict` VALUES ('32', '仅本人数据', 'dict42', '8', 'sys_data_scope', '数据范围', '90', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('33', '按明细设置', 'dict43', '9', 'sys_data_scope', '数据范围', '100', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('34', '系统管理', 'dict44', '1', 'sys_user_type', '用户类型', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('342457af503d496ba984f7e1f1a67742', '刀锋战士', 'dict151', 'A3', 'destiny_type', '天命', '40', '1', '2015-11-13 11:28:00', '1', '2015-11-13 11:28:00', '', '1');
INSERT INTO `sys_dict` VALUES ('35', '部门经理', 'dict45', '2', 'sys_user_type', '用户类型', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('36', '普通用户', 'dict46', '3', 'sys_user_type', '用户类型', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('38ed696b7a284c0fad87f9228f888096', '元宝', 'dict47', '2', 'money_type', '货币类型', '10', '1', '2014-11-13 16:11:16', '1', '2014-11-28 14:31:42', null, '1');
INSERT INTO `sys_dict` VALUES ('3fe7dbe0b4c84cdd87aa59338185c596', '杨戬', 'dict48', 'hs006', 'huashen_type', '化神', '40', '1', '2015-07-30 16:15:22', '1', '2015-07-30 16:21:39', null, '1');
INSERT INTO `sys_dict` VALUES ('4', '隐藏', 'dict49', '0', 'show_hide', '显示/隐藏', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('40861076a18c4a5785155b416bbb50a0', '绿钻贵族', 'dict50', '1', 'lv_type', '特权卡等级', '10', '1', '2015-08-31 16:32:30', '1', '2015-08-31 16:32:30', null, '1');
INSERT INTO `sys_dict` VALUES ('41ce78bddad2477789db59616fcf5910', '神之突破', 'dict152', 'A9', 'destiny_type', '天命', '100', '1', '2015-11-13 11:32:00', '1', '2015-11-13 11:32:00', '', '1');
INSERT INTO `sys_dict` VALUES ('4858f18cd600457f982f750f2d75fd08', '免费用户', 'dict51', 'log04', 'log_type', '用户', '40', '1', '2015-08-03 13:26:35', '1', '2015-08-03 13:26:35', null, '1');
INSERT INTO `sys_dict` VALUES ('4acf33d700634ae9982b4f2e98184dd8', '追猎者', 'dict153', 'B1', 'destiny_type', '天命', '130', '1', '2015-11-13 11:34:00', '1', '2015-11-13 11:35:00', '', '1');
INSERT INTO `sys_dict` VALUES ('4b255b098fab461b9b2c757fa18c1800', '玩家奖励充值', 'dict52', '0', 'recharge_type', '充值类型', '10', '1', '2014-11-13 16:07:41', '1', '2014-11-13 16:07:41', null, '1');
INSERT INTO `sys_dict` VALUES ('4c30dcc41dcb429ab8e737ce8c663933', 'vip2用户', 'dict53', '2', 'log_type', '用户', '90', '1', '2015-08-03 13:29:48', '1', '2015-08-03 13:29:48', null, '1');
INSERT INTO `sys_dict` VALUES ('4ed5e233e5404f719bc1e8f0c129245d', '停止', 'dict54', '2', 'server_status', '服务器状态', '12', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-21 10:29:29', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-21 10:29:29', null, '0');
INSERT INTO `sys_dict` VALUES ('5', '是', 'dict55', '1', 'yes_no', '是/否', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('51cfea5cab4c4038bbfa3da78ed44a2d', 'vip5用户', 'dict56', '5', 'log_type', '用户', '120', '1', '2015-08-20 13:45:13', '1', '2015-08-20 13:45:13', null, '1');
INSERT INTO `sys_dict` VALUES ('5369bfaa916e422e91f51b7d62508295', '平台', 'dict57', '1', 'pid_server', '平台及服务器', '10', '1', '2015-09-15 14:31:47', '1', '2015-09-15 14:31:47', null, '0');
INSERT INTO `sys_dict` VALUES ('5397d5763aa74de2993436446bd9f482', '圣域裁决者', 'dict154', 'A7', 'destiny_type', '天命', '80', '1', '2015-11-13 11:31:00', '1', '2015-11-13 11:31:00', '', '1');
INSERT INTO `sys_dict` VALUES ('566494379c3a44cda527361192c4e624', '流浪旅人', 'dict58', '1', 'destiny_type', '天命', '10', '1', '2015-08-31 13:35:10', '1', '2015-08-31 13:36:13', null, '1');
INSERT INTO `sys_dict` VALUES ('5730b43a5b4b4dafa478890743f6bd32', 'vip9用户', 'dict59', '9', 'log_type', '用户', '160', '1', '2015-08-20 13:47:48', '1', '2015-08-20 13:47:48', null, '1');
INSERT INTO `sys_dict` VALUES ('585aeb7c998746eda5630d11ed8df07c', '阿瑞斯', 'dict60', 'hs003', 'huashen_type', '化神', '50', '1', '2015-07-30 16:14:03', '1', '2015-07-30 16:20:36', null, '1');
INSERT INTO `sys_dict` VALUES ('5a8bc0ba51ab4b028b509e7a184d769b', '去新用户', 'dict61', 'log03', 'log_type', '用户', '30', '1', '2015-08-03 13:26:06', '1', '2015-08-03 13:26:06', null, '1');
INSERT INTO `sys_dict` VALUES ('5b659721d9394a19b9293cfbcba4e50b', 'BUG反馈', 'dict62', '1', 'feedback_type', '反馈类型', '20', '1', '2014-11-20 14:57:14', '1', '2014-11-20 14:57:14', null, '1');
INSERT INTO `sys_dict` VALUES ('5dc85ed9d8024808b7691200eac751c9', '平台充值', 'dict63', '3', 'recharge_type', '充值类型', '40', '2', '2015-03-25 11:57:09', '2', '2015-03-25 11:57:09', null, '1');
INSERT INTO `sys_dict` VALUES ('6', '否', 'dict64', '0', 'yes_no', '是/否', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('60', '调休', 'dict65', '4', 'oa_leave_type', '请假类型', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('61', '婚假', 'dict66', '5', 'oa_leave_type', '请假类型', '60', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('61061e36dd88466188391daf77b34a1b', '奥丁', 'dict67', 'hs009', 'huashen_type', '化神', '60', '1', '2015-07-30 16:15:42', '1', '2015-07-30 16:15:42', null, '1');
INSERT INTO `sys_dict` VALUES ('6125d2472e104c108f9e41bac1126031', '待审批', 'dict68', '0', 'recharge_status', '充值状态', '10', '1', '2014-11-13 16:05:27', '1', '2014-11-13 16:05:27', null, '1');
INSERT INTO `sys_dict` VALUES ('62', '接入日志', 'dict69', '1', 'sys_log_type', '日志类型', '30', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('63', '异常日志', 'dict70', '2', 'sys_log_type', '日志类型', '40', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('637045428edd458088e72503c38b9157', '已结束', 'dict71', '3', 'notice_status', '公告状态', '40', '1', '2014-10-30 15:48:19', '1', '2014-10-30 15:48:19', null, '1');
INSERT INTO `sys_dict` VALUES ('64', '单表增删改查', 'dict72', 'single', 'prj_template_type', '代码模板', '10', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('65', '所有entity和dao', 'dict73', 'entityAndDao', 'prj_template_type', '代码模板', '20', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('65fa3daa7b974a7393b2e4b8aa95b139', 'GM命令', 'dict74', '7', 'chat_channel', '聊天频道', '80', '1', '2014-11-21 17:35:04', '1', '2014-11-21 17:35:04', null, '1');
INSERT INTO `sys_dict` VALUES ('674bcb9f704448f5a0101abbc85bae81', '付费活跃用户', 'dict75', 'log07', 'log_type', '用户', '70', '1', '2015-08-03 13:28:06', '1', '2015-08-03 13:28:06', null, '1');
INSERT INTO `sys_dict` VALUES ('6bbcdb8c46ea48cebd131dbb05a601c5', 'vip12用户', 'dict76', '12', 'log_type', '用户', '190', '1', '2015-08-20 13:49:10', '1', '2015-08-20 13:52:18', null, '1');
INSERT INTO `sys_dict` VALUES ('6f480bcdb7d2411e9ccb42d9dcd9ecc2', '紫钻王者', 'dict77', '2', 'lv_type', '紫钻王者', '20', '1', '2015-08-31 16:32:55', '1', '2015-08-31 16:32:55', null, '1');
INSERT INTO `sys_dict` VALUES ('7', '红色', 'dict78', 'red', 'color', '颜色值', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('7345b1d7bc41422892086e9aaa6e1727', '新增主题', 'dict163', 'new', 'theme', '主题方案', '70', '1', '2016-11-08 13:07:26', '1', '2016-11-08 13:07:26', '', '0');
INSERT INTO `sys_dict` VALUES ('73e3f7c3ed8640c496521cd5043d1924', 'vip7用户', 'dict79', '7', 'log_type', '用户', '140', '1', '2015-08-20 13:46:46', '1', '2015-08-20 13:46:46', null, '1');
INSERT INTO `sys_dict` VALUES ('75b3a14d67104e8a8b20b014b546fec2', '绑定元宝', 'dict80', '3', 'money_type', '货币类型', '20', '1', '2014-11-13 16:11:37', '1', '2014-11-28 14:31:55', null, '1');
INSERT INTO `sys_dict` VALUES ('7defc76be4bc4940a6e8b0648f6760a1', '神之突破', 'dict155', 'A10', 'destiny_type', '天命', '110', '1', '2015-11-13 11:33:00', '1', '2015-11-13 11:33:00', '', '1');
INSERT INTO `sys_dict` VALUES ('7e077814fa5a42d8acdeecc6b5dc4f32', '国家聊天', 'dict125', '10', 'chat_channel', '聊天频道', '110', '1', '2015-11-12 15:47:21', '1', '2015-11-12 15:47:21', null, '1');
INSERT INTO `sys_dict` VALUES ('7f63fe99110040518c6d9df6234822c4', '付费用户', 'dict81', '0', 'log_type', '用户', '60', '1', '2015-08-03 13:27:37', '1', '2015-08-03 13:27:37', null, '1');
INSERT INTO `sys_dict` VALUES ('7f8aacce809a495cb982370c3c63db29', 'vip11用户', 'dict82', '11', 'log_type', '用户', '180', '1', '2015-08-20 13:50:04', '1', '2015-08-20 13:52:12', null, '1');
INSERT INTO `sys_dict` VALUES ('8', '绿色', 'dict83', 'green', 'color', '颜色值', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('824b8f981fe8430e86e44260ad551bd8', '神殿守护者', 'dict156', 'A6', 'destiny_type', '天命', '70', '1', '2015-11-13 11:30:00', '1', '2015-11-13 11:30:00', '', '1');
INSERT INTO `sys_dict` VALUES ('8303468bb80b49e5a8ee58476aa93ab2', '玩家补偿充值', 'dict84', '2', 'recharge_type', '充值类型', '30', '1', '2014-11-13 16:09:04', '1', '2014-11-13 16:09:04', null, '1');
INSERT INTO `sys_dict` VALUES ('831b65c6f26446f386cfe0cf0848d879', '罗刹', 'dict162', 'D', 'job_type', 'job_type', '40', '1', '2015-02-09 17:05:11', '1', '2015-02-09 17:05:11', null, '1');
INSERT INTO `sys_dict` VALUES ('831b65c6f26446f386cfe1cf0848d879', '法师', 'dict85', 'C', 'job_type', 'job_type', '30', '1', '2015-02-09 17:05:11', '1', '2015-02-09 17:05:11', null, '1');
INSERT INTO `sys_dict` VALUES ('851ebaee03464615b7d10292ce293378', '公会聊天', 'dict86', '3', 'chat_channel', '聊天频道', '40', '1', '2014-11-21 17:33:50', '1', '2014-11-21 17:33:50', null, '1');
INSERT INTO `sys_dict` VALUES ('858a7e53debd4ea092f3163bcd83b672', '活跃用户', 'dict87', 'log01', 'log_type', '用户', '10', '1', '2015-08-03 13:25:08', '1', '2015-08-03 13:25:08', null, '1');
INSERT INTO `sys_dict` VALUES ('8728c27613c447059790529f0115585f', '服务器', 'dict88', '2', 'pid_server', '平台及服务器', '20', '1', '2015-09-15 14:32:14', '1', '2015-09-15 14:32:14', null, '0');
INSERT INTO `sys_dict` VALUES ('878c9c68490b48788ca48b1367d94d2e', '世界频道', 'dict89', '4', 'chat_channel', '聊天频道', '50', '1', '2014-11-21 17:34:09', '1', '2014-11-21 17:34:09', null, '1');
INSERT INTO `sys_dict` VALUES ('8a6f101ee7684334bf027f0e99b207aa', '神之突破', 'dict161', 'A11', 'destiny_type', '天命', '110', '1', '2016-05-04 11:13:16', '1', '2016-05-04 11:13:16', '', '1');
INSERT INTO `sys_dict` VALUES ('8a6f101ee7684334bf027f0e99b208ea', '发送中', 'dict160', '3', 'email_status', '系统邮件状态', '40', '1', '2015-11-30 11:53:16', '1', '2015-11-30 11:53:16', '', '1');
INSERT INTO `sys_dict` VALUES ('8b7e6b0500ef414990561837531d13a5', '活动聊天', 'dict90', '8', 'chat_channel', '聊天频道', '90', '1', '2014-11-21 17:35:17', '1', '2014-11-21 17:35:17', null, '1');
INSERT INTO `sys_dict` VALUES ('8fdd30f48b7b4d7283d4f8e72483996b', 'vip3用户', 'dict91', '3', 'log_type', '用户', '100', '1', '2015-08-20 13:43:24', '1', '2015-08-20 13:43:37', null, '1');
INSERT INTO `sys_dict` VALUES ('9', '蓝色', 'dict92', 'blue', 'color', '颜色值', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('9080dfc1004c458ebf8053f138cdd34a', '宙斯', 'dict93', 'hs016', 'huashen_type', '化神', '90', '1', '2015-07-30 16:16:12', '1', '2015-07-30 16:21:49', null, '1');
INSERT INTO `sys_dict` VALUES ('958044d63f614a6e9a197650b0312e20', '公会贡献值', 'dict94', '5', 'money_type', '货币类型', '40', '1', '2015-05-06 13:32:44', '1', '2015-05-06 13:32:44', null, '1');
INSERT INTO `sys_dict` VALUES ('978976afadf945b9b11f95d04a76b031', '世界公告', 'dict95', '0', 'notice_type', '公告类型', '10', '1', '2014-10-30 10:52:42', '1', '2014-10-30 10:52:42', null, '1');
INSERT INTO `sys_dict` VALUES ('9862894d04ad42b2824d53a562ea8c6c', '队伍聊天', 'dict96', '2', 'chat_channel', '聊天频道', '30', '1', '2014-11-21 17:33:35', '1', '2014-11-21 17:33:35', null, '1');
INSERT INTO `sys_dict` VALUES ('9c39c8d5a1214a9b8a20e744cece8388', '公会团队聊天', 'dict97', '9', 'chat_channel', '聊天频道', '100', '1', '2014-11-21 17:35:30', '1', '2014-11-21 17:35:30', null, '1');
INSERT INTO `sys_dict` VALUES ('9d5a671c18fd45bc81e49673a106f268', 'GM', 'dict98', '1', 'role_type', '游戏角色类型', '20', '1', '2014-11-19 13:13:40', '1', '2014-11-21 09:50:19', null, '0');
INSERT INTO `sys_dict` VALUES ('9dc635bd84634214928c2cd9be3c0fdd', 'vip4用户', 'dict99', '4', 'log_type', '用户', '110', '1', '2015-08-20 13:44:34', '1', '2015-08-20 13:44:34', null, '1');
INSERT INTO `sys_dict` VALUES ('a0c7164e8fbe4a45a98cbcd5d178e4d3', '私聊', 'dict100', '1', 'chat_channel', '聊天频道', '20', '1', '2014-11-21 17:01:46', '1', '2014-11-21 17:33:18', null, '1');
INSERT INTO `sys_dict` VALUES ('a82d4a0441ff443790d2534e7be96180', '正常', 'dict101', '0', 'server_status', '服务器状态', '10', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-21 10:29:09', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-21 10:29:09', null, '0');
INSERT INTO `sys_dict` VALUES ('a89dbbd08a9b47bcac6a44479f91c789', '系统公告', 'dict102', '1', 'notice_type', '公告类型', '20', '1', '2014-10-30 10:56:54', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-30 14:11:19', null, '1');
INSERT INTO `sys_dict` VALUES ('b69ab051d54844b0b5a265d63a050228', '孙悟空', 'dict103', 'hs000', 'huashen_type', '化神', '70', '1', '2015-07-30 16:11:14', '1', '2015-07-30 16:11:14', null, '1');
INSERT INTO `sys_dict` VALUES ('b82f57e5164e45479fb94f07e62066e0', '免费活跃用户', 'dict104', 'log05', 'log_type', '用户', '50', '1', '2015-08-03 13:27:08', '1', '2015-08-03 13:27:08', null, '1');
INSERT INTO `sys_dict` VALUES ('bb2d531285cf45f588f355faf56a0c5d', '金币', 'dict105', '1', 'money_type', '货币类型', '30', '1', '2014-11-13 16:11:53', '1', '2014-11-28 14:31:37', null, '1');
INSERT INTO `sys_dict` VALUES ('bd0ead379e4d42a4a8b142e780749724', '国家玩法', 'dict106', '1', 'crossType', '跨服战斗模式', '11', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-22 16:59:42', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-22 17:12:21', null, '1');
INSERT INTO `sys_dict` VALUES ('be3c9b8853394b8a832ff8b60ec9eeed', '客服号', 'dict107', '3', 'role_type', '游戏角色类型', '40', '1', '2015-03-03 09:59:14', '1', '2015-03-03 09:59:20', null, '0');
INSERT INTO `sys_dict` VALUES ('bfd41c62a89a41549e58a1dd4ab91693', 'vip6用户', 'dict108', '6', 'log_type', '用户', '130', '1', '2015-08-20 13:46:18', '1', '2015-08-20 13:46:18', null, '1');
INSERT INTO `sys_dict` VALUES ('c0ed09a15f334620883633ada18276f4', '喇叭', 'dict109', '5', 'chat_channel', '聊天频道', '60', '1', '2014-11-21 17:34:22', '1', '2014-11-21 17:34:22', null, '1');
INSERT INTO `sys_dict` VALUES ('c3f6487190f941b19eaff95810e31ee6', '新用户', 'dict110', 'log02', 'log_type', '用户', '20', '1', '2015-08-03 13:25:42', '1', '2015-08-03 13:25:42', null, '1');
INSERT INTO `sys_dict` VALUES ('c560c18cc7944d41a5e0e01cb9cb2656', '场景内聊天', 'dict111', '0', 'chat_channel', '聊天频道', '10', '1', '2014-11-21 17:01:19', '1', '2014-11-21 17:33:06', null, '1');
INSERT INTO `sys_dict` VALUES ('c63c11604ed74d32ae24e98702d59b2f', '已审批', 'dict112', '1', 'recharge_status', '充值状态', '20', '1', '2014-11-13 16:05:49', '1', '2014-11-13 16:05:49', null, '1');
INSERT INTO `sys_dict` VALUES ('c6d49403e4944ce6bf52c44611663286', '尚未发布', 'dict113', '0', 'notice_status', '公告状态', '10', '1', '2014-10-30 15:47:13', '1', '2014-10-30 15:47:13', null, '1');
INSERT INTO `sys_dict` VALUES ('c7dda63c9b444533a8c240d2210c2ba9', '普通玩家', 'dict114', '0', 'role_type', '游戏角色类型', '30', '1', '2015-02-03 10:16:08', '1', '2015-02-03 10:16:08', null, '0');
INSERT INTO `sys_dict` VALUES ('c90ba6c53f9f443d83ff44113dfc7d35', '匹配服务器', 'dict115', '0', 'crossType', '跨服战斗模式', '10', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-22 16:59:15', 'bebede4ccd604db8a0375fa2b880a8a0', '2015-01-22 17:12:14', null, '1');
INSERT INTO `sys_dict` VALUES ('cc944eb6ca744466ab156500ccb1dfa5', '指导员', 'dict116', '2', 'role_type', '游戏角色类型', '10', '1', '2014-11-19 13:13:28', '1', '2014-11-21 09:50:14', null, '0');
INSERT INTO `sys_dict` VALUES ('d30fee33638d4452b9431498198f2b59', '内部人员充值', 'dict117', '1', 'recharge_type', '充值类型', '20', '1', '2014-11-13 16:08:42', '1', '2014-11-13 16:08:42', null, '1');
INSERT INTO `sys_dict` VALUES ('db3d9a1285444ed4832cbd09a641dfe3', '丛林猎手', 'dict157', 'B2', 'destiny_type', '天命', '140', '1', '2015-11-13 11:35:00', '1', '2015-11-13 11:35:00', '', '1');
INSERT INTO `sys_dict` VALUES ('df13cf28d18b42a68419520785c1c456', 'vip8用户', 'dict118', '8', 'log_type', '用户', '150', '1', '2015-08-20 13:48:07', '1', '2015-08-20 13:49:47', null, '1');
INSERT INTO `sys_dict` VALUES ('e0239effe25e4945b55f7c183b6b66e5', '阿斯嘉德战神', 'dict158', 'A8', 'destiny_type', '天命', '90', '1', '2015-11-13 11:31:00', '1', '2015-11-13 11:31:00', '', '1');
INSERT INTO `sys_dict` VALUES ('e04f0bec1c214fecac82b27e85d5c4a2', '雅典娜', 'dict119', 'hs001', 'huashen_type', '化神', '80', '1', '2015-07-30 16:11:42', '1', '2015-07-30 16:12:04', null, '1');
INSERT INTO `sys_dict` VALUES ('e4a8250bb0c54ceab830bf7f2818b00f', '剑刃勇士', 'dict159', 'A2', 'destiny_type', '天命', '30', '1', '2015-11-13 11:28:00', '1', '2015-11-13 11:28:00', '', '1');
INSERT INTO `sys_dict` VALUES ('e7898ad3bb7448d7a023f55d2c99b060', '猎人', 'dict120', 'B', 'job_type', 'job_type', '20', '1', '2015-02-09 17:05:03', '1', '2015-02-09 17:05:03', null, '1');
INSERT INTO `sys_dict` VALUES ('eadf0062f6bc467ba8fabf2dce96acbe', '其他', 'dict121', '3', 'feedback_type', '反馈类型', '40', '1', '2014-11-20 14:57:34', '1', '2014-11-20 14:57:34', null, '1');
INSERT INTO `sys_dict` VALUES ('eb51004b075d4cde99641dd97e4b9173', '已发布', 'dict122', '1', 'notice_status', '公告状态', '20', '1', '2014-10-30 15:47:33', '1', '2014-10-30 15:47:33', null, '1');
INSERT INTO `sys_dict` VALUES ('ee5a6ca13ef44fbeabc04c6a60cd4c9f', '投诉', 'dict123', '2', 'feedback_type', '反馈类型', '30', '1', '2014-11-20 14:57:26', '1', '2014-11-20 14:57:26', null, '1');
INSERT INTO `sys_dict` VALUES ('fcfdc68d227f4a7c8b4b6bc2064cb089', '已取消', 'dict124', '2', 'email_status', '系统邮件状态', '30', '104bc53879da4752b175acd55f10c1d3', '2014-11-07 09:33:13', '104bc53879da4752b175acd55f10c1d3', '2014-11-07 09:33:13', null, '1');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '1' COMMENT '日志类型',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '操作提交的数据',
  `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`) USING BTREE,
  KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
  KEY `sys_log_type` (`type`) USING BTREE,
  KEY `sys_log_create_date` (`create_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('03784498d7764b67bbe0790608a77fc6', '1', '1', '2018-12-11 08:23:42', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=s', '');
INSERT INTO `sys_log` VALUES ('1424da09f1ca405baae00b1c628d9617', '2', '1', '2018-12-08 12:53:51', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&desc=test', 'org.hibernate.exception.SQLGrammarException: could not extract ResultSet');
INSERT INTO `sys_log` VALUES ('1a2e35b5141a4a24aa40f72d17acde8d', '1', '1', '2018-12-11 08:43:37', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=2e60592984fe409d8d911a8cf297f2d9&fileId=1020&content=测试&uploadDesc=jy ', '');
INSERT INTO `sys_log` VALUES ('1faa90f1c9c14267bbf9b4c310cf65e6', '1', '1', '2018-12-08 14:40:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=', '');
INSERT INTO `sys_log` VALUES ('224d462ad16d460d9e08d4cf7e7c3b72', '1', '1', '2018-12-11 08:43:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=9fbbd6697e074e6ebac7742222fde659&fileId=1020', '');
INSERT INTO `sys_log` VALUES ('2300f99f4031405cb840ed0718e332ea', '1', '1', '2018-12-09 03:12:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=', '');
INSERT INTO `sys_log` VALUES ('290bde70ce4e498185ff4a9e60a6fe9e', '2', '1', '2018-12-09 06:22:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&desc=', 'org.springframework.dao.InvalidDataAccessResourceUsageException: could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement');
INSERT INTO `sys_log` VALUES ('2cca33325db84c1399d7ec82f106a116', '1', '1', '2018-12-11 08:22:48', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=2', '');
INSERT INTO `sys_log` VALUES ('33c9c43866ba48c8a31a49caa31d169c', '2', '1', '2018-12-08 12:43:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=t', 'org.hibernate.exception.SQLGrammarException: could not extract ResultSet');
INSERT INTO `sys_log` VALUES ('34bb97e7b948484ea31f4deadb4ca622', '1', '1', '2018-12-11 08:14:04', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=624a10df13274070aab9ef93d84922a3&fileId=1020&content=测试&uploadDesc=ttt', '');
INSERT INTO `sys_log` VALUES ('431af6ecd2184c8aa5b7133885e98893', '1', '1', '2018-12-08 14:49:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=', '');
INSERT INTO `sys_log` VALUES ('4939f2888b91412aa3b784757027d80c', '2', '1', '2018-12-09 06:29:25', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=', 'org.springframework.dao.InvalidDataAccessResourceUsageException: could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement');
INSERT INTO `sys_log` VALUES ('498f330b23a7459398563122db3ab1a5', '2', '1', '2018-12-08 13:13:53', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=ces', 'org.hibernate.exception.SQLGrammarException: could not extract ResultSet');
INSERT INTO `sys_log` VALUES ('545f77dfa9e54f099c9ed97012c8cfc8', '1', '1', '2018-12-11 08:23:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=9fbbd6697e074e6ebac7742222fde659&fileId=1020&content=测试&uploadDesc=2', '');
INSERT INTO `sys_log` VALUES ('5b65f0fbf49a43a0a681e9b9e59736c3', '1', '1', '2018-12-26 05:37:00', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1021&content=测试&uploadDesc=合同测试', '');
INSERT INTO `sys_log` VALUES ('5faa8cd176494e17860ccf00e9390654', '1', '1', '2018-12-11 11:11:33', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1021&content=测试2&uploadDesc=2', '');
INSERT INTO `sys_log` VALUES ('6172b69dadd54bf1a898d7488302db18', '1', '1', '2018-12-08 14:28:27', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&desc=t', '');
INSERT INTO `sys_log` VALUES ('6cb3dba065f34756b0525d4f80fb5518', '1', '1', '2018-12-09 11:06:11', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=566d2fa4e39e43298235a462e106a289', '');
INSERT INTO `sys_log` VALUES ('6d4c2231010749e59ec7674a33b23c8f', '1', '1', '2018-12-22 08:41:55', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=c0009f5a3e1d4b2c93c17493a422efee&fileId=1020', '');
INSERT INTO `sys_log` VALUES ('80bbbe97a9aa438888d9a4cda6fc7d3f', '1', '1', '2018-12-26 05:36:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=合同测试', '');
INSERT INTO `sys_log` VALUES ('80c78a5ca51a4ab2aef375321ed239c9', '1', '1', '2018-12-11 08:24:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=9fbbd6697e074e6ebac7742222fde659&fileId=1020&content=测试&uploadDesc=2 b', '');
INSERT INTO `sys_log` VALUES ('829fa87b48ed4f3ba5d256dd7e7ccba7', '2', '1', '2018-12-09 06:10:21', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&desc=', 'org.springframework.dao.InvalidDataAccessResourceUsageException: could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement');
INSERT INTO `sys_log` VALUES ('83022570e9384dc4af9ef73fab3388ea', '2', '1', '2018-12-08 12:56:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=d', 'org.hibernate.exception.SQLGrammarException: could not extract ResultSet');
INSERT INTO `sys_log` VALUES ('87990c18f42a4ee5817be0a8decc0551', '1', '1', '2018-12-09 11:03:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=1020', '');
INSERT INTO `sys_log` VALUES ('8836e3e91c2947529b6f0ebf37396798', '1', '1', '2018-12-26 05:36:31', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=582d65e3ac3a4db597f69ab460e1167f&fileId=1021', '');
INSERT INTO `sys_log` VALUES ('889d7ec740074b8da34c9489b2a13c81', '2', '1', '2018-12-09 06:38:10', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', 'org.springframework.orm.hibernate4.HibernateJdbcException: JDBC exception on Hibernate data access: SQLException for SQL [n/a]; SQL state [HY000]; error code [1364]; could not execute statement; nested exception is org.hibernate.exception.GenericJDBCException: could not execute statement');
INSERT INTO `sys_log` VALUES ('972aab21439a43a2a20ff652edfc54b6', '1', '1', '2018-12-11 08:13:52', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', '');
INSERT INTO `sys_log` VALUES ('9c73cc33dcb64a1bb610a344f0431590', '1', '1', '2018-12-11 08:43:18', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', '');
INSERT INTO `sys_log` VALUES ('9eef0d6798ea47ab8eb127776de4af3e', '1', '1', '2018-12-11 11:13:54', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1023&content=3&uploadDesc=3', '');
INSERT INTO `sys_log` VALUES ('a2ac00555e6846f68c5ae1bf51ed0121', '1', '1', '2018-12-11 08:43:22', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=2e60592984fe409d8d911a8cf297f2d9&fileId=1020&content=测试&uploadDesc=j ', '');
INSERT INTO `sys_log` VALUES ('a55f5f8a673740e594a8cf648b3016d6', '1', '1', '2018-12-11 08:13:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=624a10df13274070aab9ef93d84922a3&fileId=1020&content=测试&uploadDesc=ttt', '');
INSERT INTO `sys_log` VALUES ('a58aeb9635744aa9a816dfc0923fcc6b', '1', '1', '2018-12-08 14:36:26', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=d', '');
INSERT INTO `sys_log` VALUES ('a9e628f091ba431183d2fc29cfc8bb7b', '1', '1', '2018-12-11 08:43:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=a3988b106aa54d42b10b541a1e7bf345&fileId=1020', '');
INSERT INTO `sys_log` VALUES ('b3df5c31600b4cd8a6be8d3c9bbb3268', '1', '1', '2018-12-09 06:42:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', '');
INSERT INTO `sys_log` VALUES ('b736cbc15d4b4f5fb2bdfa8b96460671', '2', '1', '2018-12-09 03:20:56', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&desc=', 'org.springframework.dao.InvalidDataAccessResourceUsageException: could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement');
INSERT INTO `sys_log` VALUES ('b8ca1bdca2644089bad31d0b469423f1', '1', '1', '2018-12-11 08:23:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=624a10df13274070aab9ef93d84922a3&fileId=1020', '');
INSERT INTO `sys_log` VALUES ('c249ad474a2f44d7b19be1b7546a1e39', '1', '1', '2018-12-26 05:36:34', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=1bf3a0ec380e4e3f8447e14284cf8dfb&fileId=1023', '');
INSERT INTO `sys_log` VALUES ('c9fbb3a51c17424b97eb8d5fce798572', '1', '1', '2018-12-08 13:20:00', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&desc=t', '');
INSERT INTO `sys_log` VALUES ('d60720df52c1490b9d7b8e51a2e4924e', '1', '1', '2018-12-09 11:09:51', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=ad12f859fcd544e3a0c43fd74f806174&fileId=1020', '');
INSERT INTO `sys_log` VALUES ('d8046ba1568440f38e3a697b2b5b141c', '1', '1', '2018-12-11 08:45:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/delete', 'GET', 'id=2e60592984fe409d8d911a8cf297f2d9&fileId=1020', '');
INSERT INTO `sys_log` VALUES ('de4311b9110241ae9a9f84c3b34126ce', '2', '1', '2018-12-09 06:40:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', 'javax.validation.UnexpectedTypeException: HV000030: No validator could be found for type: java.lang.Integer.');
INSERT INTO `sys_log` VALUES ('e05971cd75a946e89ccaf01d18bff275', '2', '1', '2018-12-09 03:16:50', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=test&desc=', 'org.springframework.dao.InvalidDataAccessResourceUsageException: could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement');
INSERT INTO `sys_log` VALUES ('ed6dde1b38e84ffaa357ce05c88b8ac5', '1', '1', '2018-12-11 08:45:30', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', '');
INSERT INTO `sys_log` VALUES ('f00c51ee41074577a1e1b2719286458a', '1', '1', '2018-12-09 11:09:47', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', '/admin/a/bus/file/save', 'POST', 'id=&fileId=1020&content=测试&uploadDesc=', '');

-- ----------------------------
-- Table structure for sys_mdict
-- ----------------------------
DROP TABLE IF EXISTS `sys_mdict`;
CREATE TABLE `sys_mdict` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`) USING BTREE,
  KEY `sys_mdict_parent_ids` (`parent_ids`(255)) USING BTREE,
  KEY `sys_mdict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='多级字典表';

-- ----------------------------
-- Records of sys_mdict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `international_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '链接',
  `target` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `is_show` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`) USING BTREE,
  KEY `sys_menu_parent_ids` (`parent_ids`(255)) USING BTREE,
  KEY `sys_menu_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('01ee679ac7ab4752bd87dde13cd60bbc', 'b8d1ac047bb74a038e26a7bd5ec7f050', '0,1,b8d1ac047bb74a038e26a7bd5ec7f050,', '合同处理中心', 'bus.file.manager', '', '', 'briefcase', '30', '1', '', '1', '2018-12-02 08:06:34', '1', '2018-12-11 10:58:46', null, '0');
INSERT INTO `sys_menu` VALUES ('0b8f61959129420bac915bb68c9f56cb', '1', '0,1,', '客服工具', 'customer.tools', '', '', '', '800', '1', '', '1', '2014-10-29 16:05:56', '1', '2015-02-06 17:00:20', null, '1');
INSERT INTO `sys_menu` VALUES ('1', '0', '0,', '顶级菜单', 'top.menu', null, null, null, '0', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('10', '3', '0,1,2,3,', '字典管理', 'dict.manager', '/sys/dict/', null, 'th-list', '60', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '10', '0,1,2,3,10,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:dict:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '10', '0,1,2,3,10,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:dict:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '2', '0,1,2,', '用户管理', 'group.user', '', '', '', '970', '1', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '13', '0,1,2,13,', '区域管理', 'area.manager', '/sys/area/', '', 'th', '50', '0', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('15', '14', '0,1,2,13,14,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:area:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('16', '14', '0,1,2,13,14,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:area:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('17', '13', '0,1,2,13,', '机构管理', 'office.manager', '/sys/office/', '', 'th-large', '40', '0', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('18', '17', '0,1,2,13,17,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:office:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('19', '17', '0,1,2,13,17,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:office:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('1f18c145bb1a46a0b0dbf4a6e6d65e0d', '9b5f5c9874964798b912033bb54bd31e', '0,1,ba8605c15e5647709e6552006a843964,455d3e03f56044288760a4eacc650673,9b5f5c9874964798b912033bb54bd31e,', '查看', 'log.level.view', '', '', '', '30', '1', 'log.level.view', '1', '2015-01-29 11:27:35', '1', '2015-02-06 17:00:23', null, '0');
INSERT INTO `sys_menu` VALUES ('2', '1', '0,1,', '系统设置', 'system.setup', '', '', '', '9000', '1', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '13', '0,1,2,13,', '用户管理', 'user.manager', '/sys/user/', null, 'user', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '20', '0,1,2,13,20,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:user:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '20', '0,1,2,13,20,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:user:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '0,1,', '我的面板', 'my.dashboard', '', '', '', '100', '1', '', '1', '2013-05-27 08:00:00', '1', '2017-08-21 17:20:54', null, '0');
INSERT INTO `sys_menu` VALUES ('28', '27', '0,1,27,', '个人信息', 'person.info', null, null, null, '990', '1', null, '1', '2013-05-27 08:00:00', '1', '2017-08-21 17:20:55', null, '0');
INSERT INTO `sys_menu` VALUES ('29', '28', '0,1,27,28,', '个人信息', 'person.info', '/sys/user/info', null, 'user', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2017-08-21 17:20:55', null, '0');
INSERT INTO `sys_menu` VALUES ('3', '2', '0,1,2,', '系统设置', 'system.manager', null, null, null, '980', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('30', '28', '0,1,27,28,', '修改密码', 'modify.password', '/sys/user/modifyPwd', null, 'lock', '40', '1', null, '1', '2013-05-27 08:00:00', '1', '2017-08-21 17:20:55', null, '0');
INSERT INTO `sys_menu` VALUES ('3146b18984134f099842932b301b7f3c', '0b8f61959129420bac915bb68c9f56cb', '0,1,0b8f61959129420bac915bb68c9f56cb,', '客服工具', 'customer.tools', '', '', '', '30', '1', '', '1', '2014-10-29 16:15:44', '1', '2015-02-06 17:00:20', null, '1');
INSERT INTO `sys_menu` VALUES ('4', '3', '0,1,2,3,', '菜单管理', 'menu.manager', '/sys/menu/', null, 'list-alt', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('5', '4', '0,1,2,3,4,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:menu:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('6', '4', '0,1,2,3,4,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:menu:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('7', '3', '0,1,2,3,', '角色管理', 'role.manager', '/sys/role/', null, 'lock', '50', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('7e8f14c38b96402795f9589df302ba76', '01ee679ac7ab4752bd87dde13cd60bbc', '0,1,b8d1ac047bb74a038e26a7bd5ec7f050,01ee679ac7ab4752bd87dde13cd60bbc,', '合同预处理', 'bus.file.upload', '/bus/file/list', '', 'upload', '30', '1', 'bus:file:manager', '1', '2018-12-02 08:25:46', '1', '2018-12-11 11:03:35', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '7', '0,1,2,3,7,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:role:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '7', '0,1,2,3,7,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:role:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('9c43c42b990940898740aadd5499ebf5', '01ee679ac7ab4752bd87dde13cd60bbc', '0,1,b8d1ac047bb74a038e26a7bd5ec7f050,01ee679ac7ab4752bd87dde13cd60bbc,', '归档合同查看', 'bus.file.view', '/bus/file/list2', '', 'list', '30', '1', 'bus:file:view', '1', '2018-12-11 11:04:43', '1', '2018-12-11 11:04:43', null, '0');
INSERT INTO `sys_menu` VALUES ('a9b0d84039cd4815825ef12183f5ec5e', '7e8f14c38b96402795f9589df302ba76', '0,1,b8d1ac047bb74a038e26a7bd5ec7f050,01ee679ac7ab4752bd87dde13cd60bbc,7e8f14c38b96402795f9589df302ba76,', '合同处理列表', 'bus.file.upload.list', '', '', '', '30', '0', 'bus:file:manager', '1', '2018-12-07 13:28:36', '1', '2018-12-11 11:03:35', null, '1');
INSERT INTO `sys_menu` VALUES ('b8d1ac047bb74a038e26a7bd5ec7f050', '1', '0,1,', '业务管理', 'bus.top', '', '', '', '30', '1', '', '1', '2018-12-02 08:02:50', '1', '2018-12-02 08:02:50', null, '0');
INSERT INTO `sys_menu` VALUES ('ea5b954083f64a2d88e04b1b611d7618', '7e8f14c38b96402795f9589df302ba76', '0,1,b8d1ac047bb74a038e26a7bd5ec7f050,01ee679ac7ab4752bd87dde13cd60bbc,7e8f14c38b96402795f9589df302ba76,', '合同归档', 'bus.file.upload', '', '', '', '30', '0', 'bus:file:upload', '1', '2018-12-09 07:17:26', '1', '2018-12-11 11:03:35', null, '1');
INSERT INTO `sys_menu` VALUES ('fff08b3f09c14ee6add9288afdb99c92', '01ee679ac7ab4752bd87dde13cd60bbc', '0,1,b8d1ac047bb74a038e26a7bd5ec7f050,01ee679ac7ab4752bd87dde13cd60bbc,', '合同归档', 'bus.file.upload', '', '', '', '30', '0', 'bus:file:upload', '1', '2018-12-26 05:48:59', '1', '2018-12-26 05:48:59', null, '0');

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所有父级编号',
  `area_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '归属区域',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构名称',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构类型',
  `grade` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构等级',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传真',
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`) USING BTREE,
  KEY `sys_office_parent_ids` (`parent_ids`(255)) USING BTREE,
  KEY `sys_office_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
-- Records of sys_office
-- ----------------------------
INSERT INTO `sys_office` VALUES ('1', '0', '0,', '2', '100000', '无锡宝时德信息技术有限公司', '1', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('10', '7', '0,1,7,', '8', '200003', '市场部', '2', '2', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('11', '7', '0,1,7,', '8', '200004', '技术部', '2', '2', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('12', '7', '0,1,7,', '9', '201000', '济南市分公司', '1', '3', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('13', '12', '0,1,7,12,', '9', '201001', '公司领导', '2', '3', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('14', '12', '0,1,7,12,', '9', '201002', '综合部', '2', '3', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('15', '12', '0,1,7,12,', '9', '201003', '市场部', '2', '3', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('16', '12', '0,1,7,12,', '9', '201004', '技术部', '2', '3', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('17', '12', '0,1,7,12,', '11', '201010', '济南市历城区分公司', '1', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('18', '17', '0,1,7,12,17,', '11', '201011', '公司领导', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('19', '17', '0,1,7,12,17,', '11', '201012', '综合部', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('1bf1cccd375445f599b21310be96138a', '8', '0,1,7,8,', '8', '200003', '策划部', '2', '2', '', '', '', '', '', '', '2', '2014-10-17 16:44:01', '2', '2014-10-20 10:42:46', '', '1');
INSERT INTO `sys_office` VALUES ('2', '1', '0,1,', '2', '100001', '公司领导', '2', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_office` VALUES ('20', '17', '0,1,7,12,17,', '11', '201013', '市场部', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('21', '17', '0,1,7,12,17,', '11', '201014', '技术部', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('22', '12', '0,1,7,12,', '12', '201020', '济南市历下区分公司', '1', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('23', '22', '0,1,7,12,22,', '12', '201021', '公司领导', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('24', '22', '0,1,7,12,22,', '12', '201022', '综合部', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('25', '22', '0,1,7,12,22,', '12', '201023', '市场部', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('26', '22', '0,1,7,12,22,', '12', '201024', '技术部', '2', '4', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('3', '1', '0,1,', '2', '100002', '人力部', '2', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_office` VALUES ('4', '1', '0,1,', '2', '100003', '市场部', '2', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_office` VALUES ('5', '1', '0,1,', '2', '100004', '技术部', '2', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_office` VALUES ('6', '1', '0,1,', '2', '100005', '研发部', '2', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_office` VALUES ('6a146b43f197498aa0ce0d1cdea51a5a', '7', '0,1,7,', '8', '200003', '策划部', '2', '1', '', '', '', '', '', '', '2', '2014-10-17 16:44:40', '2', '2014-10-20 10:42:46', '', '1');
INSERT INTO `sys_office` VALUES ('7', '1', '0,1,', '0896d017434f4744bc1e6cbb4774fff0', '200000', '无锡宝时德信息技术有限公司', '1', '2', '', '', '', '', '', '', '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', '', '1');
INSERT INTO `sys_office` VALUES ('8', '7', '0,1,7,', '8', '200001', '公司领导', '2', '2', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');
INSERT INTO `sys_office` VALUES ('9', '7', '0,1,7,', '8', '200002', '综合部', '2', '2', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '2', '2014-10-20 10:42:46', null, '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `office_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据范围',
  `is_global` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否全平台权限',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '1', '系统管理员', '1', '1', '1', '2013-05-27 08:00:00', '1', '2018-12-11 11:05:00', '', '0');
INSERT INTO `sys_role` VALUES ('36070cbed9074679911a4183865ec09f', '1', '合同审核管理员', '1', null, '1', '2018-12-26 05:38:44', '1', '2018-12-26 05:49:22', '用于审核合同的归档条件', '0');
INSERT INTO `sys_role` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '1', '合同业务员', '1', null, '1', '2018-12-26 05:39:31', '1', '2018-12-26 05:49:33', '用于创建合同信息', '0');
INSERT INTO `sys_role` VALUES ('e183d2d8359f478dab51ea339be6d756', '1', '合同调阅员', '1', null, '1', '2018-12-26 05:40:15', '1', '2018-12-26 05:40:15', '仅用于调阅合同内容', '0');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '01ee679ac7ab4752bd87dde13cd60bbc');
INSERT INTO `sys_role_menu` VALUES ('1', '1');
INSERT INTO `sys_role_menu` VALUES ('1', '10');
INSERT INTO `sys_role_menu` VALUES ('1', '11');
INSERT INTO `sys_role_menu` VALUES ('1', '12');
INSERT INTO `sys_role_menu` VALUES ('1', '13');
INSERT INTO `sys_role_menu` VALUES ('1', '2');
INSERT INTO `sys_role_menu` VALUES ('1', '20');
INSERT INTO `sys_role_menu` VALUES ('1', '21');
INSERT INTO `sys_role_menu` VALUES ('1', '22');
INSERT INTO `sys_role_menu` VALUES ('1', '27');
INSERT INTO `sys_role_menu` VALUES ('1', '28');
INSERT INTO `sys_role_menu` VALUES ('1', '29');
INSERT INTO `sys_role_menu` VALUES ('1', '3');
INSERT INTO `sys_role_menu` VALUES ('1', '30');
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('1', '5');
INSERT INTO `sys_role_menu` VALUES ('1', '6');
INSERT INTO `sys_role_menu` VALUES ('1', '7');
INSERT INTO `sys_role_menu` VALUES ('1', '7e8f14c38b96402795f9589df302ba76');
INSERT INTO `sys_role_menu` VALUES ('1', '8');
INSERT INTO `sys_role_menu` VALUES ('1', '9');
INSERT INTO `sys_role_menu` VALUES ('1', '9c43c42b990940898740aadd5499ebf5');
INSERT INTO `sys_role_menu` VALUES ('1', 'b8d1ac047bb74a038e26a7bd5ec7f050');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '01ee679ac7ab4752bd87dde13cd60bbc');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '1');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '27');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '28');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '29');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '30');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '7e8f14c38b96402795f9589df302ba76');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', '9c43c42b990940898740aadd5499ebf5');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', 'b8d1ac047bb74a038e26a7bd5ec7f050');
INSERT INTO `sys_role_menu` VALUES ('36070cbed9074679911a4183865ec09f', 'fff08b3f09c14ee6add9288afdb99c92');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '01ee679ac7ab4752bd87dde13cd60bbc');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '1');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '27');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '28');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '29');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '30');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '7e8f14c38b96402795f9589df302ba76');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', '9c43c42b990940898740aadd5499ebf5');
INSERT INTO `sys_role_menu` VALUES ('aab2de7cc90b4dffb40456c71406cb85', 'b8d1ac047bb74a038e26a7bd5ec7f050');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '01ee679ac7ab4752bd87dde13cd60bbc');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '1');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '27');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '28');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '29');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '30');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', '9c43c42b990940898740aadd5499ebf5');
INSERT INTO `sys_role_menu` VALUES ('e183d2d8359f478dab51ea339be6d756', 'b8d1ac047bb74a038e26a7bd5ec7f050');

-- ----------------------------
-- Table structure for sys_role_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_office`;
CREATE TABLE `sys_role_office` (
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-机构';

-- ----------------------------
-- Records of sys_role_office
-- ----------------------------
INSERT INTO `sys_role_office` VALUES ('7', '10');
INSERT INTO `sys_role_office` VALUES ('7', '11');
INSERT INTO `sys_role_office` VALUES ('7', '12');
INSERT INTO `sys_role_office` VALUES ('7', '13');
INSERT INTO `sys_role_office` VALUES ('7', '14');
INSERT INTO `sys_role_office` VALUES ('7', '15');
INSERT INTO `sys_role_office` VALUES ('7', '16');
INSERT INTO `sys_role_office` VALUES ('7', '17');
INSERT INTO `sys_role_office` VALUES ('7', '18');
INSERT INTO `sys_role_office` VALUES ('7', '19');
INSERT INTO `sys_role_office` VALUES ('7', '20');
INSERT INTO `sys_role_office` VALUES ('7', '21');
INSERT INTO `sys_role_office` VALUES ('7', '22');
INSERT INTO `sys_role_office` VALUES ('7', '23');
INSERT INTO `sys_role_office` VALUES ('7', '24');
INSERT INTO `sys_role_office` VALUES ('7', '25');
INSERT INTO `sys_role_office` VALUES ('7', '26');
INSERT INTO `sys_role_office` VALUES ('7', '7');
INSERT INTO `sys_role_office` VALUES ('7', '8');
INSERT INTO `sys_role_office` VALUES ('7', '9');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `company_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机',
  `user_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户类型',
  `login_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`) USING BTREE,
  KEY `sys_user_login_name` (`login_name`) USING BTREE,
  KEY `sys_user_company_id` (`company_id`) USING BTREE,
  KEY `sys_user_update_date` (`update_date`) USING BTREE,
  KEY `sys_user_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', '1', 'mars', 'ac4edb451a3ead672a354517dee6eaa5aa9dfb8e6c69dd1cbce5bfaa', '0001', 'nj', '381904379@qq.com', '8675', '8675', null, '0:0:0:0:0:0:0:1', '2018-12-26 05:57:20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', '最高管理员', '0');
INSERT INTO `sys_user` VALUES ('349702992a7441f88194fc380024be5e', '1', '1', 'huangjun', '011136982647b59321efbc2225a316a8eb64bca95ae9c9aa97c2c0a4', null, null, '', '', '', null, null, null, '1', '2018-12-26 05:41:01', '1', '2018-12-26 05:41:01', '', '0');
INSERT INTO `sys_user` VALUES ('3904be864e924f2fb6bf8cc17be050f0', '1', '1', 'shenhe1', '01b9071287c5e04d88a96170e0453efce54a89fb1336715d8c600976', null, null, '', '', '', null, '0:0:0:0:0:0:0:1', '2018-12-26 05:54:44', '1', '2018-12-26 05:42:17', '1', '2018-12-26 05:42:17', 'test', '0');
INSERT INTO `sys_user` VALUES ('498b3a43a5c04792baa1380cc34be4ca', '1', '1', 'yewu1', '8e9f32d751b7b3ae0b64cbc3652864634d8dbaa544c9a43d9875f699', null, null, '', '', '', null, '0:0:0:0:0:0:0:1', '2018-12-26 05:53:01', '1', '2018-12-26 05:42:33', '1', '2018-12-26 05:42:33', 'test', '0');
INSERT INTO `sys_user` VALUES ('6cf1e8329df342f482940d075acdab39', '1', '1', 'diaoyue1', '338f2c1563a2460a35efc1be97a24ace5f05df2a074cef11787094c1', null, null, '', '', '', null, '0:0:0:0:0:0:0:1', '2018-12-26 05:45:52', '1', '2018-12-26 05:43:04', '1', '2018-12-26 05:43:04', 'test', '0');
INSERT INTO `sys_user` VALUES ('af80dc1422ae4321b68229a92c722d6e', '1', '1', 'nijia', '8ee4e0aac5bad72046892ad4d9e367cd9809782a2d986a85c1ca1f8b', null, null, '', '', '', null, null, null, '1', '2018-12-09 03:19:05', '1', '2018-12-09 03:19:05', '', '0');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('349702992a7441f88194fc380024be5e', '1');
INSERT INTO `sys_user_role` VALUES ('3904be864e924f2fb6bf8cc17be050f0', '36070cbed9074679911a4183865ec09f');
INSERT INTO `sys_user_role` VALUES ('498b3a43a5c04792baa1380cc34be4ca', 'aab2de7cc90b4dffb40456c71406cb85');
INSERT INTO `sys_user_role` VALUES ('6cf1e8329df342f482940d075acdab39', 'e183d2d8359f478dab51ea339be6d756');
INSERT INTO `sys_user_role` VALUES ('af80dc1422ae4321b68229a92c722d6e', '1');
