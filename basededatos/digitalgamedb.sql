-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-11-2017 a las 01:36:03
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `digitalgamedb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `codigo_articulo` int(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo_genero` int(255) NOT NULL,
  `plataforma` varchar(255) NOT NULL,
  `fecha_de_lanzamiento` date NOT NULL,
  `informacion_adicional` varchar(255) DEFAULT NULL,
  `stock` int(255) NOT NULL,
  `clave` int(20) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`codigo_articulo`, `nombre`, `codigo_genero`, `plataforma`, `fecha_de_lanzamiento`, `informacion_adicional`, `stock`, `clave`, `precio`) VALUES
(1, 'Call Of Duty:War at World II ', 5, 'STEAM', '2017-11-03', 'Segunda parte del ya famoso juego ambientado en la primera guerra mundial', 50, 9785, 29.95),
(2, 'Counter Strike: Global Ofensive', 5, 'STEAM', '2013-10-09', 'Counter-Strike: Global Offensive es un videojuego de disparos en primera persona desarrollado por Valve Corporation en cooperación con Hidden Path Entertainment, y es el cuarto juego de la saga Counter-Strike, sin contar Counter-Strike: Online.', 35, 5465516, 9.75),
(8, 'Rainbow Six Siege', 5, 'Uplay', '2017-11-10', 'Battle royale masivo.', 100, 6542, 20),
(9, 'PlayerUnknowns Battlegrounds', 6, 'Steam', '2017-11-16', 'Battle royale masivo.', 56, 49652, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `codigo_compra` int(255) NOT NULL,
  `fecha_hora` datetime(6) NOT NULL,
  `nombre_destino` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `email_destino` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `pais` varchar(24) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `tipo_tarjeta` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `numero_tarjeta` varchar(255) NOT NULL,
  `fecha_cad` varchar(24) NOT NULL,
  `email_usuario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`codigo_compra`, `fecha_hora`, `nombre_destino`, `email_destino`, `pais`, `tipo_tarjeta`, `numero_tarjeta`, `fecha_cad`, `email_usuario`) VALUES
(4, '2017-11-16 22:01:07.000000', 'matmoreno9@gmail.com', 'Mat', 'España', 'Visa', '215645415152', '09/12', 'caca@gmail.com'),
(5, '2017-11-16 22:14:33.000000', 'dosache94@gmail.com', 'Mat', 'España', 'Visa', '415454545545545', '09/48', 'caca@gmail.com'),
(6, '2017-11-16 22:22:52.000000', 'matmoreno9@gmail.com', 'Abel', 'España', 'Visa', '555554', '05/45', 'caca@gmail.com'),
(7, '2017-11-16 22:24:01.000000', 'matmoreno9@gmail.com', 'Abel', 'España', 'Visa', '555554', '05/45', 'caca@gmail.com'),
(8, '2017-11-16 22:24:38.000000', 'matmoreno9@gmail.com', 'dfsdf', 'España', 'Visa', '123454', '06/45', 'caca@gmail.com'),
(9, '2017-11-16 22:25:38.000000', 'matmoreno9@gmail.com', 'drfd', 'España', 'Visa', '2554', '05/45', 'caca@gmail.com'),
(10, '2017-11-16 22:42:58.000000', 'matmoreno9@gmail.com', 'mat moreno', 'España', 'Visa', '55454545454', '05/18', 'caca@gmail.com'),
(11, '2017-11-16 22:53:51.000000', 'matmoreno9@gmail.com', 'Mat Moreno', 'España', 'Visa', '5445455454', '02/45', 'caca@gmail.com'),
(12, '2017-11-16 22:58:50.000000', 'matmoreno9@gmail.com', 'Mat Moreno', 'España', 'Visa', '52454', '02/45', 'caca@gmail.com'),
(13, '2017-11-16 23:01:18.000000', 'matmoreno9@gmail.com', 'Mat Moreno', 'España', 'Visa', '54545454', '06/45', 'caca@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id_detalle` int(255) NOT NULL,
  `codigo_articulo` int(255) NOT NULL,
  `nombre_articulo` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cantidad` int(255) NOT NULL,
  `precio` int(255) NOT NULL,
  `clave_articulo` varchar(255) NOT NULL,
  `codigo_compra` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id_detalle`, `codigo_articulo`, `nombre_articulo`, `cantidad`, `precio`, `clave_articulo`, `codigo_compra`) VALUES
(1, 1, 'Call Of Duty:War at World II ', 2, 60, '9785', 4),
(2, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 5),
(3, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 6),
(4, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 7),
(6, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 9),
(7, 2, 'Counter Strike: Global Ofensive', 1, 10, '5465516', 9),
(8, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 10),
(9, 8, 'Rainbow Six Siege', 1, 20, '6542', 10),
(10, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 11),
(11, 2, 'Counter Strike: Global Ofensive', 1, 10, '5465516', 11),
(12, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 12),
(13, 2, 'Counter Strike: Global Ofensive', 1, 10, '5465516', 12),
(14, 1, 'Call Of Duty:War at World II ', 1, 30, '9785', 13),
(15, 2, 'Counter Strike: Global Ofensive', 1, 10, '5465516', 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `codigo_genero` int(255) NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`codigo_genero`, `nombre`) VALUES
(1, 'Accion'),
(2, 'Aventuras'),
(3, 'Simulador'),
(4, 'Fantasia'),
(5, 'FPS'),
(6, 'Battle Royale');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `email_usuario` varchar(100) CHARACTER SET utf32 COLLATE utf32_spanish_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fecha_de_nac` date NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`nombre`, `apellidos`, `email_usuario`, `contrasena`, `fecha_de_nac`, `admin`) VALUES
('caca', 'caca caca', 'caca@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '2017-11-05', 0),
('Mat', 'cliente', 'jaime1@gmail.com', '984cefd6d27eb0471fc401a493a4fdff', '1996-09-01', 0),
('Asdasd', 'asdasd', 'matmoreno9@gmadasdil.com', 'c99a11a53a3748269e3f86d7ac38df11', '2017-11-03', 0),
('Mat', 'Moreno Perez', 'matmoreno9@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '1996-05-09', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`codigo_articulo`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`codigo_compra`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id_detalle`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`codigo_genero`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`email_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `codigo_articulo` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `codigo_compra` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_detalle` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `codigo_genero` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
