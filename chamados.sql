CREATE DATABASE  IF NOT EXISTS `chamados` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `chamados`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: chamados
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Suporte','2025-03-23 18:05:15','2025-03-23 18:05:15'),(2,'Manutenção','2025-03-23 18:05:15','2025-03-23 18:05:15'),(3,'Financeiro','2025-03-23 18:05:15','2025-03-23 18:05:15');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chamados`
--

DROP TABLE IF EXISTS `chamados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chamados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_categoria` bigint(20) unsigned NOT NULL,
  `descricao` text DEFAULT NULL,
  `prazo_solucao` datetime DEFAULT NULL,
  `id_situacao` bigint(20) unsigned NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_autor` bigint(20) unsigned NOT NULL,
  `data_solucao` datetime DEFAULT NULL,
  `id_autor_solucao` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chamados_categoria` (`id_categoria`),
  KEY `fk_chamados_situacao` (`id_situacao`),
  KEY `fk_chamados_autor` (`id_autor`),
  KEY `fk_chamados_autor_solucao` (`id_autor_solucao`),
  CONSTRAINT `fk_chamados_autor` FOREIGN KEY (`id_autor`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_chamados_autor_solucao` FOREIGN KEY (`id_autor_solucao`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_chamados_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_chamados_situacao` FOREIGN KEY (`id_situacao`) REFERENCES `situacoes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chamados`
--

LOCK TABLES `chamados` WRITE;
/*!40000 ALTER TABLE `chamados` DISABLE KEYS */;
INSERT INTO `chamados` VALUES (2,'teste suporte',1,'uaisdduiasduiashiua','2025-03-26 00:00:00',3,'2025-03-23 21:17:30',4,'2025-03-23 19:53:03',5,'2025-03-23 21:17:30','2025-03-23 22:53:03'),(3,'Teste sup',1,'asddasdas','2025-03-26 00:00:00',3,'2025-03-23 21:19:22',4,NULL,NULL,'2025-03-23 21:19:22','2025-03-23 22:14:27'),(5,'Ainda testando',2,'ifdusnuidsajduioas','2025-03-26 00:00:00',3,'2025-03-23 21:41:56',4,'2025-03-23 00:00:00',5,'2025-03-23 21:41:56','2025-03-23 22:40:39'),(6,'usuario 2',2,'ifuadshdiuash','2025-03-26 00:00:00',1,'2025-03-23 21:43:07',6,NULL,NULL,'2025-03-23 21:43:07','2025-03-23 21:43:07'),(7,'solucionador',3,'adsuiuiosadhuoa','2025-03-26 00:00:00',3,'2025-03-23 22:43:02',4,'2025-03-23 00:00:00',5,'2025-03-23 22:43:02','2025-03-23 22:43:29'),(8,'Chamado 1',1,'Descrição do chamado 1','2025-03-26 09:00:00',3,'2025-03-23 12:00:00',7,'2025-03-25 10:00:00',8,'2025-03-23 12:00:00','2025-03-23 12:00:00'),(9,'Chamado 2',2,'Descrição do chamado 2','2025-03-26 10:00:00',2,'2025-03-23 13:00:00',7,NULL,5,'2025-03-23 13:00:00','2025-03-24 00:17:50'),(10,'Chamado 3',3,'Descrição do chamado 3','2025-03-26 11:00:00',3,'2025-03-23 14:00:00',7,'2025-03-27 11:00:00',10,'2025-03-23 14:00:00','2025-03-23 14:00:00'),(11,'Chamado 4',1,'Descrição do chamado 4','2025-03-26 12:00:00',3,'2025-03-23 15:00:00',9,'2025-04-23 12:00:00',12,'2025-03-23 15:00:00','2025-03-23 15:00:00'),(12,'Chamado 5',2,'Descrição do chamado 5','2025-03-25 13:00:00',1,'2025-03-23 16:00:00',9,NULL,NULL,'2025-03-23 16:00:00','2025-03-23 16:00:00'),(13,'Chamado 6',3,'Descrição do chamado 6','2025-03-26 14:00:00',3,'2025-03-23 17:00:00',9,'2025-03-26 14:00:00',8,'2025-03-23 17:00:00','2025-03-23 17:00:00'),(14,'Chamado 7',1,'Descrição do chamado 7','2025-03-24 15:00:00',3,'2025-03-23 18:00:00',11,'2025-03-24 15:00:00',10,'2025-03-23 18:00:00','2025-03-23 18:00:00'),(15,'Chamado 8',2,'Descrição do chamado 8','2025-03-23 16:00:00',1,'2025-03-23 19:00:00',11,NULL,NULL,'2025-03-23 19:00:00','2025-03-23 19:00:00'),(16,'Chamado 9',3,'Descrição do chamado 9','2025-03-26 17:00:00',3,'2025-03-23 20:00:00',11,'2025-03-22 17:00:00',12,'2025-03-23 20:00:00','2025-03-23 20:00:00');
/*!40000 ALTER TABLE `chamados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (8,'2014_10_12_000000_create_users_table',1),(9,'2014_10_12_100000_create_password_reset_tokens_table',1),(10,'2019_08_19_000000_create_failed_jobs_table',1),(11,'2019_12_14_000001_create_personal_access_tokens_table',1),(12,'2025_03_23_154553_create_categorias_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `guard_name` varchar(255) NOT NULL DEFAULT 'web',
  PRIMARY KEY (`permission_id`,`model_id`),
  KEY `fk_model_has_permissions_model_id` (`model_id`),
  CONSTRAINT `fk_model_has_permissions_model_id` FOREIGN KEY (`model_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_model_has_permissions_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `guard_name` varchar(255) NOT NULL DEFAULT 'web',
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  CONSTRAINT `fk_model_has_roles_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',4,'web'),(1,'App\\Models\\User',5,'web'),(1,'App\\Models\\User',6,'web'),(1,'App\\Models\\User',7,'web'),(1,'App\\Models\\User',9,'web'),(1,'App\\Models\\User',11,'web'),(2,'App\\Models\\User',5,'web'),(2,'App\\Models\\User',8,'web'),(2,'App\\Models\\User',10,'web'),(2,'App\\Models\\User',12,'web');
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) NOT NULL DEFAULT 'web',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'token-de-acesso','c6d50b554b02c8fff0ca94b18af0b70ab64f705016d05f624d7775f47892f061','[\"*\"]',NULL,NULL,'2025-03-23 20:01:58','2025-03-23 20:01:58'),(2,'App\\Models\\User',1,'token-de-acesso','f6dcab511cd0be574ab70c06914b8ba3b1cd0b86dc4353c5039bb20feb6b43d2','[\"*\"]',NULL,NULL,'2025-03-23 20:09:14','2025-03-23 20:09:14'),(3,'App\\Models\\User',2,'token-de-acesso','1af4e8f42b523cb7926ee1b0583ae047f2e9b0c2ad411dac43b124dd4c78caed','[\"*\"]',NULL,NULL,'2025-03-23 20:12:09','2025-03-23 20:12:09'),(4,'App\\Models\\User',2,'token-de-acesso','3457fa155fafaed6a08b3ec75182c242a2fc0330a4ccd71dccbc9a9ad317b8de','[\"*\"]',NULL,NULL,'2025-03-23 20:12:18','2025-03-23 20:12:18'),(5,'App\\Models\\User',2,'token-de-acesso','a791039b0adc7ae24fa7b2852ef5a732505a0ff3f0cce1d1811997706324abb7','[\"*\"]',NULL,NULL,'2025-03-23 20:12:57','2025-03-23 20:12:57'),(6,'App\\Models\\User',2,'token-de-acesso','98a2122a12d8ffcd83eec44d58f186fc81a5bd1d7329eb06f753366fde1706f2','[\"*\"]',NULL,NULL,'2025-03-23 20:14:22','2025-03-23 20:14:22'),(7,'App\\Models\\User',4,'token-de-acesso','ea5a57eb83ab732b1f6461051370fb700a0a417b6099f9b0d1ebb6d6c53daa0b','[\"*\"]',NULL,NULL,'2025-03-23 20:21:15','2025-03-23 20:21:15'),(8,'App\\Models\\User',4,'token-de-acesso','658b00b870bd1181853c2a2b4ef5c693c6a0a2efdd3edca32ccd9233eddf2333','[\"*\"]',NULL,NULL,'2025-03-23 20:21:22','2025-03-23 20:21:22'),(9,'App\\Models\\User',5,'token-de-acesso','90fb5cc46972969bd2e46d6ac5ace618396cc746e3314d162e91def6c8dc95ba','[\"*\"]',NULL,NULL,'2025-03-23 20:22:00','2025-03-23 20:22:00'),(10,'App\\Models\\User',4,'token-de-acesso','e6bb25d16d46d8c9f734fdeddd3f745c61551042db0606e23754b9501543ffab','[\"*\"]',NULL,NULL,'2025-03-23 20:24:04','2025-03-23 20:24:04'),(11,'App\\Models\\User',5,'token-de-acesso','d361816fd793a136d21c5869e44812b6532be02854dbfa99577d63c7dcfc4a0d','[\"*\"]',NULL,NULL,'2025-03-23 20:24:15','2025-03-23 20:24:15'),(12,'App\\Models\\User',4,'token-de-acesso','8b0fb7c692c04c49e76fc7934668e6b5b911546d9c5f19ed05d033d026efccd8','[\"*\"]',NULL,NULL,'2025-03-23 20:26:56','2025-03-23 20:26:56'),(13,'App\\Models\\User',4,'token-de-acesso','27a74858699826fd69e411a53af9908a464b3ec6438233bdebeefe213401c766','[\"*\"]',NULL,NULL,'2025-03-23 21:11:18','2025-03-23 21:11:18'),(14,'App\\Models\\User',4,'token-de-acesso','66b223d015d759549cd484fabebcb3d5d4f92756d2680be56f2a93d235d03602','[\"*\"]',NULL,NULL,'2025-03-23 21:33:46','2025-03-23 21:33:46'),(15,'App\\Models\\User',5,'token-de-acesso','c1a9de992f6223d58991640426ef81a1b362f1c62189f3c188471d3e194c4d80','[\"*\"]',NULL,NULL,'2025-03-23 21:34:45','2025-03-23 21:34:45'),(16,'App\\Models\\User',4,'token-de-acesso','7dca1344cc4cbff2a0103d6663af4c4ef0f93dbf4c4d88b249b6d6b7eaf802a6','[\"*\"]',NULL,NULL,'2025-03-23 21:35:50','2025-03-23 21:35:50'),(17,'App\\Models\\User',5,'token-de-acesso','e40829987de087ba492a943e26f5c9728be1f7605a33630d810d74865a8900e0','[\"*\"]',NULL,NULL,'2025-03-23 21:37:00','2025-03-23 21:37:00'),(18,'App\\Models\\User',4,'token-de-acesso','c3247bf8c38e1b851c86aee70afbc5db7885320162afdb18cc6ce7bc2e155080','[\"*\"]',NULL,NULL,'2025-03-23 21:41:40','2025-03-23 21:41:40'),(19,'App\\Models\\User',5,'token-de-acesso','b56447490199c5fe365800a5007422f51b115f88fdafb47cfbc305dd83f88210','[\"*\"]',NULL,NULL,'2025-03-23 21:42:10','2025-03-23 21:42:10'),(20,'App\\Models\\User',6,'token-de-acesso','66926c76e03d49544c28065d232cd2c99ae4c9afd6d7e3117becb6368bb426bb','[\"*\"]',NULL,NULL,'2025-03-23 21:42:51','2025-03-23 21:42:51'),(21,'App\\Models\\User',6,'token-de-acesso','69290dbc4779e8b5a4612b7130e5952434cb7c196dcf909c00b2efc673f4bc6a','[\"*\"]',NULL,NULL,'2025-03-23 21:42:56','2025-03-23 21:42:56'),(22,'App\\Models\\User',4,'token-de-acesso','7742ac43eaf74aa7b9a1f761a88153d3f377f6075787d68039a6d8bddc89207a','[\"*\"]',NULL,NULL,'2025-03-23 21:49:18','2025-03-23 21:49:18'),(23,'App\\Models\\User',5,'token-de-acesso','68ad6038854d7fa14861c64465748a6ce786ecdbda3418702d8afd6e862931b5','[\"*\"]',NULL,NULL,'2025-03-23 21:50:42','2025-03-23 21:50:42'),(24,'App\\Models\\User',4,'token-de-acesso','d6058099255542d6079821aa7b5616b875aed4e0cf21cfd4ecf2a12d534a347c','[\"*\"]',NULL,NULL,'2025-03-23 22:06:18','2025-03-23 22:06:18'),(25,'App\\Models\\User',5,'token-de-acesso','5c2d73fdd9d4a8aa7e00a18e64bdcc9dbbecec20563741367b037e0f8e2967bf','[\"*\"]',NULL,NULL,'2025-03-23 22:08:23','2025-03-23 22:08:23'),(26,'App\\Models\\User',5,'token-de-acesso','0ffa2f371b1ed40a31d45231b8567e53f6feb05831095fe1fb3e2a4c50d74507','[\"*\"]',NULL,NULL,'2025-03-23 22:14:13','2025-03-23 22:14:13'),(27,'App\\Models\\User',4,'token-de-acesso','9140c9512fd041012aaff0d7cc32cfea39c9470d781d61d86372d7194070f864','[\"*\"]',NULL,NULL,'2025-03-23 22:15:29','2025-03-23 22:15:29'),(28,'App\\Models\\User',4,'token-de-acesso','78420700fd1ab490e92155d1bd7809da5eac03081344cc519ae05695296e88f3','[\"*\"]',NULL,NULL,'2025-03-23 22:22:47','2025-03-23 22:22:47'),(29,'App\\Models\\User',6,'token-de-acesso','62499ca83ed4dd3a24bf3819d47fd92768626a89b4b48ea140a57d8960d37969','[\"*\"]',NULL,NULL,'2025-03-23 22:25:41','2025-03-23 22:25:41'),(30,'App\\Models\\User',5,'token-de-acesso','b2364bfd9d9bbf89c723b7e4a1d9c71eb4e04b182ffaff5127de08ead0fced00','[\"*\"]',NULL,NULL,'2025-03-23 22:25:51','2025-03-23 22:25:51'),(31,'App\\Models\\User',4,'token-de-acesso','7fc76b55516def25873d44fc1c2718e5d9f51569773731458a204d77148f8392','[\"*\"]',NULL,NULL,'2025-03-23 22:42:52','2025-03-23 22:42:52'),(32,'App\\Models\\User',5,'token-de-acesso','2cdb253d1b9977aae94369bc3c2d68e30359087284a428584e4af64fd9741525','[\"*\"]',NULL,NULL,'2025-03-23 22:43:19','2025-03-23 22:43:19'),(33,'App\\Models\\User',4,'token-de-acesso','6b6f07ad2b8748e5fddfe47374bee64e367162dbc6b6952e38f5352d70c819de','[\"*\"]',NULL,NULL,'2025-03-23 22:47:37','2025-03-23 22:47:37'),(34,'App\\Models\\User',5,'token-de-acesso','3a3886b9b3b9a6be3a1eaa4fe21765323a70bfb509ed1837ad56a872eeecd601','[\"*\"]',NULL,NULL,'2025-03-23 22:49:00','2025-03-23 22:49:00'),(35,'App\\Models\\User',4,'token-de-acesso','b1c53dea2e9ff9917fa1527da1ba16a2fc4f498b6381103db4b00dc4dd0972db','[\"*\"]',NULL,NULL,'2025-03-23 23:32:22','2025-03-23 23:32:22'),(36,'App\\Models\\User',5,'token-de-acesso','628a6ddb7001970e6a3145cd4ea0471249156831d2ffea3e764d3040993bbfa4','[\"*\"]',NULL,NULL,'2025-03-23 23:34:19','2025-03-23 23:34:19'),(37,'App\\Models\\User',4,'token-de-acesso','eddbc518d4497ceba80afdc921a9fab2af153f743c4700e333d4d53431735e4f','[\"*\"]',NULL,NULL,'2025-03-23 23:38:45','2025-03-23 23:38:45'),(38,'App\\Models\\User',5,'token-de-acesso','ef3f4b26167918c3c49250a864497b1e531c8b649cbbf53483ebf1ed7d75b26f','[\"*\"]',NULL,NULL,'2025-03-23 23:39:07','2025-03-23 23:39:07');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `role_id` bigint(20) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `fk_role_has_permissions_permission_id` (`permission_id`),
  CONSTRAINT `fk_role_has_permissions_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_role_has_permissions_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) NOT NULL DEFAULT 'web',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'usuario','2025-03-23 16:56:27','2025-03-23 16:56:27','web'),(2,'administrador','2025-03-23 16:56:27','2025-03-23 16:56:27','web');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacoes`
--

DROP TABLE IF EXISTS `situacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `situacoes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacoes`
--

LOCK TABLES `situacoes` WRITE;
/*!40000 ALTER TABLE `situacoes` DISABLE KEYS */;
INSERT INTO `situacoes` VALUES (1,'Novo','2025-03-23 18:16:27','2025-03-23 18:16:27'),(2,'Pendente','2025-03-23 18:17:15','2025-03-23 18:17:15'),(3,'Resolvido','2025-03-23 18:17:20','2025-03-23 18:17:20');
/*!40000 ALTER TABLE `situacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'usuario','usuario@gmail.com',NULL,'$2y$12$p5klNEB9RZn5DhdjxJ.4G.0.NytrXWsn8BzSOFG7suwFMZIxq52Gu','2025-03-23 20:21:15','2025-03-23 20:21:15'),(5,'Diluan','diluan135@gmail.com',NULL,'$2y$12$4DieberebXJjaiq.XnEQn.iuGWy.pTP5GwOUHGMQ3Dm2VmL3U6CJK','2025-03-23 20:22:00','2025-03-23 20:22:00'),(6,'2','usuario2@gmail.com',NULL,'$2y$12$zQqHzkMM2kxlRH6s19PbsOfYDLkjoxWb/OOb/6hqImYeCbmQS7C1W','2025-03-23 21:42:51','2025-03-23 21:42:51'),(7,'João Silva','joao.silva@example.com','123.456.789-00','$2y$10$abcdefg1234567890','2025-03-23 21:03:24','2025-03-23 21:03:24'),(8,'Maria Oliveira','maria.oliveira@example.com','987.654.321-00','$2y$10$hijklmn9876543210','2025-03-23 21:03:24','2025-03-23 21:03:24'),(9,'Carlos Santos','carlos.santos@example.com','456.789.123-00','$2y$10$opqrst4567891230','2025-03-23 21:03:24','2025-03-23 21:03:24'),(10,'Ana Souza','ana.souza@example.com','741.852.963-00','$2y$10$uvwxyz7418529630','2025-03-23 21:03:24','2025-03-23 21:03:24'),(11,'Pedro Lima','pedro.lima@example.com','369.258.147-00','$2y$10$mnopqr3692581470','2025-03-23 21:03:24','2025-03-23 21:03:24'),(12,'Juliana Costa','juliana.costa@example.com','159.753.486-00','$2y$10$abcdef1597534860','2025-03-23 21:03:24','2025-03-23 21:03:24');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'chamados'
--

--
-- Dumping routines for database 'chamados'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-23 18:42:30
