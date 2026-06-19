-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: parkir_mall
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `kendaraan`
--

DROP TABLE IF EXISTS `kendaraan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kendaraan` (
  `plat_nomor` varchar(12) NOT NULL,
  `jenis_kendaraan` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`plat_nomor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kendaraan`
--

LOCK TABLES `kendaraan` WRITE;
/*!40000 ALTER TABLE `kendaraan` DISABLE KEYS */;
INSERT INTO `kendaraan` VALUES ('B 1121 IJ','motor'),('B 1234 CD','mobil'),('B 5678 EF','motor'),('B 9101 GH','mobil'),('B 9999 SZ','motor');
/*!40000 ALTER TABLE `kendaraan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkir`
--

DROP TABLE IF EXISTS `parkir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parkir` (
  `id_parkir` char(4) NOT NULL,
  `waktu_masuk` time DEFAULT NULL,
  `waktu_keluar` time DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `plat_nomor` varchar(12) DEFAULT NULL,
  `id_slot` char(3) DEFAULT NULL,
  PRIMARY KEY (`id_parkir`),
  KEY `plat_nomor` (`plat_nomor`),
  KEY `id_slot` (`id_slot`),
  KEY `idx_waktu_keluar` (`waktu_keluar`),
  KEY `idx_tanggal` (`tanggal`),
  CONSTRAINT `fk_id_slot` FOREIGN KEY (`id_slot`) REFERENCES `slot_parkir` (`id_slot`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_plat_nomor` FOREIGN KEY (`plat_nomor`) REFERENCES `kendaraan` (`plat_nomor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkir`
--

LOCK TABLES `parkir` WRITE;
/*!40000 ALTER TABLE `parkir` DISABLE KEYS */;
INSERT INTO `parkir` VALUES ('P001','08:30:00','10:00:00','2026-05-13','B 1234 CD','S01'),('P002','15:20:00','17:00:00','2026-05-13','B 1234 CD','S07'),('P003','09:15:00','12:00:00','2026-05-13','B 5678 EF','S02'),('P004','16:45:00','18:00:00','2026-05-13','B 5678 EF','S08'),('P005','11:00:00','14:00:00','2026-05-13','B 9101 GH','S04'),('P006','13:10:00','15:00:00','2026-05-13','B 1121 IJ','S06'),('p007','13:00:00','14:00:00','2026-06-18','B 9999 SZ','S09');
/*!40000 ALTER TABLE `parkir` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger trg_setelah_parkir_masuk
after insert on parkir
for each row
begin
	update slot_parkir
	set status = 'terisi'
	where id_slot = new.id_slot;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pembayaran`
--

DROP TABLE IF EXISTS `pembayaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pembayaran` (
  `id_pembayaran` varchar(6) NOT NULL,
  `biaya` int(11) DEFAULT NULL,
  `id_parkir` char(4) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `id_parkir` (`id_parkir`),
  CONSTRAINT `fk_id_parkir` FOREIGN KEY (`id_parkir`) REFERENCES `parkir` (`id_parkir`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembayaran`
--

LOCK TABLES `pembayaran` WRITE;
/*!40000 ALTER TABLE `pembayaran` DISABLE KEYS */;
INSERT INTO `pembayaran` VALUES ('PY001',5000,'P001'),('PY002',2000,'P003'),('PY003',5000,'P005'),('PY004',2000,'P006'),('PY007',5000,'P002'),('PY008',2000,'P004');
/*!40000 ALTER TABLE `pembayaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slot_parkir`
--

DROP TABLE IF EXISTS `slot_parkir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slot_parkir` (
  `id_slot` char(3) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `id_zona` char(3) DEFAULT NULL,
  PRIMARY KEY (`id_slot`),
  KEY `id_zona` (`id_zona`),
  CONSTRAINT `fk_id_zona` FOREIGN KEY (`id_zona`) REFERENCES `zona_parkir` (`id_zona`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slot_parkir`
--

LOCK TABLES `slot_parkir` WRITE;
/*!40000 ALTER TABLE `slot_parkir` DISABLE KEYS */;
INSERT INTO `slot_parkir` VALUES ('S01','terisi','Z01'),('S02','terisi','Z02'),('S04','terisi','Z01'),('S06','terisi','Z02'),('S07','terisi','Z01'),('S08','terisi','Z02'),('S09','terisi','Z02');
/*!40000 ALTER TABLE `slot_parkir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_laporan_parkir`
--

DROP TABLE IF EXISTS `view_laporan_parkir`;
/*!50001 DROP VIEW IF EXISTS `view_laporan_parkir`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_laporan_parkir` AS SELECT
 1 AS `id_parkir`,
  1 AS `plat_nomor`,
  1 AS `jenis_kendaraan`,
  1 AS `waktu_masuk`,
  1 AS `waktu_keluar`,
  1 AS `id_slot`,
  1 AS `nama_zona`,
  1 AS `biaya` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zona_parkir`
--

DROP TABLE IF EXISTS `zona_parkir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zona_parkir` (
  `id_zona` char(3) NOT NULL,
  `nama_zona` varchar(10) DEFAULT NULL,
  `tarif` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zona_parkir`
--

LOCK TABLES `zona_parkir` WRITE;
/*!40000 ALTER TABLE `zona_parkir` DISABLE KEYS */;
INSERT INTO `zona_parkir` VALUES ('Z01','zona a',5000),('Z02','zona b',2000);
/*!40000 ALTER TABLE `zona_parkir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `view_laporan_parkir`
--

/*!50001 DROP VIEW IF EXISTS `view_laporan_parkir`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_laporan_parkir` AS select `p`.`id_parkir` AS `id_parkir`,`p`.`plat_nomor` AS `plat_nomor`,`k`.`jenis_kendaraan` AS `jenis_kendaraan`,`p`.`waktu_masuk` AS `waktu_masuk`,`p`.`waktu_keluar` AS `waktu_keluar`,`p`.`id_slot` AS `id_slot`,`z`.`nama_zona` AS `nama_zona`,`pem`.`biaya` AS `biaya` from ((((`parkir` `p` join `kendaraan` `k` on(`p`.`plat_nomor` = `k`.`plat_nomor`)) join `slot_parkir` `s` on(`p`.`id_slot` = `s`.`id_slot`)) join `zona_parkir` `z` on(`s`.`id_zona` = `z`.`id_zona`)) join `pembayaran` `pem` on(`p`.`id_parkir` = `pem`.`id_parkir`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-18 19:54:58
