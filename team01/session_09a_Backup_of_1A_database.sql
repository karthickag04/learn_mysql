-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: 1a
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `order_cost_summary_report`
--

DROP TABLE IF EXISTS `order_cost_summary_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_cost_summary_report` (
  `order_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_cost_summary_report`
--

LOCK TABLES `order_cost_summary_report` WRITE;
/*!40000 ALTER TABLE `order_cost_summary_report` DISABLE KEYS */;
INSERT INTO `order_cost_summary_report` VALUES (2,2,'alice_wonder',499.99,'2025-05-08 10:35:31'),(7,7,'david_johnson',140.75,'2025-05-08 10:35:31'),(14,7,'david_johnson',799.98,'2025-05-08 10:35:31'),(4,4,'emily_davis',299.97,'2025-05-08 10:35:31'),(5,5,'james_bond',399.99,'2025-05-08 10:35:31'),(13,5,'james_bond',79.99,'2025-05-08 10:35:31'),(1,1,'john_doe',1009.98,'2025-05-08 10:35:31'),(11,1,'john_doe',999.98,'2025-05-08 10:35:31'),(18,1,'john_doe',NULL,'2025-05-08 10:35:31'),(16,13,'john_doe_nDew1',NULL,'2025-05-08 10:35:31'),(17,12,'john_doe_new1',NULL,'2025-05-08 10:35:31'),(8,8,'lucas_white',110.00,'2025-05-08 10:35:31'),(3,3,'mark_smith',199.99,'2025-05-08 10:35:31'),(12,3,'mark_smith',350.50,'2025-05-08 10:35:31'),(9,9,'olivia_brown',120.00,'2025-05-08 10:35:31'),(15,9,'olivia_brown',NULL,'2025-05-08 10:35:31'),(10,10,'ryan_green',199.99,'2025-05-08 10:35:31'),(6,6,'sophia_miller',701.00,'2025-05-08 10:35:31');
/*!40000 ALTER TABLE `order_cost_summary_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `order_items_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,1),(2,1,3,2),(3,2,2,1),(4,3,5,1),(5,4,7,3),(6,5,4,1),(7,6,6,2),(8,7,9,1),(9,8,10,2),(10,9,8,1),(11,10,5,1),(12,11,2,2),(13,12,6,1),(14,13,3,1),(15,14,4,2);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`test01`@`%`*/ /*!50003 TRIGGER `before_insert_order_items` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE current_stock INT;

    SELECT stock INTO current_stock FROM products WHERE product_id = NEW.product_id;

    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough stock for this product.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order_log`
--

DROP TABLE IF EXISTS `order_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `log_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_log`
--

LOCK TABLES `order_log` WRITE;
/*!40000 ALTER TABLE `order_log` DISABLE KEYS */;
INSERT INTO `order_log` VALUES (1,16,13,'2025-05-06 10:48:16','Order placed by User ID 13'),(2,17,12,'2025-05-06 10:48:52','Order placed by User ID 12'),(3,18,1,'2025-05-07 11:03:57','Order placed by User ID 1');
/*!40000 ALTER TABLE `order_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_chk_1` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2024-01-10 05:00:00',250.75),(2,2,'2024-01-12 10:15:00',120.50),(3,3,'2024-01-15 02:50:00',340.99),(4,4,'2024-01-18 06:30:00',85.30),(5,5,'2024-01-20 08:40:00',560.25),(6,6,'2024-01-22 13:00:00',199.99),(7,7,'2024-01-25 06:15:00',420.00),(8,8,'2024-01-28 11:20:00',310.80),(9,9,'2024-01-30 03:45:00',125.99),(10,10,'2024-02-02 07:50:00',275.60),(11,1,'2024-02-05 12:00:00',90.50),(12,3,'2024-02-07 05:40:00',189.20),(13,5,'2024-02-10 09:15:00',470.99),(14,7,'2024-02-12 03:00:00',320.75),(15,9,'2024-02-15 13:50:00',145.99),(16,13,'2025-05-06 10:47:00',250.75),(17,12,'2025-05-06 10:47:00',250.75),(18,1,'2025-05-06 10:47:00',456.75);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`test01`@`%`*/ /*!50003 TRIGGER `after_insert_order` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    INSERT INTO order_log (order_id, user_id, message)
    VALUES (NEW.order_id, NEW.user_id, CONCAT('Order placed by User ID ', NEW.user_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `products_chk_1` CHECK ((`price` > 0)),
  CONSTRAINT `products_chk_2` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Laptop',850.00,15),(2,'Smartphone',499.99,30),(3,'Headphones',79.99,50),(4,'Gaming Console',399.99,20),(5,'Smartwatch',199.99,25),(6,'Tablet',350.50,18),(7,'Wireless Earbuds',99.99,40),(8,'External Hard Drive',120.00,12),(9,'Mechanical Keyboard',140.75,22),(10,'Gaming Mouse',55.00,35);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tt`
--

DROP TABLE IF EXISTS `tt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tt` (
  `sno` int DEFAULT NULL,
  `name` varchar(22) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tt`
--

LOCK TABLES `tt` WRITE;
/*!40000 ALTER TABLE `tt` DISABLE KEYS */;
/*!40000 ALTER TABLE `tt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tt01`
--

DROP TABLE IF EXISTS `tt01`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tt01` (
  `sno` int DEFAULT NULL,
  `name` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tt01`
--

LOCK TABLES `tt01` WRITE;
/*!40000 ALTER TABLE `tt01` DISABLE KEYS */;
/*!40000 ALTER TABLE `tt01` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_order_summary_report`
--

DROP TABLE IF EXISTS `user_order_summary_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_order_summary_report` (
  `user_id` int DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `total_orders` int DEFAULT NULL,
  `report_generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_order_summary_report`
--

LOCK TABLES `user_order_summary_report` WRITE;
/*!40000 ALTER TABLE `user_order_summary_report` DISABLE KEYS */;
INSERT INTO `user_order_summary_report` VALUES (2,'alice_wonder',1,'2025-05-07 11:04:48'),(7,'david_johnson',2,'2025-05-07 11:04:48'),(4,'emily_davis',1,'2025-05-07 11:04:48'),(5,'james_bond',2,'2025-05-07 11:04:48'),(1,'john_doe',3,'2025-05-07 11:04:48'),(13,'john_doe_nDew1',1,'2025-05-07 11:04:48'),(11,'john_doe_new',0,'2025-05-07 11:04:48'),(12,'john_doe_new1',1,'2025-05-07 11:04:48'),(8,'lucas_white',1,'2025-05-07 11:04:48'),(3,'mark_smith',2,'2025-05-07 11:04:48'),(9,'olivia_brown',2,'2025-05-07 11:04:48'),(10,'ryan_green',1,'2025-05-07 11:04:48'),(6,'sophia_miller',1,'2025-05-07 11:04:48');
/*!40000 ALTER TABLE `user_order_summary_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_status_history`
--

DROP TABLE IF EXISTS `user_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `old_status` varchar(20) DEFAULT NULL,
  `new_status` varchar(20) DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status_history`
--

LOCK TABLES `user_status_history` WRITE;
/*!40000 ALTER TABLE `user_status_history` DISABLE KEYS */;
INSERT INTO `user_status_history` VALUES (1,1,'active','inactive','2025-05-07 10:26:09'),(2,1,'inactive','banned','2025-05-07 10:27:04');
/*!40000 ALTER TABLE `user_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `age` int DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `users_chk_1` CHECK ((`age` >= 18))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'john_doe','password123','john@example.com',25,'banned','2025-04-17 11:41:44'),(2,'alice_wonder','alice@pass','alice@example.com',30,'active','2025-04-17 11:41:44'),(3,'mark_smith','mark@2024','mark@example.com',28,'inactive','2025-04-17 11:41:44'),(4,'emily_davis','emily_pass','emily@example.com',32,'active','2025-04-17 11:41:44'),(5,'james_bond','007@agent','james@example.com',40,'banned','2025-04-17 11:41:44'),(6,'sophia_miller','sophia@pass','sophia@example.com',27,'active','2025-04-17 11:41:44'),(7,'david_johnson','david@123','david@example.com',35,'active','2025-04-17 11:41:44'),(8,'lucas_white','lucas_pass','lucas@example.com',26,'inactive','2025-04-17 11:41:44'),(9,'olivia_brown','olivia@pass','olivia@example.com',29,'active','2025-04-17 11:41:44'),(10,'ryan_green','ryan@2024','ryan@example.com',31,'active','2025-04-17 11:41:44'),(11,'john_doe_new','password123','JoHnDoeNew@example.com',25,'active','2025-05-06 10:38:42'),(12,'john_doe_new1','password123','johndoenew1@example.com',25,'active','2025-05-06 10:40:16'),(13,'john_doe_nDew1','password123','johndoddddddddenew1@example.com',25,'active','2025-05-06 10:40:57');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`test01`@`%`*/ /*!50003 TRIGGER `before_insert_users` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    SET NEW.email = LOWER(NEW.email);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`test01`@`%`*/ /*!50003 TRIGGER `after_update_user_status` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO user_status_history (user_id, old_status, new_status)
        VALUES (OLD.user_id, OLD.status, NEW.status);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-08 16:29:51
