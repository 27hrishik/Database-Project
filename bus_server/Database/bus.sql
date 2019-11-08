-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: localhost    Database: busdb
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `bus_detail`
--

DROP TABLE IF EXISTS `bus_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus_detail` (
  `bus_id` int(11) NOT NULL AUTO_INCREMENT,
  `operator_user_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `from_city` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `to_city` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `dept_time` time NOT NULL,
  `arvl_time` time NOT NULL,
  `capacity` int(11) NOT NULL,
  `bus_type` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bus_name` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pickup_location` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `drop_location` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `cost` int(11) NOT NULL,
  `monday` tinyint(1) DEFAULT '0',
  `tuesday` tinyint(1) DEFAULT '0',
  `wednesday` tinyint(1) DEFAULT '0',
  `thursday` tinyint(1) DEFAULT '0',
  `friday` tinyint(1) DEFAULT '0',
  `saturday` tinyint(1) DEFAULT '0',
  `sunday` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`bus_id`),
  KEY `ous_fk` (`operator_user_name`),
  CONSTRAINT `ous_fk` FOREIGN KEY (`operator_user_name`) REFERENCES `operator` (`operator_user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_detail`
--

LOCK TABLES `bus_detail` WRITE;
/*!40000 ALTER TABLE `bus_detail` DISABLE KEYS */;
INSERT INTO `bus_detail` VALUES (2,'abc','bng','mys','07:45:00','12:00:00',30,'AC-SLP','Volvo','kalamandir','zoo',750,0,0,0,0,1,1,1);
/*!40000 ALTER TABLE `bus_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operator` (
  `operator_user_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `operator_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` int(11) NOT NULL,
  PRIMARY KEY (`operator_user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` VALUES ('abc','abc','abc','2nd Street','a@gmail.com',725);
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `bus_id` int(11) NOT NULL,
  `date_of_journey` date NOT NULL,
  `seat_no` int(11) NOT NULL,
  `check_availability` int(11) DEFAULT NULL,
  PRIMARY KEY (`bus_id`,`date_of_journey`,`seat_no`),
  KEY `sbi_fk` (`bus_id`),
  KEY `sbi_fk2` (`check_availability`),
  CONSTRAINT `sbi_fk` FOREIGN KEY (`bus_id`, `date_of_journey`) REFERENCES `seat_availability` (`bus_id`, `date_of_journey`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sbi_fk2` FOREIGN KEY (`check_availability`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (2,'2019-11-08',5,NULL),(2,'2019-11-08',7,NULL),(2,'2019-11-08',8,NULL),(2,'2019-11-08',9,NULL),(2,'2019-11-08',10,NULL),(2,'2019-11-08',11,NULL),(2,'2019-11-08',12,NULL),(2,'2019-11-08',13,NULL),(2,'2019-11-08',14,NULL),(2,'2019-11-08',15,NULL),(2,'2019-11-08',16,NULL),(2,'2019-11-08',17,NULL),(2,'2019-11-08',18,NULL),(2,'2019-11-08',19,NULL),(2,'2019-11-08',20,NULL),(2,'2019-11-08',21,NULL),(2,'2019-11-08',22,NULL),(2,'2019-11-08',23,NULL),(2,'2019-11-08',24,NULL),(2,'2019-11-08',26,NULL),(2,'2019-11-08',29,NULL),(2,'2019-11-09',1,NULL),(2,'2019-11-09',2,NULL),(2,'2019-11-09',3,NULL),(2,'2019-11-09',4,NULL),(2,'2019-11-09',5,NULL),(2,'2019-11-09',6,NULL),(2,'2019-11-09',7,NULL),(2,'2019-11-09',8,NULL),(2,'2019-11-09',9,NULL),(2,'2019-11-09',10,NULL),(2,'2019-11-09',11,NULL),(2,'2019-11-09',12,NULL),(2,'2019-11-09',13,NULL),(2,'2019-11-09',14,NULL),(2,'2019-11-09',15,NULL),(2,'2019-11-09',16,NULL),(2,'2019-11-09',17,NULL),(2,'2019-11-09',18,NULL),(2,'2019-11-09',19,NULL),(2,'2019-11-09',20,NULL),(2,'2019-11-09',21,NULL),(2,'2019-11-09',22,NULL),(2,'2019-11-09',23,NULL),(2,'2019-11-09',24,NULL),(2,'2019-11-09',25,NULL),(2,'2019-11-09',26,NULL),(2,'2019-11-09',27,NULL),(2,'2019-11-09',28,NULL),(2,'2019-11-09',29,NULL),(2,'2019-11-09',30,NULL),(2,'2019-11-10',1,NULL),(2,'2019-11-10',2,NULL),(2,'2019-11-10',3,NULL),(2,'2019-11-10',4,NULL),(2,'2019-11-10',5,NULL),(2,'2019-11-10',6,NULL),(2,'2019-11-10',7,NULL),(2,'2019-11-10',8,NULL),(2,'2019-11-10',9,NULL),(2,'2019-11-10',10,NULL),(2,'2019-11-10',11,NULL),(2,'2019-11-10',12,NULL),(2,'2019-11-10',13,NULL),(2,'2019-11-10',14,NULL),(2,'2019-11-10',15,NULL),(2,'2019-11-10',16,NULL),(2,'2019-11-10',17,NULL),(2,'2019-11-10',18,NULL),(2,'2019-11-10',19,NULL),(2,'2019-11-10',20,NULL),(2,'2019-11-10',21,NULL),(2,'2019-11-10',22,NULL),(2,'2019-11-10',23,NULL),(2,'2019-11-10',24,NULL),(2,'2019-11-10',25,NULL),(2,'2019-11-10',26,NULL),(2,'2019-11-10',27,NULL),(2,'2019-11-10',28,NULL),(2,'2019-11-10',29,NULL),(2,'2019-11-10',30,NULL),(2,'2019-11-15',1,NULL),(2,'2019-11-15',2,NULL),(2,'2019-11-15',3,NULL),(2,'2019-11-15',4,NULL),(2,'2019-11-15',5,NULL),(2,'2019-11-15',6,NULL),(2,'2019-11-15',7,NULL),(2,'2019-11-15',8,NULL),(2,'2019-11-15',9,NULL),(2,'2019-11-15',10,NULL),(2,'2019-11-15',11,NULL),(2,'2019-11-15',12,NULL),(2,'2019-11-15',13,NULL),(2,'2019-11-15',14,NULL),(2,'2019-11-15',15,NULL),(2,'2019-11-15',16,NULL),(2,'2019-11-15',17,NULL),(2,'2019-11-15',18,NULL),(2,'2019-11-15',19,NULL),(2,'2019-11-15',20,NULL),(2,'2019-11-15',21,NULL),(2,'2019-11-15',22,NULL),(2,'2019-11-15',23,NULL),(2,'2019-11-15',24,NULL),(2,'2019-11-15',25,NULL),(2,'2019-11-15',26,NULL),(2,'2019-11-15',27,NULL),(2,'2019-11-15',28,NULL),(2,'2019-11-15',29,NULL),(2,'2019-11-15',30,NULL),(2,'2019-11-16',1,NULL),(2,'2019-11-16',2,NULL),(2,'2019-11-16',3,NULL),(2,'2019-11-16',4,NULL),(2,'2019-11-16',5,NULL),(2,'2019-11-16',6,NULL),(2,'2019-11-16',7,NULL),(2,'2019-11-16',8,NULL),(2,'2019-11-16',9,NULL),(2,'2019-11-16',10,NULL),(2,'2019-11-16',11,NULL),(2,'2019-11-16',12,NULL),(2,'2019-11-16',13,NULL),(2,'2019-11-16',14,NULL),(2,'2019-11-16',15,NULL),(2,'2019-11-16',16,NULL),(2,'2019-11-16',17,NULL),(2,'2019-11-16',18,NULL),(2,'2019-11-16',19,NULL),(2,'2019-11-16',20,NULL),(2,'2019-11-16',21,NULL),(2,'2019-11-16',22,NULL),(2,'2019-11-16',23,NULL),(2,'2019-11-16',24,NULL),(2,'2019-11-16',25,NULL),(2,'2019-11-16',26,NULL),(2,'2019-11-16',27,NULL),(2,'2019-11-16',28,NULL),(2,'2019-11-16',29,NULL),(2,'2019-11-16',30,NULL),(2,'2019-11-17',1,NULL),(2,'2019-11-17',2,NULL),(2,'2019-11-17',3,NULL),(2,'2019-11-17',4,NULL),(2,'2019-11-17',5,NULL),(2,'2019-11-17',6,NULL),(2,'2019-11-17',7,NULL),(2,'2019-11-17',8,NULL),(2,'2019-11-17',9,NULL),(2,'2019-11-17',10,NULL),(2,'2019-11-17',11,NULL),(2,'2019-11-17',12,NULL),(2,'2019-11-17',13,NULL),(2,'2019-11-17',14,NULL),(2,'2019-11-17',15,NULL),(2,'2019-11-17',16,NULL),(2,'2019-11-17',17,NULL),(2,'2019-11-17',18,NULL),(2,'2019-11-17',19,NULL),(2,'2019-11-17',20,NULL),(2,'2019-11-17',21,NULL),(2,'2019-11-17',22,NULL),(2,'2019-11-17',23,NULL),(2,'2019-11-17',24,NULL),(2,'2019-11-17',25,NULL),(2,'2019-11-17',26,NULL),(2,'2019-11-17',27,NULL),(2,'2019-11-17',28,NULL),(2,'2019-11-17',29,NULL),(2,'2019-11-17',30,NULL),(2,'2019-11-22',1,NULL),(2,'2019-11-22',2,NULL),(2,'2019-11-22',3,NULL),(2,'2019-11-22',4,NULL),(2,'2019-11-22',5,NULL),(2,'2019-11-22',6,NULL),(2,'2019-11-22',7,NULL),(2,'2019-11-22',8,NULL),(2,'2019-11-22',9,NULL),(2,'2019-11-22',10,NULL),(2,'2019-11-22',11,NULL),(2,'2019-11-22',12,NULL),(2,'2019-11-22',13,NULL),(2,'2019-11-22',14,NULL),(2,'2019-11-22',15,NULL),(2,'2019-11-22',16,NULL),(2,'2019-11-22',17,NULL),(2,'2019-11-22',18,NULL),(2,'2019-11-22',19,NULL),(2,'2019-11-22',20,NULL),(2,'2019-11-22',21,NULL),(2,'2019-11-22',22,NULL),(2,'2019-11-22',23,NULL),(2,'2019-11-22',24,NULL),(2,'2019-11-22',25,NULL),(2,'2019-11-22',26,NULL),(2,'2019-11-22',27,NULL),(2,'2019-11-22',28,NULL),(2,'2019-11-22',29,NULL),(2,'2019-11-22',30,NULL),(2,'2019-11-23',1,NULL),(2,'2019-11-23',2,NULL),(2,'2019-11-23',3,NULL),(2,'2019-11-23',4,NULL),(2,'2019-11-23',5,NULL),(2,'2019-11-23',6,NULL),(2,'2019-11-23',7,NULL),(2,'2019-11-23',8,NULL),(2,'2019-11-23',9,NULL),(2,'2019-11-23',10,NULL),(2,'2019-11-23',11,NULL),(2,'2019-11-23',12,NULL),(2,'2019-11-23',13,NULL),(2,'2019-11-23',14,NULL),(2,'2019-11-23',15,NULL),(2,'2019-11-23',16,NULL),(2,'2019-11-23',17,NULL),(2,'2019-11-23',18,NULL),(2,'2019-11-23',19,NULL),(2,'2019-11-23',20,NULL),(2,'2019-11-23',21,NULL),(2,'2019-11-23',22,NULL),(2,'2019-11-23',23,NULL),(2,'2019-11-23',24,NULL),(2,'2019-11-23',25,NULL),(2,'2019-11-23',26,NULL),(2,'2019-11-23',27,NULL),(2,'2019-11-23',28,NULL),(2,'2019-11-23',29,NULL),(2,'2019-11-23',30,NULL),(2,'2019-11-24',1,NULL),(2,'2019-11-24',2,NULL),(2,'2019-11-24',3,NULL),(2,'2019-11-24',4,NULL),(2,'2019-11-24',5,NULL),(2,'2019-11-24',6,NULL),(2,'2019-11-24',7,NULL),(2,'2019-11-24',8,NULL),(2,'2019-11-24',9,NULL),(2,'2019-11-24',10,NULL),(2,'2019-11-24',11,NULL),(2,'2019-11-24',12,NULL),(2,'2019-11-24',13,NULL),(2,'2019-11-24',14,NULL),(2,'2019-11-24',15,NULL),(2,'2019-11-24',16,NULL),(2,'2019-11-24',17,NULL),(2,'2019-11-24',18,NULL),(2,'2019-11-24',19,NULL),(2,'2019-11-24',20,NULL),(2,'2019-11-24',21,NULL),(2,'2019-11-24',22,NULL),(2,'2019-11-24',23,NULL),(2,'2019-11-24',24,NULL),(2,'2019-11-24',25,NULL),(2,'2019-11-24',26,NULL),(2,'2019-11-24',27,NULL),(2,'2019-11-24',28,NULL),(2,'2019-11-24',29,NULL),(2,'2019-11-24',30,NULL),(2,'2019-11-29',1,NULL),(2,'2019-11-29',2,NULL),(2,'2019-11-29',3,NULL),(2,'2019-11-29',4,NULL),(2,'2019-11-29',5,NULL),(2,'2019-11-29',6,NULL),(2,'2019-11-29',7,NULL),(2,'2019-11-29',8,NULL),(2,'2019-11-29',9,NULL),(2,'2019-11-29',10,NULL),(2,'2019-11-29',11,NULL),(2,'2019-11-29',12,NULL),(2,'2019-11-29',13,NULL),(2,'2019-11-29',14,NULL),(2,'2019-11-29',15,NULL),(2,'2019-11-29',16,NULL),(2,'2019-11-29',17,NULL),(2,'2019-11-29',18,NULL),(2,'2019-11-29',19,NULL),(2,'2019-11-29',20,NULL),(2,'2019-11-29',21,NULL),(2,'2019-11-29',22,NULL),(2,'2019-11-29',23,NULL),(2,'2019-11-29',24,NULL),(2,'2019-11-29',25,NULL),(2,'2019-11-29',26,NULL),(2,'2019-11-29',27,NULL),(2,'2019-11-29',28,NULL),(2,'2019-11-29',29,NULL),(2,'2019-11-29',30,NULL),(2,'2019-11-30',1,NULL),(2,'2019-11-30',2,NULL),(2,'2019-11-30',3,NULL),(2,'2019-11-30',4,NULL),(2,'2019-11-30',5,NULL),(2,'2019-11-30',6,NULL),(2,'2019-11-30',7,NULL),(2,'2019-11-30',8,NULL),(2,'2019-11-30',9,NULL),(2,'2019-11-30',10,NULL),(2,'2019-11-30',11,NULL),(2,'2019-11-30',12,NULL),(2,'2019-11-30',13,NULL),(2,'2019-11-30',14,NULL),(2,'2019-11-30',15,NULL),(2,'2019-11-30',16,NULL),(2,'2019-11-30',17,NULL),(2,'2019-11-30',18,NULL),(2,'2019-11-30',19,NULL),(2,'2019-11-30',20,NULL),(2,'2019-11-30',21,NULL),(2,'2019-11-30',22,NULL),(2,'2019-11-30',23,NULL),(2,'2019-11-30',24,NULL),(2,'2019-11-30',25,NULL),(2,'2019-11-30',26,NULL),(2,'2019-11-30',27,NULL),(2,'2019-11-30',28,NULL),(2,'2019-11-30',29,NULL),(2,'2019-11-30',30,NULL),(2,'2019-12-01',1,NULL),(2,'2019-12-01',2,NULL),(2,'2019-12-01',3,NULL),(2,'2019-12-01',4,NULL),(2,'2019-12-01',5,NULL),(2,'2019-12-01',6,NULL),(2,'2019-12-01',7,NULL),(2,'2019-12-01',8,NULL),(2,'2019-12-01',9,NULL),(2,'2019-12-01',10,NULL),(2,'2019-12-01',11,NULL),(2,'2019-12-01',12,NULL),(2,'2019-12-01',13,NULL),(2,'2019-12-01',14,NULL),(2,'2019-12-01',15,NULL),(2,'2019-12-01',16,NULL),(2,'2019-12-01',17,NULL),(2,'2019-12-01',18,NULL),(2,'2019-12-01',19,NULL),(2,'2019-12-01',20,NULL),(2,'2019-12-01',21,NULL),(2,'2019-12-01',22,NULL),(2,'2019-12-01',23,NULL),(2,'2019-12-01',24,NULL),(2,'2019-12-01',25,NULL),(2,'2019-12-01',26,NULL),(2,'2019-12-01',27,NULL),(2,'2019-12-01',28,NULL),(2,'2019-12-01',29,NULL),(2,'2019-12-01',30,NULL),(2,'2019-12-06',1,NULL),(2,'2019-12-06',2,NULL),(2,'2019-12-06',3,NULL),(2,'2019-12-06',4,NULL),(2,'2019-12-06',5,NULL),(2,'2019-12-06',6,NULL),(2,'2019-12-06',7,NULL),(2,'2019-12-06',8,NULL),(2,'2019-12-06',9,NULL),(2,'2019-12-06',10,NULL),(2,'2019-12-06',11,NULL),(2,'2019-12-06',12,NULL),(2,'2019-12-06',13,NULL),(2,'2019-12-06',14,NULL),(2,'2019-12-06',15,NULL),(2,'2019-12-06',16,NULL),(2,'2019-12-06',17,NULL),(2,'2019-12-06',18,NULL),(2,'2019-12-06',19,NULL),(2,'2019-12-06',20,NULL),(2,'2019-12-06',21,NULL),(2,'2019-12-06',22,NULL),(2,'2019-12-06',23,NULL),(2,'2019-12-06',24,NULL),(2,'2019-12-06',25,NULL),(2,'2019-12-06',26,NULL),(2,'2019-12-06',27,NULL),(2,'2019-12-06',28,NULL),(2,'2019-12-06',29,NULL),(2,'2019-12-06',30,NULL),(2,'2019-12-07',1,NULL),(2,'2019-12-07',2,NULL),(2,'2019-12-07',3,NULL),(2,'2019-12-07',4,NULL),(2,'2019-12-07',5,NULL),(2,'2019-12-07',6,NULL),(2,'2019-12-07',7,NULL),(2,'2019-12-07',8,NULL),(2,'2019-12-07',9,NULL),(2,'2019-12-07',10,NULL),(2,'2019-12-07',11,NULL),(2,'2019-12-07',12,NULL),(2,'2019-12-07',13,NULL),(2,'2019-12-07',14,NULL),(2,'2019-12-07',15,NULL),(2,'2019-12-07',16,NULL),(2,'2019-12-07',17,NULL),(2,'2019-12-07',18,NULL),(2,'2019-12-07',19,NULL),(2,'2019-12-07',20,NULL),(2,'2019-12-07',21,NULL),(2,'2019-12-07',22,NULL),(2,'2019-12-07',23,NULL),(2,'2019-12-07',24,NULL),(2,'2019-12-07',25,NULL),(2,'2019-12-07',26,NULL),(2,'2019-12-07',27,NULL),(2,'2019-12-07',28,NULL),(2,'2019-12-07',29,NULL),(2,'2019-12-07',30,NULL),(2,'2019-11-08',1,16),(2,'2019-11-08',4,16),(2,'2019-11-08',2,17),(2,'2019-11-08',6,17),(2,'2019-11-08',3,18),(2,'2019-11-08',25,19),(2,'2019-11-08',28,19),(2,'2019-11-08',27,20),(2,'2019-11-08',30,20);
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_availability`
--

DROP TABLE IF EXISTS `seat_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_availability` (
  `bus_id` int(11) NOT NULL,
  `date_of_journey` date NOT NULL,
  `seats_available` int(11) DEFAULT NULL,
  PRIMARY KEY (`bus_id`,`date_of_journey`),
  CONSTRAINT `sabi_fk` FOREIGN KEY (`bus_id`) REFERENCES `bus_detail` (`bus_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_availability`
--

LOCK TABLES `seat_availability` WRITE;
/*!40000 ALTER TABLE `seat_availability` DISABLE KEYS */;
INSERT INTO `seat_availability` VALUES (2,'2019-11-08',21),(2,'2019-11-09',30),(2,'2019-11-10',30),(2,'2019-11-15',30),(2,'2019-11-16',30),(2,'2019-11-17',30),(2,'2019-11-22',30),(2,'2019-11-23',30),(2,'2019-11-24',30),(2,'2019-11-29',30),(2,'2019-11-30',30),(2,'2019-12-01',30),(2,'2019-12-06',30),(2,'2019-12-07',30);
/*!40000 ALTER TABLE `seat_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_booked`
--

DROP TABLE IF EXISTS `seat_booked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_booked` (
  `ticket_id` int(11) NOT NULL,
  `seat_no` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  `gender` char(1) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ticket_id`,`seat_no`),
  CONSTRAINT `sbti_fk` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_booked`
--

LOCK TABLES `seat_booked` WRITE;
/*!40000 ALTER TABLE `seat_booked` DISABLE KEYS */;
INSERT INTO `seat_booked` VALUES (16,1,'hrishi',19,'M'),(16,4,'kesh',20,'M'),(17,2,'goat',21,'F'),(17,6,'khan',11,'M'),(18,3,'sour',12,'M'),(19,25,'sqeq',12,'M'),(19,28,'asd',11,'M'),(20,27,'asd',22,'F'),(20,30,'qwrrt',12,'M'),(21,11,'Hrishi',20,'M');
/*!40000 ALTER TABLE `seat_booked` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateSeat` AFTER INSERT ON `seat_booked` FOR EACH ROW begin
    declare b_id int;
    declare d date;
    select bus_id,date_of_journey into b_id,d
    from ticket
    where ticket_id = new.ticket_id;
    update seat 
    set check_availability = new.ticket_id
    where bus_id = b_id and date_of_journey = d and seat_no = new.seat_no and check_availability is null;
    update seat_availability
    set seats_available = seats_available - 1
    where bus_id = b_id and date_of_journey = d;  
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_of_journey` date NOT NULL,
  `user_name` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bus_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `tun_fk` (`user_name`),
  KEY `tbi_fk` (`bus_id`),
  CONSTRAINT `tbi_fk` FOREIGN KEY (`bus_id`) REFERENCES `bus_detail` (`bus_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `tun_fk` FOREIGN KEY (`user_name`) REFERENCES `user` (`user_name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (14,'2019-11-08','abc',2),(15,'2019-11-08','abc',2),(16,'2019-11-08','abc',2),(17,'2019-11-08','abc',2),(18,'2019-11-08','abc',2),(19,'2019-11-08','abc',2),(20,'2019-11-08','abc',2),(21,'2019-11-08','abc',NULL);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` int(11) NOT NULL,
  `email` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `gender` char(1) COLLATE utf8mb4_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('abc','abc','abc',123,'abc@gmail.com','1st ','M',22);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-08 18:13:39
