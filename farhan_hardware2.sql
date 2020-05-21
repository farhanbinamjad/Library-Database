-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: farhan_hardware2
-- ------------------------------------------------------
-- Server version	10.1.41-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book` (
  `isbn` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author_name` varchar(40) DEFAULT NULL,
  `edition` int(11) DEFAULT NULL,
  `publisher` varchar(40) DEFAULT NULL,
  `year_of_pub` int(11) DEFAULT NULL,
  `ebook_copy` int(11) DEFAULT '0',
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES ('34543','Database','Josh',2,NULL,2013,0),('43232','Networking','Diesburg',4,'CS_UNI',2013,0);
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookAccess`
--

DROP TABLE IF EXISTS `BookAccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BookAccess` (
  `blocking_id` int(11) NOT NULL AUTO_INCREMENT,
  `facultyID_No` varchar(20) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `num_resv` int(11) DEFAULT '1',
  `reserved_till` date NOT NULL,
  PRIMARY KEY (`blocking_id`),
  KEY `facultyID_No` (`facultyID_No`),
  KEY `course_id` (`course_id`,`dept_id`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `BookAccess_ibfk_1` FOREIGN KEY (`facultyID_No`) REFERENCES `Faculty` (`facultyID_No`) ON DELETE CASCADE,
  CONSTRAINT `BookAccess_ibfk_2` FOREIGN KEY (`course_id`, `dept_id`) REFERENCES `Course` (`course_id`, `dept_id`) ON DELETE CASCADE,
  CONSTRAINT `BookAccess_ibfk_3` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookAccess`
--

LOCK TABLES `BookAccess` WRITE;
/*!40000 ALTER TABLE `BookAccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `BookAccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookList`
--

DROP TABLE IF EXISTS `BookList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BookList` (
  `book_id` varchar(20) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `is_available` int(11) DEFAULT '1',
  `blocking_id` int(11) DEFAULT NULL,
  `lib_no` int(11) DEFAULT NULL,
  `isblocked` int(1) DEFAULT '0',
  PRIMARY KEY (`book_id`),
  KEY `isbn` (`isbn`),
  KEY `blocking_id` (`blocking_id`),
  KEY `lib_no` (`lib_no`),
  CONSTRAINT `BookList_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `BookList_ibfk_2` FOREIGN KEY (`blocking_id`) REFERENCES `BookAccess` (`blocking_id`),
  CONSTRAINT `BookList_ibfk_3` FOREIGN KEY (`lib_no`) REFERENCES `Library` (`lib_no`),
  CONSTRAINT `BookList_ibfk_4` FOREIGN KEY (`book_id`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookList`
--

LOCK TABLES `BookList` WRITE;
/*!40000 ALTER TABLE `BookList` DISABLE KEYS */;
/*!40000 ALTER TABLE `BookList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CPList`
--

DROP TABLE IF EXISTS `CPList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CPList` (
  `paper_id` varchar(20) NOT NULL,
  `conf_num` varchar(20) DEFAULT NULL,
  `is_available` int(11) DEFAULT '1',
  `lib_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`paper_id`),
  KEY `conf_num` (`conf_num`),
  KEY `lib_no` (`lib_no`),
  CONSTRAINT `CPList_ibfk_1` FOREIGN KEY (`conf_num`) REFERENCES `Conf` (`conf_num`) ON DELETE CASCADE,
  CONSTRAINT `CPList_ibfk_2` FOREIGN KEY (`lib_no`) REFERENCES `Library` (`lib_no`),
  CONSTRAINT `CPList_ibfk_3` FOREIGN KEY (`paper_id`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CPList`
--

LOCK TABLES `CPList` WRITE;
/*!40000 ALTER TABLE `CPList` DISABLE KEYS */;
/*!40000 ALTER TABLE `CPList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CalcLateFee`
--

DROP TABLE IF EXISTS `CalcLateFee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CalcLateFee` (
  `res_id` int(11) NOT NULL,
  `late_fee` int(11) NOT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`res_id`),
  CONSTRAINT `CalcLateFee_ibfk_1` FOREIGN KEY (`res_id`) REFERENCES `Reservation` (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CalcLateFee`
--

LOCK TABLES `CalcLateFee` WRITE;
/*!40000 ALTER TABLE `CalcLateFee` DISABLE KEYS */;
/*!40000 ALTER TABLE `CalcLateFee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Camera`
--

DROP TABLE IF EXISTS `Camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Camera` (
  `camera_id` varchar(20) NOT NULL,
  `make` varchar(20) NOT NULL,
  `model` varchar(20) NOT NULL,
  `Lens` varchar(50) NOT NULL,
  `Memory_avail` varchar(10) NOT NULL,
  `lib_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`camera_id`),
  KEY `lib_no` (`lib_no`),
  CONSTRAINT `Camera_ibfk_1` FOREIGN KEY (`lib_no`) REFERENCES `Library` (`lib_no`),
  CONSTRAINT `Camera_ibfk_2` FOREIGN KEY (`camera_id`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Camera`
--

LOCK TABLES `Camera` WRITE;
/*!40000 ALTER TABLE `Camera` DISABLE KEYS */;
INSERT INTO `Camera` VALUES ('CAM22','CANON','D200','300mm','',NULL);
/*!40000 ALTER TABLE `Camera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Checkout`
--

DROP TABLE IF EXISTS `Checkout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Checkout` (
  `resc_type` varchar(20) NOT NULL,
  `patron_type` varchar(1) NOT NULL,
  `is_blocked` int(11) NOT NULL,
  `duration_hrs` int(11) NOT NULL,
  PRIMARY KEY (`resc_type`,`patron_type`,`is_blocked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Checkout`
--

LOCK TABLES `Checkout` WRITE;
/*!40000 ALTER TABLE `Checkout` DISABLE KEYS */;
/*!40000 ALTER TABLE `Checkout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Conf`
--

DROP TABLE IF EXISTS `Conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Conf` (
  `conf_num` varchar(20) NOT NULL,
  `name_of_conf` varchar(30) NOT NULL,
  `author_name` varchar(40) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `publ_year` int(11) NOT NULL,
  `ebook_copy` int(11) DEFAULT '0',
  PRIMARY KEY (`conf_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Conf`
--

LOCK TABLES `Conf` WRITE;
/*!40000 ALTER TABLE `Conf` DISABLE KEYS */;
/*!40000 ALTER TABLE `Conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course` (
  `course_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `book_isbn` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`dept_id`),
  KEY `dept_id` (`dept_id`),
  KEY `book_isbn` (`book_isbn`),
  CONSTRAINT `Course_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`) ON DELETE CASCADE,
  CONSTRAINT `Course_ibfk_2` FOREIGN KEY (`book_isbn`) REFERENCES `Book` (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(30) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Computer Science');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Enrolled`
--

DROP TABLE IF EXISTS `Enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Enrolled` (
  `student_num` varchar(20) NOT NULL,
  `course_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  PRIMARY KEY (`student_num`,`course_id`,`dept_id`),
  KEY `course_id` (`course_id`,`dept_id`),
  CONSTRAINT `Enrolled_ibfk_1` FOREIGN KEY (`student_num`) REFERENCES `Student` (`student_num`) ON DELETE CASCADE,
  CONSTRAINT `Enrolled_ibfk_2` FOREIGN KEY (`course_id`, `dept_id`) REFERENCES `Course` (`course_id`, `dept_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Enrolled`
--

LOCK TABLES `Enrolled` WRITE;
/*!40000 ALTER TABLE `Enrolled` DISABLE KEYS */;
/*!40000 ALTER TABLE `Enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Faculty` (
  `facultyID_No` varchar(20) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`facultyID_No`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `Faculty_ibfk_1` FOREIGN KEY (`facultyID_No`) REFERENCES `Patron` (`patron_id`),
  CONSTRAINT `Faculty_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `FacultyCategory` (`category_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculty`
--

LOCK TABLES `Faculty` WRITE;
/*!40000 ALTER TABLE `Faculty` DISABLE KEYS */;
/*!40000 ALTER TABLE `Faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacultyCategory`
--

DROP TABLE IF EXISTS `FacultyCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FacultyCategory` (
  `category_id` int(11) NOT NULL,
  `faculty_type` varchar(40) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacultyCategory`
--

LOCK TABLES `FacultyCategory` WRITE;
/*!40000 ALTER TABLE `FacultyCategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `FacultyCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Journal`
--

DROP TABLE IF EXISTS `Journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Journal` (
  `issn` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `author_name` varchar(40) NOT NULL,
  `publ_year` int(11) NOT NULL,
  `ebook_copy` int(11) DEFAULT '0',
  PRIMARY KEY (`issn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Journal`
--

LOCK TABLES `Journal` WRITE;
/*!40000 ALTER TABLE `Journal` DISABLE KEYS */;
INSERT INTO `Journal` VALUES ('12929','Networking 101','Diesburg',2013,0),('13423','SQL 101','Josh',2013,0);
/*!40000 ALTER TABLE `Journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JournalList`
--

DROP TABLE IF EXISTS `JournalList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JournalList` (
  `journal_id` varchar(20) NOT NULL,
  `issn` varchar(20) DEFAULT NULL,
  `is_available` int(11) DEFAULT '1',
  `lib_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`journal_id`),
  KEY `issn` (`issn`),
  KEY `lib_no` (`lib_no`),
  CONSTRAINT `JournalList_ibfk_1` FOREIGN KEY (`issn`) REFERENCES `Journal` (`issn`) ON DELETE CASCADE,
  CONSTRAINT `JournalList_ibfk_2` FOREIGN KEY (`lib_no`) REFERENCES `Library` (`lib_no`),
  CONSTRAINT `JournalList_ibfk_3` FOREIGN KEY (`journal_id`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JournalList`
--

LOCK TABLES `JournalList` WRITE;
/*!40000 ALTER TABLE `JournalList` DISABLE KEYS */;
/*!40000 ALTER TABLE `JournalList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Library`
--

DROP TABLE IF EXISTS `Library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Library` (
  `lib_no` int(11) NOT NULL,
  `lib_name` varchar(30) NOT NULL,
  PRIMARY KEY (`lib_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Library`
--

LOCK TABLES `Library` WRITE;
/*!40000 ALTER TABLE `Library` DISABLE KEYS */;
INSERT INTO `Library` VALUES (1,'Rod Library');
/*!40000 ALTER TABLE `Library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patron`
--

DROP TABLE IF EXISTS `Patron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patron` (
  `patron_id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `nationality` varchar(20) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `passwd` varchar(20) NOT NULL,
  `privilege` int(11) DEFAULT '1',
  PRIMARY KEY (`patron_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `Patron_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patron`
--

LOCK TABLES `Patron` WRITE;
/*!40000 ALTER TABLE `Patron` DISABLE KEYS */;
INSERT INTO `Patron` VALUES ('541325','Habib Ullah','1','Pakistan',1,'M','joke',1);
/*!40000 ALTER TABLE `Patron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Program`
--

DROP TABLE IF EXISTS `Program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program` (
  `program_id` int(11) NOT NULL,
  `degree_category` varchar(20) NOT NULL,
  `degree` varchar(30) NOT NULL,
  PRIMARY KEY (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program`
--

LOCK TABLES `Program` WRITE;
/*!40000 ALTER TABLE `Program` DISABLE KEYS */;
/*!40000 ALTER TABLE `Program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProgramEnrolled`
--

DROP TABLE IF EXISTS `ProgramEnrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProgramEnrolled` (
  `student_num` varchar(20) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `prog_year` varchar(30) NOT NULL,
  KEY `student_num` (`student_num`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `ProgramEnrolled_ibfk_1` FOREIGN KEY (`student_num`) REFERENCES `Student` (`student_num`),
  CONSTRAINT `ProgramEnrolled_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `Program` (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProgramEnrolled`
--

LOCK TABLES `ProgramEnrolled` WRITE;
/*!40000 ALTER TABLE `ProgramEnrolled` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProgramEnrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reservation` (
  `res_id` int(11) NOT NULL AUTO_INCREMENT,
  `patron_id` varchar(20) DEFAULT NULL,
  `resc_type` varchar(30) DEFAULT NULL,
  `resc_id` varchar(20) DEFAULT NULL,
  `checkout_date` date DEFAULT NULL,
  `checkin_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `isactive` int(11) DEFAULT '1',
  PRIMARY KEY (`res_id`),
  KEY `patron_id` (`patron_id`),
  KEY `resc_id` (`resc_id`),
  CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `Patron` (`patron_id`) ON DELETE CASCADE,
  CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`resc_id`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resources`
--

DROP TABLE IF EXISTS `Resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Resources` (
  `resc_id` varchar(20) NOT NULL,
  `resc_type` varchar(20) NOT NULL,
  PRIMARY KEY (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resources`
--

LOCK TABLES `Resources` WRITE;
/*!40000 ALTER TABLE `Resources` DISABLE KEYS */;
INSERT INTO `Resources` VALUES ('CAM22','Camera');
/*!40000 ALTER TABLE `Resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Room` (
  `room_no` varchar(20) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `floorno` int(11) DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `lib_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`room_no`),
  KEY `lib_no` (`lib_no`),
  CONSTRAINT `Room_ibfk_1` FOREIGN KEY (`lib_no`) REFERENCES `Library` (`lib_no`) ON DELETE CASCADE,
  CONSTRAINT `Room_ibfk_2` FOREIGN KEY (`room_no`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `student_num` varchar(20) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `alternative_phone_no` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`student_num`),
  CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`student_num`) REFERENCES `Patron` (`patron_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES ('541325','319-237-6572','319-237-6572','805 W Seerley blvd Apt#2','1999-08-14');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teaches`
--

DROP TABLE IF EXISTS `Teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teaches` (
  `facultyID_No` varchar(20) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  KEY `course_id` (`course_id`,`dept_id`),
  KEY `facultyID_No` (`facultyID_No`),
  CONSTRAINT `Teaches_ibfk_1` FOREIGN KEY (`course_id`, `dept_id`) REFERENCES `Course` (`course_id`, `dept_id`),
  CONSTRAINT `Teaches_ibfk_2` FOREIGN KEY (`facultyID_No`) REFERENCES `Faculty` (`facultyID_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teaches`
--

LOCK TABLES `Teaches` WRITE;
/*!40000 ALTER TABLE `Teaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `Teaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `Patron_id` varchar(20) NOT NULL,
  `Message` varchar(100) NOT NULL,
  PRIMARY KEY (`Patron_id`,`Message`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`Patron_id`) REFERENCES `Patron` (`patron_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resv_camera_q`
--

DROP TABLE IF EXISTS `resv_camera_q`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resv_camera_q` (
  `camera_id` varchar(20) NOT NULL,
  `patron_id` varchar(20) NOT NULL,
  `intended_friday` date NOT NULL,
  `que_pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`patron_id`,`camera_id`,`intended_friday`),
  KEY `camera_id` (`camera_id`),
  CONSTRAINT `resv_camera_q_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `Patron` (`patron_id`) ON DELETE CASCADE,
  CONSTRAINT `resv_camera_q_ibfk_2` FOREIGN KEY (`camera_id`) REFERENCES `Camera` (`camera_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resv_camera_q`
--

LOCK TABLES `resv_camera_q` WRITE;
/*!40000 ALTER TABLE `resv_camera_q` DISABLE KEYS */;
/*!40000 ALTER TABLE `resv_camera_q` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resv_publ_q`
--

DROP TABLE IF EXISTS `resv_publ_q`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resv_publ_q` (
  `publ_no` varchar(20) NOT NULL,
  `patron_id` varchar(20) NOT NULL,
  `req_date` date DEFAULT NULL,
  PRIMARY KEY (`publ_no`,`patron_id`),
  KEY `patron_id` (`patron_id`),
  CONSTRAINT `resv_publ_q_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `Patron` (`patron_id`) ON DELETE CASCADE,
  CONSTRAINT `resv_publ_q_ibfk_2` FOREIGN KEY (`publ_no`) REFERENCES `Resources` (`resc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resv_publ_q`
--

LOCK TABLES `resv_publ_q` WRITE;
/*!40000 ALTER TABLE `resv_publ_q` DISABLE KEYS */;
/*!40000 ALTER TABLE `resv_publ_q` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resv_room`
--

DROP TABLE IF EXISTS `resv_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resv_room` (
  `room_no` varchar(20) NOT NULL,
  `patron_id` varchar(20) DEFAULT NULL,
  `start_time` date NOT NULL,
  `end_time` date NOT NULL,
  `is_active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`room_no`,`start_time`,`end_time`,`is_active`),
  KEY `patron_id` (`patron_id`),
  CONSTRAINT `resv_room_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `Patron` (`patron_id`) ON DELETE CASCADE,
  CONSTRAINT `resv_room_ibfk_2` FOREIGN KEY (`room_no`) REFERENCES `Room` (`room_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resv_room`
--

LOCK TABLES `resv_room` WRITE;
/*!40000 ALTER TABLE `resv_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `resv_room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-10  0:11:00
