/*
Navicat MySQL Data Transfer

Source Server         : Conexion1
Source Server Version : 50632
Source Host           : 127.0.0.1:3306
Source Database       : asado

Target Server Type    : MYSQL
Target Server Version : 50632
File Encoding         : 65001

Date: 2018-11-07 10:43:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for asistente
-- ----------------------------
DROP TABLE IF EXISTS `asistente`;
CREATE TABLE `asistente` (
  `id_asistente` int(255) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id_asistente`,`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gasto
-- ----------------------------
DROP TABLE IF EXISTS `gasto`;
CREATE TABLE `gasto` (
  `id_gasto` int(200) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(255) NOT NULL,
  `cantidad` float(255,0) NOT NULL,
  `id_asistente` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_gasto`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for aporteporasistente
-- ----------------------------
DROP VIEW IF EXISTS `aporteporasistente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `aporteporasistente` AS SELECT
asistente.nombre,
Sum(gasto.cantidad) AS APORTO,
asistente.id_asistente
FROM
asistente
INNER JOIN gasto ON asistente.id_asistente = gasto.id_asistente
GROUP BY
asistente.nombre ;

-- ----------------------------
-- View structure for detallegasto
-- ----------------------------
DROP VIEW IF EXISTS `detallegasto`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `detallegasto` AS SELECT
gasto.id_gasto,
gasto.concepto,
gasto.cantidad,
gasto.id_asistente,
asistente.nombre
FROM
asistente
INNER JOIN gasto ON gasto.id_asistente = asistente.id_asistente AND gasto.id_asistente = asistente.id_asistente ;

-- ----------------------------
-- View structure for detalleporasistente
-- ----------------------------
DROP VIEW IF EXISTS `detalleporasistente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `detalleporasistente` AS SELECT
asistente.id_asistente,
asistente.nombre,
gastototal.sumaTotal,
(gastototal.sumaTotal/gastototal.cantidadAsistentes) as DebeAportarCadaAsistente,
IFNULL(aporteporasistente.APORTO,0) as 'APORTO',
ROUND(IF(((gastototal.sumaTotal/gastototal.cantidadAsistentes)-IFNULL(aporteporasistente.APORTO,0))<0,0,((gastototal.sumaTotal/gastototal.cantidadAsistentes)-IFNULL(aporteporasistente.APORTO,0))),2)as 'DEBE',
ROUND(IF(((gastototal.sumaTotal/gastototal.cantidadAsistentes)-IFNULL(aporteporasistente.APORTO,0))>0,0,((-gastototal.sumaTotal/gastototal.cantidadAsistentes)+IFNULL(aporteporasistente.APORTO,0))),2)as 'LE DEBEN',
gastototal.cantidadAsistentes
FROM
asistente
LEFT OUTER JOIN aporteporasistente ON asistente.id_asistente = aporteporasistente.id_asistente ,
gastototal ;

-- ----------------------------
-- View structure for gastototal
-- ----------------------------
DROP VIEW IF EXISTS `gastototal`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `gastototal` AS SELECT
Sum(gasto.cantidad) AS 'sumaTotal',
(SELECT
Count(asistente.id_asistente)
frOM
asistente) as 'cantidadAsistentes',
(Sum(gasto.cantidad) / (SELECT Count(asistente.id_asistente)
frOM asistente)) as cadaUnoPone 
FROM
gasto ;
