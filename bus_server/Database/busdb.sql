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
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'busdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `setSeats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setSeats`(
    in id int,
    in dat date,
    in cap int 
)
begin
    declare seat int default 1;
    insert ignore into seat_availability
    values (id,dat,cap);
    while seat <= cap do
        insert ignore into seat(bus_id,date_of_journey,seat_no) values (id,dat,seat);
        set seat = seat + 1;
    end while ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAvailability`(
    in id int
)
begin
    declare today_date,end_date date;
    declare mon,tue,wed,thur,fri,sat,sun boolean;
    declare cap int;
    declare seat int default 1;
    select capacity,monday,tuesday,wednesday,thursday,friday,saturday,sunday 
    into cap,mon,tue,wed,thur,fri,sat,sun 
    from bus_detail 
    where bus_id = id;
    set today_date = current_date();
    set end_date = date_add(today_date,interval 30 day);
    while today_date <= end_date do
        case weekday(today_date)
            when 0 then 
                if mon = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 1 then 
                if tue = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 2 then 
                if wed = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 3 then 
                if thur = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 4 then 
                if fri = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 5 then 
                if sat = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 6 then 
                if sun = 1 then
                    call setSeats(id,today_date,cap);
                end if;
        end case;
        set today_date = date_add(today_date,interval 1 day);                                                 
    end while;
end ;;
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

-- Dump completed on 2019-11-08 18:22:21
