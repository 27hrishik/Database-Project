-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: bus
-- ------------------------------------------------------
-- Server version	8.0.17

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
  `operator_user_name` varchar(10) NOT NULL,
  `from_city` varchar(10) NOT NULL,
  `to_city` varchar(10) NOT NULL,
  `dept_time` time NOT NULL,
  `arvl_time` time NOT NULL,	
  `capacity` int(11) NOT NULL,
  `bus_type` varchar(10) DEFAULT NULL,
  `bus_name` varchar(10) DEFAULT NULL,
  `pickup_location` varchar(10) NOT NULL,
  `drop_location` varchar(10) NOT NULL,
  `cost` int(11) NOT NULL,
  `monday` boolean DEFAULT FALSE,
  `tuesday` boolean DEFAULT FALSE,
  `wednesday` boolean DEFAULT FALSE,
  `thursday` boolean DEFAULT FALSE,
  `friday` boolean DEFAULT FALSE,
  `saturday` boolean DEFAULT FALSE,
  `sunday` boolean DEFAULT FALSE,
  PRIMARY KEY (`bus_id`),
  KEY `ous_fk` (`operator_user_name`),
  CONSTRAINT `ous_fk` FOREIGN KEY (`operator_user_name`) REFERENCES `operator` (`operator_user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_detail`
--

LOCK TABLES `bus_detail` WRITE;
/*!40000 ALTER TABLE `bus_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `bus_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operator` (
  `operator_user_name` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL,
  `operator_name` varchar(10) NOT NULL,
  `address` varchar(20) NOT NULL,	
  `email` varchar(15) NOT NULL,
  `mobile` int(11) NOT NULL,
  PRIMARY KEY (`operator_user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
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
  CONSTRAINT `sbi_fk` FOREIGN KEY (`bus_id`,`date_of_journey`) REFERENCES `seat_availability` (`bus_id`,`date_of_journey`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sbi_fk2` FOREIGN KEY (`check_availability`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
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
  `name` varchar(10) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` char NOT NULL,
  PRIMARY KEY (`ticket_id`),
  CONSTRAINT `sbti_fk` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_booked`
--

LOCK TABLES `seat_booked` WRITE;
/*!40000 ALTER TABLE `seat_booked` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_booked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_of_journey` date NOT NULL,
  `user_name` varchar(10) NULL,
  `bus_id` int(11) NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `tun_fk` (`user_name`),
  KEY `tbi_fk` (`bus_id`),
  CONSTRAINT `tbi_fk` FOREIGN KEY (`bus_id`) REFERENCES `bus_detail` (`bus_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `tun_fk` FOREIGN KEY (`user_name`) REFERENCES `user` (`user_name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_name` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL,
  `mobile` int(11) NOT NULL,
  `email` varchar(20) NOT NULL,
  `address` varchar(30) NOT NULL,
  `gender` char NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
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

-- Dump completed on 2019-10-03 21:56:41
