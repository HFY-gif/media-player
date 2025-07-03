/*
 Navicat Premium Data Transfer

 Source Server         : hfynnn
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : media-player

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 03/07/2025 22:18:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for play_records
-- ----------------------------
DROP TABLE IF EXISTS `play_records`;
CREATE TABLE `play_records`  (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `media_type` enum('video','audio') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `media_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `played_at` datetime NULL DEFAULT (now()),
  `duration` int NULL DEFAULT NULL,
  `media_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `play_records_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of play_records
-- ----------------------------
INSERT INTO `play_records` VALUES (1, 1, 'video', 'v101', '测试视频1', '2025-07-01 10:45:56', 120, NULL);
INSERT INTO `play_records` VALUES (2, 1, 'audio', 'a202', '测试音频1', '2025-07-01 10:45:56', 240, NULL);
INSERT INTO `play_records` VALUES (3, 2, 'video', 'v102', '测试视频2', '2025-07-01 10:45:56', 180, NULL);
INSERT INTO `play_records` VALUES (4, 3, 'audio', 'a203', '测试音频2', '2025-07-01 10:45:56', 300, NULL);
INSERT INTO `play_records` VALUES (5, 1, 'video', 'v999', 'Postman测试视频', '2025-07-01 11:00:48', 200, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT (now()),
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'alice', '123456', '2025-07-01 10:45:42');
INSERT INTO `users` VALUES (2, 'bob', 'abcdef', '2025-07-01 10:45:42');
INSERT INTO `users` VALUES (3, 'charlie', 'passw0rd', '2025-07-01 10:45:42');
INSERT INTO `users` VALUES (4, 'testuser', '123123', '2025-07-01 10:59:25');
INSERT INTO `users` VALUES (7, 'hfy', '123', '2025-07-03 12:19:36');

SET FOREIGN_KEY_CHECKS = 1;
