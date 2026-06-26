SET SESSION sql_require_primary_key = 0;
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:8889
-- Tiempo de generación: 26-06-2026 a las 15:59:31
-- Versión del servidor: 8.0.40
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_drogas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `drogas`
--

CREATE TABLE `drogas` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_id` int NOT NULL,
  `nombre_cientifico` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forma_consumo` enum('Oral','Inhalado','Inyectado','Fumado','Tópico','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `riesgo_adiccion` enum('Bajo','Moderado','Alto','Muy alto') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `efectos_principales` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` int DEFAULT NULL,
  `modificado_por` int DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `drogas`
--

INSERT INTO `drogas` (`id`, `nombre`, `tipo_id`, `nombre_cientifico`, `forma_consumo`, `riesgo_adiccion`, `descripcion`, `efectos_principales`, `fecha_creacion`, `creado_por`, `modificado_por`, `fecha_modificacion`) VALUES
(1, 'Cocaína', 1, 'Benzoylmethylecgonine', 'Inhalado', 'Muy alto', 'Estimulante poderoso derivado de la hoja de coca', 'Euforia, energía aumentada, disminución del apetito', '2025-05-13 00:55:23', NULL, NULL, NULL),
(2, 'Heroína', 4, 'Diamorphine', 'Inyectado', 'Muy alto', 'Opiáceo altamente adictivo', 'Euforia, alivio del dolor, sedación', '2025-05-13 00:55:23', NULL, 1, '2026-06-17 23:52:30'),
(3, 'LSD', 3, 'Lysergic acid diethylamide', 'Oral', 'Bajo', 'Alucinógeno poderoso', 'Alucinaciones, alteración de la percepción del tiempo', '2025-05-13 00:55:23', NULL, NULL, NULL),
(5, 'Alcohol', 6, 'Ethanol', 'Oral', 'Alto', 'Depresor del SNC legal', 'Desinhibición, relajación, deterioro motor', '2025-05-13 00:55:23', NULL, NULL, NULL),
(6, 'Nicotina', 7, 'Nicotiana tabacum', 'Fumado', 'Alto', 'Estimulante leve del tabaco producción\r\n', 'Aumento de la alerta, relajación', '2025-05-13 00:55:23', NULL, 1, '2025-07-09 00:58:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `droga_efectos`
--

CREATE TABLE `droga_efectos` (
  `droga_id` int NOT NULL,
  `efecto_id` int NOT NULL,
  `intensidad` enum('Leve','Moderado','Fuerte') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tiempo_inicio` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duracion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `droga_efectos`
--

INSERT INTO `droga_efectos` (`droga_id`, `efecto_id`, `intensidad`, `tiempo_inicio`, `duracion`) VALUES
(1, 1, 'Fuerte', 'Minutos', '30-60 minutos'),
(1, 4, 'Fuerte', 'Minutos', '1-2 horas'),
(1, 6, 'Moderado', 'Minutos', 'Hasta varias horas'),
(1, 8, 'Fuerte', 'Minutos', '1-2 horas'),
(2, 1, 'Fuerte', 'Minutos', '4-6 horas'),
(2, 2, 'Fuerte', 'Minutos', '4-6 horas'),
(2, 9, 'Fuerte', 'Uso prolongado', 'Crónico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `droga_riesgos`
--

CREATE TABLE `droga_riesgos` (
  `droga_id` int NOT NULL,
  `riesgo_id` int NOT NULL,
  `probabilidad` enum('Baja','Media','Alta') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `droga_riesgos`
--

INSERT INTO `droga_riesgos` (`droga_id`, `riesgo_id`, `probabilidad`) VALUES
(1, 1, 'Alta'),
(1, 2, 'Alta'),
(1, 3, 'Alta'),
(1, 6, 'Alta'),
(2, 1, 'Alta'),
(2, 2, 'Alta'),
(2, 4, 'Alta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `droga_tratamientos`
--

CREATE TABLE `droga_tratamientos` (
  `droga_id` int NOT NULL,
  `tratamiento_id` int NOT NULL,
  `recomendado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `droga_tratamientos`
--

INSERT INTO `droga_tratamientos` (`droga_id`, `tratamiento_id`, `recomendado`) VALUES
(1, 1, 1),
(1, 3, 1),
(1, 4, 1),
(2, 1, 1),
(2, 2, 1),
(2, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `efectos`
--

CREATE TABLE `efectos` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('Físico','Psicológico','Social','Comportamental') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `efectos`
--

INSERT INTO `efectos` (`id`, `nombre`, `categoria`, `descripcion`) VALUES
(1, 'Euforia', 'Psicológico', 'Sensación intensa de felicidad o bienestar'),
(2, 'Sedación', 'Físico', 'Reducción de la actividad física y mental'),
(3, 'Alucinaciones', 'Psicológico', 'Percepciones de cosas que no existen'),
(4, 'Aumento de energía', 'Físico', 'Sensación de mayor energía y alerta'),
(5, 'Deterioro motor', 'Físico', 'Reducción de la coordinación y habilidades motoras'),
(6, 'Ansiedad', 'Psicológico', 'Sensación de nerviosismo o miedo'),
(7, 'Aumento del apetito', 'Físico', 'Hambre aumentada'),
(8, 'Taquicardia', 'Físico', 'Aumento del ritmo cardíaco'),
(9, 'Dependencia', 'Comportamental', 'Necesidad compulsiva de consumir la sustancia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad`
--

CREATE TABLE `registro_actividad` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `registro_id` int DEFAULT NULL,
  `tipo_actividad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tabla_afectada` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detalles` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_actividad` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `registro_actividad`
--

INSERT INTO `registro_actividad` (`id`, `usuario_id`, `registro_id`, `tipo_actividad`, `tabla_afectada`, `detalles`, `ip_address`, `fecha_actividad`) VALUES
(1, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-08 05:09:24'),
(2, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-08 05:09:28'),
(3, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-08 05:09:52'),
(4, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2025-07-08 05:10:06'),
(5, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2025-07-08 05:10:36'),
(6, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-08 05:10:40'),
(7, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-08 17:49:30'),
(8, 1, 10, 'Eliminar Droga', 'drogas', 'Usuario admin eliminó la droga rewrew (ID: 10).', '127.0.0.1', '2025-07-08 17:54:07'),
(9, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-08 18:09:28'),
(10, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-08 18:09:33'),
(11, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-08 18:09:38'),
(12, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2025-07-08 18:09:41'),
(13, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2025-07-08 18:09:49'),
(14, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-08 18:09:55'),
(15, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:31:14'),
(16, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:31:27'),
(17, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:31:33'),
(18, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:31:44'),
(19, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:31:51'),
(20, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:32:39'),
(21, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:32:45'),
(22, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:32:51'),
(23, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:32:57'),
(24, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:33:53'),
(25, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:39:02'),
(26, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:40:17'),
(27, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:40:23'),
(28, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2025-07-09 00:41:55'),
(29, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-09 00:42:01'),
(30, 1, 9, 'Eliminar Droga', 'drogas', 'Usuario admin eliminó la droga Foco (ID: 9).', '127.0.0.1', '2025-07-09 00:42:05'),
(31, 1, 8, 'Eliminar Droga', 'drogas', 'Usuario admin eliminó la droga Tus ojos  (ID: 8).', '127.0.0.1', '2025-07-09 00:42:15'),
(32, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:46:52'),
(33, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:56:26'),
(34, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:56:57'),
(35, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:57:43'),
(36, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:58:01'),
(37, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:58:14'),
(38, 1, 6, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Nicotina (ID: 6).', '127.0.0.1', '2025-07-09 00:58:32'),
(39, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-10 20:19:44'),
(40, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-10 20:22:02'),
(41, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-10 20:22:07'),
(42, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-10 20:22:23'),
(43, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-10 20:22:27'),
(44, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-10 20:25:51'),
(45, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2025-07-10 20:26:13'),
(46, 1, 4, 'Eliminar Droga', 'drogas', 'Usuario admin eliminó la droga Marihuana (ID: 4).', '127.0.0.1', '2025-07-10 22:48:23'),
(47, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2025-07-10 22:48:47'),
(48, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2025-07-10 22:48:53'),
(49, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2025-07-10 22:49:01'),
(50, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2025-07-10 22:49:07'),
(51, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2025-07-10 22:49:19'),
(52, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-05-21 00:37:16'),
(53, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-05-21 00:38:32'),
(54, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-05-21 00:38:42'),
(55, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-05-21 00:39:12'),
(56, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-05-21 00:39:23'),
(57, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-05-21 00:41:00'),
(58, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-05-21 00:41:06'),
(59, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-05-25 23:12:46'),
(60, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-05-25 23:13:41'),
(61, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-05-28 00:11:54'),
(62, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-05-28 00:12:05'),
(63, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-05-28 00:12:17'),
(64, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-05-28 00:12:27'),
(65, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-05-28 00:19:03'),
(66, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-05-28 00:19:10'),
(67, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-04 00:18:14'),
(68, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-04 00:18:21'),
(69, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-04 00:30:26'),
(70, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-04 00:30:34'),
(71, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-08 22:59:06'),
(72, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-08 22:59:19'),
(73, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-08 22:59:45'),
(74, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-06-08 22:59:51'),
(75, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-06-08 23:01:15'),
(76, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-10 19:47:33'),
(77, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-10 23:17:48'),
(78, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-10 23:18:01'),
(79, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-10 23:56:14'),
(80, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-10 23:57:23'),
(81, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:08:32'),
(82, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-06-11 00:08:40'),
(83, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:33:22'),
(84, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-11 00:33:30'),
(85, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:38:39'),
(86, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-06-11 00:38:44'),
(87, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:39:06'),
(88, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-11 00:39:15'),
(89, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:39:18'),
(90, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-11 00:39:33'),
(91, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:39:41'),
(92, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-11 00:39:47'),
(93, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-11 00:43:36'),
(94, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-12 15:20:47'),
(95, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-12 15:36:06'),
(96, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-12 15:36:15'),
(97, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-12 16:15:44'),
(98, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-06-12 16:15:55'),
(99, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-06-12 16:16:37'),
(100, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-12 16:16:45'),
(101, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-12 18:08:53'),
(102, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-12 18:09:04'),
(103, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-12 18:09:19'),
(104, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-12 18:09:37'),
(105, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-12 18:09:55'),
(106, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-12 18:10:03'),
(107, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-12 18:10:07'),
(108, 2, NULL, 'Login', NULL, 'Usuario editor ha iniciado sesión.', '127.0.0.1', '2026-06-12 18:10:14'),
(109, 2, NULL, 'Logout', NULL, 'Usuario editor ha cerrado sesión.', '127.0.0.1', '2026-06-12 19:52:44'),
(110, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-12 19:52:54'),
(111, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-12 19:53:09'),
(112, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-12 19:53:30'),
(113, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-17 23:47:46'),
(114, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-17 23:48:09'),
(115, 1, 2, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Heroína (ID: 2).', '127.0.0.1', '2026-06-17 23:52:19'),
(116, 1, 2, 'Editar Droga', 'drogas', 'Usuario admin editó la droga Heroína (ID: 2).', '127.0.0.1', '2026-06-17 23:52:30'),
(117, 1, NULL, 'Logout', NULL, 'Usuario admin ha cerrado sesión.', '127.0.0.1', '2026-06-18 00:05:39'),
(118, 3, NULL, 'Login', NULL, 'Usuario consultor ha iniciado sesión.', '127.0.0.1', '2026-06-18 00:05:56'),
(119, 3, NULL, 'Logout', NULL, 'Usuario consultor ha cerrado sesión.', '127.0.0.1', '2026-06-18 00:52:02'),
(120, 1, NULL, 'Login', NULL, 'Usuario admin ha iniciado sesión.', '127.0.0.1', '2026-06-18 00:52:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `riesgos`
--

CREATE TABLE `riesgos` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('Físico','Mental','Social','Legal','Económico') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `gravedad` enum('Baja','Media','Alta','Muy alta') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `riesgos`
--

INSERT INTO `riesgos` (`id`, `nombre`, `categoria`, `descripcion`, `gravedad`) VALUES
(1, 'Sobredosis', 'Físico', 'Consumo excesivo que puede llevar a la muerte', 'Muy alta'),
(2, 'Adicción', 'Mental', 'Dependencia psicológica y física', 'Alta'),
(3, 'Problemas cardíacos', 'Físico', 'Daño al sistema cardiovascular', 'Alta'),
(4, 'Problemas hepáticos', 'Físico', 'Daño al hígado', 'Alta'),
(5, 'Problemas pulmonares', 'Físico', 'Daño a los pulmones', 'Alta'),
(6, 'Problemas legales', 'Legal', 'Consecuencias por posesión o consumo', 'Media'),
(7, 'Problemas económicos', 'Económico', 'Gastos excesivos en la sustancia', 'Media'),
(8, 'Aislamiento social', 'Social', 'Pérdida de relaciones personales', 'Media');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_drogas`
--

CREATE TABLE `tipos_drogas` (
  `id` int NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `legal` tinyint(1) DEFAULT '0',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipos_drogas`
--

INSERT INTO `tipos_drogas` (`id`, `nombre`, `descripcion`, `legal`, `fecha_creacion`) VALUES
(1, 'Estimulantes', 'Aceleran el sistema nervioso central', 0, '2025-05-13 00:55:23'),
(2, 'Depresores', 'Enlentecen el sistema nervioso central', 0, '2025-05-13 00:55:23'),
(3, 'Alucinógenos', 'Alteran la percepción de la realidad', 0, '2025-05-13 00:55:23'),
(4, 'Opiáceos', 'Derivados del opio, usados como analgésicos', 0, '2025-05-13 00:55:23'),
(5, 'Cannabinoides', 'Derivados del cannabis', 1, '2025-05-13 00:55:23'),
(6, 'Alcohol', 'Depresor del SNC legal en muchos países', 1, '2025-05-13 00:55:23'),
(7, 'Tabaco', 'Estimulante leve legal en muchos países', 1, '2025-05-13 00:55:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens_acceso`
--

CREATE TABLE `tokens_acceso` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'sesion',
  `fecha_expiracion` datetime DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `dispositivo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tokens_acceso`
--

INSERT INTO `tokens_acceso` (`id`, `usuario_id`, `token`, `tipo_token`, `fecha_expiracion`, `fecha_creacion`, `dispositivo`, `ip`) VALUES
(1, 1, '95dffabe-9d3e-4051-9652-ff89cc00c15d', 'sesion', NULL, '2025-07-10 20:21:22', 'Web', '127.0.0.1'),
(2, 2, '5432ee3b-8ae9-453f-b6c1-010c66b30605', 'sesion', NULL, '2025-07-10 20:23:56', 'Web', '127.0.0.1'),
(3, 3, '495aaf0e-6fa5-4ee0-a821-356c2c4a2374', 'sesion', NULL, '2025-07-10 20:24:01', 'Web', '127.0.0.1'),
(4, 1, 'c70a306d-9bdd-49e1-814e-0fa96b184676', 'sesion', NULL, '2026-05-28 00:42:29', 'Web', '127.0.0.1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('Farmacológico','Terapia','Grupo de apoyo','Internamiento','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `efectividad` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tratamientos`
--

INSERT INTO `tratamientos` (`id`, `nombre`, `tipo`, `descripcion`, `efectividad`) VALUES
(1, 'Terapia cognitivo-conductual', 'Terapia', 'Enfocada en cambiar patrones de pensamiento', 'Alta'),
(2, 'Metadona', 'Farmacológico', 'Sustituto de opiáceos para desintoxicación', 'Moderada'),
(3, 'Grupos de apoyo', 'Grupo de apoyo', 'Comunidades como Narcóticos Anónimos', 'Moderada'),
(4, 'Internamiento', 'Internamiento', 'Tratamiento residencial intensivo', 'Alta'),
(5, 'Terapia familiar', 'Terapia', 'Involucra a la familia en el tratamiento', 'Moderada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nombre_usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('admin','editor','consultor') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'consultor',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultimo_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `email`, `password_hash`, `rol`, `activo`, `fecha_creacion`, `fecha_ultimo_login`) VALUES
(1, 'admin', 'admin@gmail.com', 'scrypt:32768:8:1$6TMOctdgDQo5U8v5$7c446296e78938b07282a27e0d2ca5adc48767c38364f242f08cf7d8d65abc5035d99ce6dff57a505b217933e6e5380ff63e78e52ea4930e5d485128c0926606', 'admin', 1, '2025-07-08 05:01:59', '2026-06-18 00:52:15'),
(2, 'editor', 'editor@gmail.com', 'scrypt:32768:8:1$AQuFQqVKhHGfTcNK$487767e687329ff75745744f4e679dd41df57529fa8e798a30543647b8c6e938b07c5ab99562d7c48b0d3b547dc8bc8f5f13430e26883881102ecb14cf9cd974', 'editor', 1, '2025-07-08 05:02:00', '2026-06-12 18:10:14'),
(3, 'consultor', 'consultor@gmail.com', 'scrypt:32768:8:1$lUCesekfUrliACZG$1c272cd63f5db80306260ab56b3fbe4f025bb58438c2009d408d1a58127b8ec11d4962ac5db40a2b5cabc858758d1c99705346a315c78a7f507d1483c0b87535', 'consultor', 1, '2025-07-08 05:02:00', '2026-06-18 00:05:57');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `drogas`
--
ALTER TABLE `drogas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_id` (`tipo_id`),
  ADD KEY `creado_por` (`creado_por`),
  ADD KEY `modificado_por` (`modificado_por`);

--
-- Indices de la tabla `droga_efectos`
--
ALTER TABLE `droga_efectos`
  ADD PRIMARY KEY (`droga_id`,`efecto_id`),
  ADD KEY `efecto_id` (`efecto_id`);

--
-- Indices de la tabla `droga_riesgos`
--
ALTER TABLE `droga_riesgos`
  ADD PRIMARY KEY (`droga_id`,`riesgo_id`),
  ADD KEY `riesgo_id` (`riesgo_id`);

--
-- Indices de la tabla `droga_tratamientos`
--
ALTER TABLE `droga_tratamientos`
  ADD PRIMARY KEY (`droga_id`,`tratamiento_id`),
  ADD KEY `tratamiento_id` (`tratamiento_id`);

--
-- Indices de la tabla `efectos`
--
ALTER TABLE `efectos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `riesgos`
--
ALTER TABLE `riesgos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos_drogas`
--
ALTER TABLE `tipos_drogas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tokens_acceso`
--
ALTER TABLE `tokens_acceso`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `drogas`
--
ALTER TABLE `drogas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `efectos`
--
ALTER TABLE `efectos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT de la tabla `riesgos`
--
ALTER TABLE `riesgos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipos_drogas`
--
ALTER TABLE `tipos_drogas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tokens_acceso`
--
ALTER TABLE `tokens_acceso`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `drogas`
--
ALTER TABLE `drogas`
  ADD CONSTRAINT `fk_drogas_creado_por` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_drogas_modificado_por` FOREIGN KEY (`modificado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_drogas_tipo_id` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_drogas` (`id`);

--
-- Filtros para la tabla `droga_efectos`
--
ALTER TABLE `droga_efectos`
  ADD CONSTRAINT `fk_droga_efectos_droga_id` FOREIGN KEY (`droga_id`) REFERENCES `drogas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_droga_efectos_efecto_id` FOREIGN KEY (`efecto_id`) REFERENCES `efectos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `droga_riesgos`
--
ALTER TABLE `droga_riesgos`
  ADD CONSTRAINT `fk_droga_riesgos_droga_id` FOREIGN KEY (`droga_id`) REFERENCES `drogas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_droga_riesgos_riesgo_id` FOREIGN KEY (`riesgo_id`) REFERENCES `riesgos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `droga_tratamientos`
--
ALTER TABLE `droga_tratamientos`
  ADD CONSTRAINT `fk_droga_tratamientos_droga_id` FOREIGN KEY (`droga_id`) REFERENCES `drogas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_droga_tratamientos_tratamiento_id` FOREIGN KEY (`tratamiento_id`) REFERENCES `tratamientos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD CONSTRAINT `fk_registro_actividad_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tokens_acceso`
--
ALTER TABLE `tokens_acceso`
  ADD CONSTRAINT `fk_tokens_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
