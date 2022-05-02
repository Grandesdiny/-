/*
 Navicat Premium Data Transfer

 Source Server         : book
 Source Server Type    : MySQL
 Source Server Version : 50559
 Source Host           : localhost:3306
 Source Schema         : db_books_librarys

 Target Server Type    : MySQL
 Target Server Version : 50559
 File Encoding         : 65001

 Date: 04/03/2022 23:41:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书主键',
  `bname` varchar(205) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书名',
  `auther` varchar(205) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `num` int(5) NOT NULL COMMENT '库存',
  `residuals` int(5) NULL DEFAULT 0 COMMENT '已借',
  `press` varchar(205) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `tname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 110 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '穆斯林的葬礼', '霍达', 5, 0, '同济大学出版社', '文学');
INSERT INTO `book` VALUES (3, '基督山大小伯爵', '小仲马', 10, 0, '北京科技大学出版社', '中国历史');
INSERT INTO `book` VALUES (4, '教父', '马里奥·普佐', 5, 1, '中南民族大学出版社', '历史');
INSERT INTO `book` VALUES (5, '红高粱', 'lbai', 11, 2, '普通出版社', '文学');
INSERT INTO `book` VALUES (109, 'abcdas', 'ssfdfs', 5, 0, 'sasas', '文学');
INSERT INTO `book` VALUES (108, '上下五千年', '陆业琨', 5, 0, '中南民族大学出版社', '文学');
INSERT INTO `book` VALUES (104, 'DawnFM', 'abc', 5, 0, 'RecordRepublic', '文学');
INSERT INTO `book` VALUES (106, 'asfasfas', 'assffa', 2, 0, 'dasfsaf', '文学');
INSERT INTO `book` VALUES (107, 'dhasihi', 'dada', 2, 0, 'dada', '科技');

-- ----------------------------
-- Table structure for booktype
-- ----------------------------
DROP TABLE IF EXISTS `booktype`;
CREATE TABLE `booktype`  (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tname` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`tid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booktype
-- ----------------------------
INSERT INTO `booktype` VALUES (1, '文学');
INSERT INTO `booktype` VALUES (2, '世界历史');
INSERT INTO `booktype` VALUES (11, 'CD');
INSERT INTO `booktype` VALUES (13, '散文');

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`  (
  `hid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sid` int(11) NULL DEFAULT NULL COMMENT '学生主键',
  `bid` int(11) NULL DEFAULT NULL COMMENT '图书主键',
  `begintime` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开始时间',
  `endtime` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `timeout` int(11) NULL DEFAULT NULL COMMENT '是否超时（0表示未超时，1表示超时）',
  PRIMARY KEY (`hid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES (29, 20, 3, '2022-03-04', '2022-03-04', 0);
INSERT INTO `history` VALUES (24, 20, 103, '2022-03-04', '2022-03-04', 0);
INSERT INTO `history` VALUES (25, 20, 5, '2022-03-04', NULL, NULL);
INSERT INTO `history` VALUES (30, 1, 3, '2022-03-04', '2022-03-04', 0);
INSERT INTO `history` VALUES (28, 1, 1, '2022-03-04', '2022-03-04', 0);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `sname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `grade` int(11) NULL DEFAULT 3 COMMENT '信誉分',
  `maxnum` int(11) NULL DEFAULT 4 COMMENT '可借阅数',
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '201603140101', '张散', '138787979', 3, 4);
INSERT INTO `student` VALUES (4, '201982010509', '李时珍', '138722323131', 5, 5);
INSERT INTO `student` VALUES (5, '201603140103', '王五', '17352623320', 3, 4);
INSERT INTO `student` VALUES (20, '201921098400', '余奇龙', '110', 3, 3);
INSERT INTO `student` VALUES (22, '201921098231', '李华', '13878882312', 3, 4);
INSERT INTO `student` VALUES (23, '20198400asdas', 'abcd', '1387787', 3, 4);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `uname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '123456' COMMENT '密码',
  `utype` int(11) NULL DEFAULT NULL COMMENT '级别',
  PRIMARY KEY (`uname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1333', '123456', 2);
INSERT INTO `users` VALUES ('20002', '123456', 2);
INSERT INTO `users` VALUES ('201603140101', 'abcdefg', 3);
INSERT INTO `users` VALUES ('201603140102', '123456', 3);
INSERT INTO `users` VALUES ('201603140103', '123456', 3);
INSERT INTO `users` VALUES ('201921098231', '123456', 3);
INSERT INTO `users` VALUES ('201921098400', '123456', 3);
INSERT INTO `users` VALUES ('20198400asdas', '123456', 3);
INSERT INTO `users` VALUES ('216116', '123456', 2);
INSERT INTO `users` VALUES ('admin', 'admin', 1);

SET FOREIGN_KEY_CHECKS = 1;
