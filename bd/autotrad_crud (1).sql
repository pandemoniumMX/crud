-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 03-03-2023 a las 16:02:53
-- Versión del servidor: 5.7.23-23
-- Versión de PHP: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `autotrad_crud`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kindtbl`
--

CREATE TABLE `kindtbl` (
  `idkindtbl` int(11) NOT NULL,
  `KIND_NAME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KIND_DESC` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KIND_STATUS` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `kindtbl`
--

INSERT INTO `kindtbl` (`idkindtbl`, `KIND_NAME`, `KIND_DESC`, `KIND_STATUS`) VALUES
(1, 'ADMIN', 'MANAGER SOFTWARE', 'A'),
(2, 'USER', 'NORMAL USER', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usertbl`
--

CREATE TABLE `usertbl` (
  `idusertbl` int(11) NOT NULL,
  `USU_NAME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USU_LASTNAME` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USU_MAIL` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USU_STATUS` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kindtbl_idkindtbl` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usertbl`
--

INSERT INTO `usertbl` (`idusertbl`, `USU_NAME`, `USU_LASTNAME`, `USU_MAIL`, `USU_STATUS`, `kindtbl_idkindtbl`) VALUES
(1, 'Testx', 'Testingx', 'test@test.comx', 'B', 1),
(2, 'TestF', 'TestingF', 'test@test.comF', 'B', 1),
(3, 'asdXb', 'asdXb', 'Xb', 'B', 2),
(4, 'fernadno', 'adasd', 'axasd', 'B', 1),
(5, 'TestF', 'TestF', 'TestF', 'B', 1),
(6, 'asd', 'asd', 'asd', 'B', 2),
(7, 'Carlos', 'Marquez', 'a.com', 'B', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `kindtbl`
--
ALTER TABLE `kindtbl`
  ADD PRIMARY KEY (`idkindtbl`);

--
-- Indices de la tabla `usertbl`
--
ALTER TABLE `usertbl`
  ADD PRIMARY KEY (`idusertbl`),
  ADD KEY `fk_usertbl_kindtbl_idx` (`kindtbl_idkindtbl`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `kindtbl`
--
ALTER TABLE `kindtbl`
  MODIFY `idkindtbl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usertbl`
--
ALTER TABLE `usertbl`
  MODIFY `idusertbl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usertbl`
--
ALTER TABLE `usertbl`
  ADD CONSTRAINT `fk_usertbl_kindtbl` FOREIGN KEY (`kindtbl_idkindtbl`) REFERENCES `kindtbl` (`idkindtbl`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
