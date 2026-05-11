-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-05-2026 a las 13:24:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `peluqueria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `servicio` varchar(255) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `observaciones` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id`, `user_id`, `nombre`, `telefono`, `servicio`, `precio`, `fecha`, `hora`, `observaciones`, `created_at`, `updated_at`) VALUES
(18, 8, 'David', '666666666', 'Corte de pelo', 12.00, '2026-05-11', '13:00:00', NULL, '2026-05-11 07:41:00', '2026-05-11 07:41:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_04_15_081609_create_citas_table', 1),
(5, '2026_04_26_195426_create_personal_access_tokens_table', 2),
(6, '2026_05_05_103648_add_role_to_users_table', 3),
(7, '2026_05_11_092845_add_email_verified_at_to_users_table', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '1a997325c52b3639f765065282123949fdb849b3427ef5301799d9fdf4fa0c4b', '[\"*\"]', NULL, NULL, '2026-04-26 18:27:06', '2026-04-26 18:27:06'),
(2, 'App\\Models\\User', 1, 'auth_token', '28c4b0d7ff60eba07afbb1ad089d47bf8427b7fd0680f0807d19359669f06c00', '[\"*\"]', NULL, NULL, '2026-04-26 18:27:24', '2026-04-26 18:27:24'),
(3, 'App\\Models\\User', 1, 'auth_token', 'bd80b15ac0907c379482ef64d09d71554ba5b6f010792aef1fe772237c6f4736', '[\"*\"]', NULL, NULL, '2026-04-26 18:28:43', '2026-04-26 18:28:43'),
(4, 'App\\Models\\User', 1, 'auth_token', '5b6da537a49b06ceda32ab878e0b283fd8c74c7acd3acbf92ab3bad1001aeee0', '[\"*\"]', NULL, NULL, '2026-04-26 18:33:06', '2026-04-26 18:33:06'),
(5, 'App\\Models\\User', 2, 'auth_token', '3dac6d4095d9efd0783f8ae4b70192469d0403026347a6e8f0bfcb6c13a0f81f', '[\"*\"]', NULL, NULL, '2026-04-26 18:34:29', '2026-04-26 18:34:29'),
(6, 'App\\Models\\User', 2, 'auth_token', 'c7a057b3a5ddbc53f199d35dc3fe301c97a159b4cfe5c15ba627cb434ec249a6', '[\"*\"]', NULL, NULL, '2026-04-26 18:34:44', '2026-04-26 18:34:44'),
(7, 'App\\Models\\User', 1, 'auth_token', 'e8c1c0d90f92bcc6dc614cbd2ac69281a17fecfc7d705ab487e8ac885061ffe4', '[\"*\"]', NULL, NULL, '2026-04-26 18:52:53', '2026-04-26 18:52:53'),
(8, 'App\\Models\\User', 1, 'auth_token', '2633b0cfe3be64cf8a4726fba6b211d5344c35986a18759bc40be31e1df2c4ea', '[\"*\"]', NULL, NULL, '2026-04-27 05:37:00', '2026-04-27 05:37:00'),
(9, 'App\\Models\\User', 2, 'auth_token', 'd67e7fb788ddc466cc6620d95d5e2fb4b54d69da3a8a101177602989be052107', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:54', '2026-04-27 07:02:54'),
(10, 'App\\Models\\User', 2, 'auth_token', '1a85def74a41675a76459a7dd7e45140c28245e2d6285bc0087c3d9b1908ca43', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:56', '2026-04-27 07:02:56'),
(11, 'App\\Models\\User', 2, 'auth_token', 'f419a52dd6b0b4fa32bb790c2179341babc54e69bdfa1419dc7da954c997448e', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:56', '2026-04-27 07:02:56'),
(12, 'App\\Models\\User', 2, 'auth_token', 'f29246f657d357369db1359832337570e572b0705322226eaf4597af23e8cc45', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:57', '2026-04-27 07:02:57'),
(13, 'App\\Models\\User', 2, 'auth_token', 'f91e73b6bd7d53555e67d5a927b6d2d1be33b839736b9b9167697f84989b3de8', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:58', '2026-04-27 07:02:58'),
(14, 'App\\Models\\User', 2, 'auth_token', '623b97c5a1dc51572708efb4695ff012db4e85449d00f4af7e695bebde7bed30', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:58', '2026-04-27 07:02:58'),
(15, 'App\\Models\\User', 2, 'auth_token', '46166a0c940adfa0def94e8bb9eca44fa55fd89d999ed8aeafb7c765363cec30', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:59', '2026-04-27 07:02:59'),
(16, 'App\\Models\\User', 2, 'auth_token', 'd9866d73b6f901826976d7c33a1d53219d7c8289b6e252a13827eb2e4c6d93df', '[\"*\"]', NULL, NULL, '2026-04-27 07:02:59', '2026-04-27 07:02:59'),
(17, 'App\\Models\\User', 2, 'auth_token', '328a346ce89bf537cc502e547f5bf0dd2c6d2d9f5b9a3c0e761226cd535c6520', '[\"*\"]', NULL, NULL, '2026-04-27 07:04:44', '2026-04-27 07:04:44'),
(18, 'App\\Models\\User', 1, 'auth_token', '249f92d47fbaf0f312f38b2e954ec31de06c84dd3077d5f0a7a30f236825dd72', '[\"*\"]', NULL, NULL, '2026-04-27 07:05:14', '2026-04-27 07:05:14'),
(19, 'App\\Models\\User', 3, 'auth_token', '9418724ea86eca94bb9ec5f1dd66b33b848d07546168cb9ca83b9d94a2bdcd24', '[\"*\"]', NULL, NULL, '2026-04-28 18:53:25', '2026-04-28 18:53:25'),
(20, 'App\\Models\\User', 3, 'auth_token', 'c3f18bf24e93a3a1c54223278755983f038e0fc7d9840a5c695899970b5eec93', '[\"*\"]', NULL, NULL, '2026-04-28 18:53:42', '2026-04-28 18:53:42'),
(21, 'App\\Models\\User', 3, 'auth_token', 'e0445f694eabccc27e231a30ae099dd098596da5963d82584dc050e30e760f9d', '[\"*\"]', NULL, NULL, '2026-04-28 18:56:39', '2026-04-28 18:56:39'),
(22, 'App\\Models\\User', 1, 'auth_token', '8ab2139d804df33cb93d48f68a35914b5e127d1c2f7b360f9c7fef731d2cf9f0', '[\"*\"]', NULL, NULL, '2026-04-30 05:31:41', '2026-04-30 05:31:41'),
(23, 'App\\Models\\User', 1, 'auth_token', '7752f70894414e418f90721e13cc046349ee74d229f1bee05a15371569393290', '[\"*\"]', '2026-04-30 06:12:23', NULL, '2026-04-30 06:01:44', '2026-04-30 06:12:23'),
(24, 'App\\Models\\User', 1, 'auth_token', 'a4923ec07555bc214796d0bd5fda7f11f87884495d565b97b29b15148c355333', '[\"*\"]', '2026-04-30 06:17:51', NULL, '2026-04-30 06:17:15', '2026-04-30 06:17:51'),
(25, 'App\\Models\\User', 2, 'auth_token', '859110d187a1bac13fc4b317e99fd7fe06ebd61535855a27524c8c4d1fe1235c', '[\"*\"]', '2026-04-30 07:26:05', NULL, '2026-04-30 06:21:21', '2026-04-30 07:26:05'),
(26, 'App\\Models\\User', 1, 'auth_token', 'd5f3ee988e4b91050db3318b504391c806088f3099744c2a85adceac90100a02', '[\"*\"]', '2026-04-30 07:29:22', NULL, '2026-04-30 07:26:51', '2026-04-30 07:29:22'),
(27, 'App\\Models\\User', 1, 'auth_token', '82ef8abead598e5602b8bf8c775ba41bf7cc51b00295db7001668b598221c855', '[\"*\"]', '2026-05-05 09:19:28', NULL, '2026-05-05 09:00:06', '2026-05-05 09:19:28'),
(28, 'App\\Models\\User', 1, 'auth_token', '0678e8b37b1f6622be3ebca4b2fade698187c23d08b4f4c2af2ef2e66d90936b', '[\"*\"]', '2026-05-05 09:25:25', NULL, '2026-05-05 09:24:54', '2026-05-05 09:25:25'),
(29, 'App\\Models\\User', 2, 'auth_token', '423195768ae80399905bc3a8e43ac91c08168ff30ae759a5aa6ff88b0aa69f31', '[\"*\"]', '2026-05-05 09:26:03', NULL, '2026-05-05 09:25:47', '2026-05-05 09:26:03'),
(30, 'App\\Models\\User', 1, 'auth_token', '842f0de6e4bd65d8f7421140626ee8b0b3db3a1a620316068f9c31d42fb01bba', '[\"*\"]', '2026-05-05 10:14:05', NULL, '2026-05-05 09:45:03', '2026-05-05 10:14:05'),
(31, 'App\\Models\\User', 1, 'auth_token', '8e95a1d9864af065ff940dc4f00c508304627a228c210626ef71692aed197251', '[\"*\"]', '2026-05-07 06:30:37', NULL, '2026-05-07 05:39:19', '2026-05-07 06:30:37'),
(32, 'App\\Models\\User', 1, 'auth_token', '650bb0d035422758822a3de20a4a401b3c1b5f529e5cdcafe1e4a6505ab5683d', '[\"*\"]', NULL, NULL, '2026-05-07 07:59:24', '2026-05-07 07:59:24'),
(33, 'App\\Models\\User', 2, 'auth_token', 'fe0b4290ef63f45d2ce08791b04af78daed80c67d4e62fda762e2236e6cb8100', '[\"*\"]', NULL, NULL, '2026-05-07 08:08:12', '2026-05-07 08:08:12'),
(34, 'App\\Models\\User', 1, 'auth_token', 'f3a4c73bf5fc242d55fa09b147790bb643824849514d46efceb66d2a8e245f79', '[\"*\"]', '2026-05-07 08:08:42', NULL, '2026-05-07 08:08:38', '2026-05-07 08:08:42'),
(35, 'App\\Models\\User', 2, 'auth_token', 'b063dd71f5cb05861136cfab6ea8164dadd7922c77be4e7d655f249766e0b010', '[\"*\"]', '2026-05-07 08:09:55', NULL, '2026-05-07 08:09:22', '2026-05-07 08:09:55'),
(36, 'App\\Models\\User', 1, 'auth_token', 'be8f702e1c6b7a3b208d504e54d514fab13f2f53c5e5764dd9eed3b7a7fb6892', '[\"*\"]', '2026-05-07 10:38:46', NULL, '2026-05-07 08:10:19', '2026-05-07 10:38:46'),
(37, 'App\\Models\\User', 2, 'auth_token', '9e7e29b447115a155dc852f552375250335800a7b72edde5a949ceae3b78843d', '[\"*\"]', NULL, NULL, '2026-05-08 05:35:50', '2026-05-08 05:35:50'),
(38, 'App\\Models\\User', 1, 'auth_token', '116208e541035130b9edab752b00f9286cd38c496114d3ae1ca3bd34b145280a', '[\"*\"]', '2026-05-08 06:00:12', NULL, '2026-05-08 05:36:07', '2026-05-08 06:00:12'),
(39, 'App\\Models\\User', 2, 'auth_token', '6430918dfb716f4e48443951165b469a18fcab62b90d2d6396a68f009b19e40e', '[\"*\"]', '2026-05-08 06:24:39', NULL, '2026-05-08 06:23:34', '2026-05-08 06:24:39'),
(40, 'App\\Models\\User', 1, 'auth_token', 'c69b9062e77bea6c31f070f028139b4db11ebd7a742a51c18d30de333762fc4f', '[\"*\"]', '2026-05-08 06:27:32', NULL, '2026-05-08 06:24:51', '2026-05-08 06:27:32'),
(41, 'App\\Models\\User', 4, 'auth_token', '783fbb92168ff73bba013cd734c9713f95e3a3f2ff49cdfea904637d2453d272', '[\"*\"]', NULL, NULL, '2026-05-08 06:29:15', '2026-05-08 06:29:15'),
(42, 'App\\Models\\User', 4, 'auth_token', '8ee00978dcb81cb30cd3bbc56765b8db5e2ab6dd3fb42b0d34229b5329e78761', '[\"*\"]', '2026-05-08 06:30:02', NULL, '2026-05-08 06:29:29', '2026-05-08 06:30:02'),
(43, 'App\\Models\\User', 1, 'auth_token', '9330cf934382ca5575b03b65a789da2005fa8a2dd822a84f9ba96f569b01332d', '[\"*\"]', '2026-05-08 06:32:14', NULL, '2026-05-08 06:30:16', '2026-05-08 06:32:14'),
(44, 'App\\Models\\User', 2, 'auth_token', '0e7e17950ce078262f60b4f5ea6dd2a7d34a013fd05c966e3493c878efd92565', '[\"*\"]', '2026-05-08 06:37:19', NULL, '2026-05-08 06:35:36', '2026-05-08 06:37:19'),
(45, 'App\\Models\\User', 1, 'auth_token', '7404d31d18b5ec1f66c2af882cc29ac1f2bfec263a5828b6d5ca69750fc9e503', '[\"*\"]', '2026-05-08 07:06:43', NULL, '2026-05-08 06:38:09', '2026-05-08 07:06:43'),
(46, 'App\\Models\\User', 1, 'auth_token', '3070fb14a59b29e62d5ac0cf9208e26f78178c5e67fa37e9c050cfcf27b76250', '[\"*\"]', '2026-05-10 09:47:48', NULL, '2026-05-10 09:00:22', '2026-05-10 09:47:48'),
(47, 'App\\Models\\User', 2, 'auth_token', 'a4139ce052a5001ce8bf24c77ba49b795667ba0f51bd295be3931d267914d0f6', '[\"*\"]', '2026-05-10 09:48:12', NULL, '2026-05-10 09:48:08', '2026-05-10 09:48:12'),
(48, 'App\\Models\\User', 1, 'auth_token', 'dd88dd5ec8a2213a85e41384204296aea2b03bedf9cc4bb97fec5075a97f7bb2', '[\"*\"]', '2026-05-10 09:52:22', NULL, '2026-05-10 09:48:48', '2026-05-10 09:52:22'),
(49, 'App\\Models\\User', 1, 'auth_token', '7318563630333482db4bfbb84ed712af4df3a9c3e6077848803edd725cf417f8', '[\"*\"]', '2026-05-11 06:38:51', NULL, '2026-05-11 06:17:39', '2026-05-11 06:38:51'),
(50, 'App\\Models\\User', 4, 'auth_token', '5b210ff920d68cc486d794a08c4509434751675f4f35ba87ed1acf8fb82ac38b', '[\"*\"]', NULL, NULL, '2026-05-11 06:39:35', '2026-05-11 06:39:35'),
(51, 'App\\Models\\User', 7, 'auth_token', 'a56f9be3c205f28d85f3b8829c895fa1afc1bfe7db0c6e25f1ee03159e1dd0be', '[\"*\"]', NULL, NULL, '2026-05-11 07:30:30', '2026-05-11 07:30:30'),
(52, 'App\\Models\\User', 8, 'auth_token', '51acd4f0d5696dc4c63a09896095e43ea19a8f508a63a37eb67dbdf4426268fa', '[\"*\"]', '2026-05-11 07:41:03', NULL, '2026-05-11 07:38:36', '2026-05-11 07:41:03'),
(53, 'App\\Models\\User', 7, 'auth_token', '22c29ff7106b35afb3806d8d7e61c6df223f107143fe319a5423ebda6b21c9a6', '[\"*\"]', '2026-05-11 08:05:20', NULL, '2026-05-11 07:40:18', '2026-05-11 08:05:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `telefono`, `email`, `email_verified_at`, `password`, `role`, `created_at`, `updated_at`) VALUES
(7, 'Daniel', '677809356', 'danieltrujillofernandez@gmail.com', '2026-05-11 07:30:07', '$2y$12$55QhcIuy6.G0RG8ke6FvhuL.1PhXR7KhwLWTK1fDfMjb8XMb.43qW', 'admin', '2026-05-11 07:27:07', '2026-05-11 07:30:07'),
(8, 'David', '666666666', 'dtrufer2301@g.educaand.es', '2026-05-11 07:38:13', '$2y$12$XeWqYbSfF2rzdy66.9dzpeIETeGjwOFXZ3hIu9h7YRezNbpYv3auu', 'user', '2026-05-11 07:37:57', '2026-05-11 07:38:13');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
