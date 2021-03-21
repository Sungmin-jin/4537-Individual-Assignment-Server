-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: us-cdbr-east-03.cleardb.com    Database: heroku_bcf5e28610cc6b3
-- ------------------------------------------------------
-- Server version	5.6.50-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `option`
--

DROP TABLE IF EXISTS `option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `option` (
  `optionId` int(11) NOT NULL AUTO_INCREMENT,
  `detail` varchar(255) NOT NULL,
  `questionId` int(11) NOT NULL,
  `isAnswer` tinyint(1) NOT NULL,
  PRIMARY KEY (`optionId`),
  KEY `option_FK` (`questionId`),
  CONSTRAINT `option_FK` FOREIGN KEY (`questionId`) REFERENCES `question` (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=1124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `option`
--

LOCK TABLES `option` WRITE;
/*!40000 ALTER TABLE `option` DISABLE KEYS */;
INSERT INTO `option` VALUES (734,'Testing1',574,0),(764,'Test 4',574,1),(774,'qeqwe',584,0),(874,'dfsfds',584,1),(894,'sdfsfds',574,0),(984,'sdffsf',594,1),(994,'sdfdsdfdfs',594,0),(1004,'sddsfdfsfds',604,1),(1014,'dfsdsfdffsdfs',604,0),(1024,'dsfdssfdsdsf',604,0),(1034,'sdfsfsfdsf',604,0),(1044,'12313',614,0),(1054,'4123131',614,0),(1064,'232121',614,0),(1074,'true',614,1),(1084,'Ture',624,0),(1094,'False',624,1),(1104,'dsfsdssdf',634,0),(1114,'fdsdsffs',634,1);
/*!40000 ALTER TABLE `option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `questionId` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `quizId` int(11) NOT NULL,
  PRIMARY KEY (`questionId`),
  KEY `question_FK` (`quizId`),
  CONSTRAINT `question_FK` FOREIGN KEY (`quizId`) REFERENCES `quiz` (`quizId`)
) ENGINE=InnoDB AUTO_INCREMENT=644 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (574,'First Question',244),(584,'question',244),(594,'sdfsfs',244),(604,'dfdfdfsds',244),(614,'Melody',254),(624,'Tyler',264),(634,'sdfsfds',274);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
  `quizId` int(11) NOT NULL AUTO_INCREMENT,
  `quizName` varchar(100) NOT NULL,
  PRIMARY KEY (`quizId`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (244,'Test Quiz'),(254,'Melody'),(264,'New Quiz'),(274,'valid quiz');
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'heroku_bcf5e28610cc6b3'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-20 23:00:29
