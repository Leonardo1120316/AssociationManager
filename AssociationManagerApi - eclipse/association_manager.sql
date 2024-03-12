/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : association_manager

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 14/10/2023 19:00:34
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for active_logs
-- ----------------------------
DROP TABLE IF EXISTS `active_logs`;
CREATE TABLE `active_logs`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报名时间',
  `active_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动编号',
  `user_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报名用户',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `active_id`(`active_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `active_logs_ibfk_1` FOREIGN KEY (`active_id`) REFERENCES `activities` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `active_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报名记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of active_logs
-- ----------------------------
INSERT INTO `active_logs` VALUES ('1689228560503', '2023-07-13 14:09:20', '1689228560460', '1689228178877');

-- ----------------------------
-- Table structure for activities
-- ----------------------------
DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动名称',
  `comm` varchar(1600) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动概述',
  `detail` varchar(1600) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动详情',
  `ask` varchar(1600) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动要求',
  `total` int(0) NOT NULL COMMENT '报名人数',
  `active_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动时间',
  `team_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布社团',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `team_id`(`team_id`) USING BTREE,
  CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '活动信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activities
-- ----------------------------
INSERT INTO `activities` VALUES ('1689228560460', '团内编程大赛', '大家一起组团编程', '发挥想象力，写出惊艳代码', '携带一部笔记本', 1, '2023-07-13 14:08:36', '1689228337876');

-- ----------------------------
-- Table structure for apply_logs
-- ----------------------------
DROP TABLE IF EXISTS `apply_logs`;
CREATE TABLE `apply_logs`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `status` int(0) NOT NULL COMMENT '处理状态',
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请时间',
  `team_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请社团',
  `user_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请用户',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `team_id`(`team_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `apply_logs_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `apply_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '申请记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply_logs
-- ----------------------------
INSERT INTO `apply_logs` VALUES ('1689248985360', 1, '2023-07-13 19:49:45', '1689228337876', '1689228092884');
INSERT INTO `apply_logs` VALUES ('1693923133729', 0, '2023-09-05 22:12:13', '1689228416274', '1689228092884');

-- ----------------------------
-- Table structure for members
-- ----------------------------
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入团时间',
  `team_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '加入社团',
  `user_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请用户',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `team_id`(`team_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `members_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '成员信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of members
-- ----------------------------
INSERT INTO `members` VALUES ('1689228337906', '2023-07-13 14:05:37', '1689228337876', '1689228178877');
INSERT INTO `members` VALUES ('1689228416332', '2023-07-13 14:06:56', '1689228416274', '1689228178877');
INSERT INTO `members` VALUES ('1689248992548', '2023-07-13 19:49:52', '1689228337876', '1689228092884');

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知标题',
  `detail` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知详情',
  `create_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布时间',
  `team_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布社团',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES ('1689228498611', '祝贺计算机协会圆满建立', '祝贺计算机协会圆满建立，欢迎大家的加入，共同探讨计算机领域知识', '2023-07-13', '1689228337876');
INSERT INTO `notices` VALUES ('1689249379060', '社团管理系统更新', '现已推出最新版本的社团管理系统', '2023-07-13', NULL);

-- ----------------------------
-- Table structure for pay_logs
-- ----------------------------
DROP TABLE IF EXISTS `pay_logs`;
CREATE TABLE `pay_logs`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '缴费时间',
  `total` double NOT NULL COMMENT '缴纳费用',
  `team_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收费社团',
  `user_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '缴费用户',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `team_id`(`team_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `pay_logs_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pay_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '缴费记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_logs
-- ----------------------------
INSERT INTO `pay_logs` VALUES ('1689249023966', '2023-07-13 19:50:23', 10, '1689228337876', '1689228092884');

-- ----------------------------
-- Table structure for team_types
-- ----------------------------
DROP TABLE IF EXISTS `team_types`;
CREATE TABLE `team_types`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型名称',
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '社团类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of team_types
-- ----------------------------
INSERT INTO `team_types` VALUES ('1689228308945', '科技类', '2023-07-13 14:05:08');
INSERT INTO `team_types` VALUES ('1689228383521', '文学类', '2023-07-13 14:06:23');

-- ----------------------------
-- Table structure for teams
-- ----------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '社团名称',
  `create_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '建立时间',
  `total` int(0) NOT NULL COMMENT '社团人数',
  `manager` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '社团团长',
  `type_id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '社团编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `team_types` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '社团信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teams
-- ----------------------------
INSERT INTO `teams` VALUES ('1689228337876', '计算机协会', '2023-07-13', 2, '1689228178877', '1689228308945');
INSERT INTO `teams` VALUES ('1689228416274', '马克思主义哲学协会', '2023-07-13', 1, '1689228178877', '1689228383521');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` char(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录ID',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `pass_word` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `gender` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户性别',
  `age` int(0) NULL DEFAULT NULL COMMENT '用户年龄',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `status` int(0) NOT NULL COMMENT '信息状态',
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '添加时间',
  `type` int(0) NOT NULL COMMENT '用户身份：0系统管理员，1社团管理员，2用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1689228092884', 'user', '123456', '小刘', '男', 21, '15899999999', '北京市海淀区', 1, '2022-12-27 21:43:22', 2);
INSERT INTO `users` VALUES ('1689228116467', 'superadmin', '123456', '系统管理员', '男', 22, '13666666666', '北京市海淀区', 1, '2023-01-17 20:00:00', 0);
INSERT INTO `users` VALUES ('1689228178877', 'admin', '123456', '张三', '男', 22, '14777777777', '北京市海淀区', 1, '2023-01-17 20:00:00', 1);

SET FOREIGN_KEY_CHECKS = 1;
