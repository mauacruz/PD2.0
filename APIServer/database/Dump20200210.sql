-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: pd2.0
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `combustivel`
--

DROP TABLE IF EXISTS `combustivel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `combustivel` (
  `COMBUSTIVELOID` int(10) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(100) DEFAULT NULL,
  `VALOR` decimal(10,2) DEFAULT NULL,
  `UNIDADEMEDIDAOID` int(10) DEFAULT NULL,
  PRIMARY KEY (`COMBUSTIVELOID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `combustivel`
--

LOCK TABLES `combustivel` WRITE;
/*!40000 ALTER TABLE `combustivel` DISABLE KEYS */;
INSERT INTO `combustivel` VALUES (1,'Gasolina',4.90,1),(2,'Alcool',2.99,1);
/*!40000 ALTER TABLE `combustivel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infracao`
--

DROP TABLE IF EXISTS `infracao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infracao` (
  `INFRACAOOID` int(10) NOT NULL AUTO_INCREMENT,
  `VEICULOOID` int(10) DEFAULT NULL,
  `DATA` datetime DEFAULT NULL,
  `HORA` char(5) DEFAULT NULL,
  `AUTOINFRACAO` char(50) DEFAULT NULL,
  `ORGAO` char(50) DEFAULT NULL,
  `VALOR` decimal(10,2) DEFAULT NULL,
  `AUTORINFRACAO` int(10) DEFAULT NULL,
  `TIPOINFRACAO` char(20) DEFAULT NULL,
  PRIMARY KEY (`INFRACAOOID`),
  KEY `FK_Infracao_Veiculo_idx` (`VEICULOOID`),
  CONSTRAINT `FK_Infracao_Veiculo` FOREIGN KEY (`VEICULOOID`) REFERENCES `veiculo` (`VEICULOOID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infracao`
--

LOCK TABLES `infracao` WRITE;
/*!40000 ALTER TABLE `infracao` DISABLE KEYS */;
/*!40000 ALTER TABLE `infracao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `romaneio`
--

DROP TABLE IF EXISTS `romaneio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `romaneio` (
  `ROMANEIOOID` int(10) NOT NULL AUTO_INCREMENT,
  `VEICULOOID` int(10) DEFAULT NULL,
  `CONDUTOROID` int(10) DEFAULT NULL,
  `SAIDA` datetime DEFAULT NULL,
  `RETORNO` datetime DEFAULT NULL,
  `KMSAIDA` decimal(10,2) DEFAULT NULL,
  `KMRETORNO` decimal(10,2) DEFAULT NULL,
  `KMRODADO` decimal(10,2) DEFAULT NULL,
  `FUNCIONARIOSAIDAOID` int(10) DEFAULT NULL,
  `FUNCIONARIORETORNOOID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ROMANEIOOID`),
  KEY `FK_Romaneio_Veiculo_idx` (`VEICULOOID`),
  CONSTRAINT `FK_Romaneio_Veiculo` FOREIGN KEY (`VEICULOOID`) REFERENCES `veiculo` (`VEICULOOID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `romaneio`
--

LOCK TABLES `romaneio` WRITE;
/*!40000 ALTER TABLE `romaneio` DISABLE KEYS */;
INSERT INTO `romaneio` VALUES (1,1,1,'2020-01-01 00:00:00','2020-01-02 00:00:00',23200.00,23300.00,100.00,1,1);
/*!40000 ALTER TABLE `romaneio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguradora`
--

DROP TABLE IF EXISTS `seguradora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguradora` (
  `SEGURADORAOID` int(10) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(100) DEFAULT NULL,
  `CNPJ` char(14) DEFAULT NULL,
  `TELEFONE` varchar(15) DEFAULT NULL,
  `CORRETOR` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SEGURADORAOID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguradora`
--

LOCK TABLES `seguradora` WRITE;
/*!40000 ALTER TABLE `seguradora` DISABLE KEYS */;
INSERT INTO `seguradora` VALUES (1,'Seguradora nova','11.111.111/000','(11) 1111-1111','Nova'),(2,'Seguradora nova 2','11.111.111/000','(11) 1111-1111','Nova');
/*!40000 ALTER TABLE `seguradora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguro`
--

DROP TABLE IF EXISTS `seguro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguro` (
  `SEGUROOID` int(10) NOT NULL AUTO_INCREMENT,
  `SEGURADORAOID` int(10) DEFAULT NULL,
  `DATAINICIO` date DEFAULT NULL,
  `DATAFIM` date DEFAULT NULL,
  `COBERTURA` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`SEGUROOID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguro`
--

LOCK TABLES `seguro` WRITE;
/*!40000 ALTER TABLE `seguro` DISABLE KEYS */;
INSERT INTO `seguro` VALUES (1,1,'2020-01-01','2020-12-31','TERCEIROS'),(2,1,'2019-01-01','2019-12-31','alt');
/*!40000 ALTER TABLE `seguro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguroveiculo`
--

DROP TABLE IF EXISTS `seguroveiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguroveiculo` (
  `SEGUROOID` int(10) NOT NULL,
  `VEICULOOID` int(10) NOT NULL,
  PRIMARY KEY (`SEGUROOID`,`VEICULOOID`),
  KEY `FK_SeguroVeiculo_Seguradora_idx` (`SEGUROOID`),
  KEY `FK_SeguroVeiculo_Veiculo_idx` (`VEICULOOID`),
  CONSTRAINT `FK_SeguroVeiculo_Seguradora` FOREIGN KEY (`SEGUROOID`) REFERENCES `seguradora` (`SEGURADORAOID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SeguroVeiculo_Veiculo` FOREIGN KEY (`VEICULOOID`) REFERENCES `veiculo` (`VEICULOOID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguroveiculo`
--

LOCK TABLES `seguroveiculo` WRITE;
/*!40000 ALTER TABLE `seguroveiculo` DISABLE KEYS */;
INSERT INTO `seguroveiculo` VALUES (1,1);
/*!40000 ALTER TABLE `seguroveiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculo`
--

DROP TABLE IF EXISTS `veiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `veiculo` (
  `VEICULOOID` int(10) NOT NULL AUTO_INCREMENT,
  `MARCA` varchar(50) DEFAULT NULL,
  `MODELO` varchar(50) DEFAULT NULL,
  `PLACA` char(8) DEFAULT NULL,
  `RENAVAM` varchar(30) DEFAULT NULL,
  `COR` varchar(20) DEFAULT NULL,
  `ANO` char(4) DEFAULT NULL,
  PRIMARY KEY (`VEICULOOID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculo`
--

LOCK TABLES `veiculo` WRITE;
/*!40000 ALTER TABLE `veiculo` DISABLE KEYS */;
INSERT INTO `veiculo` VALUES (1,'corsa','sedan','aaa9999','123456','azul','1998');
/*!40000 ALTER TABLE `veiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculocombustivel`
--

DROP TABLE IF EXISTS `veiculocombustivel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `veiculocombustivel` (
  `VEICULOID` int(10) NOT NULL,
  `COMBUSTIVELID` int(10) NOT NULL,
  PRIMARY KEY (`VEICULOID`,`COMBUSTIVELID`),
  KEY `FK_VeiculoCombustivel_Combustivel_idx` (`COMBUSTIVELID`),
  CONSTRAINT `FK_VeiculoCombustivel_Combustivel` FOREIGN KEY (`COMBUSTIVELID`) REFERENCES `combustivel` (`COMBUSTIVELOID`),
  CONSTRAINT `FK_VeiculoCombustivel_Veiculo` FOREIGN KEY (`VEICULOID`) REFERENCES `veiculo` (`VEICULOOID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculocombustivel`
--

LOCK TABLES `veiculocombustivel` WRITE;
/*!40000 ALTER TABLE `veiculocombustivel` DISABLE KEYS */;
INSERT INTO `veiculocombustivel` VALUES (1,1);
/*!40000 ALTER TABLE `veiculocombustivel` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-11  0:03:10
