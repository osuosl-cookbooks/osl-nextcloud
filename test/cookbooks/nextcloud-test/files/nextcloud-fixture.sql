/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.29-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: nextcloud
-- ------------------------------------------------------
-- Server version	10.5.29-MariaDB

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
-- Table structure for table `oc_accounts`
--

DROP TABLE IF EXISTS `oc_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_accounts` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `data` longtext NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts`
--

LOCK TABLES `oc_accounts` WRITE;
/*!40000 ALTER TABLE `oc_accounts` DISABLE KEYS */;
INSERT INTO `oc_accounts` VALUES ('admin','{\"displayname\":{\"value\":\"admin\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"address\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"website\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"email\":{\"value\":\"\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"avatar\":{\"value\":\"\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"phone\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"twitter\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"bluesky\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"fediverse\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"organisation\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"role\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"headline\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"biography\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"birthdate\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"profile_enabled\":{\"value\":\"1\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"pronouns\":{\"value\":\"\",\"scope\":\"v2-federated\",\"verified\":\"0\"}}');
/*!40000 ALTER TABLE `oc_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_accounts_data`
--

DROP TABLE IF EXISTS `oc_accounts_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_accounts_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `accounts_data_uid` (`uid`),
  KEY `accounts_data_name` (`name`),
  KEY `accounts_data_value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts_data`
--

LOCK TABLES `oc_accounts_data` WRITE;
/*!40000 ALTER TABLE `oc_accounts_data` DISABLE KEYS */;
INSERT INTO `oc_accounts_data` VALUES (46,'admin','displayname','admin'),(47,'admin','address',''),(48,'admin','website',''),(49,'admin','email',''),(50,'admin','phone',''),(51,'admin','twitter',''),(52,'admin','bluesky',''),(53,'admin','fediverse',''),(54,'admin','organisation',''),(55,'admin','role',''),(56,'admin','headline',''),(57,'admin','biography',''),(58,'admin','birthdate',''),(59,'admin','profile_enabled','1'),(60,'admin','pronouns','');
/*!40000 ALTER TABLE `oc_accounts_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity`
--

DROP TABLE IF EXISTS `oc_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_activity` (
  `activity_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `user` varchar(64) DEFAULT NULL,
  `affecteduser` varchar(64) NOT NULL,
  `app` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `subjectparams` longtext NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `messageparams` longtext DEFAULT NULL,
  `file` varchar(4000) DEFAULT NULL,
  `link` varchar(4000) DEFAULT NULL,
  `object_type` varchar(255) DEFAULT NULL,
  `object_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`activity_id`),
  KEY `activity_user_time` (`affecteduser`,`timestamp`),
  KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`),
  KEY `activity_filter` (`affecteduser`,`type`,`app`,`timestamp`),
  KEY `activity_object` (`object_type`,`object_id`),
  KEY `activity_object_user` (`affecteduser`,`object_type`,`object_id`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity`
--

LOCK TABLES `oc_activity` WRITE;
/*!40000 ALTER TABLE `oc_activity` DISABLE KEYS */;
INSERT INTO `oc_activity` VALUES (1,1777588461,30,'file_created','admin','admin','files','created_self','[{\"3\":\"\\/Documents\"}]','','[]','/Documents','http://localhost/index.php/apps/files/?dir=/','files',3),(2,1777588461,30,'file_created','admin','admin','files','created_self','[{\"4\":\"\\/Documents\\/Welcome to Nextcloud Hub.docx\"}]','','[]','/Documents/Welcome to Nextcloud Hub.docx','http://localhost/index.php/apps/files/?dir=/Documents','files',4),(3,1777588461,30,'file_created','admin','admin','files','created_self','[{\"5\":\"\\/Documents\\/Nextcloud flyer.pdf\"}]','','[]','/Documents/Nextcloud flyer.pdf','http://localhost/index.php/apps/files/?dir=/Documents','files',5),(4,1777588461,30,'file_created','admin','admin','files','created_self','[{\"6\":\"\\/Documents\\/Readme.md\"}]','','[]','/Documents/Readme.md','http://localhost/index.php/apps/files/?dir=/Documents','files',6),(5,1777588461,30,'file_created','admin','admin','files','created_self','[{\"7\":\"\\/Documents\\/Example.md\"}]','','[]','/Documents/Example.md','http://localhost/index.php/apps/files/?dir=/Documents','files',7),(6,1777588461,30,'file_created','admin','admin','files','created_self','[{\"8\":\"\\/Photos\"}]','','[]','/Photos','http://localhost/index.php/apps/files/?dir=/','files',8),(7,1777588461,30,'file_created','admin','admin','files','created_self','[{\"9\":\"\\/Photos\\/Gorilla.jpg\"}]','','[]','/Photos/Gorilla.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',9),(8,1777588461,30,'file_created','admin','admin','files','created_self','[{\"10\":\"\\/Photos\\/Steps.jpg\"}]','','[]','/Photos/Steps.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',10),(9,1777588461,30,'file_created','admin','admin','files','created_self','[{\"11\":\"\\/Photos\\/Readme.md\"}]','','[]','/Photos/Readme.md','http://localhost/index.php/apps/files/?dir=/Photos','files',11),(10,1777588461,30,'file_created','admin','admin','files','created_self','[{\"12\":\"\\/Photos\\/Vineyard.jpg\"}]','','[]','/Photos/Vineyard.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',12),(11,1777588461,30,'file_created','admin','admin','files','created_self','[{\"13\":\"\\/Photos\\/Frog.jpg\"}]','','[]','/Photos/Frog.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',13),(12,1777588461,30,'file_created','admin','admin','files','created_self','[{\"14\":\"\\/Photos\\/Nextcloud community.jpg\"}]','','[]','/Photos/Nextcloud community.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',14),(13,1777588461,30,'file_created','admin','admin','files','created_self','[{\"15\":\"\\/Photos\\/Birdie.jpg\"}]','','[]','/Photos/Birdie.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',15),(14,1777588461,30,'file_created','admin','admin','files','created_self','[{\"16\":\"\\/Photos\\/Library.jpg\"}]','','[]','/Photos/Library.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',16),(15,1777588462,30,'file_created','admin','admin','files','created_self','[{\"17\":\"\\/Photos\\/Toucan.jpg\"}]','','[]','/Photos/Toucan.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',17),(16,1777588462,30,'file_created','admin','admin','files','created_self','[{\"18\":\"\\/Readme.md\"}]','','[]','/Readme.md','http://localhost/index.php/apps/files/?dir=/','files',18),(17,1777588462,30,'file_created','admin','admin','files','created_self','[{\"19\":\"\\/Nextcloud intro.mp4\"}]','','[]','/Nextcloud intro.mp4','http://localhost/index.php/apps/files/?dir=/','files',19),(18,1777588462,30,'file_created','admin','admin','files','created_self','[{\"20\":\"\\/Templates\"}]','','[]','/Templates','http://localhost/index.php/apps/files/?dir=/','files',20),(19,1777588462,30,'file_created','admin','admin','files','created_self','[{\"21\":\"\\/Templates\\/Photo book.odt\"}]','','[]','/Templates/Photo book.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',21),(20,1777588462,30,'file_created','admin','admin','files','created_self','[{\"22\":\"\\/Templates\\/Checklist.ods\"}]','','[]','/Templates/Checklist.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',22),(21,1777588462,30,'file_created','admin','admin','files','created_self','[{\"23\":\"\\/Templates\\/Invoice.odt\"}]','','[]','/Templates/Invoice.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',23),(22,1777588462,30,'file_created','admin','admin','files','created_self','[{\"24\":\"\\/Templates\\/Certificate.odt\"}]','','[]','/Templates/Certificate.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',24),(23,1777588462,30,'file_created','admin','admin','files','created_self','[{\"25\":\"\\/Templates\\/Venn diagram.whiteboard\"}]','','[]','/Templates/Venn diagram.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',25),(24,1777588462,30,'file_created','admin','admin','files','created_self','[{\"26\":\"\\/Templates\\/Syllabus.odt\"}]','','[]','/Templates/Syllabus.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',26),(25,1777588462,30,'file_created','admin','admin','files','created_self','[{\"27\":\"\\/Templates\\/Invoice.ods\"}]','','[]','/Templates/Invoice.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',27),(26,1777588463,30,'file_created','admin','admin','files','created_self','[{\"28\":\"\\/Templates\\/Security.odp\"}]','','[]','/Templates/Security.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',28),(27,1777588463,30,'file_created','admin','admin','files','created_self','[{\"29\":\"\\/Templates\\/Party invitation.odt\"}]','','[]','/Templates/Party invitation.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',29),(28,1777588463,30,'file_created','admin','admin','files','created_self','[{\"30\":\"\\/Templates\\/Calendar.odt\"}]','','[]','/Templates/Calendar.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',30),(29,1777588463,30,'file_created','admin','admin','files','created_self','[{\"31\":\"\\/Templates\\/Mother\'s day.odt\"}]','','[]','/Templates/Mother\'s day.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',31),(30,1777588463,30,'file_created','admin','admin','files','created_self','[{\"32\":\"\\/Templates\\/Ecosystem.odp\"}]','','[]','/Templates/Ecosystem.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',32),(31,1777588463,30,'file_created','admin','admin','files','created_self','[{\"33\":\"\\/Templates\\/Business model canvas.whiteboard\"}]','','[]','/Templates/Business model canvas.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',33),(32,1777588463,30,'file_created','admin','admin','files','created_self','[{\"34\":\"\\/Templates\\/Elegant.odp\"}]','','[]','/Templates/Elegant.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',34),(33,1777588463,30,'file_created','admin','admin','files','created_self','[{\"35\":\"\\/Templates\\/Letter.odt\"}]','','[]','/Templates/Letter.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',35),(34,1777588463,30,'file_created','admin','admin','files','created_self','[{\"36\":\"\\/Templates\\/Expense report.ods\"}]','','[]','/Templates/Expense report.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',36),(35,1777588463,30,'file_created','admin','admin','files','created_self','[{\"37\":\"\\/Templates\\/Modern company.odp\"}]','','[]','/Templates/Modern company.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',37),(36,1777588463,30,'file_created','admin','admin','files','created_self','[{\"38\":\"\\/Templates\\/Triangle.odp\"}]','','[]','/Templates/Triangle.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',38),(37,1777588463,30,'file_created','admin','admin','files','created_self','[{\"39\":\"\\/Templates\\/Business model canvas.odg\"}]','','[]','/Templates/Business model canvas.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',39),(38,1777588463,30,'file_created','admin','admin','files','created_self','[{\"40\":\"\\/Templates\\/Readme.md\"}]','','[]','/Templates/Readme.md','http://localhost/index.php/apps/files/?dir=/Templates','files',40),(39,1777588463,30,'file_created','admin','admin','files','created_self','[{\"41\":\"\\/Templates\\/Resume.odt\"}]','','[]','/Templates/Resume.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',41),(40,1777588463,30,'file_created','admin','admin','files','created_self','[{\"42\":\"\\/Templates\\/Nostalgia.odp\"}]','','[]','/Templates/Nostalgia.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',42),(41,1777588463,30,'file_created','admin','admin','files','created_self','[{\"43\":\"\\/Templates\\/Meeting agenda.whiteboard\"}]','','[]','/Templates/Meeting agenda.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',43),(42,1777588464,30,'file_created','admin','admin','files','created_self','[{\"44\":\"\\/Templates\\/Simple.odp\"}]','','[]','/Templates/Simple.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',44),(43,1777588464,30,'file_created','admin','admin','files','created_self','[{\"45\":\"\\/Templates\\/Yellow idea.odp\"}]','','[]','/Templates/Yellow idea.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',45),(44,1777588464,30,'file_created','admin','admin','files','created_self','[{\"46\":\"\\/Templates\\/Timesheet.ods\"}]','','[]','/Templates/Timesheet.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',46),(45,1777588464,30,'file_created','admin','admin','files','created_self','[{\"47\":\"\\/Templates\\/Pitch deck.odp\"}]','','[]','/Templates/Pitch deck.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',47),(46,1777588464,30,'file_created','admin','admin','files','created_self','[{\"48\":\"\\/Templates\\/Diagram & table.ods\"}]','','[]','/Templates/Diagram & table.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',48),(47,1777588464,30,'file_created','admin','admin','files','created_self','[{\"49\":\"\\/Templates\\/Impact effort.whiteboard\"}]','','[]','/Templates/Impact effort.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',49),(48,1777588464,30,'file_created','admin','admin','files','created_self','[{\"50\":\"\\/Templates\\/Mind map.whiteboard\"}]','','[]','/Templates/Mind map.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',50),(49,1777588464,30,'file_created','admin','admin','files','created_self','[{\"51\":\"\\/Templates\\/Gotong royong.odp\"}]','','[]','/Templates/Gotong royong.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',51),(50,1777588464,30,'file_created','admin','admin','files','created_self','[{\"52\":\"\\/Templates\\/Meeting notes.md\"}]','','[]','/Templates/Meeting notes.md','http://localhost/index.php/apps/files/?dir=/Templates','files',52),(51,1777588464,30,'file_created','admin','admin','files','created_self','[{\"53\":\"\\/Templates\\/Onboarding.odp\"}]','','[]','/Templates/Onboarding.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',53),(52,1777588464,30,'file_created','admin','admin','files','created_self','[{\"54\":\"\\/Templates\\/Report.odt\"}]','','[]','/Templates/Report.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',54),(53,1777588464,30,'file_created','admin','admin','files','created_self','[{\"55\":\"\\/Templates\\/Kanban board.whiteboard\"}]','','[]','/Templates/Kanban board.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',55),(54,1777588464,30,'file_created','admin','admin','files','created_self','[{\"56\":\"\\/Templates\\/Timeline.whiteboard\"}]','','[]','/Templates/Timeline.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',56),(55,1777588464,30,'file_created','admin','admin','files','created_self','[{\"57\":\"\\/Templates\\/Business model canvas.ods\"}]','','[]','/Templates/Business model canvas.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',57),(56,1777588464,30,'file_created','admin','admin','files','created_self','[{\"58\":\"\\/Templates\\/Flowchart.whiteboard\"}]','','[]','/Templates/Flowchart.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',58),(57,1777588464,30,'file_created','admin','admin','files','created_self','[{\"59\":\"\\/Templates\\/Sticky notes.whiteboard\"}]','','[]','/Templates/Sticky notes.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',59),(58,1777588465,30,'file_created','admin','admin','files','created_self','[{\"60\":\"\\/Templates\\/Product plan.md\"}]','','[]','/Templates/Product plan.md','http://localhost/index.php/apps/files/?dir=/Templates','files',60),(59,1777588465,30,'file_created','admin','admin','files','created_self','[{\"61\":\"\\/Templates\\/Flowchart.odg\"}]','','[]','/Templates/Flowchart.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',61),(60,1777588465,30,'file_created','admin','admin','files','created_self','[{\"62\":\"\\/Templates\\/Brainstorming.whiteboard\"}]','','[]','/Templates/Brainstorming.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',62),(61,1777588465,30,'file_created','admin','admin','files','created_self','[{\"63\":\"\\/Templates\\/Menu.odt\"}]','','[]','/Templates/Menu.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',63),(62,1777588465,30,'file_created','admin','admin','files','created_self','[{\"64\":\"\\/Templates\\/Org chart.odg\"}]','','[]','/Templates/Org chart.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',64),(63,1777588465,30,'file_created','admin','admin','files','created_self','[{\"65\":\"\\/Templates\\/Mindmap.odg\"}]','','[]','/Templates/Mindmap.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',65),(64,1777588465,30,'file_created','admin','admin','files','created_self','[{\"66\":\"\\/Nextcloud.png\"}]','','[]','/Nextcloud.png','http://localhost/index.php/apps/files/?dir=/','files',66),(65,1777588465,30,'file_created','admin','admin','files','created_self','[{\"67\":\"\\/Nextcloud Manual.pdf\"}]','','[]','/Nextcloud Manual.pdf','http://localhost/index.php/apps/files/?dir=/','files',67),(66,1777588465,30,'file_created','admin','admin','files','created_self','[{\"68\":\"\\/Templates credits.md\"}]','','[]','/Templates credits.md','http://localhost/index.php/apps/files/?dir=/','files',68),(67,1777588465,30,'file_created','admin','admin','files','created_self','[{\"69\":\"\\/Reasons to use Nextcloud.pdf\"}]','','[]','/Reasons to use Nextcloud.pdf','http://localhost/index.php/apps/files/?dir=/','files',69),(68,1777588465,30,'calendar','admin','admin','dav','calendar_add_self','{\"actor\":\"admin\",\"calendar\":{\"id\":1,\"uri\":\"personal\",\"name\":\"Personal\"}}','','[]','','','calendar',1),(69,1777588465,30,'calendar_event','admin','admin','dav','object_add_event_self','{\"actor\":\"admin\",\"calendar\":{\"id\":1,\"uri\":\"personal\",\"name\":\"Personal\"},\"object\":{\"id\":\"9nIZcRvSOj8VNoM4NfazwESzbbHvz5JO\",\"name\":\"Example event - open me!\",\"classified\":false}}','','[]','','','calendar',1),(70,1777588465,30,'contacts','admin','admin','dav','addressbook_add_self','{\"actor\":\"admin\",\"addressbook\":{\"id\":2,\"uri\":\"contacts\",\"name\":\"Contacts\"}}','','[]','','','addressbook',2),(71,1777588465,30,'contacts','admin','admin','dav','card_add_self','{\"actor\":\"admin\",\"addressbook\":{\"id\":2,\"uri\":\"contacts\",\"name\":\"Contacts\"},\"card\":{\"id\":\"ae626677-809b-44a7-a311-e8dc0e51bd6f\",\"name\":\"Leon Green\"}}','','[]','','','addressbook',2),(72,1777588465,30,'calendar','admin','admin','dav','calendar_add_self','{\"actor\":\"admin\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"}}','','[]','','','calendar',2),(73,1777588465,30,'calendar_event','admin','admin','dav','object_add_event_self','{\"actor\":\"admin\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"ae626677-809b-44a7-a311-e8dc0e51bd6f\",\"name\":\"\\ud83c\\udf82 Leon Green (2000)\",\"classified\":false}}','','[]','','','calendar',2),(74,1777588507,30,'calendar','system','system','dav','calendar_add_self','{\"actor\":\"system\",\"calendar\":{\"id\":3,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"}}','','[]','','','calendar',3),(75,1777588616,30,'calendar_event','admin','admin','dav','object_delete_event_self','{\"actor\":\"admin\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"ae626677-809b-44a7-a311-e8dc0e51bd6f\",\"name\":\"\\ud83c\\udf82 Leon Green (2000)\",\"classified\":false}}','','[]','','','calendar',2),(76,1777588616,30,'calendar_event','admin','admin','dav','object_add_event_self','{\"actor\":\"admin\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"ae626677-809b-44a7-a311-e8dc0e51bd6f\",\"name\":\"\\ud83c\\udf82 Leon Green (2000)\",\"classified\":false}}','','[]','','','calendar',2);
/*!40000 ALTER TABLE `oc_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity_mq`
--

DROP TABLE IF EXISTS `oc_activity_mq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_activity_mq` (
  `mail_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amq_timestamp` int(11) NOT NULL DEFAULT 0,
  `amq_latest_send` int(11) NOT NULL DEFAULT 0,
  `amq_type` varchar(255) NOT NULL,
  `amq_affecteduser` varchar(64) NOT NULL,
  `amq_appid` varchar(32) NOT NULL,
  `amq_subject` varchar(255) NOT NULL,
  `amq_subjectparams` longtext DEFAULT NULL,
  `object_type` varchar(255) DEFAULT NULL,
  `object_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`mail_id`),
  KEY `amp_user` (`amq_affecteduser`),
  KEY `amp_latest_send_time` (`amq_latest_send`),
  KEY `amp_timestamp_time` (`amq_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity_mq`
--

LOCK TABLES `oc_activity_mq` WRITE;
/*!40000 ALTER TABLE `oc_activity_mq` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_activity_mq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbookchanges`
--

DROP TABLE IF EXISTS `oc_addressbookchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_addressbookchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `addressbookid` bigint(20) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `addressbookid_synctoken` (`addressbookid`,`synctoken`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbookchanges`
--

LOCK TABLES `oc_addressbookchanges` WRITE;
/*!40000 ALTER TABLE `oc_addressbookchanges` DISABLE KEYS */;
INSERT INTO `oc_addressbookchanges` VALUES (1,'default',1,2,1,1777588465),(2,'Database:admin.vcf',1,1,1,1777588507),(3,'Database:admin.vcf',2,1,2,1777589702),(4,'Database:admin.vcf',3,1,2,1777592402);
/*!40000 ALTER TABLE `oc_addressbookchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbooks`
--

DROP TABLE IF EXISTS `oc_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_addressbooks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `addressbook_index` (`principaluri`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbooks`
--

LOCK TABLES `oc_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc_addressbooks` DISABLE KEYS */;
INSERT INTO `oc_addressbooks` VALUES (1,'principals/system/system','system','system','System addressbook which holds all users of this instance',4),(2,'principals/users/admin','Contacts','contacts',NULL,2);
/*!40000 ALTER TABLE `oc_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appconfig`
--

DROP TABLE IF EXISTS `oc_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appconfig` (
  `appid` varchar(32) NOT NULL DEFAULT '',
  `configkey` varchar(64) NOT NULL DEFAULT '',
  `configvalue` longtext DEFAULT NULL,
  `type` int(10) unsigned NOT NULL DEFAULT 2,
  `lazy` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `ac_lazy_i` (`lazy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appconfig`
--

LOCK TABLES `oc_appconfig` WRITE;
/*!40000 ALTER TABLE `oc_appconfig` DISABLE KEYS */;
INSERT INTO `oc_appconfig` VALUES ('activity','enabled','yes',2,0),('activity','installed_version','6.0.0',2,0),('activity','types','filesystem',2,0),('app_api','enabled','yes',2,0),('app_api','installed_version','33.0.0',2,0),('app_api','types','',2,0),('backgroundjob','lastjob','5',2,0),('bruteforcesettings','enabled','yes',2,0),('bruteforcesettings','installed_version','6.0.0',2,0),('bruteforcesettings','types','',2,0),('circles','enabled','yes',2,0),('circles','installed_version','33.0.0',2,0),('circles','loopback_tmp_scheme','http',2,0),('circles','maintenance_run','0',4,0),('circles','maintenance_update','{\"3\":1780412701,\"2\":1780416002,\"1\":1780416002}',4,0),('circles','migration_22','1',2,0),('circles','migration_run','0',4,0),('circles','remove_share_tokens_done','1',32,1),('circles','types','filesystem,dav',2,0),('cloud_federation_api','enabled','yes',2,0),('cloud_federation_api','installed_version','1.17.0',2,0),('cloud_federation_api','types','filesystem',2,0),('comments','enabled','yes',2,0),('comments','installed_version','1.23.0',2,0),('comments','types','logging',2,0),('contactsinteraction','enabled','yes',2,0),('contactsinteraction','installed_version','1.14.1',2,0),('contactsinteraction','types','dav',2,0),('core','backgroundjobs_mode','cron',4,0),('core','files_metadata','{\"photos-original_date_time\":{\"value\":null,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":null,\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":null,\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":null,\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":null,\"type\":\"string\",\"etag\":\"1d454f9b395c7f425a512182f945b290\",\"indexed\":false,\"editPermission\":0}}',64,1),('core','installedat','1777588453.2501',2,0),('core','lastcron','1780416002',8,0),('core','lastupdateResult','[]',2,0),('core','lastupdatedat','1780368655',8,0),('core','metadataGenerationDone','1',32,0),('core','moveavatarsdone','yes',2,0),('core','oc.integritycheck.checker','[]',64,1),('core','previewMovedDone','1',32,0),('core','previewsCleanedUp','1',2,0),('core','public_files','files_sharing/public.php',2,0),('core','vendor','nextcloud',2,0),('dashboard','enabled','yes',2,0),('dashboard','installed_version','7.13.0',2,0),('dashboard','types','',2,0),('dav','buildCalendarReminderIndex','yes',2,0),('dav','buildCalendarSearchIndex','yes',2,0),('dav','builtSocialSearchIndex','1',32,0),('dav','chunks_migrated','1',2,0),('dav','enabled','yes',2,0),('dav','hasCustomDefaultContact','0',32,0),('dav','installed_version','1.36.0',2,0),('dav','regeneratedBirthdayCalendarsForYearFix','yes',2,0),('dav','types','filesystem',2,0),('federatedfilesharing','enabled','yes',2,0),('federatedfilesharing','installed_version','1.23.0',2,0),('federatedfilesharing','types','',2,0),('federation','enabled','yes',2,0),('federation','installed_version','1.23.0',2,0),('federation','types','authentication',2,0),('files','enabled','yes',2,0),('files','installed_version','2.5.0',2,0),('files','mimetype_version','33.0.3.2',4,0),('files','types','filesystem',2,0),('files_downloadlimit','enabled','yes',2,0),('files_downloadlimit','installed_version','5.1.0',2,0),('files_downloadlimit','types','',2,0),('files_pdfviewer','enabled','yes',2,0),('files_pdfviewer','installed_version','6.0.0',2,0),('files_pdfviewer','types','',2,0),('files_reminders','enabled','yes',2,0),('files_reminders','installed_version','1.6.0',2,0),('files_reminders','types','',2,0),('files_sharing','enabled','yes',2,0),('files_sharing','installed_version','1.25.2',2,0),('files_sharing','types','filesystem',2,0),('files_trashbin','enabled','yes',2,0),('files_trashbin','installed_version','1.23.0',2,0),('files_trashbin','types','filesystem,dav',2,0),('files_versions','enabled','yes',2,0),('files_versions','installed_version','1.26.0',2,0),('files_versions','types','filesystem,dav',2,0),('firstrunwizard','enabled','yes',2,0),('firstrunwizard','installed_version','6.0.0',2,0),('firstrunwizard','types','',2,0),('forms','enabled','yes',2,0),('forms','installed_version','5.2.7',2,0),('forms','types','prevent_group_restriction',2,0),('logreader','enabled','yes',2,0),('logreader','installed_version','6.0.0',2,0),('logreader','types','logging',2,0),('lookup_server_connector','enabled','yes',2,0),('lookup_server_connector','installed_version','1.21.0',2,0),('lookup_server_connector','types','authentication',2,0),('nextcloud_announcements','enabled','yes',2,0),('nextcloud_announcements','installed_version','5.0.0',2,0),('nextcloud_announcements','pub_date','Thu, 24 Oct 2019 00:00:00 +0200',2,0),('nextcloud_announcements','types','logging',2,0),('notifications','enabled','yes',2,0),('notifications','installed_version','6.0.0',2,0),('notifications','types','logging',2,0),('oauth2','enabled','yes',2,0),('oauth2','installed_version','1.21.0',2,0),('oauth2','types','authentication',2,0),('password_policy','enabled','yes',2,0),('password_policy','installed_version','5.0.0',2,0),('password_policy','types','authentication',2,0),('photos','enabled','yes',2,0),('photos','installed_version','6.0.0',2,0),('photos','lastPlaceMappedUser','admin',2,0),('photos','lastPlaceMappingDone','true',2,0),('photos','types','dav,authentication',2,0),('privacy','enabled','yes',2,0),('privacy','installed_version','5.0.0',2,0),('privacy','types','',2,0),('profile','enabled','yes',2,0),('profile','installed_version','1.2.0',2,0),('profile','types','',2,0),('provisioning_api','enabled','yes',2,0),('provisioning_api','installed_version','1.23.0',2,0),('provisioning_api','types','prevent_group_restriction',2,0),('recommendations','enabled','yes',2,0),('recommendations','installed_version','6.0.0',2,0),('recommendations','types','',2,0),('related_resources','enabled','yes',2,0),('related_resources','installed_version','4.0.0',2,0),('related_resources','types','',2,0),('serverinfo','cached_count_appdata_files','21',8,0),('serverinfo','cached_count_filecache','91',8,0),('serverinfo','cached_count_storages','2',8,0),('serverinfo','enabled','yes',2,0),('serverinfo','installed_version','5.0.0',2,0),('serverinfo','size_appdata_storage','0',16,0),('serverinfo','types','',2,0),('settings','enabled','yes',2,0),('settings','installed_version','1.16.0',2,0),('settings','types','',2,0),('sharebymail','enabled','yes',2,0),('sharebymail','installed_version','1.23.0',2,0),('sharebymail','types','filesystem',2,0),('support','SwitchUpdaterServerHasRun','yes',2,0),('support','enabled','yes',2,0),('support','installed_version','5.0.0',2,0),('support','types','session',2,0),('survey_client','enabled','yes',2,0),('survey_client','installed_version','5.0.0',2,0),('survey_client','types','',2,0),('systemtags','enabled','yes',2,0),('systemtags','installed_version','1.23.0',2,0),('systemtags','types','logging',2,0),('text','enabled','yes',2,0),('text','installed_version','7.0.1',2,0),('text','types','dav',2,0),('theming','enabled','yes',2,0),('theming','installed_version','2.8.0',2,0),('theming','types','logging',2,0),('twofactor_backupcodes','enabled','yes',2,0),('twofactor_backupcodes','installed_version','1.22.0',2,0),('twofactor_backupcodes','types','',2,0),('twofactor_totp','enabled','yes',2,0),('twofactor_totp','installed_version','15.0.0',2,0),('twofactor_totp','types','',2,0),('updatenotification','core','33.0.4.1',4,0),('updatenotification','enabled','yes',2,0),('updatenotification','forms','5.2.9',4,0),('updatenotification','installed_version','1.23.0',2,0),('updatenotification','types','',2,0),('updatenotification','update_check_errors','0',8,0),('user_ldap','background_sync_interval','1800',2,0),('user_ldap','cleanUpJobOffset','0',2,0),('user_ldap','configuration_prefixes','[]',64,0),('user_ldap','enabled','yes',2,0),('user_ldap','installed_version','1.24.0',2,0),('user_ldap','types','authentication',2,0),('user_status','enabled','yes',2,0),('user_status','installed_version','1.13.0',2,0),('user_status','types','',2,0),('viewer','enabled','yes',2,0),('viewer','installed_version','6.0.0',2,0),('viewer','types','',2,0),('weather_status','enabled','no',2,0),('weather_status','installed_version','1.12.0',2,0),('weather_status','types','',2,0),('webhook_listeners','enabled','yes',2,0),('webhook_listeners','installed_version','1.5.0',2,0),('webhook_listeners','types','filesystem',2,0),('workflowengine','enabled','yes',2,0),('workflowengine','installed_version','2.15.0',2,0),('workflowengine','types','filesystem',2,0);
/*!40000 ALTER TABLE `oc_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appconfig_ex`
--

DROP TABLE IF EXISTS `oc_appconfig_ex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appconfig_ex` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `configkey` varchar(64) NOT NULL,
  `configvalue` longtext DEFAULT NULL,
  `sensitive` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appconfig_ex__idx` (`appid`,`configkey`),
  KEY `appconfig_ex__configkey` (`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appconfig_ex`
--

LOCK TABLES `oc_appconfig_ex` WRITE;
/*!40000 ALTER TABLE `oc_appconfig_ex` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_appconfig_ex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authorized_groups`
--

DROP TABLE IF EXISTS `oc_authorized_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_authorized_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(200) NOT NULL,
  `class` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admindel_groupid_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authorized_groups`
--

LOCK TABLES `oc_authorized_groups` WRITE;
/*!40000 ALTER TABLE `oc_authorized_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_authorized_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authtoken`
--

DROP TABLE IF EXISTS `oc_authtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_authtoken` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL DEFAULT '',
  `login_name` varchar(255) NOT NULL DEFAULT '',
  `password` longtext DEFAULT NULL,
  `name` longtext NOT NULL DEFAULT '',
  `token` varchar(200) NOT NULL DEFAULT '',
  `type` smallint(5) unsigned DEFAULT 0,
  `remember` smallint(5) unsigned DEFAULT 0,
  `last_activity` int(10) unsigned DEFAULT 0,
  `last_check` int(10) unsigned DEFAULT 0,
  `scope` longtext DEFAULT NULL,
  `expires` int(10) unsigned DEFAULT NULL,
  `private_key` longtext DEFAULT NULL,
  `public_key` longtext DEFAULT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `password_invalid` tinyint(1) DEFAULT 0,
  `password_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authtoken_token_index` (`token`),
  KEY `authtoken_last_activity_idx` (`last_activity`),
  KEY `authtoken_uid_index` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authtoken`
--

LOCK TABLES `oc_authtoken` WRITE;
/*!40000 ALTER TABLE `oc_authtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_authtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_bruteforce_attempts`
--

DROP TABLE IF EXISTS `oc_bruteforce_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_bruteforce_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(64) NOT NULL DEFAULT '',
  `occurred` int(10) unsigned NOT NULL DEFAULT 0,
  `ip` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `bruteforce_attempts_ip` (`ip`),
  KEY `bruteforce_attempts_subnet` (`subnet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_bruteforce_attempts`
--

LOCK TABLES `oc_bruteforce_attempts` WRITE;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_invitations`
--

DROP TABLE IF EXISTS `oc_calendar_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_invitations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(512) NOT NULL,
  `recurrenceid` varchar(255) DEFAULT NULL,
  `attendee` varchar(255) NOT NULL,
  `organizer` varchar(255) NOT NULL,
  `sequence` bigint(20) unsigned DEFAULT NULL,
  `token` varchar(60) NOT NULL,
  `expiration` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_invitation_tokens` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_invitations`
--

LOCK TABLES `oc_calendar_invitations` WRITE;
/*!40000 ALTER TABLE `oc_calendar_invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_reminders`
--

DROP TABLE IF EXISTS `oc_calendar_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_reminders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `is_recurring` smallint(6) DEFAULT NULL,
  `uid` varchar(512) NOT NULL,
  `recurrence_id` bigint(20) unsigned DEFAULT NULL,
  `is_recurrence_exception` smallint(6) NOT NULL,
  `event_hash` varchar(255) NOT NULL,
  `alarm_hash` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `is_relative` smallint(6) NOT NULL,
  `notification_date` bigint(20) unsigned NOT NULL,
  `is_repeat_based` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_reminder_objid` (`object_id`),
  KEY `calendar_reminder_uidrec` (`uid`,`recurrence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_reminders`
--

LOCK TABLES `oc_calendar_reminders` WRITE;
/*!40000 ALTER TABLE `oc_calendar_reminders` DISABLE KEYS */;
INSERT INTO `oc_calendar_reminders` VALUES (3,2,3,1,'ae626677-809b-44a7-a311-e8dc0e51bd6f',1798761600,0,'88c8121877ecb09038e898ad6bded686','76093d23ab21b01668f0685b69a71007','DISPLAY',1,1798794000,0);
/*!40000 ALTER TABLE `oc_calendar_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_resources`
--

DROP TABLE IF EXISTS `oc_calendar_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backend_id` varchar(64) DEFAULT NULL,
  `resource_id` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `group_restrictions` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resources_bkdrsc` (`backend_id`,`resource_id`),
  KEY `calendar_resources_email` (`email`),
  KEY `calendar_resources_name` (`displayname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_resources`
--

LOCK TABLES `oc_calendar_resources` WRITE;
/*!40000 ALTER TABLE `oc_calendar_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_resources_md`
--

DROP TABLE IF EXISTS `oc_calendar_resources_md`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_resources_md` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resources_md_idk` (`resource_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_resources_md`
--

LOCK TABLES `oc_calendar_resources_md` WRITE;
/*!40000 ALTER TABLE `oc_calendar_resources_md` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_resources_md` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_rooms`
--

DROP TABLE IF EXISTS `oc_calendar_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backend_id` varchar(64) DEFAULT NULL,
  `resource_id` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `group_restrictions` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_rooms_bkdrsc` (`backend_id`,`resource_id`),
  KEY `calendar_rooms_email` (`email`),
  KEY `calendar_rooms_name` (`displayname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_rooms`
--

LOCK TABLES `oc_calendar_rooms` WRITE;
/*!40000 ALTER TABLE `oc_calendar_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_rooms_md`
--

DROP TABLE IF EXISTS `oc_calendar_rooms_md`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_rooms_md` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_rooms_md_idk` (`room_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_rooms_md`
--

LOCK TABLES `oc_calendar_rooms_md` WRITE;
/*!40000 ALTER TABLE `oc_calendar_rooms_md` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_rooms_md` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarchanges`
--

DROP TABLE IF EXISTS `oc_calendarchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `calendarid` bigint(20) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `calid_type_synctoken` (`calendarid`,`calendartype`,`synctoken`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarchanges`
--

LOCK TABLES `oc_calendarchanges` WRITE;
/*!40000 ALTER TABLE `oc_calendarchanges` DISABLE KEYS */;
INSERT INTO `oc_calendarchanges` VALUES (1,'9nIZcRvSOj8VNoM4NfazwESzbbHvz5JO.ics',1,1,1,0,1777588465),(2,'contacts-default.ics',1,2,1,0,1777588465),(3,'contacts-default.ics',2,2,3,0,1777588616),(4,'contacts-default.ics',3,2,1,0,1777588616);
/*!40000 ALTER TABLE `oc_calendarchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects`
--

DROP TABLE IF EXISTS `oc_calendarobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendardata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `calendarid` bigint(20) unsigned NOT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `componenttype` varchar(8) DEFAULT NULL,
  `firstoccurence` bigint(20) unsigned DEFAULT NULL,
  `lastoccurence` bigint(20) unsigned DEFAULT NULL,
  `uid` varchar(512) DEFAULT NULL,
  `classification` int(11) DEFAULT 0,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  `deleted_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calobjects_index` (`calendarid`,`calendartype`,`uri`),
  UNIQUE KEY `calobjects_by_uid_index` (`calendarid`,`calendartype`,`uid`),
  KEY `calobj_clssfction_index` (`classification`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects`
--

LOCK TABLES `oc_calendarobjects` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects` DISABLE KEYS */;
INSERT INTO `oc_calendarobjects` VALUES (1,'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//Sabre//Sabre VObject 4.5.6//EN\r\nCALSCALE:GREGORIAN\r\nBEGIN:VEVENT\r\nUID:9nIZcRvSOj8VNoM4NfazwESzbbHvz5JO\r\nDTSTAMP:20260430T223425Z\r\nSUMMARY:Example event - open me!\r\nDTSTART:20260507T100000Z\r\nDTEND:20260507T110000Z\r\nDESCRIPTION:Welcome to Nextcloud Calendar!\\n\\nThis is a sample event - expl\r\n ore the flexibility of planning with Nextcloud Calendar by making any edit\r\n s you want!\\n\\nWith Nextcloud Calendar\\, you can:\\n- Create\\, edit\\, and m\r\n anage events effortlessly.\\n- Create multiple calendars and share them wit\r\n h teammates\\, friends\\, or family.\\n- Check availability and display your \r\n busy times to others.\\n- Seamlessly integrate with apps and devices via Ca\r\n lDAV.\\n- Customize your experience: schedule recurring events\\, adjust not\r\n ifications and other settings.\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n','9nIZcRvSOj8VNoM4NfazwESzbbHvz5JO.ics',1,1777588465,'4d2b5eac3d734cf5d0bf480ba3466a82',853,'VEVENT',1778148000,1778151600,'9nIZcRvSOj8VNoM4NfazwESzbbHvz5JO',0,0,NULL),(3,'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nCALSCALE:GREGORIAN\r\nPRODID:-//IDN nextcloud.com//Birthday calendar//EN\r\nBEGIN:VEVENT\r\nDTSTAMP:20260430T223656Z\r\nDTSTART;VALUE=DATE:20000101\r\nDTEND;VALUE=DATE:20000102\r\nUID:ae626677-809b-44a7-a311-e8dc0e51bd6f\r\nRRULE:FREQ=YEARLY\r\nSUMMARY:🎂 Leon Green (2000)\r\nTRANSP:TRANSPARENT\r\nX-NEXTCLOUD-BC-FIELD-TYPE:BDAY\r\nX-NEXTCLOUD-BC-UNKNOWN-YEAR:0\r\nX-NEXTCLOUD-BC-YEAR:2000\r\nBEGIN:VALARM\r\nTRIGGER;VALUE=DURATION:PT9H\r\nACTION:DISPLAY\r\nDESCRIPTION:🎂 Leon Green (2000)\r\nEND:VALARM\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n','contacts-default.ics',2,1777588616,'41d9bfae05e317730555fd34f6042b7a',534,'VEVENT',946684800,2145916800,'ae626677-809b-44a7-a311-e8dc0e51bd6f',0,0,NULL);
/*!40000 ALTER TABLE `oc_calendarobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects_props`
--

DROP TABLE IF EXISTS `oc_calendarobjects_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarobjects_props` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendarid` bigint(20) NOT NULL DEFAULT 0,
  `objectid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `parameter` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `calendarobject_index` (`objectid`,`calendartype`),
  KEY `calendarobject_name_index` (`name`,`calendartype`),
  KEY `calendarobject_value_index` (`value`,`calendartype`),
  KEY `calendarobject_calid_index` (`calendarid`,`calendartype`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects_props`
--

LOCK TABLES `oc_calendarobjects_props` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects_props` DISABLE KEYS */;
INSERT INTO `oc_calendarobjects_props` VALUES (4,1,1,'SUMMARY',NULL,'Example event - open me!',0),(5,1,1,'DESCRIPTION',NULL,'Welcome to Nextcloud Calendar!\n\nThis is a sample event - explore the flexibility of planning with Nextcloud Calendar by making any edits you want!\n\nWith Nextcloud Calendar, you can:\n- Create, edit, and manage events effortlessly.\n- Create multiple calend',0),(7,2,3,'SUMMARY',NULL,'🎂 Leon Green (2000)',0);
/*!40000 ALTER TABLE `oc_calendarobjects_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendars`
--

DROP TABLE IF EXISTS `oc_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `description` varchar(255) DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT 0,
  `calendarcolor` varchar(255) DEFAULT NULL,
  `timezone` longtext DEFAULT NULL,
  `components` varchar(64) DEFAULT NULL,
  `transparent` smallint(6) NOT NULL DEFAULT 0,
  `deleted_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendars_index` (`principaluri`,`uri`),
  KEY `cals_princ_del_idx` (`principaluri`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendars`
--

LOCK TABLES `oc_calendars` WRITE;
/*!40000 ALTER TABLE `oc_calendars` DISABLE KEYS */;
INSERT INTO `oc_calendars` VALUES (1,'principals/users/admin','Personal','personal',2,NULL,0,'#00679e',NULL,'VEVENT',0,NULL),(2,'principals/users/admin','Contact birthdays','contact_birthdays',4,NULL,0,'#E9D859',NULL,'VEVENT',0,NULL),(3,'principals/system/system','Contact birthdays','contact_birthdays',1,NULL,0,'#E9D859',NULL,'VEVENT',0,NULL);
/*!40000 ALTER TABLE `oc_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendars_federated`
--

DROP TABLE IF EXISTS `oc_calendars_federated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendars_federated` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) NOT NULL,
  `color` varchar(7) DEFAULT NULL,
  `uri` varchar(255) NOT NULL,
  `principaluri` varchar(255) NOT NULL,
  `remote_Url` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `sync_token` int(10) unsigned NOT NULL DEFAULT 0,
  `last_sync` bigint(20) unsigned DEFAULT NULL,
  `shared_by` varchar(255) NOT NULL,
  `shared_by_display_name` varchar(255) NOT NULL,
  `components` varchar(255) NOT NULL,
  `permissions` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fedcals_uris_index` (`principaluri`,`uri`),
  KEY `fedcals_last_sync_index` (`last_sync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendars_federated`
--

LOCK TABLES `oc_calendars_federated` WRITE;
/*!40000 ALTER TABLE `oc_calendars_federated` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendars_federated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarsubscriptions`
--

DROP TABLE IF EXISTS `oc_calendarsubscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarsubscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(100) DEFAULT NULL,
  `refreshrate` varchar(10) DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT 0,
  `calendarcolor` varchar(255) DEFAULT NULL,
  `striptodos` smallint(6) DEFAULT NULL,
  `stripalarms` smallint(6) DEFAULT NULL,
  `stripattachments` smallint(6) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `source` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calsub_index` (`principaluri`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarsubscriptions`
--

LOCK TABLES `oc_calendarsubscriptions` WRITE;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards`
--

DROP TABLE IF EXISTS `oc_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT 0,
  `carddata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `lastmodified` bigint(20) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_abiduri` (`addressbookid`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards`
--

LOCK TABLES `oc_cards` WRITE;
/*!40000 ALTER TABLE `oc_cards` DISABLE KEYS */;
INSERT INTO `oc_cards` VALUES (1,2,'BEGIN:VCARD\r\nVERSION:3.0\r\nPRODID:-//Sabre//Sabre VObject 4.5.6//EN\r\nUID:ae626677-809b-44a7-a311-e8dc0e51bd6f\r\nFN:Leon Green\r\nADR;TYPE=HOME:;;123 Street Street;City;State;;Country\r\nEMAIL;TYPE=HOME:leon@example.com\r\nTEL;TYPE=HOME,VOICE:+999999999999\r\nPHOTO;ENCODING=b;TYPE=PNG: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\r\n ORK5CYII=\r\nPHOTO;VALUE=URI:\r\nPHOTO;VALUE=URI:\r\nTITLE:Manager\r\nORG:Company\r\nBDAY;VALUE=DATE:20000101\r\nURL;VALUE=URI:www.nextcloud.com\r\nREV;VALUE=DATE-AND-OR-TIME:20260430T223425Z\r\nNOTE:This is an example contact\r\nEND:VCARD\r\n','default',1777588465,'bfa55ee3915dc77ee530c6b9e2770346',272899,'ae626677-809b-44a7-a311-e8dc0e51bd6f'),(2,1,'BEGIN:VCARD\r\nVERSION:3.0\r\nPRODID:-//Sabre//Sabre VObject 4.5.6//EN\r\nUID:admin\r\nFN;X-NC-SCOPE=v2-federated:admin\r\nN;X-NC-SCOPE=v2-federated:admin;;;;\r\nPHOTO;ENCODING=b;TYPE=image/png;0=v2-federated:iVBORw0KGgoAAAANSUhEUgAAAgAA\r\n AAIACAYAAAD0eNT6AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAcCklEQVR4nO3dSX9UV5rg4TckIU\r\n BCA4nBYIMNdrrS6fSQldWb7i/S36+X/S1y073oKhuM8YANQhIIMEMMUmiIsRdKZ5VtZCOIN6bz\r\n PKtMD+e9Py+If8S9555Kq1nrBwBQlJlRXwAAMHwCAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoE\r\n ACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEAC\r\n AAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAA\r\n AKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAK\r\n JAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJA\r\n AAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAA\r\n oEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoE\r\n ACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEAC\r\n AAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAA\r\n AKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAK\r\n JAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJA\r\n AAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAA\r\n oEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoEACAAAKJAAAoE\r\n ACAAAKNDfqCwAGp9/vxcbf/1f0OgcDX/sPH/z3WHn304GvC4yGAIApsrP1XTQf30lZ+1n//wgA\r\n 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\r\n AEyU/NevOvhnGg0j6mprX0S/30ufA4MiAJgYnb3t2Hl4O3XG4pvvO/hnCq2+97eIqKTO6O7vxM\r\n 7Wd6kzYJAEABOjtvZFRPI3rMMPCqbNiYWVWLz4x/Q51bufp8+AQREATIzse6wO/pluw9jZsfPw\r\n dnT2cp9RgUERAEyE5o/3or3zPHWGg3+m29LbH8bsycXcIf1e1O7l7lKBQREATIRh7LM++37+Eb\r\n KMTmVmNlaufpY+p+qdAEwIAcDY67b3o3H/69QZp85eilOrF1NnMHpn38uPvPbO82j+eC99Drwu\r\n AcDYq9+7Ef3kd607+KcMJ5fPx+lzV9Ln1LwTgAkgABh72X+YOvinLMO41dPYvBXd5NMq4XVVWs\r\n 1a7kvVAYCx4xcAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkA\r\n ACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAAC\r\n iQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQ\r\n AACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAA\r\n CAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACA\r\n AgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAg\r\n kAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkA\r\n ACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAAC\r\n iQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQ\r\n AACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAA\r\n CAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACA\r\n AgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAg\r\n kAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAgkAACiQAACAAv1/\r\n 6A0wz9UEX2IAAAAASUVORK5CYII=\r\nX-SOCIALPROFILE;TYPE=NEXTCLOUD;X-NC-SCOPE=v2-published:http://nextcloud.exa\r\n mple.com/index.php/u/admin\r\nCLOUD:admin@http://nextcloud.example.com\r\nEND:VCARD\r\n','Database:admin.vcf',1777592402,'60e4aee3a169715391858787cce85bea',10427,'admin');
/*!40000 ALTER TABLE `oc_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards_properties`
--

DROP TABLE IF EXISTS `oc_cards_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_cards_properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT 0,
  `cardid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `card_contactid_index` (`cardid`),
  KEY `card_name_index` (`name`),
  KEY `card_value_index` (`value`),
  KEY `cards_prop_abid_name_value` (`addressbookid`,`name`,`value`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards_properties`
--

LOCK TABLES `oc_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc_cards_properties` DISABLE KEYS */;
INSERT INTO `oc_cards_properties` VALUES (1,2,1,'UID','ae626677-809b-44a7-a311-e8dc0e51bd6f',0),(2,2,1,'FN','Leon Green',0),(3,2,1,'ADR',';;123 Street Street;City;State;;Country',0),(4,2,1,'EMAIL','leon@example.com',0),(5,2,1,'TEL','+999999999999',0),(6,2,1,'TITLE','Manager',0),(7,2,1,'ORG','Company',0),(8,2,1,'BDAY','20000101',0),(9,2,1,'URL','www.nextcloud.com',0),(10,2,1,'NOTE','This is an example contact',0),(21,1,2,'UID','admin',0),(22,1,2,'FN','admin',0),(23,1,2,'N','admin;;;;',0),(24,1,2,'X-SOCIALPROFILE','http://nextcloud.example.com/index.php/u/admin',0),(25,1,2,'CLOUD','admin@http://nextcloud.example.com',0);
/*!40000 ALTER TABLE `oc_cards_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_circle`
--

DROP TABLE IF EXISTS `oc_circles_circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_circle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(31) NOT NULL,
  `name` varchar(127) NOT NULL,
  `display_name` varchar(255) DEFAULT '',
  `sanitized_name` varchar(127) DEFAULT '',
  `instance` varchar(255) DEFAULT '',
  `config` int(10) unsigned DEFAULT NULL,
  `source` int(10) unsigned DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `contact_addressbook` int(10) unsigned DEFAULT NULL,
  `contact_groupname` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8195F548E3C68343` (`unique_id`),
  KEY `IDX_8195F548D48A2F7C` (`config`),
  KEY `IDX_8195F5484230B1DE` (`instance`),
  KEY `IDX_8195F5485F8A7F73` (`source`),
  KEY `IDX_8195F548C317B362` (`sanitized_name`),
  KEY `dname` (`display_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_circle`
--

LOCK TABLES `oc_circles_circle` WRITE;
/*!40000 ALTER TABLE `oc_circles_circle` DISABLE KEYS */;
INSERT INTO `oc_circles_circle` VALUES (1,'3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','user:admin:3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','admin','','',1,1,'[]','','2026-04-30 22:34:20',0,''),(2,'yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','app:circles:yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','Circles','','',8193,10001,'[]','','2026-04-30 22:34:20',0,''),(3,'62qmFphgShTcfBYGUD9NxmoKlmDHhHz','group:admin','admin','','',1540,2,'{\"population\":0,\"populationInherited\":0}','','2026-04-30 22:35:07',0,'');
/*!40000 ALTER TABLE `oc_circles_circle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_event`
--

DROP TABLE IF EXISTS `oc_circles_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_event` (
  `token` varchar(63) NOT NULL,
  `instance` varchar(255) NOT NULL,
  `event` longtext DEFAULT NULL,
  `result` longtext DEFAULT NULL,
  `interface` int(11) NOT NULL DEFAULT 0,
  `severity` int(11) DEFAULT NULL,
  `retry` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`token`,`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_event`
--

LOCK TABLES `oc_circles_event` WRITE;
/*!40000 ALTER TABLE `oc_circles_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_member`
--

DROP TABLE IF EXISTS `oc_circles_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `single_id` varchar(31) DEFAULT NULL,
  `circle_id` varchar(31) NOT NULL,
  `member_id` varchar(31) DEFAULT NULL,
  `user_id` varchar(127) NOT NULL,
  `user_type` smallint(6) NOT NULL DEFAULT 1,
  `instance` varchar(255) DEFAULT '',
  `invited_by` varchar(31) DEFAULT NULL,
  `level` smallint(6) NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `cached_name` varchar(255) DEFAULT '',
  `cached_update` datetime DEFAULT NULL,
  `contact_id` varchar(127) DEFAULT NULL,
  `contact_meta` longtext DEFAULT NULL,
  `joined` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `circles_member_cisiuiutil` (`circle_id`,`single_id`,`user_id`,`user_type`,`instance`,`level`),
  KEY `circles_member_cisi` (`circle_id`,`single_id`),
  KEY `IDX_25C66A49E7A1254A` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_member`
--

LOCK TABLES `oc_circles_member` WRITE;
/*!40000 ALTER TABLE `oc_circles_member` DISABLE KEYS */;
INSERT INTO `oc_circles_member` VALUES (1,'yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','circles',10000,'',NULL,9,'Member','[]','Circles','2026-04-30 22:34:20','',NULL,'2026-04-30 22:34:20'),(2,'3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','admin',1,'','yZK2MpotuTbkvnyjUp5QutFkAtvxWFI',9,'Member','[]','admin','2026-04-30 23:40:02','',NULL,'2026-04-30 22:34:20'),(3,'yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','62qmFphgShTcfBYGUD9NxmoKlmDHhHz','ssA9cAWI5HoCV3uB8DqllPjemJuyCAq','circles',10000,'',NULL,9,'Member','[]','Circles','2026-04-30 22:35:07','',NULL,'2026-04-30 22:35:07');
/*!40000 ALTER TABLE `oc_circles_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_membership`
--

DROP TABLE IF EXISTS `oc_circles_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_membership` (
  `circle_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `inheritance_first` varchar(31) NOT NULL,
  `inheritance_last` varchar(31) NOT NULL,
  `inheritance_depth` int(10) unsigned NOT NULL,
  `inheritance_path` longtext NOT NULL,
  PRIMARY KEY (`single_id`,`circle_id`),
  KEY `IDX_8FC816EAE7C1D92B` (`single_id`),
  KEY `circles_membership_ifilci` (`inheritance_first`,`inheritance_last`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_membership`
--

LOCK TABLES `oc_circles_membership` WRITE;
/*!40000 ALTER TABLE `oc_circles_membership` DISABLE KEYS */;
INSERT INTO `oc_circles_membership` VALUES ('3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3',9,'3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3','3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3',1,'[\"3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3\"]'),('yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','yZK2MpotuTbkvnyjUp5QutFkAtvxWFI',9,'yZK2MpotuTbkvnyjUp5QutFkAtvxWFI','yZK2MpotuTbkvnyjUp5QutFkAtvxWFI',1,'[\"yZK2MpotuTbkvnyjUp5QutFkAtvxWFI\"]');
/*!40000 ALTER TABLE `oc_circles_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_mount`
--

DROP TABLE IF EXISTS `oc_circles_mount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_mount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mount_id` varchar(31) NOT NULL,
  `circle_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `token` varchar(63) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `mountpoint` longtext DEFAULT NULL,
  `mountpoint_hash` varchar(64) DEFAULT NULL,
  `remote` varchar(255) DEFAULT '',
  `remote_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `circles_mount_cimipt` (`circle_id`,`mount_id`,`parent`,`token`),
  KEY `m_sid_rmt_rid` (`circle_id`,`remote`,`remote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_mount`
--

LOCK TABLES `oc_circles_mount` WRITE;
/*!40000 ALTER TABLE `oc_circles_mount` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_mount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_mountpoint`
--

DROP TABLE IF EXISTS `oc_circles_mountpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_mountpoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mount_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `mountpoint` longtext DEFAULT NULL,
  `mountpoint_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mp_sid_hash` (`single_id`,`mountpoint_hash`),
  KEY `circles_mountpoint_ms` (`mount_id`,`single_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_mountpoint`
--

LOCK TABLES `oc_circles_mountpoint` WRITE;
/*!40000 ALTER TABLE `oc_circles_mountpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_mountpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_remote`
--

DROP TABLE IF EXISTS `oc_circles_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_remote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL DEFAULT 'Unknown',
  `interface` int(11) NOT NULL DEFAULT 0,
  `uid` varchar(20) DEFAULT NULL,
  `instance` varchar(127) DEFAULT NULL,
  `href` varchar(254) DEFAULT NULL,
  `item` longtext DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F94EF834230B1DE` (`instance`),
  KEY `IDX_F94EF83539B0606` (`uid`),
  KEY `IDX_F94EF8334F8E741` (`href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_remote`
--

LOCK TABLES `oc_circles_remote` WRITE;
/*!40000 ALTER TABLE `oc_circles_remote` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_remote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_share_lock`
--

DROP TABLE IF EXISTS `oc_circles_share_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_share_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` varchar(31) NOT NULL,
  `circle_id` varchar(31) NOT NULL,
  `instance` varchar(127) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_337F52F8126F525E70EE2FF6` (`item_id`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_share_lock`
--

LOCK TABLES `oc_circles_share_lock` WRITE;
/*!40000 ALTER TABLE `oc_circles_share_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_share_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_token`
--

DROP TABLE IF EXISTS `oc_circles_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) DEFAULT NULL,
  `circle_id` varchar(31) DEFAULT NULL,
  `single_id` varchar(31) DEFAULT NULL,
  `member_id` varchar(31) DEFAULT NULL,
  `token` varchar(31) DEFAULT NULL,
  `password` varchar(127) DEFAULT NULL,
  `accepted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sicisimit` (`share_id`,`circle_id`,`single_id`,`member_id`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_token`
--

LOCK TABLES `oc_circles_token` WRITE;
/*!40000 ALTER TABLE `oc_circles_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_accesscache`
--

DROP TABLE IF EXISTS `oc_collres_accesscache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_accesscache` (
  `user_id` varchar(64) NOT NULL,
  `collection_id` bigint(20) NOT NULL DEFAULT 0,
  `resource_type` varchar(64) NOT NULL DEFAULT '',
  `resource_id` varchar(64) NOT NULL DEFAULT '',
  `access` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`user_id`,`collection_id`,`resource_type`,`resource_id`),
  KEY `collres_user_res` (`user_id`,`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_accesscache`
--

LOCK TABLES `oc_collres_accesscache` WRITE;
/*!40000 ALTER TABLE `oc_collres_accesscache` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_accesscache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_collections`
--

DROP TABLE IF EXISTS `oc_collres_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_collections` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_collections`
--

LOCK TABLES `oc_collres_collections` WRITE;
/*!40000 ALTER TABLE `oc_collres_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_resources`
--

DROP TABLE IF EXISTS `oc_collres_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_resources` (
  `collection_id` bigint(20) NOT NULL,
  `resource_type` varchar(64) NOT NULL,
  `resource_id` varchar(64) NOT NULL,
  PRIMARY KEY (`collection_id`,`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_resources`
--

LOCK TABLES `oc_collres_resources` WRITE;
/*!40000 ALTER TABLE `oc_collres_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments`
--

DROP TABLE IF EXISTS `oc_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `topmost_parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `children_count` int(10) unsigned NOT NULL DEFAULT 0,
  `actor_type` varchar(64) NOT NULL DEFAULT '',
  `actor_id` varchar(64) NOT NULL DEFAULT '',
  `message` longtext DEFAULT NULL,
  `verb` varchar(64) DEFAULT NULL,
  `creation_timestamp` datetime DEFAULT NULL,
  `latest_child_timestamp` datetime DEFAULT NULL,
  `object_type` varchar(64) NOT NULL DEFAULT '',
  `object_id` varchar(64) NOT NULL DEFAULT '',
  `reference_id` varchar(64) DEFAULT NULL,
  `reactions` varchar(4000) DEFAULT NULL,
  `expire_date` datetime DEFAULT NULL,
  `meta_data` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `comments_parent_id_index` (`parent_id`),
  KEY `comments_topmost_parent_id_idx` (`topmost_parent_id`),
  KEY `comments_object_index` (`object_type`,`object_id`,`creation_timestamp`),
  KEY `comments_actor_index` (`actor_type`,`actor_id`),
  KEY `expire_date` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments`
--

LOCK TABLES `oc_comments` WRITE;
/*!40000 ALTER TABLE `oc_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments_read_markers`
--

DROP TABLE IF EXISTS `oc_comments_read_markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_comments_read_markers` (
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `object_type` varchar(64) NOT NULL DEFAULT '',
  `object_id` varchar(64) NOT NULL DEFAULT '',
  `marker_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`object_type`,`object_id`),
  KEY `comments_marker_object_index` (`object_type`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments_read_markers`
--

LOCK TABLES `oc_comments_read_markers` WRITE;
/*!40000 ALTER TABLE `oc_comments_read_markers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments_read_markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_absence`
--

DROP TABLE IF EXISTS `oc_dav_absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_absence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `first_day` varchar(10) NOT NULL,
  `last_day` varchar(10) NOT NULL,
  `status` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `replacement_user_id` varchar(64) DEFAULT '',
  `replacement_user_display_name` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_absence_uid_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_absence`
--

LOCK TABLES `oc_dav_absence` WRITE;
/*!40000 ALTER TABLE `oc_dav_absence` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_absence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_cal_proxy`
--

DROP TABLE IF EXISTS `oc_dav_cal_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_cal_proxy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(64) NOT NULL,
  `proxy_id` varchar(64) NOT NULL,
  `permissions` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_cal_proxy_uidx` (`owner_id`,`proxy_id`,`permissions`),
  KEY `dav_cal_proxy_ipid` (`proxy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_cal_proxy`
--

LOCK TABLES `oc_dav_cal_proxy` WRITE;
/*!40000 ALTER TABLE `oc_dav_cal_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_cal_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_shares`
--

DROP TABLE IF EXISTS `oc_dav_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_shares` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `access` smallint(6) DEFAULT NULL,
  `resourceid` bigint(20) unsigned NOT NULL,
  `publicuri` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_shares_index` (`principaluri`,`resourceid`,`type`,`publicuri`),
  KEY `dav_shares_resourceid_type` (`resourceid`,`type`),
  KEY `dav_shares_resourceid_access` (`resourceid`,`access`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_shares`
--

LOCK TABLES `oc_dav_shares` WRITE;
/*!40000 ALTER TABLE `oc_dav_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_direct_edit`
--

DROP TABLE IF EXISTS `oc_direct_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_direct_edit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `editor_id` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `share_id` bigint(20) DEFAULT NULL,
  `timestamp` bigint(20) unsigned NOT NULL,
  `accessed` tinyint(1) DEFAULT 0,
  `file_path` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D5AFECA5F37A13B` (`token`),
  KEY `direct_edit_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_direct_edit`
--

LOCK TABLES `oc_direct_edit` WRITE;
/*!40000 ALTER TABLE `oc_direct_edit` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_direct_edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_directlink`
--

DROP TABLE IF EXISTS `oc_directlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_directlink` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) DEFAULT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `token` varchar(60) DEFAULT NULL,
  `expiration` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `directlink_token_idx` (`token`),
  KEY `directlink_expiration_idx` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_directlink`
--

LOCK TABLES `oc_directlink` WRITE;
/*!40000 ALTER TABLE `oc_directlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_directlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_apps`
--

DROP TABLE IF EXISTS `oc_ex_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_apps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `version` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `daemon_config_name` varchar(64) NOT NULL DEFAULT '0',
  `port` smallint(5) unsigned NOT NULL,
  `secret` varchar(256) NOT NULL,
  `status` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`status`)),
  `enabled` smallint(6) NOT NULL DEFAULT 0,
  `created_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_apps__appid` (`appid`),
  UNIQUE KEY `ex_apps_c_port__idx` (`daemon_config_name`,`port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_apps`
--

LOCK TABLES `oc_ex_apps` WRITE;
/*!40000 ALTER TABLE `oc_ex_apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_apps_daemons`
--

DROP TABLE IF EXISTS `oc_ex_apps_daemons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_apps_daemons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `accepts_deploy_id` varchar(64) NOT NULL,
  `protocol` varchar(32) NOT NULL,
  `host` varchar(255) NOT NULL,
  `deploy_config` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`deploy_config`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_apps_daemons__name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_apps_daemons`
--

LOCK TABLES `oc_ex_apps_daemons` WRITE;
/*!40000 ALTER TABLE `oc_ex_apps_daemons` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_apps_daemons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_apps_routes`
--

DROP TABLE IF EXISTS `oc_ex_apps_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_apps_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `url` varchar(512) NOT NULL,
  `verb` varchar(64) NOT NULL,
  `access_level` int(11) NOT NULL DEFAULT 0,
  `headers_to_exclude` varchar(512) DEFAULT NULL,
  `bruteforce_protection` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ex_apps_routes_appid` (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_apps_routes`
--

LOCK TABLES `oc_ex_apps_routes` WRITE;
/*!40000 ALTER TABLE `oc_ex_apps_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_apps_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_deploy_options`
--

DROP TABLE IF EXISTS `oc_ex_deploy_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_deploy_options` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`value`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `deploy_options__idx` (`appid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_deploy_options`
--

LOCK TABLES `oc_ex_deploy_options` WRITE;
/*!40000 ALTER TABLE `oc_ex_deploy_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_deploy_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_occ_commands`
--

DROP TABLE IF EXISTS `oc_ex_occ_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_occ_commands` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `hidden` smallint(6) NOT NULL DEFAULT 0,
  `arguments` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`arguments`)),
  `options` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`options`)),
  `usages` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`usages`)),
  `execute_handler` varchar(410) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_occ_commands__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_occ_commands`
--

LOCK TABLES `oc_ex_occ_commands` WRITE;
/*!40000 ALTER TABLE `oc_ex_occ_commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_occ_commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_settings_forms`
--

DROP TABLE IF EXISTS `oc_ex_settings_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_settings_forms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `formid` varchar(64) NOT NULL,
  `scheme` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`scheme`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_settings_forms__idx` (`appid`,`formid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_settings_forms`
--

LOCK TABLES `oc_ex_settings_forms` WRITE;
/*!40000 ALTER TABLE `oc_ex_settings_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_settings_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_task_processing`
--

DROP TABLE IF EXISTS `oc_ex_task_processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_task_processing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `task_type` varchar(255) NOT NULL,
  `custom_task_type` longtext DEFAULT NULL,
  `provider` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_processing_idx` (`app_id`,`name`,`task_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_task_processing`
--

LOCK TABLES `oc_ex_task_processing` WRITE;
/*!40000 ALTER TABLE `oc_ex_task_processing` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_task_processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_files_actions`
--

DROP TABLE IF EXISTS `oc_ex_ui_files_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_files_actions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `mime` longtext NOT NULL DEFAULT 'file',
  `permissions` varchar(255) NOT NULL,
  `order` bigint(20) NOT NULL DEFAULT 0,
  `icon` varchar(255) DEFAULT '',
  `action_handler` varchar(64) NOT NULL,
  `version` varchar(64) NOT NULL DEFAULT '1.0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_ui_files_actions__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_files_actions`
--

LOCK TABLES `oc_ex_ui_files_actions` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_files_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_files_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_scripts`
--

DROP TABLE IF EXISTS `oc_ex_ui_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_scripts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `path` varchar(410) NOT NULL,
  `after_app_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_script__idx` (`appid`,`type`,`name`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_scripts`
--

LOCK TABLES `oc_ex_ui_scripts` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_states`
--

DROP TABLE IF EXISTS `oc_ex_ui_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_states` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`value`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_state__idx` (`appid`,`type`,`name`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_states`
--

LOCK TABLES `oc_ex_ui_states` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_styles`
--

DROP TABLE IF EXISTS `oc_ex_ui_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_styles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `path` varchar(410) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_style__idx` (`appid`,`type`,`name`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_styles`
--

LOCK TABLES `oc_ex_ui_styles` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_top_menu`
--

DROP TABLE IF EXISTS `oc_ex_ui_top_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_top_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `display_name` varchar(32) NOT NULL,
  `icon` varchar(255) DEFAULT '',
  `admin_required` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_top_menu__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_top_menu`
--

LOCK TABLES `oc_ex_ui_top_menu` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_top_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_top_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_federated_invites`
--

DROP TABLE IF EXISTS `oc_federated_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_federated_invites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `recipient_provider` varchar(2083) DEFAULT NULL,
  `recipient_user_id` varchar(1024) DEFAULT NULL,
  `recipient_name` varchar(1024) DEFAULT NULL,
  `recipient_email` varchar(320) DEFAULT NULL,
  `token` varchar(60) NOT NULL,
  `accepted` tinyint(1) DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) DEFAULT NULL,
  `accepted_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A2C17D5A5F37A13B` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_federated_invites`
--

LOCK TABLES `oc_federated_invites` WRITE;
/*!40000 ALTER TABLE `oc_federated_invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_federated_invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_federated_reshares`
--

DROP TABLE IF EXISTS `oc_federated_reshares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_federated_reshares` (
  `share_id` bigint(20) NOT NULL,
  `remote_id` varchar(255) DEFAULT '',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_federated_reshares`
--

LOCK TABLES `oc_federated_reshares` WRITE;
/*!40000 ALTER TABLE `oc_federated_reshares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_federated_reshares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_file_locks`
--

DROP TABLE IF EXISTS `oc_file_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_file_locks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lock` int(11) NOT NULL DEFAULT 0,
  `key` varchar(64) NOT NULL,
  `ttl` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lock_key_index` (`key`),
  KEY `lock_ttl_index` (`ttl`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_file_locks`
--

LOCK TABLES `oc_file_locks` WRITE;
/*!40000 ALTER TABLE `oc_file_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_file_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache`
--

DROP TABLE IF EXISTS `oc_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_filecache` (
  `fileid` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage` bigint(20) NOT NULL DEFAULT 0,
  `path` varchar(4000) DEFAULT NULL,
  `path_hash` varchar(32) NOT NULL DEFAULT '',
  `parent` bigint(20) NOT NULL DEFAULT 0,
  `name` varchar(250) DEFAULT NULL,
  `mimetype` bigint(20) NOT NULL DEFAULT 0,
  `mimepart` bigint(20) NOT NULL DEFAULT 0,
  `size` bigint(20) NOT NULL DEFAULT 0,
  `mtime` bigint(20) NOT NULL DEFAULT 0,
  `storage_mtime` bigint(20) NOT NULL DEFAULT 0,
  `encrypted` int(11) NOT NULL DEFAULT 0,
  `unencrypted_size` bigint(20) NOT NULL DEFAULT 0,
  `etag` varchar(40) DEFAULT NULL,
  `permissions` int(11) DEFAULT 0,
  `checksum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`),
  KEY `fs_parent_name_hash` (`parent`,`name`),
  KEY `fs_storage_mimetype` (`storage`,`mimetype`),
  KEY `fs_storage_mimepart` (`storage`,`mimepart`),
  KEY `fs_storage_size` (`storage`,`size`,`fileid`),
  KEY `fs_parent` (`parent`),
  KEY `fs_name_hash` (`name`),
  KEY `fs_mtime` (`mtime`),
  KEY `fs_size` (`size`),
  KEY `fs_storage_path_prefix` (`storage`,`path`(64))
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache`
--

LOCK TABLES `oc_filecache` WRITE;
/*!40000 ALTER TABLE `oc_filecache` DISABLE KEYS */;
INSERT INTO `oc_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,59833306,1777588465,1777588460,0,0,'69f3d8f18422e',23,''),(2,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,59833306,1777588465,1777588465,0,0,'69f3d8f18422e',31,''),(3,1,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',2,'Documents',2,1,1108446,1777588461,1777588461,0,0,'69f3d8ed4aa1f',31,''),(4,1,'files/Documents/Welcome to Nextcloud Hub.docx','b44cb84f22ceddc4ca2826e026038091',3,'Welcome to Nextcloud Hub.docx',4,3,23876,1777588461,1777588461,0,0,'bfd28341d8979deae210b7b60f461abb',27,''),(5,1,'files/Documents/Nextcloud flyer.pdf','9c5b4dc7182a7435767708ac3e8d126c',3,'Nextcloud flyer.pdf',5,3,1083339,1777588461,1777588461,0,0,'d5744bb2debaa9570e26f3f357b80eba',27,''),(6,1,'files/Documents/Readme.md','51ec9e44357d147dd5c212b850f6910f',3,'Readme.md',7,6,136,1777588461,1777588461,0,0,'717d5791c981ce18b92ed53281402e74',27,''),(7,1,'files/Documents/Example.md','efe0853470dd0663db34818b444328dd',3,'Example.md',7,6,1095,1777588461,1777588461,0,0,'00cc9683678921cc7e831c5d7f292bbb',27,''),(8,1,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',2,'Photos',2,1,5656463,1777588462,1777588462,0,0,'69f3d8ee136e5',31,''),(9,1,'files/Photos/Gorilla.jpg','6d5f5956d8ff76a5f290cebb56402789',8,'Gorilla.jpg',9,8,474653,1777588461,1777588461,0,0,'9fbb38dcd39339e34e1607fa65b3f8de',27,''),(10,1,'files/Photos/Steps.jpg','7b2ca8d05bbad97e00cbf5833d43e912',8,'Steps.jpg',9,8,567689,1777588461,1777588461,0,0,'5c1485ebfb9921146df8962c11f6e813',27,''),(11,1,'files/Photos/Readme.md','2a4ac36bb841d25d06d164f291ee97db',8,'Readme.md',7,6,150,1777588461,1777588461,0,0,'af018ff2cd227434e045126798a16270',27,''),(12,1,'files/Photos/Vineyard.jpg','14e5f2670b0817614acd52269d971db8',8,'Vineyard.jpg',9,8,427030,1777588461,1777588461,0,0,'fa6be432fbf6b5c8674a0180b7b5a447',27,''),(13,1,'files/Photos/Frog.jpg','d6219add1a9129ed0c1513af985e2081',8,'Frog.jpg',9,8,457744,1777588461,1777588461,0,0,'d3a4b7d6d99d6cc135d7910db56e862a',27,''),(14,1,'files/Photos/Nextcloud community.jpg','b9b3caef83a2a1c20354b98df6bcd9d0',8,'Nextcloud community.jpg',9,8,797325,1777588461,1777588461,0,0,'5edbf7e458734168158cb9137d516f50',27,''),(15,1,'files/Photos/Birdie.jpg','cd31c7af3a0ec6e15782b5edd2774549',8,'Birdie.jpg',9,8,593508,1777588461,1777588461,0,0,'1720f6a385893a3b5fbe6b4381f08370',27,''),(16,1,'files/Photos/Library.jpg','0b785d02a19fc00979f82f6b54a05805',8,'Library.jpg',9,8,2170375,1777588461,1777588461,0,0,'129f85e5c56051fd9a4fe1b75d8907dd',27,''),(17,1,'files/Photos/Toucan.jpg','681d1e78f46a233e12ecfa722cbc2aef',8,'Toucan.jpg',9,8,167989,1777588462,1777588462,0,0,'1fcd46f60f0443b0a96cf2bab13e4ec6',27,''),(18,1,'files/Readme.md','49af83716f8dcbfa89aaf835241c0b9f',2,'Readme.md',7,6,197,1777588462,1777588462,0,0,'3ab9e5b7d91a20362da0c5b89dc1c443',27,''),(19,1,'files/Nextcloud intro.mp4','e4919345bcc87d4585a5525daaad99c0',2,'Nextcloud intro.mp4',11,10,3963036,1777588462,1777588462,0,0,'8b4edcb1a9991e346edb3bbed5e4a30f',27,''),(20,1,'files/Templates','530b342d0b8164ff3b4754c2273a453e',2,'Templates',2,1,23476072,1777588465,1777588465,0,0,'69f3d8f1484f5',31,''),(21,1,'files/Templates/Photo book.odt','ea35993988e2799424fef3ff4f420c24',20,'Photo book.odt',12,3,5155877,1777588462,1777588462,0,0,'b07c7813bc69395abb2478176990b938',27,''),(22,1,'files/Templates/Checklist.ods','bf1cf0b1734780fa0f93520224ccf706',20,'Checklist.ods',13,3,256849,1777588462,1777588462,0,0,'fa68db1843e4685dbc8e98fdab84dc04',27,''),(23,1,'files/Templates/Invoice.odt','40fdccb51b6c3e3cf20532e06ed5016e',20,'Invoice.odt',12,3,17276,1777588462,1777588462,0,0,'107e5d4b2ddfc753a25811b1aee3db0e',27,''),(24,1,'files/Templates/Certificate.odt','925a8dcedb5c2d2f6ef697aa3edf17c6',20,'Certificate.odt',12,3,33441,1777588462,1777588462,0,0,'831ae82fa9ba23e706307ee30afbf67e',27,''),(25,1,'files/Templates/Venn diagram.whiteboard','71d9f77ebd2c126375fa7170a1c86509',20,'Venn diagram.whiteboard',14,3,23359,1777588462,1777588462,0,0,'faeec3d253ccf49a14b30994179bbe84',27,''),(26,1,'files/Templates/Syllabus.odt','03b3147e6dae00674c1d50fe22bb8496',20,'Syllabus.odt',12,3,32323,1777588462,1777588462,0,0,'31aa7a4552941ec0499d2de0686a3715',27,''),(27,1,'files/Templates/Invoice.ods','c777e4557c09ad1582c1ce3e2608cdd9',20,'Invoice.ods',13,3,22002,1777588462,1777588462,0,0,'c03b1b789f46adee1e129899f592c3b7',27,''),(28,1,'files/Templates/Security.odp','f60c1935b9b65bc06c6c6bfb5776d799',20,'Security.odp',15,3,190107,1777588462,1777588462,0,0,'f8c234c6f068534af4a97412409c18ce',27,''),(29,1,'files/Templates/Party invitation.odt','439f95f734be87868374b1a5a312c550',20,'Party invitation.odt',12,3,868111,1777588463,1777588463,0,0,'ec0643e3c691c0c0eadac76f0f1e1570',27,''),(30,1,'files/Templates/Calendar.odt','0708fc19c3dfcbc1b4b9ed9fd4cc9fdc',20,'Calendar.odt',12,3,22675,1777588463,1777588463,0,0,'bc11c4f3b7614fee74ec8298be45fa50',27,''),(31,1,'files/Templates/Mother\'s day.odt','cb66c617dbb4acc9b534ec095c400b53',20,'Mother\'s day.odt',12,3,340061,1777588463,1777588463,0,0,'de6ec315e76eb6ee3f642f2706f73623',27,''),(32,1,'files/Templates/Ecosystem.odp','83433827d87227520f743f7ac13fb047',20,'Ecosystem.odp',15,3,1441424,1777588463,1777588463,0,0,'47bc77e768c8437d28fd1a5f55e367eb',27,''),(33,1,'files/Templates/Business model canvas.whiteboard','1c4e5432621502fa9a668c49b25b81d9',20,'Business model canvas.whiteboard',14,3,30290,1777588463,1777588463,0,0,'ab32102e30c3c00e01d28d132e2f264a',27,''),(34,1,'files/Templates/Elegant.odp','f3ec70ed694c0ca215f094b98eb046a7',20,'Elegant.odp',15,3,14316,1777588463,1777588463,0,0,'8ee7b64dc1b7337dd8d917f905c0932d',27,''),(35,1,'files/Templates/Letter.odt','15545ade0e9863c98f3a5cc0fbf2836a',20,'Letter.odt',12,3,15961,1777588463,1777588463,0,0,'7638a9b464e9155d2977df384db8ce96',27,''),(36,1,'files/Templates/Expense report.ods','d0a4025621279b95d2f94ff4ec09eab3',20,'Expense report.ods',13,3,19026,1777588463,1777588463,0,0,'ad3b8cee862c79fd2b206468b9deaa03',27,''),(37,1,'files/Templates/Modern company.odp','96ad2c06ebb6a79bcdf2f4030421dee3',20,'Modern company.odp',15,3,317015,1777588463,1777588463,0,0,'7fbb8e349d3ff9b4dfb0abdf7902e402',27,''),(38,1,'files/Templates/Triangle.odp','00d15a150581c646b5fef301fe99d5b6',20,'Triangle.odp',15,3,35454,1777588463,1777588463,0,0,'f6f8829e322f727c17705ec70d8cd638',27,''),(39,1,'files/Templates/Business model canvas.odg','6a8f3e02bdf45c8b0671967969393bcb',20,'Business model canvas.odg',16,3,16988,1777588463,1777588463,0,0,'707ec8163ee8b9dd5ee519dd24aa4d36',27,''),(40,1,'files/Templates/Readme.md','71fa2e74ab30f39eed525572ccc3bbec',20,'Readme.md',7,6,554,1777588463,1777588463,0,0,'e94794f2ee3e3ed4d739fa40f59e10c0',27,''),(41,1,'files/Templates/Resume.odt','ace8f81202eadb2f0c15ba6ecc2539f5',20,'Resume.odt',12,3,17331,1777588463,1777588463,0,0,'9d25d8b2fc51a165d737d9e241a94638',27,''),(42,1,'files/Templates/Nostalgia.odp','3ec95d91860764c9c4316dcfa4be06aa',20,'Nostalgia.odp',15,3,560887,1777588463,1777588463,0,0,'b58af4448ba169e4ffc212ca82b354c9',27,''),(43,1,'files/Templates/Meeting agenda.whiteboard','be213da59b99766ceae11e80093803a9',20,'Meeting agenda.whiteboard',14,3,27629,1777588463,1777588463,0,0,'4458e7aa3e322ea263db904bacb4955e',27,''),(44,1,'files/Templates/Simple.odp','a2c90ff606d31419d699b0b437969c61',20,'Simple.odp',15,3,14810,1777588463,1777588463,0,0,'0dbab8d08eecb673a580a159e0df56a2',27,''),(45,1,'files/Templates/Yellow idea.odp','3a57051288d7b81bef3196a2123f4af5',20,'Yellow idea.odp',15,3,81196,1777588464,1777588464,0,0,'401132784e21cc7ace9e46d6ff78ca10',27,''),(46,1,'files/Templates/Timesheet.ods','cb79c81e41d3c3c77cd31576dc7f1a3a',20,'Timesheet.ods',13,3,90170,1777588464,1777588464,0,0,'67fabbf9b3740ac230743d32e757a6ac',27,''),(47,1,'files/Templates/Pitch deck.odp','008c83c17a2021c0ca2a45592902cbf8',20,'Pitch deck.odp',15,3,35963,1777588464,1777588464,0,0,'f93dd3e3aeef4b55c711629e561e5ea5',27,''),(48,1,'files/Templates/Diagram & table.ods','0a89f154655f6d4a0098bc4e6ca87367',20,'Diagram & table.ods',13,3,13378,1777588464,1777588464,0,0,'60946431d3a9aa0328805675f4448ff8',27,''),(49,1,'files/Templates/Impact effort.whiteboard','071dbd5231cfcb493fa2fcc4a763be05',20,'Impact effort.whiteboard',14,3,30671,1777588464,1777588464,0,0,'b8949fdb247ab2f63ef4fd7507c68697',27,''),(50,1,'files/Templates/Mind map.whiteboard','27c7b4d83fd3526a42122bcacf5dfbe9',20,'Mind map.whiteboard',14,3,35657,1777588464,1777588464,0,0,'1fb4fa0469ebfa80da4f87128f0ac752',27,''),(51,1,'files/Templates/Gotong royong.odp','14b958f5aafb7cfd703090226f3cbd1b',20,'Gotong royong.odp',15,3,3509628,1777588464,1777588464,0,0,'f2d2ad1c5ce01f623b87287455e24909',27,''),(52,1,'files/Templates/Meeting notes.md','c0279758bb570afdcdbc2471b2f16285',20,'Meeting notes.md',7,6,326,1777588464,1777588464,0,0,'7383440eaecd6a9d3ed87f458b2be95b',27,''),(53,1,'files/Templates/Onboarding.odp','2131269b631b9e1b4d5ffdb5cc3e09bc',20,'Onboarding.odp',15,3,9904434,1777588464,1777588464,0,0,'2063eb481cbfeff7f5dcbb567087540f',27,''),(54,1,'files/Templates/Report.odt','51fbc02b90f00b6b3c8783ab160938ae',20,'Report.odt',12,3,34163,1777588464,1777588464,0,0,'60640161d8c6b1804d9dc2cef383e401',27,''),(55,1,'files/Templates/Kanban board.whiteboard','174b2766514fef9a88cbb3076e362b4a',20,'Kanban board.whiteboard',14,3,25621,1777588464,1777588464,0,0,'4dacc2a434bdffad29dfc0a5f808e356',27,''),(56,1,'files/Templates/Timeline.whiteboard','a009a1620252b19a9307d35de49311e9',20,'Timeline.whiteboard',14,3,31325,1777588464,1777588464,0,0,'bfaf82bd2c7fe4ed8ce4458535d90224',27,''),(57,1,'files/Templates/Business model canvas.ods','86c10a47dedf156bf4431cb75e0f76ec',20,'Business model canvas.ods',13,3,29055,1777588464,1777588464,0,0,'e973cae388a9abf1e15d0a3cc0a48eaf',27,''),(58,1,'files/Templates/Flowchart.whiteboard','b944a25f1ef13e8e256107178bb28141',20,'Flowchart.whiteboard',14,3,31132,1777588464,1777588464,0,0,'1d109069f1101602a9780737e15833dc',27,''),(59,1,'files/Templates/Sticky notes.whiteboard','72309dacd55c6de379c738caf18d84c4',20,'Sticky notes.whiteboard',14,3,45778,1777588464,1777588464,0,0,'cbe959b4be0ac736cde2d3ede322bc0e',27,''),(60,1,'files/Templates/Product plan.md','a9fbf58bf31cebb8143f7ad3a5205633',20,'Product plan.md',7,6,573,1777588464,1777588464,0,0,'7470ca77dfc952c8f9b2184b4b847df8',27,''),(61,1,'files/Templates/Flowchart.odg','832942849155883ceddc6f3cede21867',20,'Flowchart.odg',16,3,11836,1777588465,1777588465,0,0,'3cdb669c037e807b958ebac3c18f3f57',27,''),(62,1,'files/Templates/Brainstorming.whiteboard','aa2d36938cf5c1f41813d1e8bbd3ae00',20,'Brainstorming.whiteboard',14,3,30780,1777588465,1777588465,0,0,'33f797867cb7a693af5000c59aff29be',27,''),(63,1,'files/Templates/Menu.odt','64663435ca7de4c9ca8d7672f2e2663a',20,'Menu.odt',12,3,33089,1777588465,1777588465,0,0,'3258ecadbb615e2c494bd95e42bc7d8d',27,''),(64,1,'files/Templates/Org chart.odg','fd846bc062b158abb99a75a5b33b53e7',20,'Org chart.odg',16,3,13878,1777588465,1777588465,0,0,'967d028cdbc868ed7cf2d5fdd64edcee',27,''),(65,1,'files/Templates/Mindmap.odg','74cff798fc1b9634ee45380599b2a6da',20,'Mindmap.odg',16,3,13653,1777588465,1777588465,0,0,'e2d5eea0c67c73f54c2ed5bf6f7b986a',27,''),(66,1,'files/Nextcloud.png','2bcc0ff06465ef1bfc4a868efde1e485',2,'Nextcloud.png',17,8,50598,1777588465,1777588465,0,0,'1d454f9b395c7f425a512182f945b290',27,''),(67,1,'files/Nextcloud Manual.pdf','2bc58a43566a8edde804a4a97a9c7469',2,'Nextcloud Manual.pdf',5,3,24598701,1777588465,1777588465,0,0,'27dffa02c908efad402d295ef1daf56a',27,''),(68,1,'files/Templates credits.md','f7c01e3e0b55bb895e09dc08d19375b3',2,'Templates credits.md',7,6,3168,1777588465,1777588465,0,0,'55b32c910f923eb7b0fd6b340d7417f5',27,''),(69,1,'files/Reasons to use Nextcloud.pdf','418b19142a61c5bef296ea56ee144ca3',2,'Reasons to use Nextcloud.pdf',5,3,976625,1777588465,1777588465,0,0,'083d8d9b191cd19c377ee4910425e552',27,''),(70,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1777588465,1777588465,0,0,'69f3ddc908ba2',23,''),(71,2,'appdata_ocm9ua92lqzi','9830daab7453f2d54d4be8fd1dce377e',70,'appdata_ocm9ua92lqzi',2,1,0,1777589474,1777589474,0,0,'69f3d8f1a4c49',31,''),(72,2,'appdata_ocm9ua92lqzi/dav','8bb5fd379655c7dd495b75622d4e440a',71,'dav',2,1,0,1777588465,1777588465,0,0,'69f3d8f1a7c5e',31,''),(73,2,'appdata_ocm9ua92lqzi/dav/defaultContact','aee4cf4dd6c3352bcc74e4021b23e25b',72,'defaultContact',2,1,0,1777588465,1777588465,0,0,'69f3d8f1aa3d2',31,''),(74,2,'appdata_ocm9ua92lqzi/dav/defaultContact/defaultContact.vcf','a145439c2a93e0007b4b006b2192f3dc',73,'defaultContact.vcf',18,6,269311,1777588465,1777588465,0,0,'88337233338b3f5ef59e99ea69396a23',27,''),(75,2,'appdata_ocm9ua92lqzi/appstore','763681f2dbadaebf3bba76dadff8c46b',71,'appstore',2,1,0,1777588470,1777588470,0,0,'69f3d8f3de474',31,''),(76,2,'appdata_ocm9ua92lqzi/appstore/apps.json','32c8fbe2ac477d022695dcd5fcadd95c',75,'apps.json',19,3,3634125,1780368659,1780368659,0,0,'2c3dd347565cb35c2957d4b5c82e2032',27,''),(77,2,'appdata_ocm9ua92lqzi/js','e532e802e6672fd87cf896f4a210b88e',71,'js',2,1,0,1777588471,1777588471,0,0,'69f3d8f7b2c59',31,''),(78,2,'appdata_ocm9ua92lqzi/preview','31ae80538423ccb38418782602ee3fb9',71,'preview',2,1,0,1777588502,1777588502,0,0,'69f3d9166b703',31,''),(158,2,'appdata_ocm9ua92lqzi/avatar','b231485f2cbd5b94d7d4271c972bc87d',71,'avatar',2,1,0,1777588506,1777588506,0,0,'69f3d91ad113e',31,''),(159,2,'appdata_ocm9ua92lqzi/avatar/admin','62f3db654e2e4a5102434b6574fa827a',158,'admin',2,1,0,1777588507,1777588507,0,0,'69f3d91ad1e95',31,''),(160,2,'appdata_ocm9ua92lqzi/avatar/admin/avatar.png','8aecf88f4d768467e3adb72e216c5d02',159,'avatar.png',17,8,15643,1777588507,1777588507,0,0,'4301168a94a4f4d3f255058888ebcd78',27,''),(161,2,'appdata_ocm9ua92lqzi/avatar/admin/generated','5500c3eb1b43f2e5c61859557c7def18',159,'generated',25,3,0,1777588507,1777588507,0,0,'5f869f1e83fe4443535971448cd6ecee',27,''),(162,2,'appdata_ocm9ua92lqzi/avatar/admin/avatar.512.png','8ed51e9f22cc2c3e880e68e3e751d39c',159,'avatar.512.png',17,8,6447,1777588507,1777588507,0,0,'f3a80e1f62c2a12c893b63fe120ff07a',27,''),(163,2,'appdata_ocm9ua92lqzi/theming','dee410aa532b4cb7af2764bc457f3d76',71,'theming',2,1,-1,1777588481,1777588481,0,0,'69f3d91b68f85',31,''),(164,2,'appdata_ocm9ua92lqzi/theming/global','d67d3e07cd0fa5134a94d998d0aa6e2e',163,'global',2,1,0,1777590002,1777590002,0,0,'69f3d91b6891b',23,''),(166,2,'appdata_ocm9ua92lqzi/identityproof','53d1d1b72e8b8e2c9d59d8ffc57c55db',71,'identityproof',2,1,0,1777588707,1777588707,0,0,'69f3d9e33ca48',31,''),(167,2,'appdata_ocm9ua92lqzi/identityproof/app-core-ocm_external','c96b38942af61aa939c82a7b44f57be3',166,'app-core-ocm_external',2,1,0,1777588707,1777588707,0,0,'69f3d9e340724',31,''),(168,2,'appdata_ocm9ua92lqzi/identityproof/app-core-ocm_external/private','af11958c6c718dc2eed59089fd558915',167,'private',25,3,3588,1777588707,1777588707,0,0,'98fa5b5a70050334d62234d1afb76a2d',27,''),(169,2,'appdata_ocm9ua92lqzi/identityproof/app-core-ocm_external/public','d2ae1917a197681adc57e9549887b2f2',167,'public',25,3,451,1777588707,1777588707,0,0,'a57d5d633b1b67b9a155dbdb33a6f354',27,''),(170,2,'appdata_ocm9ua92lqzi/text','afdaac18dc48c3f3ad7245433827a59a',71,'text',2,1,0,1777589474,1777589474,0,0,'69f3dce23988c',31,''),(171,2,'appdata_ocm9ua92lqzi/text/documents','2236fb51c179690b941ddc3fd620e8e9',170,'documents',2,1,0,1777589474,1777589474,0,0,'69f3dce23d7c9',31,'');
/*!40000 ALTER TABLE `oc_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache_extended`
--

DROP TABLE IF EXISTS `oc_filecache_extended`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_filecache_extended` (
  `fileid` bigint(20) unsigned NOT NULL,
  `metadata_etag` varchar(40) DEFAULT NULL,
  `creation_time` bigint(20) NOT NULL DEFAULT 0,
  `upload_time` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fileid`),
  KEY `fce_ctime_idx` (`creation_time`),
  KEY `fce_utime_idx` (`upload_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache_extended`
--

LOCK TABLES `oc_filecache_extended` WRITE;
/*!40000 ALTER TABLE `oc_filecache_extended` DISABLE KEYS */;
INSERT INTO `oc_filecache_extended` VALUES (4,NULL,1777588461,0),(5,NULL,1777588461,0),(6,NULL,1777588461,0),(7,NULL,1777588461,0),(9,NULL,1777588461,0),(10,NULL,1777588461,0),(11,NULL,1777588461,0),(12,NULL,1777588461,0),(13,NULL,1777588461,0),(14,NULL,1777588461,0),(15,NULL,1777588461,0),(16,NULL,1777588462,0),(17,NULL,1777588462,0),(18,NULL,1777588462,0),(19,NULL,1777588462,0),(21,NULL,1777588462,0),(22,NULL,1777588462,0),(23,NULL,1777588462,0),(24,NULL,1777588462,0),(25,NULL,1777588462,0),(26,NULL,1777588462,0),(27,NULL,1777588462,0),(28,NULL,1777588463,0),(29,NULL,1777588463,0),(30,NULL,1777588463,0),(31,NULL,1777588463,0),(32,NULL,1777588463,0),(33,NULL,1777588463,0),(34,NULL,1777588463,0),(35,NULL,1777588463,0),(36,NULL,1777588463,0),(37,NULL,1777588463,0),(38,NULL,1777588463,0),(39,NULL,1777588463,0),(40,NULL,1777588463,0),(41,NULL,1777588463,0),(42,NULL,1777588463,0),(43,NULL,1777588463,0),(44,NULL,1777588464,0),(45,NULL,1777588464,0),(46,NULL,1777588464,0),(47,NULL,1777588464,0),(48,NULL,1777588464,0),(49,NULL,1777588464,0),(50,NULL,1777588464,0),(51,NULL,1777588464,0),(52,NULL,1777588464,0),(53,NULL,1777588464,0),(54,NULL,1777588464,0),(55,NULL,1777588464,0),(56,NULL,1777588464,0),(57,NULL,1777588464,0),(58,NULL,1777588464,0),(59,NULL,1777588464,0),(60,NULL,1777588465,0),(61,NULL,1777588465,0),(62,NULL,1777588465,0),(63,NULL,1777588465,0),(64,NULL,1777588465,0),(65,NULL,1777588465,0),(66,NULL,1777588465,0),(67,NULL,1777588465,0),(68,NULL,1777588465,0),(69,NULL,1777588465,0),(74,NULL,1777588465,0),(76,NULL,1777588470,0),(87,NULL,1777588502,0),(96,NULL,1777588502,0),(105,NULL,1777588503,0),(113,NULL,1777588503,0),(122,NULL,1777588504,0),(131,NULL,1777588504,0),(139,NULL,1777588505,0),(148,NULL,1777588505,0),(157,NULL,1777588506,0),(160,NULL,1777588507,0),(161,NULL,1777588507,0),(162,NULL,1777588507,0),(168,NULL,1777588707,0),(169,NULL,1777588707,0);
/*!40000 ALTER TABLE `oc_filecache_extended` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_metadata`
--

DROP TABLE IF EXISTS `oc_files_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_metadata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `json` longtext NOT NULL,
  `sync_token` varchar(15) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_meta_fileid` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_metadata`
--

LOCK TABLES `oc_files_metadata` WRITE;
/*!40000 ALTER TABLE `oc_files_metadata` DISABLE KEYS */;
INSERT INTO `oc_files_metadata` VALUES (1,9,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/640\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":1,\"ISOSpeedRatings\":12800,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 13:47:40\",\"DateTimeDigitized\":\"2012:06:30 13:47:40\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"75\\/8\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"6149\\/1087\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"235\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"134321\\/34\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":1,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.3.1\",\"DateTime\":\"2012:06:30 13:47:40\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1341064060,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"L87_1d~qM|Io%gt7oMxuE1M{%M?b\",\"type\":\"string\",\"etag\":\"9fbb38dcd39339e34e1607fa65b3f8de\",\"indexed\":false,\"editPermission\":0}}','lw3RoY1','2026-04-30 22:35:02'),(2,10,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/160\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":100,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2013:06:27 07:51:09\",\"DateTimeDigitized\":\"2013:06:27 07:51:09\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"59\\/8\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"2\\/3\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"45\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1200,\"ExifImageLength\":1800,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"185679\\/47\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"000052602c\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.4.5\",\"DateTime\":\"2013:06:27 07:51:09\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1200,\"height\":1800},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1372319469,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"LZJ$~jNyIqj]u6SPWBoM76s:oJj]\",\"type\":\"string\",\"etag\":\"5c1485ebfb9921146df8962c11f6e813\",\"indexed\":false,\"editPermission\":0}}','YrNXwMZ','2026-04-30 22:35:03'),(3,12,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"10\\/12500\",\"FNumber\":\"35\\/10\",\"ExposureProgram\":3,\"ISOSpeedRatings\":100,\"DateTimeOriginal\":\"2018:05:16 20:03:00\",\"DateTimeDigitized\":\"2018:05:16 20:03:00\",\"ExposureBiasValue\":\"0\\/6\",\"MaxApertureValue\":\"30\\/10\",\"MeteringMode\":5,\"LightSource\":0,\"Flash\":16,\"FocalLength\":\"700\\/10\",\"MakerNote\":\"Nikon\",\"UserComment\":\"Christoph WurstCC-SA 4.0\",\"SubSecTime\":\"30\",\"SubSecTimeOriginal\":\"30\",\"SubSecTimeDigitized\":\"30\",\"ColorSpace\":1,\"SensingMethod\":2,\"FileSource\":\"\",\"SceneType\":\"\",\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"DigitalZoomRatio\":\"1\\/1\",\"FocalLengthIn__mmFilm\":70,\"SceneCaptureType\":0,\"GainControl\":0,\"Contrast\":1,\"Saturation\":0,\"Sharpness\":1,\"SubjectDistanceRange\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"ImageDescription\":\"Christoph WurstCC-SA 4.0\",\"Make\":\"NIKON CORPORATION\",\"Model\":\"NIKON D610\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"GIMP 2.10.14\",\"DateTime\":\"2019:12:10 08:51:16\",\"Artist\":\"Christoph Wurst                     \",\"Copyright\":\"Christoph Wurst                                       \",\"Exif_IFD_Pointer\":402,\"GPS_IFD_Pointer\":13738,\"DateTimeOriginal\":\"2018:05:16 20:03:00\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1920,\"height\":1281},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1526500980,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"LXCigUWB0ft6~VWB9Gs:-;WBMxof\",\"type\":\"string\",\"etag\":\"fa6be432fbf6b5c8674a0180b7b5a447\",\"indexed\":false,\"editPermission\":0}}','3La7mPQ','2026-04-30 22:35:03'),(4,13,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/500\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":1,\"ISOSpeedRatings\":8000,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 16:15:15\",\"DateTimeDigitized\":\"2012:06:30 16:15:15\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"9\\/1\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"6149\\/1087\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"280\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"134321\\/34\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":1,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.3.1\",\"DateTime\":\"2012:06:30 16:15:15\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1341072915,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"LRFEu.MxI[Ip~AR*WDj@Iqj[xZxY\",\"type\":\"string\",\"etag\":\"d3a4b7d6d99d6cc135d7910db56e862a\",\"indexed\":false,\"editPermission\":0}}','lrTpWNh','2026-04-30 22:35:04'),(5,14,'{\"photos-size\":{\"value\":{\"width\":3000,\"height\":2000},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1777588461,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"LKECzlxa8_s..8t6Mwt7~qWAadxu\",\"type\":\"string\",\"etag\":\"5edbf7e458734168158cb9137d516f50\",\"indexed\":false,\"editPermission\":0}}','N4axSLz','2026-04-30 22:35:04'),(6,15,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/125\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":3,\"ISOSpeedRatings\":320,\"UndefinedTag__x____\":320,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 12:32:11\",\"DateTimeDigitized\":\"2012:06:30 12:32:11\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"7\\/1\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"189284\\/33461\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"280\\/1\",\"SubSecTime\":\"83\",\"SubSecTimeOriginal\":\"83\",\"SubSecTimeDigitized\":\"83\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"1920000\\/487\",\"FocalPlaneYResolution\":\"320000\\/81\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"0000000000\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"DateTime\":\"2012:06:30 12:32:11\",\"Exif_IFD_Pointer\":174},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1341059531,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"LKINpnRO4:RP_NnNIoV[%zRPNH%1\",\"type\":\"string\",\"etag\":\"1720f6a385893a3b5fbe6b4381f08370\",\"indexed\":false,\"editPermission\":0}}','VjaFArN','2026-04-30 22:35:04'),(7,16,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/80\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":400,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:07:02 19:50:36\",\"DateTimeDigitized\":\"2012:07:02 19:50:36\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"51\\/8\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"32\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1066,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"185679\\/47\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"GIMP 2.8.0\",\"DateTime\":\"2012:07:02 22:06:14\",\"Exif_IFD_Pointer\":198},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1066},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1341258636,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"L4J*xMx]00~qnfoM%Mof9XjFoMD*\",\"type\":\"string\",\"etag\":\"129f85e5c56051fd9a4fe1b75d8907dd\",\"indexed\":false,\"editPermission\":0}}','KRaAhwV','2026-04-30 22:35:05'),(8,17,'{\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/320\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":640,\"UndefinedTag__x____\":640,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2015:10:15 11:07:44\",\"DateTimeDigitized\":\"2015:10:15 11:07:44\",\"ShutterSpeedValue\":\"27970\\/3361\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"1\\/3\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"200\\/1\",\"SubSecTimeOriginal\":\"63\",\"SubSecTimeDigitized\":\"63\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"1600\\/1\",\"FocalPlaneYResolution\":\"1600\\/1\",\"FocalPlaneResolutionUnit\":3,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"000084121f\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"240\\/1\",\"YResolution\":\"240\\/1\",\"ResolutionUnit\":2,\"Software\":\"Adobe Photoshop Lightroom 6.2.1 (Macintosh)\",\"DateTime\":\"2015:10:16 14:40:21\",\"Exif_IFD_Pointer\":230},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1444907264,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"L6CQO}~V4?B,~jQp4XTc00EMi6vo\",\"type\":\"string\",\"etag\":\"1fcd46f60f0443b0a96cf2bab13e4ec6\",\"indexed\":false,\"editPermission\":0}}','aEtbjBJ','2026-04-30 22:35:05'),(9,19,'{\"photos-original_date_time\":{\"value\":1777588462,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0}}','CR9hVbL','2026-04-30 22:34:22'),(10,66,'{\"photos-size\":{\"value\":{\"width\":500,\"height\":500},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-original_date_time\":{\"value\":1777588465,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"blurhash\":{\"value\":\"LKBPq}iu9bfm.TayRlj[04ae-nbI\",\"type\":\"string\",\"etag\":\"1d454f9b395c7f425a512182f945b290\",\"indexed\":false,\"editPermission\":0}}','DZgBdt9','2026-04-30 22:35:06');
/*!40000 ALTER TABLE `oc_files_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_metadata_index`
--

DROP TABLE IF EXISTS `oc_files_metadata_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_metadata_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `meta_key` varchar(31) DEFAULT NULL,
  `meta_value_string` varchar(63) DEFAULT NULL,
  `meta_value_int` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_meta_index` (`file_id`,`meta_key`,`meta_value_string`),
  KEY `f_meta_index_i` (`file_id`,`meta_key`,`meta_value_int`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_metadata_index`
--

LOCK TABLES `oc_files_metadata_index` WRITE;
/*!40000 ALTER TABLE `oc_files_metadata_index` DISABLE KEYS */;
INSERT INTO `oc_files_metadata_index` VALUES (9,19,'photos-original_date_time',NULL,1777588462),(11,9,'photos-original_date_time',NULL,1341064060),(12,10,'photos-original_date_time',NULL,1372319469),(13,12,'photos-original_date_time',NULL,1526500980),(14,13,'photos-original_date_time',NULL,1341072915),(15,14,'photos-original_date_time',NULL,1777588461),(16,15,'photos-original_date_time',NULL,1341059531),(17,16,'photos-original_date_time',NULL,1341258636),(18,17,'photos-original_date_time',NULL,1444907264),(19,66,'photos-original_date_time',NULL,1777588465);
/*!40000 ALTER TABLE `oc_files_metadata_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_reminders`
--

DROP TABLE IF EXISTS `oc_files_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_reminders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `due_date` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `notified` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reminders_uniq_idx` (`user_id`,`file_id`,`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_reminders`
--

LOCK TABLES `oc_files_reminders` WRITE;
/*!40000 ALTER TABLE `oc_files_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_trash`
--

DROP TABLE IF EXISTS `oc_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_trash` (
  `auto_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` varchar(250) NOT NULL DEFAULT '',
  `user` varchar(64) NOT NULL DEFAULT '',
  `timestamp` varchar(12) NOT NULL DEFAULT '',
  `location` varchar(512) NOT NULL DEFAULT '',
  `type` varchar(4) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  `deleted_by` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_trash`
--

LOCK TABLES `oc_files_trash` WRITE;
/*!40000 ALTER TABLE `oc_files_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_versions`
--

DROP TABLE IF EXISTS `oc_files_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_versions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `size` bigint(20) NOT NULL,
  `mimetype` bigint(20) NOT NULL,
  `metadata` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`metadata`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_versions_uniq_index` (`file_id`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_versions`
--

LOCK TABLES `oc_files_versions` WRITE;
/*!40000 ALTER TABLE `oc_files_versions` DISABLE KEYS */;
INSERT INTO `oc_files_versions` VALUES (1,4,1777588461,23876,4,'{\"author\":\"admin\"}'),(2,5,1777588461,1083339,5,'{\"author\":\"admin\"}'),(3,6,1777588461,136,7,'{\"author\":\"admin\"}'),(4,7,1777588461,1095,7,'{\"author\":\"admin\"}'),(5,9,1777588461,474653,9,'{\"author\":\"admin\"}'),(6,10,1777588461,567689,9,'{\"author\":\"admin\"}'),(7,11,1777588461,150,7,'{\"author\":\"admin\"}'),(8,12,1777588461,427030,9,'{\"author\":\"admin\"}'),(9,13,1777588461,457744,9,'{\"author\":\"admin\"}'),(10,14,1777588461,797325,9,'{\"author\":\"admin\"}'),(11,15,1777588461,593508,9,'{\"author\":\"admin\"}'),(12,16,1777588461,2170375,9,'{\"author\":\"admin\"}'),(13,17,1777588462,167989,9,'{\"author\":\"admin\"}'),(14,18,1777588462,197,7,'{\"author\":\"admin\"}'),(15,19,1777588462,3963036,11,'{\"author\":\"admin\"}'),(16,21,1777588462,5155877,12,'{\"author\":\"admin\"}'),(17,22,1777588462,256849,13,'{\"author\":\"admin\"}'),(18,23,1777588462,17276,12,'{\"author\":\"admin\"}'),(19,24,1777588462,33441,12,'{\"author\":\"admin\"}'),(20,25,1777588462,23359,14,'{\"author\":\"admin\"}'),(21,26,1777588462,32323,12,'{\"author\":\"admin\"}'),(22,27,1777588462,22002,13,'{\"author\":\"admin\"}'),(23,28,1777588462,190107,15,'{\"author\":\"admin\"}'),(24,29,1777588463,868111,12,'{\"author\":\"admin\"}'),(25,30,1777588463,22675,12,'{\"author\":\"admin\"}'),(26,31,1777588463,340061,12,'{\"author\":\"admin\"}'),(27,32,1777588463,1441424,15,'{\"author\":\"admin\"}'),(28,33,1777588463,30290,14,'{\"author\":\"admin\"}'),(29,34,1777588463,14316,15,'{\"author\":\"admin\"}'),(30,35,1777588463,15961,12,'{\"author\":\"admin\"}'),(31,36,1777588463,19026,13,'{\"author\":\"admin\"}'),(32,37,1777588463,317015,15,'{\"author\":\"admin\"}'),(33,38,1777588463,35454,15,'{\"author\":\"admin\"}'),(34,39,1777588463,16988,16,'{\"author\":\"admin\"}'),(35,40,1777588463,554,7,'{\"author\":\"admin\"}'),(36,41,1777588463,17331,12,'{\"author\":\"admin\"}'),(37,42,1777588463,560887,15,'{\"author\":\"admin\"}'),(38,43,1777588463,27629,14,'{\"author\":\"admin\"}'),(39,44,1777588463,14810,15,'{\"author\":\"admin\"}'),(40,45,1777588464,81196,15,'{\"author\":\"admin\"}'),(41,46,1777588464,90170,13,'{\"author\":\"admin\"}'),(42,47,1777588464,35963,15,'{\"author\":\"admin\"}'),(43,48,1777588464,13378,13,'{\"author\":\"admin\"}'),(44,49,1777588464,30671,14,'{\"author\":\"admin\"}'),(45,50,1777588464,35657,14,'{\"author\":\"admin\"}'),(46,51,1777588464,3509628,15,'{\"author\":\"admin\"}'),(47,52,1777588464,326,7,'{\"author\":\"admin\"}'),(48,53,1777588464,9904434,15,'{\"author\":\"admin\"}'),(49,54,1777588464,34163,12,'{\"author\":\"admin\"}'),(50,55,1777588464,25621,14,'{\"author\":\"admin\"}'),(51,56,1777588464,31325,14,'{\"author\":\"admin\"}'),(52,57,1777588464,29055,13,'{\"author\":\"admin\"}'),(53,58,1777588464,31132,14,'{\"author\":\"admin\"}'),(54,59,1777588464,45778,14,'{\"author\":\"admin\"}'),(55,60,1777588464,573,7,'{\"author\":\"admin\"}'),(56,61,1777588465,11836,16,'{\"author\":\"admin\"}'),(57,62,1777588465,30780,14,'{\"author\":\"admin\"}'),(58,63,1777588465,33089,12,'{\"author\":\"admin\"}'),(59,64,1777588465,13878,16,'{\"author\":\"admin\"}'),(60,65,1777588465,13653,16,'{\"author\":\"admin\"}'),(61,66,1777588465,50598,17,'{\"author\":\"admin\"}'),(62,67,1777588465,24598701,5,'{\"author\":\"admin\"}'),(63,68,1777588465,3168,7,'{\"author\":\"admin\"}'),(64,69,1777588465,976625,5,'{\"author\":\"admin\"}');
/*!40000 ALTER TABLE `oc_files_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_checks`
--

DROP TABLE IF EXISTS `oc_flow_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_checks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL DEFAULT '',
  `operator` varchar(16) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL,
  `hash` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_checks`
--

LOCK TABLES `oc_flow_checks` WRITE;
/*!40000 ALTER TABLE `oc_flow_checks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations`
--

DROP TABLE IF EXISTS `oc_flow_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL DEFAULT '',
  `name` varchar(256) DEFAULT '',
  `checks` longtext DEFAULT NULL,
  `operation` longtext DEFAULT NULL,
  `entity` varchar(256) NOT NULL DEFAULT 'OCA\\WorkflowEngine\\Entity\\File',
  `events` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations`
--

LOCK TABLES `oc_flow_operations` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations_scope`
--

DROP TABLE IF EXISTS `oc_flow_operations_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_operations_scope` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_id` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `value` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_scope` (`operation_id`,`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations_scope`
--

LOCK TABLES `oc_flow_operations_scope` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations_scope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_answers`
--

DROP TABLE IF EXISTS `oc_forms_v2_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `file_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forms_answers_submission` (`submission_id`),
  KEY `forms_answers_question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_answers`
--

LOCK TABLES `oc_forms_v2_answers` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_forms`
--

DROP TABLE IF EXISTS `oc_forms_v2_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(64) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `owner_id` varchar(64) NOT NULL,
  `created` int(11) DEFAULT NULL COMMENT 'unix-timestamp',
  `expires` int(11) DEFAULT 0 COMMENT 'unix-timestamp',
  `is_anonymous` tinyint(1) DEFAULT 0,
  `submit_multiple` tinyint(1) DEFAULT 0,
  `show_expiration` tinyint(1) DEFAULT 0,
  `last_updated` int(11) DEFAULT 0 COMMENT 'unix-timestamp',
  `submission_message` varchar(2048) DEFAULT NULL COMMENT 'custom thank you message',
  `file_id` bigint(20) unsigned DEFAULT NULL,
  `file_format` varchar(5) DEFAULT NULL,
  `state` smallint(5) unsigned NOT NULL DEFAULT 0,
  `access_enum` smallint(5) unsigned DEFAULT NULL,
  `allow_edit_submissions` tinyint(1) DEFAULT 0,
  `locked_by` varchar(255) DEFAULT NULL,
  `locked_until` int(11) DEFAULT NULL COMMENT 'unix-timestamp',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueHash` (`hash`),
  KEY `forms_forms_owner` (`owner_id`),
  KEY `forms_forms_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_forms`
--

LOCK TABLES `oc_forms_v2_forms` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_options`
--

DROP TABLE IF EXISTS `oc_forms_v2_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `text` varchar(1024) DEFAULT NULL,
  `order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forms_options_question` (`question_id`),
  KEY `forms_options_question_order` (`question_id`,`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_options`
--

LOCK TABLES `oc_forms_v2_options` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_questions`
--

DROP TABLE IF EXISTS `oc_forms_v2_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `order` int(11) DEFAULT 1,
  `type` varchar(256) NOT NULL,
  `text` varchar(2048) DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT 0,
  `description` text DEFAULT '',
  `extra_settings_json` longtext DEFAULT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`extra_settings_json`)),
  `name` varchar(255) DEFAULT '' COMMENT 'technical-identifier',
  PRIMARY KEY (`id`),
  KEY `forms_questions_form_order` (`form_id`,`order`),
  KEY `forms_questions_form` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_questions`
--

LOCK TABLES `oc_forms_v2_questions` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_shares`
--

DROP TABLE IF EXISTS `oc_forms_v2_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_shares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `share_type` smallint(6) DEFAULT NULL,
  `share_with` varchar(256) NOT NULL,
  `permissions_json` longtext DEFAULT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`permissions_json`)),
  PRIMARY KEY (`id`),
  KEY `forms_shares_form` (`form_id`),
  KEY `forms_shares_type` (`share_type`),
  KEY `forms_shares_with` (`share_with`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_shares`
--

LOCK TABLES `oc_forms_v2_shares` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_submissions`
--

DROP TABLE IF EXISTS `oc_forms_v2_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `timestamp` int(11) DEFAULT NULL COMMENT 'unix-timestamp',
  PRIMARY KEY (`id`),
  KEY `forms_submissions_form` (`form_id`),
  KEY `forms_submissions_form_user` (`form_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_submissions`
--

LOCK TABLES `oc_forms_v2_submissions` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_forms_v2_uploaded_files`
--

DROP TABLE IF EXISTS `oc_forms_v2_uploaded_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_forms_v2_uploaded_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `original_file_name` varchar(256) NOT NULL,
  `file_id` bigint(20) unsigned DEFAULT NULL,
  `created` int(11) DEFAULT NULL COMMENT 'unix-timestamp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_forms_v2_uploaded_files`
--

LOCK TABLES `oc_forms_v2_uploaded_files` WRITE;
/*!40000 ALTER TABLE `oc_forms_v2_uploaded_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_forms_v2_uploaded_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_admin`
--

DROP TABLE IF EXISTS `oc_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_group_admin` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `uid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_admin`
--

LOCK TABLES `oc_group_admin` WRITE;
/*!40000 ALTER TABLE `oc_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_user`
--

DROP TABLE IF EXISTS `oc_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_group_user` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `uid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `gu_uid_index` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_user`
--

LOCK TABLES `oc_group_user` WRITE;
/*!40000 ALTER TABLE `oc_group_user` DISABLE KEYS */;
INSERT INTO `oc_group_user` VALUES ('admin','admin');
/*!40000 ALTER TABLE `oc_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_groups`
--

DROP TABLE IF EXISTS `oc_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_groups` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `displayname` varchar(255) NOT NULL DEFAULT 'name',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_groups`
--

LOCK TABLES `oc_groups` WRITE;
/*!40000 ALTER TABLE `oc_groups` DISABLE KEYS */;
INSERT INTO `oc_groups` VALUES ('admin','admin');
/*!40000 ALTER TABLE `oc_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_jobs`
--

DROP TABLE IF EXISTS `oc_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_jobs` (
  `id` bigint(20) unsigned NOT NULL,
  `class` varchar(255) NOT NULL DEFAULT '',
  `argument` text NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT 0,
  `last_checked` int(11) DEFAULT 0,
  `reserved_at` int(11) DEFAULT 0,
  `execution_duration` int(11) DEFAULT 0,
  `argument_hash` varchar(64) DEFAULT NULL,
  `time_sensitive` smallint(6) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`),
  KEY `job_lastcheck_reserved` (`last_checked`,`reserved_at`),
  KEY `job_argument_hash` (`class`,`argument_hash`),
  KEY `jobs_time_sensitive` (`time_sensitive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_jobs`
--

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES (1,'OCA\\WorkflowEngine\\BackgroundJobs\\Rotate','null',1780413002,1780423802,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(2,'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash','null',1780416002,1780417802,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(3,'OCA\\AppAPI\\BackgroundJob\\ExAppInitStatusCheckJob','null',1780416002,1780416062,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(4,'OCA\\DAV\\BackgroundJob\\CleanupDirectLinksJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(5,'OCA\\DAV\\BackgroundJob\\UpdateCalendarResourcesRoomsBackgroundJob','null',1780412402,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(6,'OCA\\DAV\\BackgroundJob\\CleanupInvitationTokenJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(7,'OCA\\DAV\\BackgroundJob\\EventReminderJob','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(8,'OCA\\DAV\\BackgroundJob\\CalendarRetentionJob','null',1780405502,1780427102,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(9,'OCA\\DAV\\BackgroundJob\\PruneOutdatedSyncTokensJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(10,'OCA\\DAV\\BackgroundJob\\FederatedCalendarPeriodicSyncJob','null',1780412402,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(11,'OCA\\ServerInfo\\Jobs\\UpdateStorageStats','null',1780413002,1780423802,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(12,'OCA\\NextcloudAnnouncements\\Cron\\Crawler','null',1780355102,1780441862,0,2,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(13,'OCA\\Files_Sharing\\DeleteOrphanedSharesJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(14,'OCA\\Files_Sharing\\ExpireSharesJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(15,'OCA\\Files_Sharing\\SharesReminderJob','null',1780412402,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(16,'OCA\\Files_Sharing\\BackgroundJob\\FederatedSharesDiscoverJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(17,'OCA\\Photos\\Jobs\\AutomaticPlaceMapperJob','null',1780368604,1780455004,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(18,'OCA\\OAuth2\\BackgroundJob\\CleanupExpiredAuthorizationCode','null',1780189502,1780535402,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(19,'OCA\\UserStatus\\BackgroundJob\\ClearOldStatusesBackgroundJob','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(20,'OCA\\UpdateNotification\\BackgroundJob\\UpdateAvailableNotifications','null',1780368604,1780455004,0,55,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(21,'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(22,'OCA\\Federation\\SyncJob','null',1780369202,1780455602,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(23,'OCA\\Text\\Cron\\Cleanup','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(24,'OCA\\Notifications\\BackgroundJob\\GenerateUserSettings','null',1780360802,1780447202,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(25,'OCA\\Notifications\\BackgroundJob\\SendNotificationMails','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(26,'OCA\\Circles\\Cron\\Maintenance','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(27,'OCA\\FilesReminders\\BackgroundJob\\CleanUpReminders','null',1780369502,1780455902,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(28,'OCA\\FilesReminders\\BackgroundJob\\ScheduledNotifications','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(29,'OCA\\Files\\BackgroundJob\\ScanFiles','null',1780415701,1780416301,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(30,'OCA\\Files\\BackgroundJob\\DeleteOrphanedItems','null',1780413002,1780416602,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(31,'OCA\\Files\\BackgroundJob\\CleanupFileLocks','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(32,'OCA\\Files\\BackgroundJob\\CleanupDirectEditingTokens','null',1780415401,1780416301,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(33,'OCA\\Files\\BackgroundJob\\DeleteExpiredOpenLocalEditor','null',1780362001,1780405201,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(34,'OCA\\Support\\BackgroundJobs\\CheckSubscription','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(35,'OCA\\ContactsInteraction\\BackgroundJob\\CleanupJob','null',1780369502,1780455902,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(36,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(37,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(38,'OCA\\Activity\\BackgroundJob\\DigestMail','null',1780414201,1780417801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(39,'OCA\\Activity\\BackgroundJob\\RemoveFormerActivitySettings','null',1780362302,1780448702,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(40,'OC\\Authentication\\Token\\TokenCleanupJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(41,'OC\\Log\\Rotate','null',1780414201,1780417801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(42,'OC\\Preview\\BackgroundCleanupJob','null',1780377302,1780380902,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(43,'OC\\TextProcessing\\RemoveOldTasksBackgroundJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(44,'OC\\User\\BackgroundJobs\\CleanupDeletedUsers','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(45,'OC\\Core\\BackgroundJobs\\GenerateMetadataJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(114,'OC\\Core\\BackgroundJobs\\CleanupLoginFlowV2','null',1780413902,1780417502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(115,'OC\\Security\\Bruteforce\\CleanupJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(117,'OC\\TextToImage\\RemoveOldTasksBackgroundJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(118,'OC\\TaskProcessing\\RemoveOldTasksBackgroundJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(120,'OCA\\DAV\\BackgroundJob\\DeleteOutdatedSchedulingObjects','null',1780362001,1780444801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(136,'OCA\\Forms\\BackgroundJob\\CleanupUploadedFilesJob','null',1780414201,1780417801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(137,'OCA\\User_LDAP\\Jobs\\UpdateGroups','null',1780414201,1780417801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(138,'OCA\\User_LDAP\\Jobs\\CleanUp','null',1780414201,1780417801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(139,'OCA\\User_LDAP\\Jobs\\Sync','null',1780414202,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(78652327065333760,'OC\\Core\\BackgroundJobs\\PreviewMigrationJob','null',1780370102,1780456502,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(78652333902049280,'OCA\\WebhookListeners\\BackgroundJobs\\WebhookTokenCleanup','null',1780416002,1780416002,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1);
/*!40000 ALTER TABLE `oc_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_known_users`
--

DROP TABLE IF EXISTS `oc_known_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_known_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `known_to` varchar(255) NOT NULL,
  `known_user` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ku_known_to` (`known_to`),
  KEY `ku_known_user` (`known_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_known_users`
--

LOCK TABLES `oc_known_users` WRITE;
/*!40000 ALTER TABLE `oc_known_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_known_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ldap_group_mapping`
--

DROP TABLE IF EXISTS `oc_ldap_group_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ldap_group_mapping` (
  `owncloud_name` varchar(64) NOT NULL DEFAULT '',
  `ldap_dn` varchar(4000) NOT NULL DEFAULT '',
  `directory_uuid` varchar(255) NOT NULL DEFAULT '',
  `ldap_dn_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`owncloud_name`),
  UNIQUE KEY `ldap_group_directory_uuid` (`directory_uuid`),
  UNIQUE KEY `ldap_group_dn_hashes` (`ldap_dn_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ldap_group_mapping`
--

LOCK TABLES `oc_ldap_group_mapping` WRITE;
/*!40000 ALTER TABLE `oc_ldap_group_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ldap_group_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ldap_group_membership`
--

DROP TABLE IF EXISTS `oc_ldap_group_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ldap_group_membership` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `groupid` varchar(255) NOT NULL DEFAULT '',
  `userid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_ldap_membership_unique` (`groupid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ldap_group_membership`
--

LOCK TABLES `oc_ldap_group_membership` WRITE;
/*!40000 ALTER TABLE `oc_ldap_group_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ldap_group_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ldap_user_mapping`
--

DROP TABLE IF EXISTS `oc_ldap_user_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ldap_user_mapping` (
  `owncloud_name` varchar(64) NOT NULL DEFAULT '',
  `ldap_dn` varchar(4000) NOT NULL DEFAULT '',
  `directory_uuid` varchar(255) NOT NULL DEFAULT '',
  `ldap_dn_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`owncloud_name`),
  UNIQUE KEY `ldap_user_directory_uuid` (`directory_uuid`),
  UNIQUE KEY `ldap_user_dn_hashes` (`ldap_dn_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ldap_user_mapping`
--

LOCK TABLES `oc_ldap_user_mapping` WRITE;
/*!40000 ALTER TABLE `oc_ldap_user_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ldap_user_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_login_flow_v2`
--

DROP TABLE IF EXISTS `oc_login_flow_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_login_flow_v2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) unsigned NOT NULL,
  `started` smallint(5) unsigned NOT NULL DEFAULT 0,
  `poll_token` varchar(255) NOT NULL,
  `login_token` varchar(255) NOT NULL,
  `public_key` text NOT NULL,
  `private_key` text NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `login_name` varchar(255) DEFAULT NULL,
  `server` varchar(255) DEFAULT NULL,
  `app_password` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `poll_token` (`poll_token`),
  UNIQUE KEY `login_token` (`login_token`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_login_flow_v2`
--

LOCK TABLES `oc_login_flow_v2` WRITE;
/*!40000 ALTER TABLE `oc_login_flow_v2` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_login_flow_v2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_migrations`
--

DROP TABLE IF EXISTS `oc_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_migrations` (
  `app` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`app`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_migrations`
--

LOCK TABLES `oc_migrations` WRITE;
/*!40000 ALTER TABLE `oc_migrations` DISABLE KEYS */;
INSERT INTO `oc_migrations` VALUES ('activity','2006Date20170808154933'),('activity','2006Date20170808155040'),('activity','2006Date20170919095939'),('activity','2007Date20181107114613'),('activity','2008Date20181011095117'),('activity','2010Date20190416112817'),('activity','2011Date20201006132544'),('activity','2011Date20201006132545'),('activity','2011Date20201006132546'),('activity','2011Date20201006132547'),('activity','2011Date20201207091915'),('app_api','032000Date20250109162434'),('app_api','032001Date20250115164140'),('app_api','032002Date20250527174907'),('app_api','1000Date202305221555'),('app_api','1004Date202311061844'),('app_api','2000Date20240120094952'),('app_api','2005Date20240209094951'),('app_api','2201Date20240221124152'),('app_api','2203Date20240325124149'),('app_api','2204Date20240403125002'),('app_api','2205Date20240411124836'),('app_api','2206Date20240502145029'),('app_api','2207Date20240502145029'),('app_api','2700Date20240515092246'),('app_api','2800Date20240710220000'),('app_api','2800Date20240711080316'),('app_api','3000Date20240715170800'),('app_api','3000Date20240807085759'),('app_api','3100Date20240822080316'),('app_api','3200Date20240905080316'),('app_api','5000Date20241120135411'),('circles','0022Date20220526111723'),('circles','0022Date20220526113601'),('circles','0022Date20220703115023'),('circles','0023Date20211216113101'),('circles','0024Date20220203123901'),('circles','0024Date20220203123902'),('circles','0024Date20220317190331'),('circles','0028Date20230705222601'),('circles','0031Date20241105133904'),('circles','0032Date20250623120204'),('cloud_federation_api','1016Date202502262004'),('contactsinteraction','010000Date20200304152605'),('core','13000Date20170705121758'),('core','13000Date20170718121200'),('core','13000Date20170814074715'),('core','13000Date20170919121250'),('core','13000Date20170926101637'),('core','14000Date20180129121024'),('core','14000Date20180404140050'),('core','14000Date20180516101403'),('core','14000Date20180518120534'),('core','14000Date20180522074438'),('core','14000Date20180626223656'),('core','14000Date20180710092004'),('core','14000Date20180712153140'),('core','15000Date20180926101451'),('core','15000Date20181015062942'),('core','15000Date20181029084625'),('core','16000Date20190207141427'),('core','16000Date20190212081545'),('core','16000Date20190427105638'),('core','16000Date20190428150708'),('core','17000Date20190514105811'),('core','18000Date20190920085628'),('core','18000Date20191014105105'),('core','18000Date20191204114856'),('core','19000Date20200211083441'),('core','20000Date20201109081915'),('core','20000Date20201109081918'),('core','20000Date20201109081919'),('core','20000Date20201111081915'),('core','21000Date20201120141228'),('core','21000Date20201202095923'),('core','21000Date20210119195004'),('core','21000Date20210309185126'),('core','21000Date20210309185127'),('core','22000Date20210216080825'),('core','23000Date20210721100600'),('core','23000Date20210906132259'),('core','23000Date20210930122352'),('core','23000Date20211203110726'),('core','23000Date20211213203940'),('core','24000Date20211210141942'),('core','24000Date20211213081506'),('core','24000Date20211213081604'),('core','24000Date20211222112246'),('core','24000Date20211230140012'),('core','24000Date20220131153041'),('core','24000Date20220202150027'),('core','24000Date20220404230027'),('core','24000Date20220425072957'),('core','25000Date20220515204012'),('core','25000Date20220602190540'),('core','25000Date20220905140840'),('core','25000Date20221007010957'),('core','27000Date20220613163520'),('core','27000Date20230309104325'),('core','27000Date20230309104802'),('core','28000Date20230616104802'),('core','28000Date20230728104802'),('core','28000Date20230803221055'),('core','28000Date20230906104802'),('core','28000Date20231004103301'),('core','28000Date20231103104802'),('core','28000Date20231126110901'),('core','28000Date20240828142927'),('core','29000Date20231126110901'),('core','29000Date20231213104850'),('core','29000Date20240124132201'),('core','29000Date20240124132202'),('core','29000Date20240131122720'),('core','30000Date20240429122720'),('core','30000Date20240708160048'),('core','30000Date20240717111406'),('core','30000Date20240814180800'),('core','30000Date20240815080800'),('core','30000Date20240906095113'),('core','31000Date20240101084401'),('core','31000Date20240814184402'),('core','31000Date20250213102442'),('core','32000Date20250620081925'),('core','32000Date20250731062008'),('core','32000Date20250806110519'),('core','33000Date20250819110529'),('core','33000Date20251013110519'),('core','33000Date20251023110529'),('core','33000Date20251023120529'),('core','33000Date20251106131209'),('core','33000Date20251124110529'),('core','33000Date20251126152410'),('core','33000Date20251209123503'),('core','33000Date20260126120000'),('core','34000Date20260318095645'),('dav','1004Date20170825134824'),('dav','1004Date20170919104507'),('dav','1004Date20170924124212'),('dav','1004Date20170926103422'),('dav','1005Date20180413093149'),('dav','1005Date20180530124431'),('dav','1006Date20180619154313'),('dav','1006Date20180628111625'),('dav','1008Date20181030113700'),('dav','1008Date20181105104826'),('dav','1008Date20181105104833'),('dav','1008Date20181105110300'),('dav','1008Date20181105112049'),('dav','1008Date20181114084440'),('dav','1011Date20190725113607'),('dav','1011Date20190806104428'),('dav','1012Date20190808122342'),('dav','1016Date20201109085907'),('dav','1017Date20210216083742'),('dav','1018Date20210312100735'),('dav','1024Date20211221144219'),('dav','1025Date20240308063933'),('dav','1027Date20230504122946'),('dav','1029Date20221114151721'),('dav','1029Date20231004091403'),('dav','1030Date20240205103243'),('dav','1031Date20240610134258'),('dav','1034Date20250605132605'),('dav','1034Date20250813093701'),('dav','1036Date20251202000000'),('federatedfilesharing','1010Date20200630191755'),('federatedfilesharing','1011Date20201120125158'),('federation','1010Date20200630191302'),('files','11301Date20191205150729'),('files','12101Date20221011153334'),('files','2003Date20241021095629'),('files_downloadlimit','000000Date20210910094923'),('files_reminders','10000Date20230725162149'),('files_sharing','11300Date20201120141438'),('files_sharing','21000Date20201223143245'),('files_sharing','22000Date20210216084241'),('files_sharing','24000Date20220208195521'),('files_sharing','24000Date20220404142216'),('files_sharing','31000Date20240821142813'),('files_sharing','32000Date20251017081948'),('files_sharing','33000Date20251030081948'),('files_trashbin','1010Date20200630192639'),('files_trashbin','1020Date20240403003535'),('files_versions','1020Date20221114144058'),('forms','0010Date20190000000007'),('forms','010102Date20200323120846'),('forms','010200Date20200323141300'),('forms','020002Date20200729205932'),('forms','020200Date20210120082018'),('forms','020202Date20210311150843'),('forms','020300Date20210403214012'),('forms','020300Date20210406114130'),('forms','020300Date20210406133704'),('forms','030000Date20211206213004'),('forms','030000Date20220402100057'),('forms','030000Date20220402151229'),('forms','030000Date20220414203511'),('forms','030000Date20220705192811'),('forms','030000Date20220707130109'),('forms','030000Date20220831195000'),('forms','030000Date20220926200602'),('forms','030100Date20221231100426'),('forms','030100Date20230115214242'),('forms','030100Date20230123182700'),('forms','030100Date20230202175747'),('forms','030200Date20230307141800'),('forms','030400Date20230628011500'),('forms','040010Date20240122133700'),('forms','040200Date20240219201500'),('forms','040200Date20240402200139'),('forms','040200Date20240402224725'),('forms','040300Date20240420155356'),('forms','040300Date20240523123456'),('forms','040300Date20240708163401'),('forms','050000Date20241005173955'),('forms','050004Date20250319180638'),('forms','050200Date20250109201500'),('forms','050200Date20250512004000'),('notifications','2004Date20190107135757'),('notifications','2010Date20210218082811'),('notifications','2010Date20210218082855'),('notifications','2011Date20210930134607'),('notifications','2011Date20220826074907'),('oauth2','010401Date20181207190718'),('oauth2','010402Date20190107124745'),('oauth2','011601Date20230522143227'),('oauth2','011602Date20230613160650'),('oauth2','011603Date20230620111039'),('oauth2','011901Date20240829164356'),('photos','20000Date20220727125801'),('photos','20001Date20220830131446'),('photos','20003Date20221102170153'),('photos','20003Date20221103094628'),('photos','30000Date20240417075405'),('photos','32000Date20250507132617'),('privacy','100Date20190217131943'),('systemtags','31000Date20241018063111'),('systemtags','31000Date20241114171300'),('text','010000Date20190617184535'),('text','030001Date20200402075029'),('text','030201Date20201116110353'),('text','030201Date20201116123153'),('text','030501Date20220202101853'),('text','030701Date20230207131313'),('text','030901Date20231114150437'),('text','040100Date20240611165300'),('text','070000Date20250925110024'),('text','080000Date20260331132113'),('theming','2006Date20240905111627'),('twofactor_backupcodes','1002Date20170607104347'),('twofactor_backupcodes','1002Date20170607113030'),('twofactor_backupcodes','1002Date20170919123342'),('twofactor_backupcodes','1002Date20170926101419'),('twofactor_backupcodes','1002Date20180821043638'),('twofactor_totp','010501Date20181018124436'),('twofactor_totp','020102Date20190304124405'),('twofactor_totp','030000Date20190305114917'),('twofactor_totp','140000Date202503027114917'),('user_ldap','1010Date20200630192842'),('user_ldap','1120Date20210917155206'),('user_ldap','1130Date20211102154716'),('user_ldap','1130Date20220110154717'),('user_ldap','1130Date20220110154718'),('user_ldap','1130Date20220110154719'),('user_ldap','1141Date20220323143801'),('user_ldap','1190Date20230706134108'),('user_ldap','1190Date20230706134109'),('user_status','0001Date20200602134824'),('user_status','0002Date20200902144824'),('user_status','1000Date20201111130204'),('user_status','1003Date20210809144824'),('user_status','1008Date20230921144701'),('webhook_listeners','1000Date20240527153425'),('webhook_listeners','1001Date20240716184935'),('webhook_listeners','1500Date20251007130000'),('workflowengine','2000Date20190808074233'),('workflowengine','2200Date20210805101925');
/*!40000 ALTER TABLE `oc_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mimetypes`
--

DROP TABLE IF EXISTS `oc_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_mimetypes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mimetypes`
--

LOCK TABLES `oc_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc_mimetypes` DISABLE KEYS */;
INSERT INTO `oc_mimetypes` VALUES (3,'application'),(19,'application/json'),(25,'application/octet-stream'),(5,'application/pdf'),(27,'application/toml'),(14,'application/vnd.excalidraw+json'),(16,'application/vnd.oasis.opendocument.graphics'),(15,'application/vnd.oasis.opendocument.presentation'),(13,'application/vnd.oasis.opendocument.spreadsheet'),(12,'application/vnd.oasis.opendocument.text'),(4,'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),(22,'application/vnd.recordare.musicxml'),(23,'application/vnd.recordare.musicxml+xml'),(26,'application/x-openvpn-profile'),(20,'application/zstd'),(1,'httpd'),(2,'httpd/unix-directory'),(8,'image'),(9,'image/jpeg'),(17,'image/png'),(6,'text'),(7,'text/markdown'),(24,'text/plain'),(18,'text/vcard'),(21,'text/x-nfo'),(10,'video'),(11,'video/mp4');
/*!40000 ALTER TABLE `oc_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mounts`
--

DROP TABLE IF EXISTS `oc_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_mounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage_id` bigint(20) NOT NULL,
  `root_id` bigint(20) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `mount_point` varchar(4000) NOT NULL,
  `mount_id` bigint(20) DEFAULT NULL,
  `mount_provider_class` varchar(128) DEFAULT NULL,
  `mount_point_hash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mounts_user_path_root_index` (`user_id`,`mount_point_hash`,`root_id`),
  KEY `mounts_storage_index` (`storage_id`),
  KEY `mounts_root_index` (`root_id`),
  KEY `mounts_mount_id_index` (`mount_id`),
  KEY `mounts_class_index` (`mount_provider_class`),
  KEY `mount_user_storage` (`storage_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mounts`
--

LOCK TABLES `oc_mounts` WRITE;
/*!40000 ALTER TABLE `oc_mounts` DISABLE KEYS */;
INSERT INTO `oc_mounts` VALUES (1,1,1,'admin','/admin/',NULL,'OC\\Files\\Mount\\LocalHomeMountProvider','65846967add5725ad01dabcc978e314e');
/*!40000 ALTER TABLE `oc_mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications`
--

DROP TABLE IF EXISTS `oc_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(32) NOT NULL,
  `user` varchar(64) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `object_type` varchar(64) NOT NULL,
  `object_id` varchar(64) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `subject_parameters` longtext DEFAULT NULL,
  `message` varchar(64) DEFAULT NULL,
  `message_parameters` longtext DEFAULT NULL,
  `link` varchar(4000) DEFAULT NULL,
  `icon` varchar(4000) DEFAULT NULL,
  `actions` longtext DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `oc_notifications_app` (`app`),
  KEY `oc_notifications_user` (`user`),
  KEY `oc_notifications_timestamp` (`timestamp`),
  KEY `oc_notifications_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications`
--

LOCK TABLES `oc_notifications` WRITE;
/*!40000 ALTER TABLE `oc_notifications` DISABLE KEYS */;
INSERT INTO `oc_notifications` VALUES (1,'firstrunwizard','admin',1777588502,'user','admin','profile','[]','','[]','','','[]'),(2,'survey_client','admin',1777588507,'dummy','23','updated','[]','','[]','','','[]'),(3,'survey_client','admin',1777589706,'dummy','23','updated','[]','','[]','','','[]'),(5,'updatenotification','admin',1780022523,'core','33.0.4.1','update_available','{\"version\":\"Nextcloud 33.0.4\"}','','[]','','','[]'),(6,'updatenotification','admin',1780022525,'forms','5.2.9','update_available','[]','','[]','','','[]');
/*!40000 ALTER TABLE `oc_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_pushhash`
--

DROP TABLE IF EXISTS `oc_notifications_pushhash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications_pushhash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `token` int(11) NOT NULL DEFAULT 0,
  `deviceidentifier` varchar(128) NOT NULL,
  `devicepublickey` varchar(512) NOT NULL,
  `devicepublickeyhash` varchar(128) NOT NULL,
  `pushtokenhash` varchar(128) NOT NULL,
  `proxyserver` varchar(256) NOT NULL,
  `apptype` varchar(32) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  UNIQUE KEY `oc_npushhash_uid` (`uid`,`token`),
  KEY `oc_npushhash_di` (`deviceidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_pushhash`
--

LOCK TABLES `oc_notifications_pushhash` WRITE;
/*!40000 ALTER TABLE `oc_notifications_pushhash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_notifications_pushhash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_settings`
--

DROP TABLE IF EXISTS `oc_notifications_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `batch_time` int(11) NOT NULL DEFAULT 0,
  `last_send_id` bigint(20) NOT NULL DEFAULT 0,
  `next_send_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notset_user` (`user_id`),
  KEY `notset_nextsend` (`next_send_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_settings`
--

LOCK TABLES `oc_notifications_settings` WRITE;
/*!40000 ALTER TABLE `oc_notifications_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_notifications_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_access_tokens`
--

DROP TABLE IF EXISTS `oc_oauth2_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_oauth2_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `hashed_code` varchar(128) NOT NULL,
  `encrypted_token` varchar(786) NOT NULL,
  `code_created_at` bigint(20) unsigned NOT NULL DEFAULT 0,
  `token_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_access_hash_idx` (`hashed_code`),
  KEY `oauth2_access_client_id_idx` (`client_id`),
  KEY `oauth2_tk_c_created_idx` (`token_count`,`code_created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_access_tokens`
--

LOCK TABLES `oc_oauth2_access_tokens` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_clients`
--

DROP TABLE IF EXISTS `oc_oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_oauth2_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `redirect_uri` varchar(2000) NOT NULL,
  `client_identifier` varchar(64) NOT NULL,
  `secret` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_client_id_idx` (`client_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_clients`
--

LOCK TABLES `oc_oauth2_clients` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_open_local_editor`
--

DROP TABLE IF EXISTS `oc_open_local_editor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_open_local_editor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `path_hash` varchar(64) NOT NULL,
  `expiration_time` bigint(20) unsigned NOT NULL,
  `token` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `openlocal_user_path_token` (`user_id`,`path_hash`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_open_local_editor`
--

LOCK TABLES `oc_open_local_editor` WRITE;
/*!40000 ALTER TABLE `oc_open_local_editor` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_open_local_editor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums`
--

DROP TABLE IF EXISTS `oc_photos_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums` (
  `album_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `created` bigint(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `last_added_photo` bigint(20) NOT NULL,
  `filters` longtext DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `pa_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums`
--

LOCK TABLES `oc_photos_albums` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums_collabs`
--

DROP TABLE IF EXISTS `oc_photos_albums_collabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums_collabs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NOT NULL,
  `collaborator_id` varchar(64) NOT NULL,
  `collaborator_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `album_collabs_uniq_collab` (`album_id`,`collaborator_id`,`collaborator_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums_collabs`
--

LOCK TABLES `oc_photos_albums_collabs` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums_collabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums_collabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums_files`
--

DROP TABLE IF EXISTS `oc_photos_albums_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums_files` (
  `album_file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `added` bigint(20) NOT NULL,
  `owner` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`album_file_id`),
  UNIQUE KEY `paf_album_file` (`album_id`,`file_id`),
  KEY `paf_folder` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums_files`
--

LOCK TABLES `oc_photos_albums_files` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preferences`
--

DROP TABLE IF EXISTS `oc_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preferences` (
  `userid` varchar(64) NOT NULL DEFAULT '',
  `appid` varchar(32) NOT NULL DEFAULT '',
  `configkey` varchar(64) NOT NULL DEFAULT '',
  `configvalue` longtext DEFAULT NULL,
  `lazy` smallint(5) unsigned NOT NULL DEFAULT 0,
  `type` smallint(5) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `indexed` varchar(64) DEFAULT '',
  PRIMARY KEY (`userid`,`appid`,`configkey`),
  KEY `prefs_uid_lazy_i` (`userid`,`lazy`),
  KEY `prefs_app_key_ind_fl_i` (`appid`,`configkey`,`indexed`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preferences`
--

LOCK TABLES `oc_preferences` WRITE;
/*!40000 ALTER TABLE `oc_preferences` DISABLE KEYS */;
INSERT INTO `oc_preferences` VALUES ('admin','activity','configured','yes',0,0,0,''),('admin','avatar','generated','true',0,0,0,''),('admin','circles','userSingleId','3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3',0,1,2,'3cZxj2pYvONGzJz2jeN2O3mYgYWgbR3'),('admin','core','templateDirectory','Templates/',0,0,0,''),('admin','files_sharing','user_needs_share_refresh','0',0,4,0,''),('admin','firstrunwizard','apphint','19',0,0,0,''),('admin','login','firstLogin','1777588460',0,0,0,''),('admin','login','lastLogin','1777588460',0,0,0,''),('admin','lookup_server_connector','dataSend','1',0,0,0,''),('admin','password_policy','failedLoginAttempts','0',0,0,0,'');
/*!40000 ALTER TABLE `oc_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preferences_ex`
--

DROP TABLE IF EXISTS `oc_preferences_ex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preferences_ex` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) NOT NULL,
  `appid` varchar(32) NOT NULL,
  `configkey` varchar(64) NOT NULL,
  `configvalue` longtext DEFAULT NULL,
  `sensitive` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `preferences_ex__idx` (`userid`,`appid`,`configkey`),
  KEY `preferences_ex__configkey` (`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preferences_ex`
--

LOCK TABLES `oc_preferences_ex` WRITE;
/*!40000 ALTER TABLE `oc_preferences_ex` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_preferences_ex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preview_locations`
--

DROP TABLE IF EXISTS `oc_preview_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preview_locations` (
  `id` bigint(20) unsigned NOT NULL,
  `bucket_name` varchar(40) NOT NULL,
  `object_store_name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_bucket_store` (`bucket_name`,`object_store_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preview_locations`
--

LOCK TABLES `oc_preview_locations` WRITE;
/*!40000 ALTER TABLE `oc_preview_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_preview_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preview_versions`
--

DROP TABLE IF EXISTS `oc_preview_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preview_versions` (
  `id` bigint(20) unsigned NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `version` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preview_versions`
--

LOCK TABLES `oc_preview_versions` WRITE;
/*!40000 ALTER TABLE `oc_preview_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_preview_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_previews`
--

DROP TABLE IF EXISTS `oc_previews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_previews` (
  `id` bigint(20) unsigned NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `storage_id` bigint(20) unsigned NOT NULL,
  `old_file_id` bigint(20) unsigned DEFAULT NULL,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `width` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `mimetype_id` int(11) NOT NULL,
  `source_mimetype_id` int(11) NOT NULL,
  `max` tinyint(1) NOT NULL DEFAULT 0,
  `cropped` tinyint(1) NOT NULL DEFAULT 0,
  `encrypted` tinyint(1) NOT NULL DEFAULT 0,
  `etag` char(40) NOT NULL,
  `mtime` int(10) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `version_id` bigint(20) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `previews_file_uniq_idx` (`file_id`,`width`,`height`,`mimetype_id`,`cropped`,`version_id`),
  KEY `IDX_67DC472793CB796C` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_previews`
--

LOCK TABLES `oc_previews` WRITE;
/*!40000 ALTER TABLE `oc_previews` DISABLE KEYS */;
INSERT INTO `oc_previews` VALUES (78653328312807424,9,1,87,NULL,1600,1067,9,9,1,0,0,'9fbb38dcd39339e34e1607fa65b3f8de',1777588502,232378,-1),(78653329181028352,10,1,96,NULL,1200,1800,9,9,1,0,0,'5c1485ebfb9921146df8962c11f6e813',1777588502,207095,-1),(78653329936003072,12,1,105,NULL,1920,1281,9,9,1,0,0,'fa6be432fbf6b5c8674a0180b7b5a447',1777588503,294390,-1),(78653330539982848,13,1,113,NULL,1600,1067,9,9,1,0,0,'d3a4b7d6d99d6cc135d7910db56e862a',1777588503,147631,-1),(78653331097825280,14,1,122,NULL,3000,2000,9,9,1,0,0,'5edbf7e458734168158cb9137d516f50',1777588504,808212,-1),(78653331697610752,15,1,131,NULL,1600,1067,9,9,1,0,0,'1720f6a385893a3b5fbe6b4381f08370',1777588504,165982,-1),(78653332448391168,16,1,139,NULL,1600,1066,9,9,1,0,0,'129f85e5c56051fd9a4fe1b75d8907dd',1777588505,351167,-1),(78653333031399424,17,1,148,NULL,1600,1067,9,9,1,0,0,'1fcd46f60f0443b0a96cf2bab13e4ec6',1777588505,137923,-1),(78653333631184896,66,1,157,NULL,500,500,17,17,1,0,0,'1d454f9b395c7f425a512182f945b290',1777588506,50545,-1);
/*!40000 ALTER TABLE `oc_previews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_privacy_admins`
--

DROP TABLE IF EXISTS `oc_privacy_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_privacy_admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayname` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_privacy_admins`
--

LOCK TABLES `oc_privacy_admins` WRITE;
/*!40000 ALTER TABLE `oc_privacy_admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_privacy_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_profile_config`
--

DROP TABLE IF EXISTS `oc_profile_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_profile_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `config` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_config_user_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_profile_config`
--

LOCK TABLES `oc_profile_config` WRITE;
/*!40000 ALTER TABLE `oc_profile_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_profile_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_properties`
--

DROP TABLE IF EXISTS `oc_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_properties` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) NOT NULL DEFAULT '',
  `propertypath` varchar(255) NOT NULL DEFAULT '',
  `propertyname` varchar(255) NOT NULL DEFAULT '',
  `propertyvalue` longtext NOT NULL,
  `valuetype` smallint(6) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `properties_path_index` (`userid`,`propertypath`),
  KEY `properties_pathonly_index` (`propertypath`),
  KEY `properties_name_path_user` (`propertyname`,`propertypath`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_properties`
--

LOCK TABLES `oc_properties` WRITE;
/*!40000 ALTER TABLE `oc_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ratelimit_entries`
--

DROP TABLE IF EXISTS `oc_ratelimit_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ratelimit_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL,
  `delete_after` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ratelimit_hash` (`hash`),
  KEY `ratelimit_delete_after` (`delete_after`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ratelimit_entries`
--

LOCK TABLES `oc_ratelimit_entries` WRITE;
/*!40000 ALTER TABLE `oc_ratelimit_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ratelimit_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_reactions`
--

DROP TABLE IF EXISTS `oc_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_reactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL,
  `message_id` bigint(20) unsigned NOT NULL,
  `actor_type` varchar(64) NOT NULL DEFAULT '',
  `actor_id` varchar(64) NOT NULL DEFAULT '',
  `reaction` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_reaction_unique` (`parent_id`,`actor_type`,`actor_id`,`reaction`),
  KEY `comment_reaction` (`reaction`),
  KEY `comment_reaction_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_reactions`
--

LOCK TABLES `oc_reactions` WRITE;
/*!40000 ALTER TABLE `oc_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_recent_contact`
--

DROP TABLE IF EXISTS `oc_recent_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_recent_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_uid` varchar(64) NOT NULL,
  `uid` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `federated_cloud_id` varchar(255) DEFAULT NULL,
  `card` longblob NOT NULL,
  `last_contact` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recent_contact_actor_uid` (`actor_uid`),
  KEY `recent_contact_id_uid` (`id`,`actor_uid`),
  KEY `recent_contact_uid` (`uid`),
  KEY `recent_contact_email` (`email`),
  KEY `recent_contact_fed_id` (`federated_cloud_id`),
  KEY `recent_contact_last_contact` (`last_contact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_recent_contact`
--

LOCK TABLES `oc_recent_contact` WRITE;
/*!40000 ALTER TABLE `oc_recent_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_recent_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_schedulingobjects`
--

DROP TABLE IF EXISTS `oc_schedulingobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_schedulingobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `calendardata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedulobj_principuri_index` (`principaluri`),
  KEY `schedulobj_lastmodified_idx` (`lastmodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_schedulingobjects`
--

LOCK TABLES `oc_schedulingobjects` WRITE;
/*!40000 ALTER TABLE `oc_schedulingobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_schedulingobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_sec_signatory`
--

DROP TABLE IF EXISTS `oc_sec_signatory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_sec_signatory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key_id_sum` varchar(127) NOT NULL,
  `key_id` varchar(512) NOT NULL,
  `host` varchar(512) NOT NULL,
  `provider_id` varchar(31) NOT NULL,
  `account` varchar(127) DEFAULT '',
  `public_key` longtext NOT NULL DEFAULT '',
  `metadata` longtext NOT NULL DEFAULT '[]',
  `type` smallint(6) NOT NULL DEFAULT 9,
  `status` smallint(6) NOT NULL DEFAULT 0,
  `creation` int(10) unsigned DEFAULT 0,
  `last_updated` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sec_sig_unic` (`provider_id`,`host`,`account`),
  KEY `sec_sig_key` (`key_id_sum`,`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_sec_signatory`
--

LOCK TABLES `oc_sec_signatory` WRITE;
/*!40000 ALTER TABLE `oc_sec_signatory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_sec_signatory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share`
--

DROP TABLE IF EXISTS `oc_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_share` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `share_type` smallint(6) NOT NULL DEFAULT 0,
  `share_with` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `uid_owner` varchar(64) NOT NULL DEFAULT '',
  `uid_initiator` varchar(64) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `item_type` varchar(64) NOT NULL DEFAULT '',
  `item_source` varchar(255) DEFAULT NULL,
  `item_target` varchar(255) DEFAULT NULL,
  `file_source` bigint(20) DEFAULT NULL,
  `file_target` varchar(512) DEFAULT NULL,
  `permissions` smallint(6) NOT NULL DEFAULT 0,
  `stime` bigint(20) NOT NULL DEFAULT 0,
  `accepted` smallint(6) NOT NULL DEFAULT 0,
  `expiration` datetime DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `mail_send` smallint(6) NOT NULL DEFAULT 0,
  `share_name` varchar(64) DEFAULT NULL,
  `password_by_talk` tinyint(1) DEFAULT 0,
  `note` longtext DEFAULT NULL,
  `hide_download` smallint(6) DEFAULT 0,
  `label` varchar(255) DEFAULT NULL,
  `attributes` longtext DEFAULT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`attributes`)),
  `password_expiration_time` datetime DEFAULT NULL,
  `reminder_sent` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item_share_type_index` (`item_type`,`share_type`),
  KEY `file_source_index` (`file_source`),
  KEY `token_index` (`token`),
  KEY `share_with_index` (`share_with`),
  KEY `parent_index` (`parent`),
  KEY `owner_index` (`uid_owner`),
  KEY `initiator_index` (`uid_initiator`),
  KEY `share_with_file_target_index` (`share_with`,`file_target`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share`
--

LOCK TABLES `oc_share` WRITE;
/*!40000 ALTER TABLE `oc_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share_external`
--

DROP TABLE IF EXISTS `oc_share_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_share_external` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent` bigint(20) DEFAULT -1,
  `share_type` int(11) DEFAULT NULL,
  `remote` varchar(512) NOT NULL,
  `remote_id` varchar(255) DEFAULT '',
  `share_token` varchar(64) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(4000) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `user` varchar(64) NOT NULL,
  `mountpoint` varchar(4000) NOT NULL,
  `mountpoint_hash` varchar(32) NOT NULL,
  `accepted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`),
  KEY `user_mountpoint_index` (`user`,`mountpoint`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share_external`
--

LOCK TABLES `oc_share_external` WRITE;
/*!40000 ALTER TABLE `oc_share_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_shares_limits`
--

DROP TABLE IF EXISTS `oc_shares_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_shares_limits` (
  `id` varchar(32) NOT NULL,
  `limit` bigint(20) NOT NULL,
  `downloads` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_shares_limits`
--

LOCK TABLES `oc_shares_limits` WRITE;
/*!40000 ALTER TABLE `oc_shares_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_shares_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages`
--

DROP TABLE IF EXISTS `oc_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_storages` (
  `numeric_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` varchar(64) DEFAULT NULL,
  `available` int(11) NOT NULL DEFAULT 1,
  `last_checked` int(11) DEFAULT NULL,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages`
--

LOCK TABLES `oc_storages` WRITE;
/*!40000 ALTER TABLE `oc_storages` DISABLE KEYS */;
INSERT INTO `oc_storages` VALUES (1,'home::admin',1,NULL),(2,'local::/var/www/nextcloud.example.com/data/',1,NULL);
/*!40000 ALTER TABLE `oc_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages_credentials`
--

DROP TABLE IF EXISTS `oc_storages_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_storages_credentials` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user` varchar(64) DEFAULT NULL,
  `identifier` varchar(64) NOT NULL,
  `credentials` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stocred_ui` (`user`,`identifier`),
  KEY `stocred_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages_credentials`
--

LOCK TABLES `oc_storages_credentials` WRITE;
/*!40000 ALTER TABLE `oc_storages_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_storages_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag`
--

DROP TABLE IF EXISTS `oc_systemtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `visibility` smallint(6) NOT NULL DEFAULT 1,
  `editable` smallint(6) NOT NULL DEFAULT 1,
  `etag` varchar(32) DEFAULT NULL,
  `color` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_ident` (`name`,`visibility`,`editable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag`
--

LOCK TABLES `oc_systemtag` WRITE;
/*!40000 ALTER TABLE `oc_systemtag` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_group`
--

DROP TABLE IF EXISTS `oc_systemtag_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag_group` (
  `systemtagid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `gid` varchar(255) NOT NULL,
  PRIMARY KEY (`gid`,`systemtagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_group`
--

LOCK TABLES `oc_systemtag_group` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_object_mapping`
--

DROP TABLE IF EXISTS `oc_systemtag_object_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag_object_mapping` (
  `objectid` varchar(64) NOT NULL DEFAULT '',
  `objecttype` varchar(64) NOT NULL DEFAULT '',
  `systemtagid` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`objecttype`,`objectid`,`systemtagid`),
  KEY `systag_by_tagid` (`systemtagid`,`objecttype`),
  KEY `systag_by_objectid` (`objectid`),
  KEY `systag_objecttype` (`objecttype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_object_mapping`
--

LOCK TABLES `oc_systemtag_object_mapping` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_taskprocessing_tasks`
--

DROP TABLE IF EXISTS `oc_taskprocessing_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_taskprocessing_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `input` longtext NOT NULL,
  `output` longtext DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `custom_id` varchar(255) DEFAULT '',
  `last_updated` int(10) unsigned DEFAULT 0,
  `completion_expected_at` datetime DEFAULT NULL,
  `progress` double DEFAULT 0,
  `error_message` varchar(4000) DEFAULT NULL,
  `scheduled_at` int(10) unsigned DEFAULT NULL,
  `started_at` int(10) unsigned DEFAULT NULL,
  `ended_at` int(10) unsigned DEFAULT NULL,
  `webhook_uri` varchar(4000) DEFAULT NULL,
  `webhook_method` varchar(64) DEFAULT NULL,
  `allow_cleanup` smallint(5) unsigned NOT NULL DEFAULT 1,
  `user_facing_error_message` varchar(4000) DEFAULT NULL,
  `include_watermark` smallint(5) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `taskp_tasks_status_type` (`status`,`type`),
  KEY `taskp_tasks_updated` (`last_updated`),
  KEY `taskp_tasks_uid_appid_cid` (`user_id`,`app_id`,`custom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_taskprocessing_tasks`
--

LOCK TABLES `oc_taskprocessing_tasks` WRITE;
/*!40000 ALTER TABLE `oc_taskprocessing_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_taskprocessing_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text2image_tasks`
--

DROP TABLE IF EXISTS `oc_text2image_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text2image_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `input` longtext NOT NULL,
  `status` int(11) DEFAULT 0,
  `number_of_images` int(11) NOT NULL DEFAULT 1,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `identifier` varchar(255) DEFAULT '',
  `last_updated` datetime DEFAULT NULL,
  `completion_expected_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t2i_tasks_updated` (`last_updated`),
  KEY `t2i_tasks_status` (`status`),
  KEY `t2i_tasks_uid_appid_ident` (`user_id`,`app_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text2image_tasks`
--

LOCK TABLES `oc_text2image_tasks` WRITE;
/*!40000 ALTER TABLE `oc_text2image_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text2image_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_documents`
--

DROP TABLE IF EXISTS `oc_text_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_documents` (
  `id` bigint(20) unsigned NOT NULL,
  `current_version` bigint(20) unsigned DEFAULT 0,
  `last_saved_version` bigint(20) unsigned DEFAULT 0,
  `last_saved_version_time` bigint(20) unsigned NOT NULL,
  `last_saved_version_etag` varchar(64) DEFAULT '',
  `base_version_etag` varchar(64) DEFAULT '',
  `checksum` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_documents`
--

LOCK TABLES `oc_text_documents` WRITE;
/*!40000 ALTER TABLE `oc_text_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_sessions`
--

DROP TABLE IF EXISTS `oc_text_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) DEFAULT NULL,
  `guest_name` varchar(64) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `token` varchar(64) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `last_contact` bigint(20) unsigned NOT NULL,
  `last_awareness_message` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `rd_session_token_idx` (`token`),
  KEY `ts_lastcontact` (`last_contact`),
  KEY `ts_docid_lastcontact` (`document_id`,`last_contact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_sessions`
--

LOCK TABLES `oc_text_sessions` WRITE;
/*!40000 ALTER TABLE `oc_text_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_steps`
--

DROP TABLE IF EXISTS `oc_text_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_steps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL,
  `data` longtext NOT NULL,
  `version` bigint(20) unsigned DEFAULT 0,
  `timestamp` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rd_steps_did_idx` (`document_id`),
  KEY `rd_steps_version_idx` (`version`),
  KEY `textstep_session` (`session_id`),
  KEY `text_steps_doc_id_id_index` (`document_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_steps`
--

LOCK TABLES `oc_text_steps` WRITE;
/*!40000 ALTER TABLE `oc_text_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_textprocessing_tasks`
--

DROP TABLE IF EXISTS `oc_textprocessing_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_textprocessing_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `input` longtext NOT NULL,
  `output` longtext DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `last_updated` int(10) unsigned DEFAULT 0,
  `completion_expected_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tp_tasks_updated` (`last_updated`),
  KEY `tp_tasks_status_type_nonunique` (`status`,`type`),
  KEY `tp_tasks_uid_appid_ident` (`user_id`,`app_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_textprocessing_tasks`
--

LOCK TABLES `oc_textprocessing_tasks` WRITE;
/*!40000 ALTER TABLE `oc_textprocessing_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_textprocessing_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_trusted_servers`
--

DROP TABLE IF EXISTS `oc_trusted_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_trusted_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) NOT NULL,
  `url_hash` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(128) DEFAULT NULL,
  `shared_secret` varchar(256) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `sync_token` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url_hash` (`url_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_trusted_servers`
--

LOCK TABLES `oc_trusted_servers` WRITE;
/*!40000 ALTER TABLE `oc_trusted_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_trusted_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_backupcodes`
--

DROP TABLE IF EXISTS `oc_twofactor_backupcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_backupcodes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `code` varchar(128) NOT NULL,
  `used` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `twofactor_backupcodes_uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_backupcodes`
--

LOCK TABLES `oc_twofactor_backupcodes` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_providers`
--

DROP TABLE IF EXISTS `oc_twofactor_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_providers` (
  `provider_id` varchar(32) NOT NULL,
  `uid` varchar(64) NOT NULL,
  `enabled` smallint(6) NOT NULL,
  PRIMARY KEY (`provider_id`,`uid`),
  KEY `twofactor_providers_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_providers`
--

LOCK TABLES `oc_twofactor_providers` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_providers` DISABLE KEYS */;
INSERT INTO `oc_twofactor_providers` VALUES ('backup_codes','admin',0),('totp','admin',0);
/*!40000 ALTER TABLE `oc_twofactor_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_totp_secrets`
--

DROP TABLE IF EXISTS `oc_twofactor_totp_secrets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_totp_secrets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `secret` longtext NOT NULL,
  `state` int(11) NOT NULL DEFAULT 2,
  `last_counter` bigint(20) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `totp_secrets_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_totp_secrets`
--

LOCK TABLES `oc_twofactor_totp_secrets` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_totp_secrets` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_twofactor_totp_secrets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_status`
--

DROP TABLE IF EXISTS `oc_user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_user_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `status_timestamp` int(10) unsigned NOT NULL,
  `is_user_defined` tinyint(1) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `custom_icon` varchar(255) DEFAULT NULL,
  `custom_message` longtext DEFAULT NULL,
  `clear_at` int(10) unsigned DEFAULT NULL,
  `is_backup` tinyint(1) DEFAULT 0,
  `status_message_timestamp` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_status_uid_ix` (`user_id`),
  KEY `user_status_clr_ix` (`clear_at`),
  KEY `user_status_tstmp_ix` (`status_timestamp`),
  KEY `user_status_iud_ix` (`is_user_defined`,`status`),
  KEY `user_status_mtstmp_ix` (`status_message_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_status`
--

LOCK TABLES `oc_user_status` WRITE;
/*!40000 ALTER TABLE `oc_user_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_transfer_owner`
--

DROP TABLE IF EXISTS `oc_user_transfer_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_user_transfer_owner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_user` varchar(64) NOT NULL,
  `target_user` varchar(64) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `node_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_transfer_owner`
--

LOCK TABLES `oc_user_transfer_owner` WRITE;
/*!40000 ALTER TABLE `oc_user_transfer_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_user_transfer_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_users`
--

DROP TABLE IF EXISTS `oc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_users` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `displayname` varchar(64) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `uid_lower` varchar(64) DEFAULT '',
  PRIMARY KEY (`uid`),
  KEY `user_uid_lower` (`uid_lower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_users`
--

LOCK TABLES `oc_users` WRITE;
/*!40000 ALTER TABLE `oc_users` DISABLE KEYS */;
INSERT INTO `oc_users` VALUES ('admin',NULL,'3|$argon2id$v=19$m=65536,t=4,p=1$ww7IjzM71L6jGKKJjvQ8oA$XtxtxSGXAZinAM0ZZIBwGq0nOL+SEVl1D98brL69Bfg','admin');
/*!40000 ALTER TABLE `oc_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory`
--

DROP TABLE IF EXISTS `oc_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_vcategory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL DEFAULT '',
  `type` varchar(64) NOT NULL DEFAULT '',
  `category` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_category_per_user` (`uid`,`type`,`category`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory`
--

LOCK TABLES `oc_vcategory` WRITE;
/*!40000 ALTER TABLE `oc_vcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_vcategory_to_object` (
  `objid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `categoryid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `type` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory_to_object`
--

LOCK TABLES `oc_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory_to_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_webauthn`
--

DROP TABLE IF EXISTS `oc_webauthn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_webauthn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `public_key_credential_id` varchar(512) NOT NULL,
  `data` longtext NOT NULL,
  `user_verification` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `webauthn_uid` (`uid`),
  KEY `webauthn_publicKeyCredentialId` (`public_key_credential_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_webauthn`
--

LOCK TABLES `oc_webauthn` WRITE;
/*!40000 ALTER TABLE `oc_webauthn` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_webauthn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_webhook_listeners`
--

DROP TABLE IF EXISTS `oc_webhook_listeners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_webhook_listeners` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `http_method` varchar(32) NOT NULL,
  `uri` varchar(4000) NOT NULL,
  `event` varchar(4000) NOT NULL,
  `event_filter` longtext DEFAULT NULL,
  `user_id_filter` varchar(64) DEFAULT NULL,
  `headers` longtext DEFAULT NULL,
  `auth_method` varchar(16) NOT NULL DEFAULT '',
  `auth_data` longtext DEFAULT NULL,
  `token_needed` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_webhook_listeners`
--

LOCK TABLES `oc_webhook_listeners` WRITE;
/*!40000 ALTER TABLE `oc_webhook_listeners` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_webhook_listeners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_webhook_tokens`
--

DROP TABLE IF EXISTS `oc_webhook_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_webhook_tokens` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token_id` bigint(20) unsigned NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `created_at` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_webhook_tokens`
--

LOCK TABLES `oc_webhook_tokens` WRITE;
/*!40000 ALTER TABLE `oc_webhook_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_webhook_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'nextcloud'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-02 16:02:37
