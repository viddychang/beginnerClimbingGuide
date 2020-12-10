CREATE DATABASE  IF NOT EXISTS `climbingFinalProject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `climbingFinalProject`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: climbingFinalProject
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `climbingUsers`
--

DROP TABLE IF EXISTS `climbingUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `climbingUsers` (
  `user_username` varchar(45) NOT NULL,
  `user_password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `climbingUsers`
--

LOCK TABLES `climbingUsers` WRITE;
/*!40000 ALTER TABLE `climbingUsers` DISABLE KEYS */;
INSERT INTO `climbingUsers` VALUES ('changd','password'),('meep','meep'),('newAccount','testAccountPw'),('test','test');
/*!40000 ALTER TABLE `climbingUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `climbStyle`
--

DROP TABLE IF EXISTS `climbStyle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `climbStyle` (
  `climbStyleId` int NOT NULL AUTO_INCREMENT,
  `styleName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`climbStyleId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `climbStyle`
--

LOCK TABLES `climbStyle` WRITE;
/*!40000 ALTER TABLE `climbStyle` DISABLE KEYS */;
INSERT INTO `climbStyle` VALUES (1,'Trad'),(2,'Top Rope'),(3,'Boulder'),(4,'Sport');
/*!40000 ALTER TABLE `climbStyle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gear`
--

DROP TABLE IF EXISTS `gear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gear` (
  `gearId` int NOT NULL AUTO_INCREMENT,
  `gearName` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`gearId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gear`
--

LOCK TABLES `gear` WRITE;
/*!40000 ALTER TABLE `gear` DISABLE KEYS */;
INSERT INTO `gear` VALUES (1,'Crash Pad'),(2,'Belay device'),(3,'Rope'),(4,'Quick Draw'),(5,'Trad Cam'),(6,'Slings'),(7,'Cordellette'),(8,'Carabiner');
/*!40000 ALTER TABLE `gear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `routeId` int NOT NULL AUTO_INCREMENT,
  `routeName` varchar(65) DEFAULT NULL,
  `locationCoordinates` varchar(65) DEFAULT NULL,
  `parkingInformation` longtext,
  `routeDescription` longtext,
  `dateModified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stateId` int DEFAULT NULL,
  `author` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`routeId`),
  KEY `stateId` (`stateId`),
  KEY `routeAuthor_idx` (`author`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`stateId`) REFERENCES `state` (`stateId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `routeAuthor` FOREIGN KEY (`author`) REFERENCES `climbingUsers` (`user_username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'Zipper','42.617, -70.728','From the main parking area, follow the obvious trail along Route 128 until it turns sharply uphill at the Pink Floyd Wall. Continue up to the main area.','This is one of the finer routes here. It ascends an obvious crack that is typically laybacked. It just begs to be climbed. The crux is mid-height where it jogs left. Continue up. Enjoy. Zipper is one of the nicest short routes in New England, IMHO.','2020-12-07 23:41:12','2020-12-07 23:41:12',2,NULL),(2,'Sit On That','42.323, -71.174','Drive West on Route 9 to Hammond Pond Parkway. Go north. 7 of the 14 crags lie east between Hammond Pond Parkway and Hammond Pond. 5 of the 14 crags lie SW of the intersection of Beacon St & Hammond Pond Parkway. 2 of the 14 crags lie just north of the temple along Hammond Pond Parkway. Do not park at the temple!','This is a silly little problem that starts on Scrambled, but instead of topping the boulder out, you make your way to the big ledge rail directly above the Lower Traverse (aka Chinese Vodka). Find a way to balance yourself on the small ledge for a no hands, sit down finish. While the climb is fun, please be safe, and have ample pads and a spotter.','2020-12-08 21:53:55','2020-12-08 21:53:55',2,NULL),(3,'Ashbury Park','43.801, -71.838','Interstate 93 is the main north/south artery in New Hampshire. From all points north or south. Take 93 to exit 26. Follow Rt 25 West for a few miles following signs for the town of Rumney. You will go through a couple sets of lights, then a rotary, and finally 2 blinking yellow lights. At the second blinking light turn right on to Main st. In less than a mile you will cross a bridge and be in \"downtown\" Rumney (a small New England village. Please be courteous and drive slowly) Here you turn left on to Buffalo Rd. The \"Rumney Rocks\" parking area will be on your right in about a mile.\n\nFrom points west, take Interstate 91 to Highway 25. Head east on this and follow signs to Rumney. From points east, get yourself to 93 and refer to above directions from there.','One of the more fun moderate routes at the 5.8 Crag. You will find it on the far left end of the cliff. Follow the line of bolts wandering slightly up right following the blunt low-angle arete past crimpy and slabby moves to the top.\n\nThe crux is just past the first bolt and its a bit stout for 5.7. I feel like it\'s gotten harder with use. Very crimpy. A few more tricky parts but nothing nearly as hard as you finish. At the top, follow cracks to the clips.','2020-12-08 22:26:40','2020-12-08 22:26:40',1,NULL),(4,'\'Peary Gates\'','	44.022, -70.962','Not a lot of parking','Approach from the top on the low angle slab. Locate the rap anchor and rap down to the lower Rap anchor 40-45 ft below.','2020-12-09 04:33:00','2020-12-09 04:33:00',3,'changd'),(12,'Toe Jams','42.617, -70.728','From the main parking area, follow the obvious trail along Route 128 until it turns sharply uphill at the Pink Floyd Wall. Continue up to the main area.','Toe Jams climbs a toe-width crack on the far right end of the main wall. From the bottom, scramble up and right over blocks to the base of the crack. Belay from here or the bottom, bottom recommended. Hand and fist jam with ease up the low-angle crack until it becomes shallow and face holds appear. Anchor at trees.','2020-12-09 15:57:42','2020-12-09 15:57:42',2,'changd'),(13,'Sprite','43.805, -71.843','Interstate 93 is the main north/south artery in New Hampshire. From all points north or south. Take 93 to exit 26. Follow Rt 25 West for a few miles following signs for the town of Rumney. You will go through a couple sets of lights, then a rotary, and finally 2 blinking yellow lights. At the second blinking light turn right on to Main st. In less than a mile you will cross a bridge and be in \"downtown\" Rumney (a small New England village. Please be courteous and drive slowly) Here you turn left on to Buffalo Rd. The \"Rumney Rocks\" parking area will be on your right in about a mile.','The first 5 bolts of Ale 8, up the featured slab to an anchor at a ledge at the intersection of the overhang.  - better description once I reclimb it. I remember it being pretty good.','2020-12-10 16:07:13','2020-12-10 16:07:13',1,'changd'),(14,'Free Range Chicken','43.805, -71.843','Interstate 93 is the main north/south artery in New Hampshire. From all points north or south. Take 93 to exit 26. Follow Rt 25 West for a few miles following signs for the town of Rumney. You will go through a couple sets of lights, then a rotary, and finally 2 blinking yellow lights. At the second blinking light turn right on to Main st. In less than a mile you will cross a bridge and be in \"downtown\" Rumney (a small New England village. Please be courteous and drive slowly) Here you turn left on to Buffalo Rd. The \"Rumney Rocks\" parking area will be on your right in about a mile.','A cool short crack climb directly under the big fin on Jolt (5.10b)... If it was longer it could be classic but it just ends and you are left wishing for a little more... Start to the right of Jolt and find the steep crack that eases up as you go... This leads a set of anchors... If you are the type to seek out trad climbs at rumney (like my self) climb it for sure but dont bother going too far out of your way for it...','2020-12-10 16:10:01','2020-12-10 16:10:01',1,'changd'),(15,'Hinterland Highway','43.805, -71.843','The quickest way to get there is to pick up the trail from the Blackjack Boulders up to Triple Corners Wall...then head left and up a steep hill and a gully with a fixed rope in it...continue your way up the steep hill to the Hinterlands cliff...Climb over a log and you are officially there.... To the right is a slab capped with the huge roof of Giant Man (5.12b/c) walk left and down to get to Jolt (5.10b)....','','2020-12-10 16:12:43','2020-12-10 16:12:43',1,'changd'),(16,'Pried and Joy','44.793, -68.496','From the intersection of route 9 and 180, drive 2.6 miles south on route 180. The northern parking area will be on the left after about 2.5 miles, followed by the overflow parking and finally the southern parking area.  If you reach Springy Pond Road you are in the vicinity of the parking areas but missed them all, which are back towards Route 9.','Start at crack just right of ledges. Awkward moves up the crack to ledge with giant block. Continue up on large holds past horizontals and a bolt.','2020-12-10 16:19:36','2020-12-10 16:19:36',3,'changd'),(17,'Help','	44.793, -68.496','From the intersection of route 9 and 180, drive 2.6 miles south on route 180. The northern parking area will be on the left after about 2.5 miles, followed by the overflow parking and finally the southern parking area.  If you reach Springy Pond Road you are in the vicinity of the parking areas but missed them all, which are back towards Route 9.','Short slab to blocky climbing followed by crack running through a dihedral at the upper portion of the climb. A little stemming in the dihedral or laybacking keeps the upper portion interesting. One of the better pitches on the practice wall, IMO. Good lead for the 5.7 leader as it takes great gear ','2020-12-10 16:21:08','2020-12-10 16:21:08',3,'changd');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routeClimbStyle`
--

DROP TABLE IF EXISTS `routeClimbStyle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routeClimbStyle` (
  `routeId` int NOT NULL,
  `climbStyleId` int NOT NULL,
  PRIMARY KEY (`routeId`,`climbStyleId`),
  KEY `climbStyleId` (`climbStyleId`),
  CONSTRAINT `routeclimbstyle_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`routeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `routeclimbstyle_ibfk_2` FOREIGN KEY (`climbStyleId`) REFERENCES `climbStyle` (`climbStyleId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routeClimbStyle`
--

LOCK TABLES `routeClimbStyle` WRITE;
/*!40000 ALTER TABLE `routeClimbStyle` DISABLE KEYS */;
INSERT INTO `routeClimbStyle` VALUES (1,1),(12,1),(17,1),(1,2),(12,2),(16,2),(2,3),(3,4),(13,4),(14,4),(15,4);
/*!40000 ALTER TABLE `routeClimbStyle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routeComment`
--

DROP TABLE IF EXISTS `routeComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routeComment` (
  `commentId` int NOT NULL AUTO_INCREMENT,
  `commentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `authorUserName` varchar(65) DEFAULT NULL,
  `routeId` int DEFAULT NULL,
  `commentText` longtext,
  PRIMARY KEY (`commentId`),
  KEY `authorUserName` (`authorUserName`),
  KEY `routecomment_ibfk_1` (`routeId`),
  CONSTRAINT `routecomment_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`routeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `routecomment_ibfk_2` FOREIGN KEY (`authorUserName`) REFERENCES `climbingUsers` (`user_username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routeComment`
--

LOCK TABLES `routeComment` WRITE;
/*!40000 ALTER TABLE `routeComment` DISABLE KEYS */;
INSERT INTO `routeComment` VALUES (1,'2020-12-08 18:57:54','changd',1,'first comment'),(2,'2020-12-08 20:01:48','changd',1,'second comment'),(3,'2020-12-08 20:02:21','changd',1,'three'),(4,'2020-12-08 20:40:20','changd',1,'inserted new comment via procedure'),(9,'2020-12-09 18:23:16','newAccount',1,'this is an overwrite'),(10,'2020-12-09 18:33:39','changd',3,'test');
/*!40000 ALTER TABLE `routeComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routeHasResource`
--

DROP TABLE IF EXISTS `routeHasResource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routeHasResource` (
  `resourceId` int NOT NULL,
  `routeId` int NOT NULL,
  PRIMARY KEY (`routeId`,`resourceId`),
  KEY `routehasresource_ibfk_2` (`resourceId`),
  CONSTRAINT `routehasresource_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`routeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `routehasresource_ibfk_2` FOREIGN KEY (`resourceId`) REFERENCES `skillResources` (`resourceId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routeHasResource`
--

LOCK TABLES `routeHasResource` WRITE;
/*!40000 ALTER TABLE `routeHasResource` DISABLE KEYS */;
INSERT INTO `routeHasResource` VALUES (1,1),(1,3),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(2,1),(2,12),(2,14),(2,15),(2,16),(2,17),(3,3),(3,13),(3,14),(3,15),(3,17),(4,3),(4,13),(4,14),(4,15),(5,1),(5,3),(5,12),(5,13),(5,14),(5,15),(5,16),(5,17);
/*!40000 ALTER TABLE `routeHasResource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routeRequiresGear`
--

DROP TABLE IF EXISTS `routeRequiresGear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routeRequiresGear` (
  `routeId` int NOT NULL,
  `gearId` int NOT NULL,
  `numberOfGear` int DEFAULT NULL,
  PRIMARY KEY (`routeId`,`gearId`),
  KEY `routerequiresgear_ibfk_2` (`gearId`),
  CONSTRAINT `routerequiresgear_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`routeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `routerequiresgear_ibfk_2` FOREIGN KEY (`gearId`) REFERENCES `gear` (`gearId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routeRequiresGear`
--

LOCK TABLES `routeRequiresGear` WRITE;
/*!40000 ALTER TABLE `routeRequiresGear` DISABLE KEYS */;
INSERT INTO `routeRequiresGear` VALUES (1,2,1),(1,3,1),(1,4,2),(1,7,1),(1,8,5),(2,1,2),(3,2,1),(3,3,1),(3,4,5),(3,7,1),(3,8,5),(12,2,1),(12,3,1),(12,5,4),(12,7,1),(12,8,5),(13,2,1),(13,3,1),(13,4,6),(13,7,1),(13,8,5),(14,2,1),(14,3,1),(14,4,5),(14,6,2),(14,8,5),(15,2,1),(15,3,1),(15,4,8),(15,7,1),(15,8,5),(16,2,1),(16,3,1),(16,6,3),(16,8,5),(17,2,1),(17,3,1),(17,5,5),(17,7,1),(17,8,10);
/*!40000 ALTER TABLE `routeRequiresGear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skillResources`
--

DROP TABLE IF EXISTS `skillResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skillResources` (
  `resourceId` int NOT NULL AUTO_INCREMENT,
  `resourceName` varchar(65) DEFAULT NULL,
  `resourceLink` varchar(65) NOT NULL,
  PRIMARY KEY (`resourceId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skillResources`
--

LOCK TABLES `skillResources` WRITE;
/*!40000 ALTER TABLE `skillResources` DISABLE KEYS */;
INSERT INTO `skillResources` VALUES (1,'How to set up a Top Rope anchor','https://www.youtube.com/watch?v=Y-pLP9dRWPc'),(2,'How to top rope belay','https://www.youtube.com/watch?v=CFIz4cBFVro'),(3,'How to lead belay','https://www.youtube.com/watch?v=S_F1MfVGOzk'),(4,'How to lead fall','https://www.youtube.com/watch?v=RJZ8OxYP5T4'),(5,'How to rappel','https://www.youtube.com/watch?v=7U6tdEevJgs&list');
/*!40000 ALTER TABLE `skillResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `stateId` int NOT NULL AUTO_INCREMENT,
  `stateAbbName` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`stateId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'NH'),(2,'MA'),(3,'ME');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'climbingFinalProject'
--

--
-- Dumping routines for database 'climbingFinalProject'
--
/*!50003 DROP FUNCTION IF EXISTS `userPermission_commentCheck` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `userPermission_commentCheck`(
	f_userName varchar(65), f_commentId int
    ) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE result INT;
	
	IF (SELECT EXISTS (SELECT 1 FROM routeComment
			WHERE commentId = f_commentId AND authorUserName = f_userName)) THEN
		SET result = 1;
	ELSE 
		SET result = -1;
	END IF;
    RETURN(result);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_addGearToRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_addGearToRoute`(
	rId INT, gId INT, n INT
    )
BEGIN
	INSERT INTO routeRequiresGear(routeId, gearId, numberOfGear)
    VALUES (rId, gId, n);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_addSkillResourceToRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_addSkillResourceToRoute`(
	rId INT, resId INT
    )
BEGIN
	INSERT INTO routeHasResource(routeId, resourceId)
    VALUES (rId, resId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_addStyleToRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_addStyleToRoute`(
	rId INT, sId INT
    )
BEGIN
	INSERT INTO routeClimbStyle(routeId, climbStyleId)
    VALUES (rId, sId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_createUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_createUser`(
    p_username VARCHAR(45),
    p_password VARCHAR(45)
)
BEGIN
	IF (SELECT EXISTS (SELECT 1 FROM climbingUsers WHERE user_username = p_username)) THEN
		SELECT 'Username Exists!';
	ELSE
		insert into climbingUsers
		(
            user_username,
            user_password
		)
        values
		(
            p_username,
            p_password
		);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteUserComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteUserComment`(
	commentrouteId INT, authorUser varchar(65)
    )
BEGIN
	declare userCheck int;
    set userCheck = userPermission_commentCheck(authorUser, commentrouteId);
    IF userCheck = 1 THEN
		DELETE FROM routeComment WHERE commentId = commentrouteId;
        SELECT "Comment was deleted";
	ELSE
		SELECT "Cannot delete someone else's comment";
	END IF ;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getGearForRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getGearForRoute`(
	rId INT
)
BEGIN
	SELECT gearName, numberOfGear FROM gear JOIN 
		(select gearId, numberOfGear from routeRequiresGear where routeId = rId) as temp
        WHERE gear.gearId = temp.gearId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getRoutesInState` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getRoutesInState`(
	sId INT
    )
BEGIN
	SELECT routeId FROM route WHERE stateId = sId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getRoutesInStyle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getRoutesInStyle`(
	sId INT
    )
BEGIN
	SELECT routeId FROM routeClimbStyle WHERE climbStyleId = sId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getSkillResourceForRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getSkillResourceForRoute`(
	rId INT
)
BEGIN
	SELECT resourceName, resourceLink FROM skillResources JOIN 
		(select resourceId from routeHasResource where routeId = rId) as temp
        WHERE skillResources.resourceId = temp.resourceId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getStylesForRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getStylesForRoute`(
	rId INT
)
BEGIN
    SELECT styleName FROM climbStyle JOIN 
		(select climbStyleId from routeClimbStyle where routeId = rId) as temp
        WHERE climbStyle.climbStyleId = temp.climbStyleId;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getUsers`()
BEGIN
	SELECT user_username FROM climbingUsers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertComment`(
	rId INT, authorUser varchar(65), newText longtext
    )
BEGIN
	INSERT INTO routeComment(routeId, authorUserName, commentText)
    VALUES (rId, authorUser, newText);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertRoute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertRoute`(
	rName varchar(65), lCoordinates varchar(65), parkinginfo longtext,
    rDescription longtext, stateId int, authorName varchar(65)
    )
BEGIN
	INSERT INTO route(routeName, locationCoordinates, parkingInformation,
    routeDescription,stateId, author)
    VALUES (rName, lCoordinates, parkinginfo, rDescription,stateId, authorName);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_modifyUserComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_modifyUserComment`(
	commentrouteId INT, authorUser varchar(65), newText longtext
    )
BEGIN
	declare userCheck int;
    set userCheck = userPermission_commentCheck(authorUser, commentrouteId);
    IF userCheck = 1 THEN
		UPDATE routeComment
		SET commentText = newText
        WHERE commentId = commentrouteId;
        SELECT "Comment was updated";
	ELSE
		SELECT "Cannot edit someone else's comment";
	END IF ;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_routeComments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_routeComments`(
	rId INT)
BEGIN
	SELECT authorUserName, commentId, commentText, commentDate FROM routeComment
		Where routeId = rId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_routeWithState` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_routeWithState`(
	rId INT)
BEGIN
		SELECT * FROM route r JOIN state s ON s.stateId = r.stateId WHERE routeId = rId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_userLoginCheck` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_userLoginCheck`(
p_username VARCHAR(45),
p_password VARCHAR(45)
)
BEGIN
	IF (SELECT EXISTS (SELECT 1 FROM climbingUsers WHERE user_username = p_username 
    AND user_password = p_password)) THEN
		SELECT 'success';
	ELSE
		SELECT 'failed';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_userRouteComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_userRouteComment`(
	commentrouteId INT, authorUser varchar(255)
    )
BEGIN
	SELECT commentId, commentText FROM routeComment
		Where routeId = commentrouteId AND authorUserName = authorUser
        ORDER BY commentDate DESC;
END ;;
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

-- Dump completed on 2020-12-10 16:22:40
