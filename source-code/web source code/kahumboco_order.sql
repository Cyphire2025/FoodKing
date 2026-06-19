-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 13, 2026 at 05:43 PM
-- Server version: 8.0.36-cll-lve
-- PHP Version: 8.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kahumboco_order`
--

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `author` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `files` json DEFAULT NULL,
  `item_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `license_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apartment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `label`, `address`, `apartment`, `latitude`, `longitude`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 4, 'Home', 'Unknown Location Found', NULL, '28.6093181330324', '77.29404900223017', NULL, NULL, NULL, NULL, '2026-03-24 14:18:51', '2026-03-24 14:18:51'),
(2, 4, 'Work', 'Orchard Drive, Uxbridge, UB8 3AE, England, United Kingdom', 'brunel university', '51.5298091', '-0.4776743', NULL, NULL, NULL, NULL, '2026-04-10 03:12:37', '2026-04-10 03:12:37'),
(3, 10, 'Home', '13/2 east madartak .Singapore road .basaboo, ঢাকা 1212, Bangladesh', '33', '23.804093151143885', '90.4152374714613', NULL, NULL, NULL, NULL, '2026-04-17 06:33:37', '2026-04-17 06:33:37'),
(4, 10, 'Office', '2 Dhaka Medical College, Dhaka, Bangladesh', '43', '23.72602586490375', '90.39746414870024', NULL, NULL, NULL, NULL, '2026-04-17 06:34:34', '2026-04-17 06:34:34'),
(7, 11, 'Home', 'Arbor House, 6 Station Rd, Orpington BR6 0RY, UK', '7', '51.373868524010035', '0.09682506322860718', NULL, NULL, NULL, NULL, '2026-04-17 06:48:02', '2026-04-17 06:48:02'),
(8, 14, 'Home', '10 Haig Ave, Brighton and Hove, Brighton BN1 9EQ, UK', '647', '50.86511122610092', '-0.11488135904073715', NULL, NULL, NULL, NULL, '2026-04-17 13:14:41', '2026-04-17 13:14:41'),
(9, 14, 'Office', '11 Elm Grove, Orpington BR6 0AA, UK', '62', '51.37378313303205', '0.09328320622444153', NULL, NULL, NULL, NULL, '2026-04-17 13:15:33', '2026-04-17 13:15:33'),
(10, 15, 'Home', '344 High St., Orpington BR6 0NQ, UK', '123', '51.37309748793504', '0.09755261242389679', NULL, NULL, NULL, NULL, '2026-04-24 00:12:11', '2026-04-24 00:12:11'),
(11, 19, 'Home', '285 High St., Orpington BR6 0NN, UK', NULL, '51.374342985195064', '0.09849607944488525', NULL, NULL, NULL, NULL, '2026-04-26 23:20:18', '2026-04-26 23:20:18');

-- --------------------------------------------------------

--
-- Table structure for table `analytics`
--

CREATE TABLE `analytics` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `analytics`
--

INSERT INTO `analytics` (`id`, `name`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'v', 5, NULL, NULL, NULL, NULL, '2026-04-10 03:32:37', '2026-04-10 03:32:37');

-- --------------------------------------------------------

--
-- Table structure for table `analytic_sections`
--

CREATE TABLE `analytic_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `analytic_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` tinyint NOT NULL DEFAULT '5',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `email`, `phone`, `latitude`, `longitude`, `city`, `state`, `zip_code`, `address`, `zone`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'kahumbo Brighton Road', 'mf@gmail.com', '+44 7345233213', '51.3382321', '0.1322144', 'Purley', 'London', 'CR8 2LP', '942 Brighton Road, Purley, CR8 2LP, London, UK', '\"[{\\\"lat\\\":51.29111174227885,\\\"lng\\\":0.034778109671758095},{\\\"lat\\\":51.27802901667095,\\\"lng\\\":0.01648494127600042},{\\\"lat\\\":51.36111775654401,\\\"lng\\\":0.24103872457752473},{\\\"lat\\\":51.44990102620034,\\\"lng\\\":0.209212807711463},{\\\"lat\\\":51.45739626426078,\\\"lng\\\":0.039343649294476535},{\\\"lat\\\":51.37259867063215,\\\"lng\\\":-0.040102873573761855}]\"', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-04-17 06:44:12');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `capture_payment_notifications`
--

CREATE TABLE `capture_payment_notifications` (
  `order_id` bigint UNSIGNED NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` decimal(19,6) NOT NULL,
  `discount_type` tinyint NOT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `minimum_order` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `maximum_discount` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `limit_per_user` bigint DEFAULT '0',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `name`, `description`, `code`, `discount`, `discount_type`, `start_date`, `end_date`, `minimum_order`, `maximum_discount`, `limit_per_user`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'NEW50', NULL, 'NEW50', 50.000000, 10, '2026-05-11 07:56:00', '2027-05-11 07:56:00', 30.000000, 15.000000, 1, NULL, NULL, NULL, NULL, '2026-05-11 07:57:57', '2026-05-11 07:57:57'),
(2, 'REG10', NULL, 'REG10', 10.000000, 10, '2026-05-11 08:07:00', '2027-05-11 08:07:00', 20.000000, 10.000000, NULL, NULL, NULL, NULL, NULL, '2026-05-11 08:07:58', '2026-05-11 08:07:58');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_cryptocurrency` tinyint UNSIGNED NOT NULL,
  `exchange_rate` decimal(13,2) DEFAULT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint UNSIGNED DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `symbol`, `code`, `is_cryptocurrency`, `exchange_rate`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Pound', '£', 'GBP', 10, 1.00, NULL, NULL, NULL, NULL, NULL, '2026-03-24 18:27:47');

-- --------------------------------------------------------

--
-- Table structure for table `default_access`
--

CREATE TABLE `default_access` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `default_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `default_access`
--

INSERT INTO `default_access` (`id`, `name`, `user_id`, `default_id`, `created_at`, `updated_at`) VALUES
(1, 'branch_id', 1, 1, '2026-03-24 18:16:43', '2026-03-24 18:16:43'),
(2, 'branch_id', 3, 1, '2026-03-24 13:23:42', '2026-03-24 13:23:42'),
(3, 'branch_id', 4, 1, '2026-03-24 14:18:31', '2026-03-24 14:18:31'),
(4, 'branch_id', 5, 1, '2026-03-24 23:47:23', '2026-03-24 23:47:23'),
(5, 'branch_id', 6, 1, '2026-03-25 08:54:12', '2026-03-25 08:54:12'),
(6, 'branch_id', 7, 1, '2026-03-25 08:55:03', '2026-03-25 08:55:03'),
(7, 'branch_id', 8, 1, '2026-04-10 02:53:21', '2026-04-10 02:53:21'),
(8, 'branch_id', 9, 1, '2026-04-10 03:08:32', '2026-04-10 03:08:32'),
(9, 'branch_id', 10, 1, '2026-04-17 06:32:24', '2026-04-17 06:32:24'),
(10, 'branch_id', 11, 1, '2026-04-17 06:35:32', '2026-04-17 06:35:32'),
(11, 'branch_id', 12, 1, '2026-04-17 06:39:46', '2026-04-17 06:39:46'),
(12, 'branch_id', 13, 1, '2026-04-17 12:44:46', '2026-04-17 12:44:46'),
(13, 'branch_id', 14, 1, '2026-04-17 13:13:17', '2026-04-17 13:13:17'),
(14, 'branch_id', 15, 1, '2026-04-23 23:55:15', '2026-04-23 23:55:15'),
(15, 'branch_id', 16, 1, '2026-04-24 00:24:27', '2026-04-24 00:24:27'),
(16, 'branch_id', 17, 1, '2026-04-24 01:26:40', '2026-04-24 01:26:40'),
(17, 'branch_id', 18, 1, '2026-04-26 09:20:45', '2026-04-26 09:20:45'),
(18, 'branch_id', 19, 1, '2026-04-26 23:19:16', '2026-04-26 23:19:16'),
(19, 'branch_id', 20, 1, '2026-05-12 05:59:15', '2026-05-12 05:59:15'),
(20, 'branch_id', 21, 1, '2026-05-13 02:16:54', '2026-05-13 02:16:54');

-- --------------------------------------------------------

--
-- Table structure for table `dining_tables`
--

CREATE TABLE `dining_tables` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int DEFAULT NULL,
  `qr_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gateway_options`
--

CREATE TABLE `gateway_options` (
  `id` bigint UNSIGNED NOT NULL,
  `model_id` bigint NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `type` tinyint NOT NULL,
  `activities` longtext COLLATE utf8mb4_unicode_ci,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateway_options`
--

INSERT INTO `gateway_options` (`id`, `model_id`, `model_type`, `option`, `value`, `type`, `activities`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 3, 'App\\Models\\PaymentGateway', 'paypal_app_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 3, 'App\\Models\\PaymentGateway', 'paypal_client_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 3, 'App\\Models\\PaymentGateway', 'paypal_client_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 3, 'App\\Models\\PaymentGateway', 'paypal_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, 3, 'App\\Models\\PaymentGateway', 'paypal_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 4, 'App\\Models\\PaymentGateway', 'stripe_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 4, 'App\\Models\\PaymentGateway', 'stripe_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 4, 'App\\Models\\PaymentGateway', 'stripe_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(9, 4, 'App\\Models\\PaymentGateway', 'stripe_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(10, 5, 'App\\Models\\PaymentGateway', 'flutterwave_public_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(11, 5, 'App\\Models\\PaymentGateway', 'flutterwave_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(12, 5, 'App\\Models\\PaymentGateway', 'flutterwave_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(13, 5, 'App\\Models\\PaymentGateway', 'flutterwave_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(14, 6, 'App\\Models\\PaymentGateway', 'paystack_public_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(15, 6, 'App\\Models\\PaymentGateway', 'paystack_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(16, 6, 'App\\Models\\PaymentGateway', 'paystack_payment_url', 'https://api.paystack.co', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(17, 6, 'App\\Models\\PaymentGateway', 'paystack_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(18, 6, 'App\\Models\\PaymentGateway', 'paystack_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(19, 7, 'App\\Models\\PaymentGateway', 'sslcommerz_store_name', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(20, 7, 'App\\Models\\PaymentGateway', 'sslcommerz_store_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(21, 7, 'App\\Models\\PaymentGateway', 'sslcommerz_store_password', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(22, 7, 'App\\Models\\PaymentGateway', 'sslcommerz_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(23, 7, 'App\\Models\\PaymentGateway', 'sslcommerz_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(24, 8, 'App\\Models\\PaymentGateway', 'mollie_api_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(25, 8, 'App\\Models\\PaymentGateway', 'mollie_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(26, 8, 'App\\Models\\PaymentGateway', 'mollie_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(27, 9, 'App\\Models\\PaymentGateway', 'senangpay_merchant_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(28, 9, 'App\\Models\\PaymentGateway', 'senangpay_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(29, 9, 'App\\Models\\PaymentGateway', 'senangpay_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(30, 9, 'App\\Models\\PaymentGateway', 'senangpay_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(31, 10, 'App\\Models\\PaymentGateway', 'bkash_app_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(32, 10, 'App\\Models\\PaymentGateway', 'bkash_app_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(33, 10, 'App\\Models\\PaymentGateway', 'bkash_username', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(34, 10, 'App\\Models\\PaymentGateway', 'bkash_password', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(35, 10, 'App\\Models\\PaymentGateway', 'bkash_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(36, 10, 'App\\Models\\PaymentGateway', 'bkash_status', '', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(37, 11, 'App\\Models\\PaymentGateway', 'paytm_merchant_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(38, 11, 'App\\Models\\PaymentGateway', 'paytm_merchant_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(39, 11, 'App\\Models\\PaymentGateway', 'paytm_merchant_website', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(40, 11, 'App\\Models\\PaymentGateway', 'paytm_channel', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(41, 11, 'App\\Models\\PaymentGateway', 'paytm_industry_type', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(42, 11, 'App\\Models\\PaymentGateway', 'paytm_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(43, 11, 'App\\Models\\PaymentGateway', 'paytm_status', '', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(44, 12, 'App\\Models\\PaymentGateway', 'razorpay_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(45, 12, 'App\\Models\\PaymentGateway', 'razorpay_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(46, 12, 'App\\Models\\PaymentGateway', 'razorpay_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(47, 12, 'App\\Models\\PaymentGateway', 'razorpay_status', '', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(48, 13, 'App\\Models\\PaymentGateway', 'mercadopago_client_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(49, 13, 'App\\Models\\PaymentGateway', 'mercadopago_client_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(50, 13, 'App\\Models\\PaymentGateway', 'mercadopago_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(51, 13, 'App\\Models\\PaymentGateway', 'mercadopago_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(52, 14, 'App\\Models\\PaymentGateway', 'cashfree_app_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(53, 14, 'App\\Models\\PaymentGateway', 'cashfree_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(54, 14, 'App\\Models\\PaymentGateway', 'cashfree_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(55, 14, 'App\\Models\\PaymentGateway', 'cashfree_status', '', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(56, 15, 'App\\Models\\PaymentGateway', 'payfast_merchant_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(57, 15, 'App\\Models\\PaymentGateway', 'payfast_merchant_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(58, 15, 'App\\Models\\PaymentGateway', 'payfast_passphrase', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(59, 15, 'App\\Models\\PaymentGateway', 'payfast_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(60, 15, 'App\\Models\\PaymentGateway', 'payfast_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(61, 16, 'App\\Models\\PaymentGateway', 'skrill_merchant_email', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(62, 16, 'App\\Models\\PaymentGateway', 'skrill_merchant_api_password', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(63, 16, 'App\\Models\\PaymentGateway', 'skrill_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(64, 16, 'App\\Models\\PaymentGateway', 'skrill_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(65, 17, 'App\\Models\\PaymentGateway', 'phonepe_client_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(66, 17, 'App\\Models\\PaymentGateway', 'phonepe_merchant_user_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(67, 17, 'App\\Models\\PaymentGateway', 'phonepe_key_index', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(68, 17, 'App\\Models\\PaymentGateway', 'phonepe_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(69, 17, 'App\\Models\\PaymentGateway', 'phonepe_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(70, 17, 'App\\Models\\PaymentGateway', 'phonepe_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(71, 18, 'App\\Models\\PaymentGateway', 'telr_store_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(72, 18, 'App\\Models\\PaymentGateway', 'telr_store_auth_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(73, 18, 'App\\Models\\PaymentGateway', 'telr_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(74, 18, 'App\\Models\\PaymentGateway', 'telr_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(75, 19, 'App\\Models\\PaymentGateway', 'iyzico_api_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(76, 19, 'App\\Models\\PaymentGateway', 'iyzico_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(77, 19, 'App\\Models\\PaymentGateway', 'iyzico_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(78, 19, 'App\\Models\\PaymentGateway', 'iyzico_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(79, 20, 'App\\Models\\PaymentGateway', 'pesapal_consumer_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(80, 20, 'App\\Models\\PaymentGateway', 'pesapal_consumer_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(81, 20, 'App\\Models\\PaymentGateway', 'pesapal_ipn_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(82, 20, 'App\\Models\\PaymentGateway', 'pesapal_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(83, 20, 'App\\Models\\PaymentGateway', 'pesapal_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(84, 21, 'App\\Models\\PaymentGateway', 'midtrans_server_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(85, 21, 'App\\Models\\PaymentGateway', 'midtrans_client_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(86, 21, 'App\\Models\\PaymentGateway', 'midtrans_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(87, 21, 'App\\Models\\PaymentGateway', 'midtrans_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(88, 22, 'App\\Models\\PaymentGateway', 'twocheckout_seller_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(89, 22, 'App\\Models\\PaymentGateway', 'twocheckout_secret_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(90, 22, 'App\\Models\\PaymentGateway', 'twocheckout_buy_link_secret_word', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(91, 22, 'App\\Models\\PaymentGateway', 'twocheckout_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(92, 22, 'App\\Models\\PaymentGateway', 'twocheckout_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(93, 23, 'App\\Models\\PaymentGateway', 'myfatoorah_api_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(94, 23, 'App\\Models\\PaymentGateway', 'myfatoorah_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(95, 23, 'App\\Models\\PaymentGateway', 'myfatoorah_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(96, 24, 'App\\Models\\PaymentGateway', 'easypaisa_store_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(97, 24, 'App\\Models\\PaymentGateway', 'easypaisa_hash_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(98, 24, 'App\\Models\\PaymentGateway', 'easypaisa_username', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(99, 24, 'App\\Models\\PaymentGateway', 'easypaisa_password', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(100, 24, 'App\\Models\\PaymentGateway', 'easypaisa_mode', '', 10, '{\"5\":\"sandbox\",\"10\":\"live\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(101, 24, 'App\\Models\\PaymentGateway', 'easypaisa_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(102, 1, 'App\\Models\\SmsGateway', 'twilio_account_sid', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(103, 1, 'App\\Models\\SmsGateway', 'twilio_auth_token', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(104, 1, 'App\\Models\\SmsGateway', 'twilio_from', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(105, 1, 'App\\Models\\SmsGateway', 'twilio_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(106, 2, 'App\\Models\\SmsGateway', 'clickatell_apikey', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(107, 2, 'App\\Models\\SmsGateway', 'clickatell_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(108, 3, 'App\\Models\\SmsGateway', 'nexmo_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(109, 3, 'App\\Models\\SmsGateway', 'nexmo_secret', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(110, 3, 'App\\Models\\SmsGateway', 'nexmo_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(111, 4, 'App\\Models\\SmsGateway', 'msg91_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(112, 4, 'App\\Models\\SmsGateway', 'msg91_sender_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(113, 4, 'App\\Models\\SmsGateway', 'msg91_template_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(114, 4, 'App\\Models\\SmsGateway', 'msg91_template_variable', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(115, 4, 'App\\Models\\SmsGateway', 'msg91_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(116, 5, 'App\\Models\\SmsGateway', 'twofactor_module', 'PROMO_SMS', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(117, 5, 'App\\Models\\SmsGateway', 'twofactor_from', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(118, 5, 'App\\Models\\SmsGateway', 'twofactor_api_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(119, 5, 'App\\Models\\SmsGateway', 'twofactor_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(120, 6, 'App\\Models\\SmsGateway', 'bulksms_username', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(121, 6, 'App\\Models\\SmsGateway', 'bulksms_password', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(122, 6, 'App\\Models\\SmsGateway', 'bulksms_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(123, 7, 'App\\Models\\SmsGateway', 'bulksmsbd_api_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(124, 7, 'App\\Models\\SmsGateway', 'bulksmsbd_sender_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(125, 7, 'App\\Models\\SmsGateway', 'bulksmsbd_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(126, 8, 'App\\Models\\SmsGateway', 'telesign_api_key', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(127, 8, 'App\\Models\\SmsGateway', 'telesign_customer_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(128, 8, 'App\\Models\\SmsGateway', 'telesign_sender_id', '', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(129, 8, 'App\\Models\\SmsGateway', 'telesign_status', '10', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(130, 1, 'App\\Models\\SocialLogin', 'google_client_id', '3032888630-tkt9n4ul08honvbsst07q2klv9044kdb.apps.googleusercontent.com', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-04-23 11:41:16'),
(131, 1, 'App\\Models\\SocialLogin', 'google_client_secret', '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', 5, '\"\"', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-04-23 11:41:16'),
(132, 1, 'App\\Models\\SocialLogin', 'google_status', '5', 10, '{\"5\":\"enable\",\"10\":\"disable\"}', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-04-23 11:41:16');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint UNSIGNED NOT NULL,
  `item_category_id` bigint UNSIGNED NOT NULL,
  `tax_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `caution` longtext COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `price` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `item_type` tinyint NOT NULL DEFAULT '5',
  `order` bigint NOT NULL DEFAULT '1',
  `is_featured` tinyint NOT NULL DEFAULT '5',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `item_category_id`, `tax_id`, `name`, `slug`, `caution`, `description`, `price`, `status`, `item_type`, `order`, `is_featured`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 15, NULL, 'Zesty Lemon Iced Tea', 'zesty-lemon-iced-tea', '', 'Refreshing lemon iced tea.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, '2026-03-24 13:01:46', '2026-03-24 12:57:57', '2026-03-24 13:01:46'),
(2, 15, NULL, 'Peach Breeze Iced Tea', 'peach-breeze-iced-tea', '', 'Smooth peach iced tea.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, '2026-03-24 13:01:45', '2026-03-24 12:57:57', '2026-03-24 13:01:45'),
(3, 21, NULL, 'Iced Coffee Classic', 'iced-coffee-classic', '', 'Classic chilled coffee.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, '2026-03-24 13:01:43', '2026-03-24 12:57:57', '2026-03-24 13:01:43'),
(4, 21, NULL, 'Mocha Iced Coffee', 'mocha-iced-coffee', '', 'Coffee with chocolate blend.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, '2026-03-24 13:01:42', '2026-03-24 12:57:57', '2026-03-24 13:01:42'),
(5, 21, NULL, 'Caramel Latte Iced Coffee', 'caramel-latte-iced-coffee', '', 'Caramel flavored iced coffee.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, '2026-03-24 13:01:40', '2026-03-24 12:57:57', '2026-03-24 13:01:40'),
(6, 15, NULL, 'Masala Tea', 'masala-tea', '', 'Indian spiced tea.', 4.500000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, '2026-03-24 13:01:38', '2026-03-24 12:57:57', '2026-03-24 13:01:38'),
(7, 15, NULL, 'Green Tea', 'green-tea', '', 'Light healthy tea.', 4.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, '2026-03-24 13:01:36', '2026-03-24 12:57:57', '2026-03-24 13:01:36'),
(8, 42, NULL, 'Lychee Shot', 'lychee-shot', 'ggvhubivbnrijvbnrjkwinbvhjkrnvjkbhjvbfhjbfhj\r\nvfvbjbhvrtgfhjvb g\r\nbfbtgtrgrtgr\r\nFGgrtgrtgrtgrtB\r\nfhttrghtrytryr\r\nfjhbhgbvhdbvhuuirbuirnbgbrg', 'Sweet tropical lychee shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-05-12 03:14:18'),
(9, 42, NULL, 'Guava Regular Shot', 'guava-regular-shot', NULL, 'Fresh guava flavor shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:46:08'),
(10, 42, NULL, 'Guava Spicy Shot', 'guava-spicy-shot', NULL, 'Spicy tangy guava shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:45:46'),
(11, 42, NULL, 'Jamun Shot', 'jamun-shot', NULL, 'Rich jamun fruity shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:45:31'),
(12, 42, NULL, 'Strawberry Shot', 'strawberry-shot', NULL, 'Fresh strawberry shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:45:11'),
(13, 42, NULL, 'Kiwi Shot', 'kiwi-shot', NULL, 'Tangy kiwi shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:43:42'),
(14, 42, NULL, 'Paan Shot', 'paan-shot', NULL, 'Refreshing paan flavored shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:42:35'),
(15, 42, NULL, 'Falsa Shot', 'falsa-shot', NULL, 'Classic falsa tangy shot.', 3.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:52:50'),
(16, 48, NULL, 'Classic Mint Mojito', 'classic-mint-mojito', '', 'Refreshing mint mojito.', 6.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-03-24 13:02:27'),
(17, 48, NULL, 'Watermelon Mojito', 'watermelon-mojito', NULL, 'Cool watermelon mojito.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:41:33'),
(18, 48, NULL, 'Green Apple Mojito', 'green-apple-mojito', NULL, 'Tangy apple mojito.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:40:47'),
(19, 48, NULL, 'Strawberry Mojito', 'strawberry-mojito', NULL, 'Sweet strawberry mojito.', 6.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:39:12'),
(20, 48, NULL, 'Tangy Mango Mojito', 'tangy-mango-mojito', NULL, 'Mango citrus mojito.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:38:33'),
(21, 48, NULL, 'Spiced Mint Mojito', 'spiced-mint-mojito', NULL, 'Mint mojito with spice.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:37:46'),
(22, 44, NULL, 'Zesty Lemon Iced Tea', 'zesty-lemon-iced-tea', NULL, 'Refreshing lemon iced tea.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:36:52'),
(23, 44, NULL, 'Peach Breeze Iced Tea', 'peach-breeze-iced-tea', NULL, 'Smooth peach iced tea.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:35:56'),
(24, 45, NULL, 'Mango Juice', 'mango-juice', NULL, 'Fresh mango juice.', 5.500000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:34:11'),
(25, 45, NULL, 'Watermelon Juice', 'watermelon-juice', NULL, 'Hydrating watermelon juice.', 5.500000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:33:32'),
(26, 45, NULL, 'Orange Juice', 'orange-juice', NULL, 'Classic orange juice.', 5.500000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:32:44'),
(27, 45, NULL, 'Pineapple Juice', 'pineapple-juice', NULL, 'Tropical pineapple juice.', 5.500000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:32:12'),
(28, 41, NULL, 'Iced Coffee Classic', 'iced-coffee-classic', NULL, 'Classic chilled coffee.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:51:04'),
(29, 41, NULL, 'Mocha Iced Coffee', 'mocha-iced-coffee', NULL, 'Coffee with chocolate blend.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:31:43'),
(30, 41, NULL, 'Caramel Latte Iced Coffee', 'caramel-latte-iced-coffee', NULL, 'Caramel flavored iced coffee.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:30:26'),
(31, 47, NULL, 'Bluewave Refresher', 'bluewave-refresher', NULL, 'Citrus blue refreshing drink.', 6.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:29:25'),
(32, 47, NULL, 'Tropic Guava Rush', 'tropic-guava-rush', NULL, 'Guava tropical drink.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:28:33'),
(33, 47, NULL, 'Red Ember Cooler', 'red-ember-cooler', NULL, 'Bold refreshing cooler.', 7.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:27:18'),
(34, 47, NULL, 'Masala Citrus Rush', 'masala-citrus-rush', NULL, 'Spicy citrus drink.', 6.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:25:15'),
(35, 47, NULL, 'Classic Lemon Fusion', 'classic-lemon-fusion', NULL, 'Traditional shikanji.', 5.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:24:04'),
(36, 46, NULL, 'Strawberry Bliss Shake', 'strawberry-bliss-shake', NULL, 'Creamy strawberry shake.', 7.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:22:31'),
(37, 46, NULL, 'Golden Mango Bliss Shake', 'golden-mango-bliss-shake', NULL, 'Rich mango shake.', 8.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:21:54'),
(38, 46, NULL, 'Sapota Bliss Shake', 'sapota-bliss-shake', NULL, 'Chiku creamy shake.', 7.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:56:24'),
(39, 46, NULL, 'Kaju Anjir Shake', 'kaju-anjir-shake', NULL, 'Cashew fig premium shake.', 9.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:20:04'),
(40, 40, NULL, 'KitKat Milkshake', 'kitkat-milkshake', NULL, 'Chocolate with KitKat crunch.', 8.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:18:35'),
(41, 40, NULL, 'Nutella Milkshake', 'nutella-milkshake', NULL, 'Rich Nutella shake.', 8.000000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:16:56'),
(42, 40, NULL, 'Chocolate Brownie Milkshake', 'chocolate-brownie-milkshake', NULL, 'Brownie blended shake.', 8.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:14:33'),
(43, 43, NULL, 'Hot Chocolate Classic', 'hot-chocolate-classic', NULL, 'Warm chocolate drink.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:54:33'),
(44, 43, NULL, 'Hot Latte Coffee', 'hot-latte-coffee', NULL, 'Smooth hot latte.', 5.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:10:37'),
(45, 44, NULL, 'Masala Tea', 'masala-tea', NULL, 'Indian spiced tea.', 4.500000, 5, 5, 1, 5, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-04-22 05:09:09'),
(46, 44, NULL, 'Green Tea', 'green-tea', 'this is test cautionthis is test cautionthis is test cautionthis is test cautionthis is test caution', 'Light healthy tea.', 4.000000, 5, 5, 1, 10, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:02:27', '2026-05-13 02:24:09');

-- --------------------------------------------------------

--
-- Table structure for table `item_addons`
--

CREATE TABLE `item_addons` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `addon_item_id` bigint UNSIGNED NOT NULL,
  `addon_item_variation` json DEFAULT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_attributes`
--

CREATE TABLE `item_attributes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_attributes`
--

INSERT INTO `item_attributes` (`id`, `name`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'juice', 5, NULL, NULL, NULL, NULL, '2026-05-12 05:51:16', '2026-05-12 05:51:16');

-- --------------------------------------------------------

--
-- Table structure for table `item_categories`
--

CREATE TABLE `item_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `sort` bigint UNSIGNED NOT NULL DEFAULT '1',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_categories`
--

INSERT INTO `item_categories` (`id`, `name`, `slug`, `description`, `status`, `sort`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(40, 'Chocolate Shakes', 'chocolate-shakes', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:37:25'),
(41, 'Coffee', 'coffee', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-05-11 06:06:40'),
(42, 'Fruit Shots', 'fruit-shots', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:42:47'),
(43, 'Hot Drinks', 'hot-drinks', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:58:29'),
(44, 'Iced Tea', 'iced-tea', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:45:26'),
(45, 'Juices', 'juices', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:46:55'),
(46, 'Milkshakes', 'milkshakes', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:47:42'),
(47, 'Mocktails', 'mocktails', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 04:48:12'),
(48, 'Mojitos', 'mojitos', '', 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-03-24 13:02:10'),
(49, 'Tea', 'tea', NULL, 5, 1, NULL, NULL, NULL, NULL, '2026-03-24 13:02:10', '2026-04-22 05:00:35');

-- --------------------------------------------------------

--
-- Table structure for table `item_extras`
--

CREATE TABLE `item_extras` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(19,6) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_variations`
--

CREATE TABLE `item_variations` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `item_attribute_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `caution` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kiosk_machines`
--

CREATE TABLE `kiosk_machines` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `machine_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_login` tinyint DEFAULT '10',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_mode` tinyint UNSIGNED NOT NULL DEFAULT '5',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `display_mode`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 5, 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'German', 'de', 5, 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `generated_conversions`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\PaymentGateway', 1, '09b64460-9adb-4c50-819d-b2b077eb0ff4', 'payment-gateway', 'cash-on-delivery', 'cash-on-delivery.png', 'image/png', 'public', 'public', 3437, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'App\\Models\\PaymentGateway', 2, '2680e4c8-6823-468d-a516-def5fc8544ee', 'payment-gateway', 'credit', 'credit.png', 'image/png', 'public', 'public', 3885, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'App\\Models\\PaymentGateway', 3, '2735ca4d-fd6c-4f07-8582-e40d84416240', 'payment-gateway', 'paypal', 'paypal.png', 'image/png', 'public', 'public', 3809, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 'App\\Models\\PaymentGateway', 4, '9c98a0bb-1d65-4e19-a9b8-114325755722', 'payment-gateway', 'stripe', 'stripe.png', 'image/png', 'public', 'public', 3635, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, 'App\\Models\\PaymentGateway', 5, 'ea652917-3534-4cf8-b0e5-af426ba86d22', 'payment-gateway', 'flutterwave', 'flutterwave.png', 'image/png', 'public', 'public', 5191, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 'App\\Models\\PaymentGateway', 6, 'f8fc08cf-028e-4d69-8789-00b9a8352c1c', 'payment-gateway', 'paystack', 'paystack.png', 'image/png', 'public', 'public', 4195, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 'App\\Models\\PaymentGateway', 7, '3e37af77-5253-4965-bf41-9f65fe676864', 'payment-gateway', 'sslcommerz', 'sslcommerz.png', 'image/png', 'public', 'public', 4546, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 'App\\Models\\PaymentGateway', 8, '9c858c99-373a-4386-a4e6-bba81ef274b1', 'payment-gateway', 'mollie', 'mollie.png', 'image/png', 'public', 'public', 8116, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(9, 'App\\Models\\PaymentGateway', 9, 'f2f47479-f3b7-4058-864e-e112791fa9d4', 'payment-gateway', 'senangpay', 'senangpay.png', 'image/png', 'public', 'public', 6541, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(10, 'App\\Models\\PaymentGateway', 10, '4f640cf1-254e-41fb-a01b-14a764bcbb89', 'payment-gateway', 'bkash', 'bkash.png', 'image/png', 'public', 'public', 5282, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(11, 'App\\Models\\PaymentGateway', 11, 'd11fe712-7e7c-4631-b69f-cc7a1dd5af29', 'payment-gateway', 'paytm', 'paytm.png', 'image/png', 'public', 'public', 3285, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(12, 'App\\Models\\PaymentGateway', 12, '58928db3-85d7-449f-8fcc-ae547d05d8e5', 'payment-gateway', 'razorpay', 'razorpay.png', 'image/png', 'public', 'public', 4847, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(13, 'App\\Models\\PaymentGateway', 13, '743c2001-f67d-4b61-bf62-ac632b22be15', 'payment-gateway', 'mercadopago', 'mercadopago.png', 'image/png', 'public', 'public', 11423, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(14, 'App\\Models\\PaymentGateway', 14, '894b6ccc-de76-435e-8a63-1510bd58d9f0', 'payment-gateway', 'cashfree', 'cashfree.png', 'image/png', 'public', 'public', 4940, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(15, 'App\\Models\\PaymentGateway', 15, 'b0189cd0-a13c-4980-98be-9ed780d80b13', 'payment-gateway', 'payfast', 'payfast.png', 'image/png', 'public', 'public', 2173, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(16, 'App\\Models\\PaymentGateway', 16, 'e314e343-bad1-4675-a92b-c399de70f0bf', 'payment-gateway', 'skrill', 'skrill.png', 'image/png', 'public', 'public', 7074, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(17, 'App\\Models\\PaymentGateway', 17, 'e953420b-cc9f-49b9-8666-ed0beae5c8d6', 'payment-gateway', 'phonepe', 'phonepe.png', 'image/png', 'public', 'public', 4417, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(18, 'App\\Models\\PaymentGateway', 18, 'caee6909-b91a-4ee1-b198-e597d2292f15', 'payment-gateway', 'telr', 'telr.png', 'image/png', 'public', 'public', 7594, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(19, 'App\\Models\\PaymentGateway', 19, '10564d68-9f2f-4a20-93f8-a8645d35dd8c', 'payment-gateway', 'iyzico', 'iyzico.png', 'image/png', 'public', 'public', 7652, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(20, 'App\\Models\\PaymentGateway', 20, '766c516b-f668-470d-b794-33de5e472260', 'payment-gateway', 'pesapal', 'pesapal.png', 'image/png', 'public', 'public', 9373, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(21, 'App\\Models\\PaymentGateway', 21, '674fc26a-8b40-45bd-a0c5-377ef70ba02b', 'payment-gateway', 'midtrans', 'midtrans.png', 'image/png', 'public', 'public', 5877, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(22, 'App\\Models\\PaymentGateway', 22, 'eaa94444-20c3-4940-b146-8bffebcc378a', 'payment-gateway', 'twocheckout', 'twocheckout.png', 'image/png', 'public', 'public', 4063, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(23, 'App\\Models\\PaymentGateway', 23, '7d30ffd3-0327-4fd2-91d8-c5f482bc182e', 'payment-gateway', 'myfatoorah', 'myfatoorah.png', 'image/png', 'public', 'public', 5411, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(24, 'App\\Models\\PaymentGateway', 24, '165d47cc-99c1-44ed-a277-f7f54a039349', 'payment-gateway', 'easypaisa', 'easypaisa.png', 'image/png', 'public', 'public', 11255, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(25, 'App\\Models\\SocialLogin', 1, '54b9c3e3-34f1-4ed4-80c8-e9a32491a1cc', 'social-login', 'google', 'google.png', 'image/png', 'public', 'public', 9062, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(26, 'App\\Models\\Language', 1, '59c6916b-204c-4629-8933-9228ce243269', 'language', 'english', 'english.png', 'image/png', 'public', 'public', 1149, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(28, 'App\\Models\\Language', 3, 'e829aec4-deaf-4449-9b48-b7cde834d848', 'language', 'german', 'german.png', 'image/png', 'public', 'public', 1835, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(30, 'App\\Models\\ThemeSetting', 61, '424ed038-8e25-44ce-99a2-9d81a3eb9f16', 'theme-logo', 'kahumbo logo. 2', 'kahumbo-logo.-2.png', 'image/png', 'public', 'public', 120098, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:26:22', '2026-03-24 18:26:22'),
(31, 'App\\Models\\ThemeSetting', 62, '30ebe4dd-685b-42b8-92f3-5026ee7642e4', 'theme-favicon-logo', 'kahumbo logo (1)', 'kahumbo-logo-(1).png', 'image/png', 'public', 'public', 157125, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:26:22', '2026-03-24 18:26:22'),
(32, 'App\\Models\\ThemeSetting', 63, 'f180ff5e-9f0a-4b1f-ab1d-8f7e9606324f', 'theme-footer-logo', 'kahumbo logo white', 'kahumbo-logo-white.png', 'image/png', 'public', 'public', 290374, '[]', '[]', '[]', '[]', 1, '2026-03-24 18:26:22', '2026-03-24 18:26:22'),
(33, 'App\\Models\\User', 1, 'b3b757cf-6345-44f7-bbee-b006a30d509b', 'profile', 'IMG_1625.JPG', 'IMG_1625.JPG.jpeg', 'image/jpeg', 'public', 'public', 204414, '[]', '[]', '[]', '[]', 1, '2026-03-24 13:04:39', '2026-03-24 13:04:39'),
(34, 'App\\Models\\Slider', 1, '607818cd-b4e0-41be-8d38-264ab05fc396', 'slider', 'slide-0', 'slide-0.jpg', 'image/jpeg', 'public', 'public', 185506, '[]', '[]', '{\"cover\": true}', '[]', 1, '2026-03-24 13:20:33', '2026-03-24 13:20:33'),
(35, 'App\\Models\\Slider', 2, 'f26030c3-abaa-46b2-be04-587e4322f8e3', 'slider', 'slide-1', 'slide-1.jpg', 'image/jpeg', 'public', 'public', 183352, '[]', '[]', '{\"cover\": true}', '[]', 1, '2026-03-24 13:21:00', '2026-03-24 13:21:00'),
(36, 'App\\Models\\Slider', 3, '1da0b8a9-43eb-4712-b360-15a8f9273898', 'slider', 'slider-03', 'slider-03.jpg', 'image/jpeg', 'public', 'public', 280311, '[]', '[]', '{\"cover\": true}', '[]', 1, '2026-03-24 13:22:31', '2026-03-24 13:22:31'),
(37, 'App\\Models\\MessageHistory', 2, 'c161fe32-e172-46f8-991a-10b1f2632ecf', 'message', 'Gemini_Generated_Image_kq6dqlkq6dqlkq6d', 'Gemini_Generated_Image_kq6dqlkq6dqlkq6d.png', 'image/png', 'public', 'public', 1851574, '[]', '[]', '[]', '[]', 1, '2026-04-10 02:58:07', '2026-04-10 02:58:07'),
(42, 'App\\Models\\ItemCategory', 44, '573be0b8-29c5-4c0f-a8aa-35ec8357d332', 'item-category', 'Lemon-Ice-Tea-1', 'Lemon-Ice-Tea-1.jpg', 'image/jpeg', 'public', 'public', 14240, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-04-22 04:45:26', '2026-04-22 04:45:26'),
(43, 'App\\Models\\ItemCategory', 45, 'da830bcf-7975-460e-8903-3c4558979d6c', 'item-category', 'Strawberry-Juice', 'Strawberry-Juice.jpg', 'image/jpeg', 'public', 'public', 8824, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-04-22 04:46:55', '2026-04-22 04:46:55'),
(44, 'App\\Models\\ItemCategory', 46, '5b089c10-e91c-443d-aa5d-15e147614419', 'item-category', 'hoptionb-img7', 'hoptionb-img7.png', 'image/png', 'public', 'public', 26145, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-04-22 04:47:42', '2026-04-22 04:47:42'),
(45, 'App\\Models\\ItemCategory', 47, '1d8b4607-73cb-4830-8e99-68bda93a044f', 'item-category', 'Unique-Mocktails', 'Unique-Mocktails.png', 'image/png', 'public', 'public', 25505, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-04-22 04:48:12', '2026-04-22 04:48:12'),
(47, 'App\\Models\\ItemCategory', 43, 'd5ec1905-f8d2-44f4-a537-ea74350b36b7', 'item-category', 'Please provide the original Pinterest title you want me to reformat_', 'Please-provide-the-original-Pinterest-title-you-want-me-to-reformat_.jpg', 'image/jpeg', 'public', 'public', 52296, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-04-22 05:00:24', '2026-04-22 05:00:24'),
(48, 'App\\Models\\ItemCategory', 49, '34903026-0136-454b-a1d5-8537921b3506', 'item-category', 'Capture', 'Capture.JPG', 'image/jpeg', 'public', 'public', 24994, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-04-22 05:00:35', '2026-04-22 05:00:35'),
(51, 'App\\Models\\Item', 44, '1dae755f-76e5-4653-a648-ae20e1229a80', 'item', 'Cappuccino', 'Cappuccino.jpg', 'image/jpeg', 'public', 'public', 60678, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:10:37', '2026-04-22 05:10:37'),
(54, 'App\\Models\\Item', 40, '326b119b-066d-4b2e-b82d-ea32586a0e14', 'item', 'kit kat shake', 'kit-kat-shake.jpg', 'image/jpeg', 'public', 'public', 60539, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:18:35', '2026-04-22 05:18:35'),
(55, 'App\\Models\\Item', 39, 'd79acbb8-c30d-47b9-b469-a6facd17c889', 'item', 'download (1)', 'download-(1).jpg', 'image/jpeg', 'public', 'public', 70146, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:20:04', '2026-04-22 05:20:05'),
(58, 'App\\Models\\Item', 35, 'fcbd1ea4-37bd-4efe-8b33-776df315ca69', 'item', 'Sparkling Limoncello Mocktail', 'Sparkling-Limoncello-Mocktail.jpg', 'image/jpeg', 'public', 'public', 94457, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:24:04', '2026-04-22 05:24:04'),
(59, 'App\\Models\\Item', 34, '7f002e57-1da5-436b-9cc8-9cf138793526', 'item', 'Sugar Free Mocktails_ 10 Guilt-Free & Refreshing Recipes', 'Sugar-Free-Mocktails_-10-Guilt-Free-&-Refreshing-Recipes.jpg', 'image/jpeg', 'public', 'public', 89633, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:25:15', '2026-04-22 05:25:15'),
(60, 'App\\Models\\Item', 33, '61bab1e3-b8b8-46ba-9b40-0a7ba69f76e0', 'item', 'Cranberry Mocktail Spritzer (Festive, Bubbly, & Fun!)', 'Cranberry-Mocktail-Spritzer-(Festive,-Bubbly,-&-Fun!).jpg', 'image/jpeg', 'public', 'public', 66896, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:27:18', '2026-04-22 05:27:18'),
(61, 'App\\Models\\Item', 32, '34b61d88-aeb2-4103-8334-b54c96293b52', 'item', '35 Easy Summer Mocktails Non-Alcoholic Recipes', '35-Easy-Summer-Mocktails-Non-Alcoholic-Recipes.jpg', 'image/jpeg', 'public', 'public', 66590, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:28:33', '2026-04-22 05:28:34'),
(62, 'App\\Models\\Item', 31, '55412b5c-41e4-4d50-9d7c-de8764c95a99', 'item', 'download (2)', 'download-(2).jpg', 'image/jpeg', 'public', 'public', 101992, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:29:25', '2026-04-22 05:29:26'),
(63, 'App\\Models\\Item', 30, '1876473e-e533-48b5-a03b-d7c3ac5a1f8e', 'item', '🧋Iced Caramel Latte – 5-Minute Authentic & Delicious Recipe', '🧋Iced-Caramel-Latte-–-5-Minute-Authentic-&-Delicious-Recipe.jpg', 'image/jpeg', 'public', 'public', 57713, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:30:26', '2026-04-22 05:30:27'),
(64, 'App\\Models\\Item', 29, 'c5bfe253-5b5e-4eea-8490-35522b86053d', 'item', 'Mocha Iced Americano That’ll Cool You Off Instantly ☕❄️', 'Mocha-Iced-Americano-That’ll-Cool-You-Off-Instantly-☕❄️.jpg', 'image/jpeg', 'public', 'public', 100525, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:31:43', '2026-04-22 05:31:43'),
(65, 'App\\Models\\Item', 27, '16094578-8ecf-4341-84f3-7618ab224735', 'item', 'Pineapple-Juice', 'Pineapple-Juice.jpg', 'image/jpeg', 'public', 'public', 9101, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:32:12', '2026-04-22 05:32:13'),
(66, 'App\\Models\\Item', 26, '2de88038-e43b-423c-ae50-19ad6133f77a', 'item', 'Orange-Juice-1', 'Orange-Juice-1.jpg', 'image/jpeg', 'public', 'public', 11286, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:32:44', '2026-04-22 05:32:44'),
(67, 'App\\Models\\Item', 25, 'd320e04b-0547-4d77-b898-eaa202e58d6b', 'item', 'Drinks For Refreshment', 'Drinks-For-Refreshment.jpg', 'image/jpeg', 'public', 'public', 84522, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:33:32', '2026-04-22 05:33:33'),
(68, 'App\\Models\\Item', 24, 'e6b58988-624f-433b-a14d-2fa663c8983a', 'item', 'MANGO FROOTI RECIPE, HOMEMADE MANGO FROOTI RECIPE WITH STEP BY STEP PHOTOS , HOW TO MANGO FROOTI AT HOME , HOMEMADE MANGO SQUASH', 'MANGO-FROOTI-RECIPE,-HOMEMADE-MANGO-FROOTI-RECIPE-WITH-STEP-BY-STEP-PHOTOS-,-HOW-TO-MANGO-FROOTI-AT-HOME-,-HOMEMADE-MANGO-SQUASH.jpg', 'image/jpeg', 'public', 'public', 48769, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:34:11', '2026-04-22 05:34:11'),
(69, 'App\\Models\\Item', 24, '6a06c204-8320-4949-b9ab-30d780a76330', 'item', 'MANGO FROOTI RECIPE, HOMEMADE MANGO FROOTI RECIPE WITH STEP BY STEP PHOTOS , HOW TO MANGO FROOTI AT HOME , HOMEMADE MANGO SQUASH', 'MANGO-FROOTI-RECIPE,-HOMEMADE-MANGO-FROOTI-RECIPE-WITH-STEP-BY-STEP-PHOTOS-,-HOW-TO-MANGO-FROOTI-AT-HOME-,-HOMEMADE-MANGO-SQUASH.jpg', 'image/jpeg', 'public', 'public', 48769, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 2, '2026-04-22 05:34:33', '2026-04-22 05:34:33'),
(70, 'App\\Models\\Item', 23, '95ea65af-5f77-416f-8317-2c436d41efee', 'item', 'Spiked Peach Iced Tea_ Sweet tea with a boozy kick_', 'Spiked-Peach-Iced-Tea_-Sweet-tea-with-a-boozy-kick_.jpg', 'image/jpeg', 'public', 'public', 74412, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:35:56', '2026-04-22 05:35:57'),
(71, 'App\\Models\\Item', 22, '3175ca93-b0df-4fcc-a3c1-d33a0ff728c6', 'item', 'Master Kong Lemon Iced Tea Drink, 500ml', 'Master-Kong-Lemon-Iced-Tea-Drink,-500ml.jpg', 'image/jpeg', 'public', 'public', 77980, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:36:52', '2026-04-22 05:36:53'),
(72, 'App\\Models\\Item', 21, '22f306af-12af-4663-9902-b36dd293ebc0', 'item', 'download (3)', 'download-(3).jpg', 'image/jpeg', 'public', 'public', 102886, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:37:46', '2026-04-22 05:37:46'),
(73, 'App\\Models\\Item', 20, '6c2b17d0-e86f-4bd5-ba2c-871f022e449b', 'item', 'Green Mango & Mint Mocktail_ Tropical Vibes Only', 'Green-Mango-&-Mint-Mocktail_-Tropical-Vibes-Only.jpg', 'image/jpeg', 'public', 'public', 77121, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:38:33', '2026-04-22 05:38:33'),
(76, 'App\\Models\\Item', 18, '1d2a1339-397a-4b6c-b965-4d72379ed5dd', 'item', 'Green Apple Sparkler Recipe 🍏✨', 'Green-Apple-Sparkler-Recipe-🍏✨.jpg', 'image/jpeg', 'public', 'public', 63847, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:40:47', '2026-04-22 05:40:47'),
(77, 'App\\Models\\Item', 17, '1e63b9a6-e947-483d-8205-e7afc35c5a6d', 'item', 'Watermelon Mint Mojito Mocktail _ Refreshing Summer Drink', 'Watermelon-Mint-Mojito-Mocktail-_-Refreshing-Summer-Drink.jpg', 'image/jpeg', 'public', 'public', 83353, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:41:33', '2026-04-22 05:41:33'),
(78, 'App\\Models\\Item', 14, '065bc95e-df85-4466-aec2-826f2dd16bed', 'item', 'Paan-Shot', 'Paan-Shot.jpg', 'image/jpeg', 'public', 'public', 23937, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:42:35', '2026-04-22 05:42:36'),
(79, 'App\\Models\\Item', 13, 'b151eb7f-1c0f-4201-a386-f3c3ddeda200', 'item', 'Delicious Kiwi Caipirinha Drink', 'Delicious-Kiwi-Caipirinha-Drink.jpg', 'image/jpeg', 'public', 'public', 64586, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:43:42', '2026-04-22 05:43:42'),
(80, 'App\\Models\\Item', 12, '6dd04a1a-ddf2-496c-9c31-3afdacd9fb01', 'item', 'Strawberry Dirty Sprite _ A Sweet Summer Sip - recipezed', 'Strawberry-Dirty-Sprite-_-A-Sweet-Summer-Sip---recipezed.jpg', 'image/jpeg', 'public', 'public', 96087, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:45:11', '2026-04-22 05:45:11'),
(81, 'App\\Models\\Item', 11, '9dc8a7a2-fe6c-4b49-adef-788328795acc', 'item', 'Jamun-Shot (1)', 'Jamun-Shot-(1).jpg', 'image/jpeg', 'public', 'public', 22192, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:45:31', '2026-04-22 05:45:31'),
(82, 'App\\Models\\Item', 10, 'e574cbb1-e23b-4503-a54a-cb2b42152837', 'item', 'Guava-Spicy-Shot', 'Guava-Spicy-Shot.jpg', 'image/jpeg', 'public', 'public', 22242, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:45:46', '2026-04-22 05:45:46'),
(83, 'App\\Models\\Item', 9, '1856666c-7509-4f94-a2ee-86a58b81371b', 'item', 'Guava-Spicy-Shot', 'Guava-Spicy-Shot.jpg', 'image/jpeg', 'public', 'public', 22242, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:46:08', '2026-04-22 05:46:08'),
(84, 'App\\Models\\Item', 8, 'da273c74-fbf6-4309-a7f6-a9717568325b', 'item', 'Sakura Lychee Fizz _ Sift & Simmer', 'Sakura-Lychee-Fizz-_-Sift-&-Simmer.jpg', 'image/jpeg', 'public', 'public', 47539, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:48:21', '2026-04-22 05:48:22'),
(85, 'App\\Models\\Item', 28, 'effae69e-0dee-42a0-840e-ef04ed77f17e', 'item', '🥤 Iced Caramel Coffee at Home (Better Than Starbucks!)', '🥤-Iced-Caramel-Coffee-at-Home-(Better-Than-Starbucks!).jpg', 'image/jpeg', 'public', 'public', 117643, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:51:04', '2026-04-22 05:51:04'),
(86, 'App\\Models\\Item', 15, 'f25e0ead-59e3-4aa4-982f-42a29aff3956', 'item', 'Falsa Sharbat I How To make Phalse Ka Sharbat +video', 'Falsa-Sharbat-I-How-To-make-Phalse-Ka-Sharbat-+video.jpg', 'image/jpeg', 'public', 'public', 86567, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:52:50', '2026-04-22 05:52:50'),
(87, 'App\\Models\\Item', 43, 'e0d19ec4-a21b-4875-9d20-9b87d648adc4', 'item', 'Rich Hot Chocolate_ The Ultimate Homemade Winter Treat', 'Rich-Hot-Chocolate_-The-Ultimate-Homemade-Winter-Treat.jpg', 'image/jpeg', 'public', 'public', 54497, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:54:33', '2026-04-22 05:54:33'),
(88, 'App\\Models\\Item', 38, '6b69ba04-591b-4aee-af32-67118f321ace', 'item', 'download (4)', 'download-(4).jpg', 'image/jpeg', 'public', 'public', 85032, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-04-22 05:56:24', '2026-04-22 05:56:25'),
(89, 'App\\Models\\NotificationSetting', 58, 'd452121a-dbce-414d-823c-0ab62196e2c3', 'notification-file', 'firebase-web', 'service-account-file.json', 'application/json', 'public', 'public', 330, '[]', '[]', '[]', '[]', 1, '2026-04-23 10:43:22', '2026-04-23 10:43:22'),
(91, 'App\\Models\\Page', 2, '15e289e6-d3a1-4b2d-a31b-f422d1424155', 'page-image', 'kahumbo-customerapp', 'kahumbo-customerapp.png', 'image/png', 'public', 'public', 55480, '[]', '[]', '[]', '[]', 1, '2026-04-24 02:19:29', '2026-04-24 02:19:29'),
(92, 'App\\Models\\Page', 3, 'd2e78f0a-a93b-4816-a65d-2b0412e6981a', 'page-image', 'kahumbo-customerapp', 'kahumbo-customerapp.png', 'image/png', 'public', 'public', 55480, '[]', '[]', '[]', '[]', 1, '2026-04-24 02:19:52', '2026-04-24 02:19:52'),
(93, 'App\\Models\\Page', 1, 'bd8c1425-a074-4f49-8ed3-3a223e63655d', 'page-image', 'kahumbo-customerapp', 'kahumbo-customerapp.png', 'image/png', 'public', 'public', 55480, '[]', '[]', '[]', '[]', 1, '2026-04-24 02:20:10', '2026-04-24 02:20:10'),
(94, 'App\\Models\\Page', 4, '0dcbecd4-0abe-4218-b724-6a1edb299eab', 'page-image', 'kahumbo-customerapp', 'kahumbo-customerapp.png', 'image/png', 'public', 'public', 55480, '[]', '[]', '[]', '[]', 1, '2026-04-24 07:02:22', '2026-04-24 07:02:22'),
(95, 'App\\Models\\Page', 5, '45fe548b-ecc1-44e9-8908-9d87d92329c5', 'page-image', 'kahumbo-customerapp', 'kahumbo-customerapp.png', 'image/png', 'public', 'public', 55480, '[]', '[]', '[]', '[]', 1, '2026-04-24 07:03:10', '2026-04-24 07:03:10'),
(96, 'App\\Models\\Item', 37, 'f05938bf-8d87-49cf-b5f3-45640851d334', 'item', 'golden mango bliss', 'golden-mango-bliss.png', 'image/png', 'public', 'public', 1700354, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:15:23', '2026-05-11 05:15:24'),
(97, 'App\\Models\\Item', 41, '1e84f1f5-555c-4872-a805-cce4511f4277', 'item', 'nutella milkshae', 'nutella-milkshae.png', 'image/png', 'public', 'public', 1900728, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:20:53', '2026-05-11 05:20:54'),
(98, 'App\\Models\\Item', 36, 'be3a19c1-2579-4d90-a04c-aaba0e25a888', 'item', 'strawverry bliss', 'strawverry-bliss.png', 'image/png', 'public', 'public', 1694015, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:24:48', '2026-05-11 05:24:48'),
(99, 'App\\Models\\Item', 42, '55b136f3-bf74-49a5-a8bf-e295f6ef6e93', 'item', 'choco brownie', 'choco-brownie.png', 'image/png', 'public', 'public', 2084693, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:32:31', '2026-05-11 05:32:32'),
(100, 'App\\Models\\Item', 19, '0caad559-c680-42dc-8e9a-f149cec31576', 'item', 'strawberry mojito', 'strawberry-mojito.png', 'image/png', 'public', 'public', 2060482, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:41:30', '2026-05-11 05:41:31'),
(101, 'App\\Models\\Item', 46, 'b709ccfd-3bd6-4a4c-bd72-2838d715ebb1', 'item', 'green tea', 'green-tea.png', 'image/png', 'public', 'public', 1862733, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:42:06', '2026-05-11 05:42:07'),
(102, 'App\\Models\\Item', 45, 'b5feda7f-6a12-459a-8cd2-6df6d5a22525', 'item', 'masala tea', 'masala-tea.png', 'image/png', 'public', 'public', 2067325, '[]', '[]', '{\"cover\": true, \"thumb\": true, \"preview\": true}', '[]', 1, '2026-05-11 05:52:22', '2026-05-11 05:52:23'),
(103, 'App\\Models\\ItemCategory', 40, 'faacb809-b085-4c35-ac64-367774013de8', 'item-category', 'chocolate shakes', 'chocolate-shakes.png', 'image/png', 'public', 'public', 1792970, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-05-11 06:02:41', '2026-05-11 06:02:42'),
(104, 'App\\Models\\ItemCategory', 41, '83152b43-ef6d-4654-bdd4-8bee132f1d53', 'item-category', 'coffee', 'coffee.png', 'image/png', 'public', 'public', 1889681, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-05-11 06:04:29', '2026-05-11 06:04:29'),
(105, 'App\\Models\\ItemCategory', 42, 'add39128-93bf-471f-b88b-a749d9c5e0f8', 'item-category', 'fruit shots', 'fruit-shots.png', 'image/png', 'public', 'public', 1682633, '[]', '[]', '{\"cover\": true, \"thumb\": true}', '[]', 1, '2026-05-11 06:15:56', '2026-05-11 06:15:56'),
(106, 'App\\Models\\Coupon', 1, 'a69408b0-374d-4c9e-b850-135baf934c0f', 'coupon', 'jamun bg', 'jamun-bg.png', 'image/png', 'public', 'public', 1939356, '[]', '[]', '[]', '[]', 1, '2026-05-11 07:57:57', '2026-05-11 07:57:57'),
(107, 'App\\Models\\Offer', 1, '7cea8da9-f506-4dd0-ade6-095a3850cb4e', 'offer', 'strawverry bliss', 'strawverry-bliss.png', 'image/png', 'public', 'public', 1694015, '[]', '[]', '{\"cover\": true}', '[]', 1, '2026-05-11 07:58:58', '2026-05-11 07:58:58'),
(108, 'App\\Models\\Coupon', 2, 'debf8c5a-f28b-4511-bcaf-532def4d6d55', 'coupon', 'jamun bg', 'jamun-bg.png', 'image/png', 'public', 'public', 1939356, '[]', '[]', '[]', '[]', 1, '2026-05-11 08:07:58', '2026-05-11 08:07:58'),
(109, 'App\\Models\\Offer', 2, '969a1eef-ede5-4057-8bd5-3173610d67f7', 'offer', 'fruit shots', 'fruit-shots.png', 'image/png', 'public', 'public', 1682633, '[]', '[]', '{\"cover\": true}', '[]', 1, '2026-05-11 08:09:47', '2026-05-11 08:09:47');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `parent` int UNSIGNED NOT NULL DEFAULT '0',
  `type` int UNSIGNED NOT NULL DEFAULT '1',
  `priority` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `language`, `url`, `icon`, `status`, `parent`, `type`, `priority`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', 'dashboard', 'dashboard', 'lab lab-dashboard', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'Items', 'items', 'items', 'lab lab-items', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'Dining Tables', 'dining_tables', 'dining-tables', 'lab lab-dining-table', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 'Pos & Orders', 'pos_and_orders', '#', 'lab lab-pos', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, 'POS', 'pos', 'pos', 'lab lab-pos', 1, 4, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 'POS Orders', 'pos_orders', 'pos-orders', 'lab lab-pos-orders', 1, 4, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 'Online Orders', 'online_orders', 'online-orders', 'lab lab-online-orders', 1, 4, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 'Table Orders', 'table_orders', 'table-orders', 'lab lab-reserve-line', 1, 4, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(9, 'K.D.S', 'k_d_s', 'kitchen-display-system', 'lab lab-kds', 1, 4, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(10, 'O.S.S', 'o_s_s', 'order-status-screen', 'lab lab-cds', 1, 4, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(11, 'Promo', 'promo', '#', 'lab ', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(12, 'Coupons', 'coupons', 'coupons', 'lab lab-coupons', 1, 11, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(13, 'Offers', 'offers', 'offers', 'lab lab-offers', 1, 11, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(14, 'Communications', 'communications', '#', 'lab ', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(15, 'Push Notifications', 'push_notifications', 'push-notifications', 'lab lab-push-notification', 1, 14, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(16, 'Messages', 'messages', 'messages', 'lab lab-messages', 1, 14, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(17, 'Subscribers', 'subscribers', 'subscribers', 'lab lab-subscribers', 1, 14, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(18, 'Users', 'users', '#', 'lab ', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(19, 'Administrators', 'administrators', 'administrators', 'lab lab-administrators', 1, 18, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(20, 'Delivery Boys', 'delivery_boys', 'delivery-boys', 'lab lab-delivery-boys', 1, 18, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(21, 'Customers', 'customers', 'customers', 'lab lab-customers', 1, 18, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(22, 'Employees', 'employees', 'employees', 'lab lab-employee-2', 1, 18, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(23, 'Waiters', 'waiters', 'waiters', 'lab lab-waiter', 1, 18, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(24, 'Chef', 'chefs', 'chefs', 'lab lab-chef', 1, 18, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(25, 'Accounts', 'accounts', '#', 'lab ', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(26, 'Transactions', 'transactions', 'transactions', 'lab lab-transactions', 1, 25, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(27, 'Reports', 'reports', '#', 'lab ', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(28, 'Sales Report', 'sales_report', 'sales-report', 'lab lab-sales-report', 1, 27, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(29, 'Items Report', 'items_report', 'items-report', 'lab lab-items-report', 1, 27, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(30, 'Credit Balance Report', 'credit_balance_report', 'credit-balance-report', 'lab lab-credit-balance-report', 1, 27, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(31, 'Setup', 'setup', '#', 'lab ', 1, 0, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(32, 'Settings', 'settings', 'settings', 'lab lab-settings', 1, 31, 1, 100, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `menu_sections`
--

CREATE TABLE `menu_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_sections`
--

INSERT INTO `menu_sections` (`id`, `name`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Header Section', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'Footer Section', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `menu_templates`
--

CREATE TABLE `menu_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_templates`
--

INSERT INTO `menu_templates` (`id`, `name`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Contact Us', NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `branch_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 8, '2026-04-10 02:57:36', '2026-04-10 02:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `message_histories`
--

CREATE TABLE `message_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `message_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `text` longtext COLLATE utf8mb4_unicode_ci,
  `is_read` tinyint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `message_histories`
--

INSERT INTO `message_histories` (`id`, `message_id`, `user_id`, `text`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 'delivery is not working, what is this service', 10, '2026-04-10 02:57:36', '2026-04-10 02:57:36'),
(2, 1, 8, NULL, 10, '2026-04-10 02:58:07', '2026-04-10 02:58:07');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2014_10_12_000000_create_users_table', 1),
(4, '2014_10_12_100000_create_password_resets_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2020_09_10_080029_create_menus_table', 1),
(7, '2022_05_01_142407_create_permission_tables', 1),
(8, '2022_05_24_204620_create_settings_table', 1),
(9, '2022_05_25_124629_create_currencies_table', 1),
(10, '2022_06_26_055545_create_default_access_table', 1),
(11, '2022_08_10_143500_create_media_table', 1),
(12, '2022_11_10_075751_create_subscribers_table', 1),
(13, '2022_11_17_110125_create_branches_table', 1),
(14, '2022_11_17_110157_create_languages_table', 1),
(15, '2022_11_17_110300_create_addresses_table', 1),
(16, '2022_11_17_110319_create_sliders_table', 1),
(17, '2022_11_17_110428_create_item_categories_table', 1),
(18, '2022_11_17_110455_create_offers_table', 1),
(19, '2022_11_17_110459_create_taxes_table', 1),
(20, '2022_11_17_110514_create_items_table', 1),
(21, '2022_11_17_110541_create_item_attributes_table', 1),
(22, '2022_11_17_110621_create_item_variations_table', 1),
(23, '2022_11_17_110650_create_item_extras_table', 1),
(24, '2022_11_17_110810_create_orders_table', 1),
(25, '2022_11_17_110832_create_order_items_table', 1),
(26, '2022_11_17_110910_create_coupons_table', 1),
(27, '2022_11_17_111737_create_offer_items_table', 1),
(28, '2022_11_17_113842_create_menu_sections_table', 1),
(29, '2022_11_17_114040_create_menu_templates_table', 1),
(30, '2022_11_17_114144_create_analytics_table', 1),
(31, '2022_11_17_114516_create_analytics_sections_table', 1),
(32, '2022_11_17_114835_create_payment_gateways_table', 1),
(33, '2022_11_17_115136_create_sms_gateways_table', 1),
(34, '2022_11_17_115341_create_gateway_options_table', 1),
(35, '2022_11_17_115716_create_addons_table', 1),
(36, '2022_11_17_120130_create_notifications_table', 1),
(37, '2022_11_17_120408_create_messages_table', 1),
(38, '2022_11_17_120624_create_message_histories_table', 1),
(39, '2022_11_17_120625_create_order_coupons_table', 1),
(40, '2022_11_17_120626_create_pages_table', 1),
(41, '2022_11_17_120627_create_item_addons_table', 1),
(42, '2022_11_23_125038_create_push_notifications_table', 1),
(43, '2023_01_09_111734_create_time_slots_table', 1),
(44, '2023_02_20_180253_create_order_addresses_table', 1),
(45, '2023_03_06_154954_create_otps_table', 1),
(46, '2023_03_23_143747_create_transactions_table', 1),
(47, '2023_03_23_170303_create_capture_payment_notifications_table', 1),
(48, '2023_03_27_140107_create_notification_alerts_table', 1),
(49, '2023_07_19_135307_add_soft_delete_column_to_users_table', 1),
(50, '2023_07_20_095727_add_total_tax_to_orders_table', 1),
(51, '2023_07_20_095843_add_tax_to_order_items_table', 1),
(52, '2023_09_05_133748_create_dining_tables_table', 1),
(53, '2023_11_18_154743_add_dining_table_id_to_order_table', 1),
(54, '2024_01_22_172712_add_display_mode_to_languages_table', 1),
(55, '2024_02_29_095727_add_sort_to_item_categories_table', 1),
(56, '2024_10_28_000000_add_pos_payment_method_and_note_to_orders_table', 1),
(57, '2025_02_09_000000_add_pos_received_amount_to_orders_table', 1),
(58, '2025_02_12_000000_add_zone_to_branches_table', 1),
(59, '2025_02_21_110459_create_kiosk_machines_table', 1),
(60, '2026_02_05_122014_create_social_logins_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(3, 'App\\Models\\User', 12),
(3, 'App\\Models\\User', 13),
(2, 'App\\Models\\User', 14),
(2, 'App\\Models\\User', 15),
(3, 'App\\Models\\User', 16),
(2, 'App\\Models\\User', 17),
(3, 'App\\Models\\User', 18),
(2, 'App\\Models\\User', 19),
(2, 'App\\Models\\User', 20),
(2, 'App\\Models\\User', 21);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_alerts`
--

CREATE TABLE `notification_alerts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_notification_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail` tinyint DEFAULT NULL,
  `sms` tinyint DEFAULT NULL,
  `push_notification` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_alerts`
--

INSERT INTO `notification_alerts` (`id`, `name`, `language`, `mail_message`, `sms_message`, `push_notification_message`, `mail`, `sms`, `push_notification`, `created_at`, `updated_at`) VALUES
(1, 'Order Pending Message', 'order_pending_message', 'Your order is successfully placed.', 'Your order is successfully placed.', 'Your order is successfully placed.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(2, 'Order Confirmation Message', 'order_confirmation_message', 'Your order is Confirmed.', 'Your order is Confirmed.', 'Your order is Confirmed.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(3, 'Order preparing Message', 'order_preparing_message', 'Your order is being Prepared.', 'Your order is being Prepared.', 'Your order is being Prepared.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(4, 'Order prepared Message', 'order_prepared_message', 'The order has been prepared and is waiting for delivery.', 'The order has been prepared and is waiting for delivery.', 'The order has been prepared and is waiting for delivery.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(5, 'Order Out For Delivery Message', 'order_out_for_delivery_message', 'Your order is Out for delivery.', 'Your order is Out for delivery.', 'Your order is Out for delivery.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(6, 'Order Delivered Message', 'order_delivered_message', 'Your order is Successfully delivered.', 'Your order is Successfully delivered.', 'Your order is Successfully delivered.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(7, 'Order Canceled Message', 'order_canceled_message', 'Your order is Canceled.', 'Your order is Canceled.', 'Your order is Canceled.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(8, 'Order Rejected Message', 'order_rejected_message', 'Your order is Rejected.', 'Your order is Rejected.', 'Your order is Rejected.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(9, 'Order Returned Message', 'order_returned_message', 'Your order is Returned.', 'Your order is Returned.', 'Your order is Returned.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(10, 'Delivery Boy After Assign Message', 'delivery_boy_after_assign_message', 'You have been assigned an order for delivery.', 'You have been assigned an order for delivery.', 'You have been assigned an order for delivery.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(11, 'Admin And Branch Manager New Order Message', 'admin_and_branch_manager_new_order_message', 'You have a new order.', 'You have a new order.', 'You have a new order.', 10, 10, 10, '2026-03-24 18:15:50', '2026-03-24 18:15:50');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `name`, `slug`, `amount`, `status`, `start_date`, `end_date`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'LAUNCH', 'launch', 25.000000, 10, '2026-05-11 15:58:00', '2026-08-11 15:58:00', NULL, NULL, NULL, NULL, '2026-05-11 07:58:58', '2026-05-11 14:44:08'),
(2, 'dgdgd', 'dgdgd', 54.000000, 5, '2026-05-11 16:09:00', '2026-05-31 10:39:00', NULL, NULL, NULL, NULL, '2026-05-11 08:09:47', '2026-05-13 02:39:04');

-- --------------------------------------------------------

--
-- Table structure for table `offer_items`
--

CREATE TABLE `offer_items` (
  `id` bigint UNSIGNED NOT NULL,
  `offer_id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `offer_items`
--

INSERT INTO `offer_items` (`id`, `offer_id`, `item_id`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 2, 24, NULL, NULL, NULL, NULL, '2026-05-11 08:26:25', '2026-05-11 08:26:25');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `order_serial_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `subtotal` decimal(19,6) NOT NULL,
  `discount` decimal(19,6) DEFAULT '0.000000',
  `delivery_charge` decimal(19,6) DEFAULT '0.000000',
  `total_tax` decimal(19,6) DEFAULT NULL,
  `total` decimal(19,6) NOT NULL,
  `order_type` tinyint NOT NULL DEFAULT '5',
  `order_datetime` timestamp NOT NULL DEFAULT '2026-03-24 18:03:48',
  `delivery_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparation_time` int NOT NULL DEFAULT '0',
  `is_advance_order` tinyint NOT NULL DEFAULT '5',
  `payment_method` bigint NOT NULL DEFAULT '1',
  `pos_payment_method` tinyint DEFAULT NULL,
  `pos_received_amount` decimal(19,6) DEFAULT '0.000000',
  `pos_payment_note` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` tinyint NOT NULL DEFAULT '10',
  `status` tinyint NOT NULL,
  `dining_table_id` bigint UNSIGNED DEFAULT NULL,
  `delivery_boy_id` bigint DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_serial_no`, `token`, `user_id`, `branch_id`, `subtotal`, `discount`, `delivery_charge`, `total_tax`, `total`, `order_type`, `order_datetime`, `delivery_time`, `preparation_time`, `is_advance_order`, `payment_method`, `pos_payment_method`, `pos_received_amount`, `pos_payment_note`, `payment_status`, `status`, `dining_table_id`, `delivery_boy_id`, `reason`, `source`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, '2403261', NULL, 4, 1, 15.000000, 0.000000, 0.000000, 0.000000, 15.000000, 10, '2026-03-24 14:22:34', '11:45 - 12:30', 45, 5, 1, NULL, 0.000000, NULL, 5, 4, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, '2026-03-24 14:22:34', '2026-03-24 14:23:24'),
(2, '2503262', NULL, 4, 1, 15.000000, 0.000000, 0.000000, 0.000000, 15.000000, 10, '2026-03-24 23:49:41', '14:45 - 15:30', 45, 5, 1, NULL, 0.000000, NULL, 10, 1, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, '2026-03-24 23:49:41', '2026-03-24 23:49:41'),
(3, '2503263', NULL, 7, 1, 50.500000, 0.000000, 0.000000, 0.000000, 50.500000, 10, '2026-03-25 08:55:16', '19:15 - 20:00', 45, 10, 1, NULL, 0.000000, NULL, 10, 16, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, '2026-03-25 08:55:16', '2026-03-25 08:57:16'),
(4, '1004264', NULL, 8, 1, 41.500000, 0.000000, 0.000000, 0.000000, 41.500000, 10, '2026-04-10 02:57:05', '11:00 - 11:45', 45, 10, 1, NULL, 0.000000, NULL, 10, 13, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, '2026-04-10 02:57:05', '2026-04-10 03:14:11'),
(5, '1004265', NULL, 9, 1, 7.000000, 0.000000, 0.000000, 0.000000, 7.000000, 10, '2026-04-10 03:08:38', '11:45 - 12:30', 45, 10, 1, NULL, 0.000000, NULL, 10, 19, NULL, NULL, 'fake', '5', NULL, NULL, NULL, NULL, '2026-04-10 03:08:38', '2026-04-10 03:13:41'),
(6, '1704266', NULL, 11, 1, 32.000000, 0.000000, 0.000000, 0.000000, 32.000000, 10, '2026-04-17 06:37:05', '14:45 - 15:30', 45, 10, 1, NULL, 0.000000, NULL, 10, 8, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, '2026-04-17 06:37:05', '2026-04-17 06:37:52'),
(7, '1704267', NULL, 11, 1, 45.000000, 0.000000, 1.662715, 0.000000, 46.662715, 5, '2026-04-17 06:48:19', '14:45 - 15:30', 45, 10, 1, NULL, 0.000000, NULL, 10, 4, NULL, 12, NULL, '10', NULL, NULL, NULL, NULL, '2026-04-17 06:48:19', '2026-04-17 06:48:48'),
(8, '1704268', NULL, 14, 1, 24.000000, 0.000000, 1.789051, 0.000000, 25.789051, 5, '2026-04-17 13:15:41', '21:30 - 22:15', 45, 10, 1, NULL, 0.000000, NULL, 10, 7, NULL, 13, NULL, '10', NULL, NULL, NULL, NULL, '2026-04-17 13:15:41', '2026-04-17 13:49:24'),
(9, '1804269', NULL, 14, 1, 63.000000, 0.000000, 1.789051, 0.000000, 64.789051, 5, '2026-04-17 21:41:44', '11:00 - 11:45', 45, 10, 1, NULL, 0.000000, NULL, 10, 1, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, '2026-04-17 21:41:44', '2026-04-17 21:41:44'),
(10, '27042610', NULL, 19, 1, 24.000000, 0.000000, 1.648111, 0.000000, 25.648111, 5, '2026-04-26 23:20:27', '11:45 - 12:30', 45, 5, 1, NULL, 0.000000, NULL, 5, 4, NULL, 18, NULL, '10', NULL, NULL, NULL, NULL, '2026-04-26 23:20:27', '2026-04-26 23:24:43'),
(11, '12052611', NULL, 1, 1, 26.500000, 0.000000, 0.000000, 0.000000, 26.500000, 10, '2026-05-12 05:13:18', NULL, 45, 10, 1, NULL, 0.000000, NULL, 10, 13, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, '2026-05-12 05:13:18', '2026-05-12 05:20:39');

-- --------------------------------------------------------

--
-- Table structure for table `order_addresses`
--

CREATE TABLE `order_addresses` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apartment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_addresses`
--

INSERT INTO `order_addresses` (`id`, `order_id`, `user_id`, `label`, `address`, `apartment`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(1, 7, 11, 'Home', 'Arbor House, 6 Station Rd, Orpington BR6 0RY, UK', '7', '51.373868524010035', '0.09682506322860718', '2026-04-17 06:48:19', '2026-04-17 06:48:19'),
(2, 8, 14, 'Office', '11 Elm Grove, Orpington BR6 0AA, UK', '62', '51.37378313303205', '0.09328320622444153', '2026-04-17 13:15:41', '2026-04-17 13:15:41'),
(3, 9, 14, 'Office', '11 Elm Grove, Orpington BR6 0AA, UK', '62', '51.37378313303205', '0.09328320622444153', '2026-04-17 21:41:44', '2026-04-17 21:41:44'),
(4, 10, 19, 'Home', '285 High St., Orpington BR6 0NN, UK', NULL, '51.374342985195064', '0.09849607944488525', '2026-04-26 23:20:27', '2026-04-26 23:20:27');

-- --------------------------------------------------------

--
-- Table structure for table `order_coupons`
--

CREATE TABLE `order_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `coupon_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `discount` decimal(19,6) NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `discount` decimal(19,6) NOT NULL,
  `tax_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_rate` decimal(19,6) DEFAULT NULL,
  `tax_type` tinyint DEFAULT NULL,
  `tax_amount` decimal(19,6) DEFAULT NULL,
  `price` decimal(19,6) NOT NULL,
  `item_variations` longtext COLLATE utf8mb4_unicode_ci,
  `item_extras` longtext COLLATE utf8mb4_unicode_ci,
  `item_variation_total` decimal(19,6) DEFAULT '0.000000',
  `item_extra_total` decimal(19,6) DEFAULT '0.000000',
  `total_price` decimal(19,6) DEFAULT '0.000000',
  `instruction` text COLLATE utf8mb4_unicode_ci,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `branch_id`, `item_id`, `quantity`, `discount`, `tax_name`, `tax_rate`, `tax_type`, `tax_amount`, `price`, `item_variations`, `item_extras`, `item_variation_total`, `item_extra_total`, `total_price`, `instruction`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 36, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 7.000000, '[]', '[]', 0.000000, 0.000000, 7.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 1, 37, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 2, 1, 36, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 7.000000, '[]', '[]', 0.000000, 0.000000, 7.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 2, 1, 37, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 3, 1, 37, 3, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 24.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 3, 1, 35, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 5.000000, '[]', '[]', 0.000000, 0.000000, 5.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 3, 1, 24, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 5.500000, '[]', '[]', 0.000000, 0.000000, 5.500000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 3, 1, 40, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 3, 1, 42, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 4, 1, 40, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, 'sdfghjkl;\'', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 4, 1, 45, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 4.500000, '[]', '[]', 0.000000, 0.000000, 4.500000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 4, 1, 19, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 6.000000, '[]', '[]', 0.000000, 0.000000, 6.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 4, 1, 36, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 7.000000, '[]', '[]', 0.000000, 0.000000, 7.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 4, 1, 37, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 4, 1, 42, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 8.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 5, 1, 36, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 7.000000, '[]', '[]', 0.000000, 0.000000, 7.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 6, 1, 40, 4, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 32.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 7, 1, 35, 9, 0.000000, NULL, 0.000000, 5, 0.000000, 5.000000, '[]', '[]', 0.000000, 0.000000, 45.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 8, 1, 19, 4, 0.000000, NULL, 0.000000, 5, 0.000000, 6.000000, '[]', '[]', 0.000000, 0.000000, 24.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 9, 1, 35, 3, 0.000000, NULL, 0.000000, 5, 0.000000, 5.000000, '[]', '[]', 0.000000, 0.000000, 15.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 9, 1, 37, 3, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 24.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 9, 1, 37, 3, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 24.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 10, 1, 37, 3, 0.000000, NULL, 0.000000, 5, 0.000000, 8.000000, '[]', '[]', 0.000000, 0.000000, 24.000000, '', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 11, 1, 24, 1, 0.000000, NULL, 0.000000, 5, 0.000000, 5.500000, '[]', '[]', 0.000000, 0.000000, 5.500000, 'asdfghjkl;\'\n', NULL, NULL, NULL, NULL, NULL, NULL),
(25, 11, 1, 36, 3, 0.000000, NULL, 0.000000, 5, 0.000000, 7.000000, '[]', '[]', 0.000000, 0.000000, 21.000000, '', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `otps`
--

CREATE TABLE `otps` (
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_section_id` bigint UNSIGNED NOT NULL,
  `template_id` bigint DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `slug`, `description`, `menu_section_id`, `template_id`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Privacy Polciy', 'privacy-polciy', '<p>Privacy Policy</p><p><br></p><p>Last updated: 24 April 2026</p><p><br></p><p>Kahumbo UK operates the Kahumbo restaurant ordering website and mobile applications. This Privacy Policy explains how we collect, use, store, and protect user information when customers use our website and mobile apps to browse menus, place food orders, manage accounts, and receive delivery or collection services.</p><p><br></p><p>Company Name: Kahumbo UK</p><p>Location: Purley, London, United Kingdom</p><p>Website: https://kahumbo.co.uk</p><p>Support Email: info@kahumbo.co.uk</p><p><br></p><p>This Privacy Policy applies to our website and mobile applications, including customer ordering apps and related delivery/restaurant service apps operated by Kahumbo UK.</p><p><br></p><p>Information We Collect</p><p><br></p><p>We may collect the following information:</p><p><br></p><p>- Name</p><p>- Email address</p><p>- Phone number</p><p>- Delivery address</p><p>- Account login details</p><p>- Order details and purchase history</p><p>- Location information, if permission is granted</p><p>- Profile photo, if uploaded by the user</p><p>- App activity such as browsing, cart, checkout, search, and account actions</p><p>- Device identifiers and push notification tokens</p><p>- Crash logs and diagnostic information</p><p><br></p><p>How We Use Your Information</p><p><br></p><p>We use user information to:</p><p><br></p><p>- Create and manage customer accounts</p><p>- Allow customers to browse menus and place food orders</p><p>- Process delivery and collection orders</p><p>- Manage delivery addresses</p><p>- Provide order updates and customer support</p><p>- Send important app notifications</p><p>- Improve website and app performance</p><p>- Maintain security and prevent fraud</p><p>- Comply with legal, tax, accounting, and business record requirements</p><p><br></p><p>Location Data</p><p><br></p><p>Our apps may request location access to help customers find nearby branches, select delivery areas, and add delivery addresses. Users may choose not to allow location access and may manually enter an address where available.</p><p><br></p><p>Payments</p><p><br></p><p>Kahumbo UK may allow customers to pay for orders through supported payment methods. We do not store full card numbers, CVV codes, or sensitive banking credentials in our mobile apps. Payment processing may be handled by trusted third-party payment providers.</p><p><br></p><p>Data Sharing</p><p><br></p><p>We may share limited data with trusted service providers that help us operate our website, mobile apps, ordering system, delivery services, hosting, analytics, notifications, crash reporting, and payment processing.</p><p><br></p><p>We do not sell personal information.</p><p><br></p><p>Data Security</p><p><br></p><p>We use reasonable technical and organisational measures to protect user information. Data transmitted between our apps, website, and servers is encrypted in transit using secure connections.</p><p><br></p><p>Data Retention</p><p><br></p><p>We keep personal information only for as long as necessary to provide our services, manage accounts, process orders, comply with legal obligations, resolve disputes, prevent fraud, and maintain business records.</p><p><br></p><p>Account and Data Deletion</p><p><br></p><p>Users can request deletion of their Kahumbo account and associated personal data.</p><p><br></p><p>To delete your account through the app:</p><p><br></p><p>1. Open the Kahumbo app.</p><p>2. Log in to your account.</p><p>3. Go to Profile.</p><p>4. Tap Delete Account.</p><p>5. Confirm the deletion request.</p><p><br></p><p>If you cannot access the app, you can request account deletion by emailing us from your registered email address.</p><p><br></p><p>Email: info@kahumbo.co.uk</p><p>Subject: Delete my account</p><p><br></p><p>When an account is deleted, we delete or anonymise account profile information, saved addresses, login/account access data, and other personal data where applicable.</p><p><br></p><p>Some information may be retained where required for legal, tax, accounting, fraud prevention, dispute resolution, security, or business record obligations. This may include order records and payment transaction records.</p><p><br></p><p>Children\'s Privacy</p><p><br></p><p>Kahumbo UK is not directed to children. Our website and mobile apps are intended for users aged 18 and over.</p><p><br></p><p>User Rights</p><p><br></p><p>Depending on your location, you may have rights to access, correct, delete, or restrict the use of your personal information. To make a request, contact us at:</p><p><br></p><p>info@kahumbo.co.uk</p><p><br></p><p>Changes to This Privacy Policy</p><p><br></p><p>We may update this Privacy Policy from time to time. Any updates will be posted on this page with a revised date.</p><p><br></p><p>Contact Us</p><p><br></p><p>If you have any questions about this Privacy Policy or how Kahumbo UK handles user data, contact us at:</p><p><br></p><p>Kahumbo UK</p><p>Purley, London, United Kingdom</p><p>Email: info@kahumbo.co.uk</p><p>Website: https://kahumbo.co.uk</p>', 2, 1, 5, NULL, NULL, NULL, NULL, '2026-04-24 01:58:00', '2026-04-24 02:20:10'),
(2, 'User Policy', 'user-policy', '<p>User Policy</p><p><br></p><p>Last updated: 24 April 2026</p><p><br></p><p>This User Policy explains the rules and responsibilities that apply when using the Kahumbo UK website and mobile applications.</p><p><br></p><p>Company Name: Kahumbo UK</p><p>Location: Purley, London, United Kingdom</p><p>Website: https://kahumbo.co.uk</p><p>Support Email: info@kahumbo.co.uk</p><p><br></p><p>By using Kahumbo UK, you agree to use our website and mobile apps responsibly and in accordance with this User Policy.</p><p><br></p><p>User Accounts</p><p><br></p><p>Users may need to create an account to place orders, manage addresses, view order history, and access certain features.</p><p><br></p><p>You agree to:</p><p><br></p><p>- Provide accurate and current information</p><p>- Keep your login details secure</p><p>- Not share your account with unauthorized users</p><p>- Notify us if you believe your account has been misused</p><p>- Use the app only for lawful food ordering purposes</p><p><br></p><p>Orders</p><p><br></p><p>When placing an order, you are responsible for checking:</p><p><br></p><p>- Selected items</p><p>- Quantity</p><p>- Delivery or collection option</p><p>- Delivery address</p><p>- Contact details</p><p>- Payment method</p><p>- Order total</p><p><br></p><p>Once an order is accepted or prepared, changes or cancellations may not always be possible.</p><p><br></p><p>Delivery and Collection</p><p><br></p><p>Delivery times are estimates and may vary due to order volume, traffic, weather, branch availability, or other circumstances outside our control.</p><p><br></p><p>Users must provide a complete and accurate delivery address and be available to receive the order. Failed delivery caused by incorrect details or unavailability may not qualify for a refund.</p><p><br></p><p>Acceptable Use</p><p><br></p><p>You must not:</p><p><br></p><p>- Use the app or website for unlawful, fraudulent, or abusive purposes</p><p>- Attempt to interfere with the security or operation of our systems</p><p>- Submit false orders or misuse offers, coupons, or promotions</p><p>- Abuse, threaten, or harass staff, drivers, or support teams</p><p>- Copy, scrape, or misuse app content, branding, or data</p><p>- Upload harmful, offensive, or illegal content</p><p><br></p><p>Payments</p><p><br></p><p>Where online payment is available, payment must be completed using supported payment methods. Payment processing may be handled by third-party payment providers.</p><p><br></p><p>Promotions and Coupons</p><p><br></p><p>Promotions, discounts, and coupons may be subject to conditions, expiry dates, branch availability, and minimum order values. Kahumbo UK may withdraw or change promotions where necessary.</p><p><br></p><p>Account Suspension or Termination</p><p><br></p><p>We may suspend or restrict access to accounts that are used fraudulently, abusively, unlawfully, or in breach of this User Policy.</p><p><br></p><p>Changes to This Policy</p><p><br></p><p>We may update this User Policy from time to time. Updated versions will be posted on this page.</p><p><br></p><p>Contact Us</p><p><br></p><p>For questions about this User Policy, contact:</p><p><br></p><p>Kahumbo UK</p><p>Purley, London, United Kingdom</p><p>Email: info@kahumbo.co.uk</p><p>Website: https://kahumbo.co.uk</p><p><br></p>', 2, 1, 5, NULL, NULL, NULL, NULL, '2026-04-24 02:19:29', '2026-04-24 02:19:29'),
(3, 'Refund Policy', 'refund-policy', '<p>Refund Policy</p><p><br></p><p>Last updated: 24 April 2026</p><p><br></p><p>This Refund Policy explains how refunds, cancellations, and order issues are handled for orders placed through the Kahumbo UK website and mobile applications.</p><p><br></p><p>Company Name: Kahumbo UK</p><p>Location: Purley, London, United Kingdom</p><p>Website: https://kahumbo.co.uk</p><p>Support Email: info@kahumbo.co.uk</p><p><br></p><p>Order Cancellations</p><p><br></p><p>Customers should contact Kahumbo UK as soon as possible if they want to cancel an order.</p><p><br></p><p>Cancellation may be possible if the order has not yet been accepted, prepared, dispatched, or completed. Once food preparation has started, cancellation may not be possible.</p><p><br></p><p>Refund Eligibility</p><p><br></p><p>Refunds may be considered in cases such as:</p><p><br></p><p>- The order was cancelled before preparation started</p><p>- The wrong item was supplied</p><p>- Items were missing from the order</p><p>- The order could not be fulfilled by Kahumbo UK</p><p>- Payment was taken but the order was not received by the restaurant</p><p>- There was a confirmed duplicate payment</p><p><br></p><p>Refunds may not be available where:</p><p><br></p><p>- The customer entered an incorrect delivery address</p><p>- The customer was unavailable to receive the order</p><p>- The customer changed their mind after food preparation started</p><p>- The customer selected the wrong item or quantity</p><p>- Delivery was delayed due to circumstances outside our reasonable control</p><p>- The issue was reported too late for us to verify</p><p><br></p><p>How to Request a Refund</p><p><br></p><p>To request a refund, contact us as soon as possible using:</p><p><br></p><p>Email: info@kahumbo.co.uk</p><p><br></p><p>Please include:</p><p><br></p><p>- Your name</p><p>- Registered email or phone number</p><p>- Order number</p><p>- Order date and time</p><p>- Description of the issue</p><p>- Photos, where relevant</p><p><br></p><p>Refund Review</p><p><br></p><p>Refund requests are reviewed on a case-by-case basis. We may need to verify the order details, payment status, delivery status, and issue reported before approving a refund.</p><p><br></p><p>Refund Method and Time</p><p><br></p><p>Approved refunds will normally be returned to the original payment method where possible. Processing times may vary depending on the payment provider, bank, or card issuer.</p><p><br></p><p>Partial Refunds</p><p><br></p><p>Where only part of an order is affected, Kahumbo UK may offer a partial refund, replacement, store credit, or another appropriate resolution.</p><p><br></p><p>Cash Orders</p><p><br></p><p>For cash orders, refunds or adjustments may be handled directly by Kahumbo UK support or branch staff.</p><p><br></p><p>Third-Party Payment Providers</p><p><br></p><p>If payment was processed by a third-party payment provider, refund timing and availability may also depend on that provider’s rules and processing times.</p><p><br></p><p>Contact Us</p><p><br></p><p>For refund questions or order issues, contact:</p><p><br></p><p>Kahumbo UK</p><p>Purley, London, United Kingdom</p><p>Email: info@kahumbo.co.uk</p><p>Website: https://kahumbo.co.uk</p><p><br></p>', 2, 1, 5, NULL, NULL, NULL, NULL, '2026-04-24 02:19:52', '2026-04-24 02:19:52'),
(4, 'Delete Account', 'delete-account', '<p>Delete Account</p><p><br></p><p>Last updated: 24 April 2026</p><p><br></p><p>This page explains how users can request deletion of their Kahumbo account and associated personal data.</p><p><br></p><p>Company Name: Kahumbo UK</p><p>Location: Purley, London, United Kingdom</p><p>Website: https://kahumbo.co.uk</p><p>Support Email: info@kahumbo.co.uk</p><p><br></p><p>How to Delete Your Account in the Kahumbo App</p><p><br></p><p>You can request deletion of your Kahumbo account directly from the Kahumbo mobile app.</p><p><br></p><p>Steps:</p><p><br></p><p>1. Open the Kahumbo app.</p><p>2. Log in to your account.</p><p>3. Go to Profile.</p><p>4. Tap Delete Account.</p><p>5. Confirm the deletion request.</p><p><br></p><p>If You Cannot Access the App</p><p><br></p><p>If you cannot access your account or the app, you can request account deletion by contacting us from your registered email address.</p><p><br></p><p>Email: info@kahumbo.co.uk</p><p>Subject: Delete my account</p><p><br></p><p>Please include your registered name, email address, and phone number so we can identify your account.</p><p><br></p><p>What Data Will Be Deleted</p><p><br></p><p>When your account deletion request is processed, we will delete or anonymise personal data associated with your account where applicable, including:</p><p><br></p><p>- Account profile information</p><p>- Name</p><p>- Email address</p><p>- Phone number</p><p>- Saved delivery addresses</p><p>- Login/account access data</p><p>- Profile photo, if uploaded</p><p>- Device notification tokens</p><p><br></p><p>Data We May Retain</p><p><br></p><p>Some information may be retained where required for legal, tax, accounting, fraud prevention, dispute resolution, security, or business record obligations.</p><p><br></p><p>This may include:</p><p><br></p><p>- Order records</p><p>- Payment transaction records</p><p>- Refund records</p><p>- Customer support records</p><p>- Records required to comply with applicable laws</p><p><br></p><p>How Long Deletion Takes</p><p><br></p><p>We aim to process account deletion requests within a reasonable time after verifying the request. Some retained records may be kept for the period required by law or legitimate business obligations.</p><p><br></p><p>Contact Us</p><p><br></p><p>For account deletion or privacy-related questions, contact:</p><p><br></p><p>Kahumbo UK</p><p>Purley, London, United Kingdom</p><p>Email: info@kahumbo.co.uk</p><p>Website: https://kahumbo.co.uk</p><p><br></p>', 2, 1, 5, NULL, NULL, NULL, NULL, '2026-04-24 07:02:22', '2026-04-24 07:02:22'),
(5, 'Terms and Conditions', 'terms-and-conditions', '<p>Terms and Conditions</p><p><br></p><p>Last updated: 24 April 2026</p><p><br></p><p>These Terms and Conditions apply to the use of the Kahumbo website and mobile applications operated by Kahumbo UK.</p><p><br></p><p>Company Name: Kahumbo UK</p><p>Location: Purley, London, United Kingdom</p><p>Website: https://kahumbo.co.uk</p><p>Support Email: info@kahumbo.co.uk</p><p><br></p><p>By using the Kahumbo website or mobile apps, you agree to these Terms and Conditions. If you do not agree, please do not use our services.</p><p><br></p><p>About Kahumbo</p><p><br></p><p>Kahumbo UK provides restaurant ordering services through its website and mobile applications. Customers can browse menus, place food and drink orders, manage delivery or collection details, and access related account features.</p><p><br></p><p>User Accounts</p><p><br></p><p>You may need to create an account to use certain features of Kahumbo.</p><p><br></p><p>You agree to:</p><p><br></p><p>- Provide accurate and up-to-date information</p><p>- Keep your login details secure</p><p>- Not allow unauthorised access to your account</p><p>- Notify us if you believe your account has been misused</p><p>- Use the website and apps only for lawful purposes</p><p><br></p><p>You are responsible for activity carried out through your account.</p><p><br></p><p>Orders</p><p><br></p><p>When placing an order, you are responsible for reviewing all details before confirming, including:</p><p><br></p><p>- Items selected</p><p>- Quantities</p><p>- Delivery or collection option</p><p>- Delivery address</p><p>- Contact details</p><p>- Payment method</p><p>- Order total</p><p><br></p><p>Orders are subject to acceptance, availability, branch operation times, delivery coverage, and payment confirmation where applicable.</p><p><br></p><p>Kahumbo UK may refuse or cancel an order if it cannot be fulfilled, if payment fails, if incorrect information is provided, or if misuse or fraud is suspected.</p><p><br></p><p>Prices and Availability</p><p><br></p><p>Prices, menu items, offers, and availability may change without notice. We aim to keep information accurate, but errors may occasionally occur.</p><p><br></p><p>If an item is unavailable after an order is placed, we may contact you to offer an alternative, adjustment, cancellation, or refund where applicable.</p><p><br></p><p>Delivery and Collection</p><p><br></p><p>Delivery and collection times are estimates only. Actual times may vary due to order volume, traffic, weather, branch availability, courier availability, or other circumstances outside our reasonable control.</p><p><br></p><p>For delivery orders, you must provide a complete and accurate address and be available to receive the order. Kahumbo UK is not responsible for failed delivery caused by incorrect details, unavailable recipients, or access restrictions.</p><p><br></p><p>Payments</p><p><br></p><p>Where online payment is available, payment must be made using the supported payment methods shown at checkout. Payment processing may be handled by third-party payment providers.</p><p><br></p><p>You agree that all payment information provided is accurate and that you are authorised to use the selected payment method.</p><p><br></p><p>Refunds and Cancellations</p><p><br></p><p>Refunds and cancellations are handled according to our Refund Policy.</p><p><br></p><p>Cancellation may not be possible once food preparation has started or the order has been dispatched.</p><p><br></p><p>Promotions and Coupons</p><p><br></p><p>Promotions, discounts, coupons, and offers may be subject to conditions, expiry dates, minimum order values, branch availability, and other restrictions.</p><p><br></p><p>Kahumbo UK may change, withdraw, or refuse promotions where misuse, error, or fraud is suspected.</p><p><br></p><p>Acceptable Use</p><p><br></p><p>You must not:</p><p><br></p><p>- Use Kahumbo for unlawful, fraudulent, abusive, or harmful purposes</p><p>- Place false, abusive, or malicious orders</p><p>- Interfere with the security or operation of the website, apps, or systems</p><p>- Attempt to access accounts, systems, or data without permission</p><p>- Copy, scrape, or misuse Kahumbo content, branding, menus, or data</p><p>- Upload or submit harmful, offensive, misleading, or illegal content</p><p>- Abuse, threaten, harass, or mistreat staff, drivers, support teams, or other service providers</p><p><br></p><p>Account Suspension or Termination</p><p><br></p><p>Kahumbo UK may suspend, restrict, or terminate access to an account if we believe the user has breached these Terms, misused the service, provided false information, acted fraudulently, or caused harm to our business, staff, systems, or customers.</p><p><br></p><p>Intellectual Property</p><p><br></p><p>All branding, logos, text, images, menus, designs, software, and content made available through Kahumbo are owned by or licensed to Kahumbo UK unless stated otherwise.</p><p><br></p><p>You may not copy, reproduce, distribute, modify, or use our content or branding without permission.</p><p><br></p><p>Third-Party Services</p><p><br></p><p>Kahumbo may use third-party services for payment processing, maps, analytics, notifications, hosting, delivery support, and other operational features.</p><p><br></p><p>Use of third-party services may also be subject to the relevant third party’s terms and privacy policies.</p><p><br></p><p>Limitation of Liability</p><p><br></p><p>Kahumbo UK aims to provide reliable services, but we do not guarantee that the website or apps will always be uninterrupted, error-free, or available.</p><p><br></p><p>To the extent permitted by law, Kahumbo UK is not responsible for losses caused by service interruptions, incorrect user information, unavailable items, delivery delays, third-party service issues, or circumstances outside our reasonable control.</p><p><br></p><p>Nothing in these Terms limits rights that cannot be excluded under applicable law.</p><p><br></p><p>Privacy</p><p><br></p><p>Use of personal information is explained in our Privacy Policy.</p><p><br></p><p>Account Deletion</p><p><br></p><p>Customers may request deletion of their account through the Kahumbo app or by contacting us. More information is available on our Delete Account page.</p><p><br></p><p>Changes to These Terms</p><p><br></p><p>We may update these Terms and Conditions from time to time. Updated terms will be posted on this page with a revised date.</p><p><br></p><p>Contact Us</p><p><br></p><p>For questions about these Terms and Conditions, contact:</p><p><br></p><p>Kahumbo UK</p><p>Purley, London, United Kingdom</p><p>Email: info@kahumbo.co.uk</p><p>Website: https://kahumbo.co.uk</p><p><br></p>', 2, 1, 5, NULL, NULL, NULL, NULL, '2026-04-24 07:03:10', '2026-04-24 07:03:10');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('madmin@kahumbo.co.uk', '9580', '2026-04-10 02:57:21');

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `misc` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_gateways`
--

INSERT INTO `payment_gateways` (`id`, `name`, `slug`, `misc`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Cash On Delivery', 'cash-on-delivery', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'Credit', 'credit', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'Paypal', 'paypal', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 'Stripe', 'stripe', '{\"input\":[\"stripe.stripeInput.blade.php\"],\"js\":[\"stripe.stripeJs.blade.php\"],\"submit\":true}', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, 'Flutterwave', 'flutterwave', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 'Paystack', 'paystack', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 'SslCommerz', 'sslcommerz', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 'Mollie', 'mollie', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(9, 'Senangpay', 'senangpay', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(10, 'Bkash', 'bkash', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(11, 'Paytm', 'paytm', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(12, 'Razorpay', 'razorpay', '{\"input\":[],\"js\":[\"razorpay.razorpayJs.blade.php\"],\"submit\":false}', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(13, 'Mercadopago', 'mercadopago', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(14, 'Cashfree', 'cashfree', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(15, 'Payfast', 'payfast', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(16, 'Skrill', 'skrill', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(17, 'PhonePe', 'phonepe', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(18, 'Telr', 'telr', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(19, 'Iyzico', 'iyzico', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(20, 'Pesapal', 'pesapal', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(21, 'Midtrans', 'midtrans', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(22, 'TwoCheckout', 'twocheckout', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(23, 'MyFatoorah', 'myfatoorah', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(24, 'EasyPaisa', 'easypaisa', 'null', 10, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(125) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(125) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` bigint UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `title`, `name`, `guard_name`, `url`, `parent`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', 'dashboard', 'sanctum', 'dashboard', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'Items', 'items', 'sanctum', 'items', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'Items Create', 'items_create', 'sanctum', 'items/create', 2, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 'Items Edit', 'items_edit', 'sanctum', 'items/edit', 2, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, 'Items Delete', 'items_delete', 'sanctum', 'items/delete', 2, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 'Items Show', 'items_show', 'sanctum', 'items/show', 2, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 'Dining Tables', 'dining-tables', 'sanctum', 'dining-tables', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 'Dining Tables Create', 'dining-tables_create', 'sanctum', 'dining-tables/create', 7, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(9, 'Dining Tables Edit', 'dining-tables_edit', 'sanctum', 'dining-tables/edit', 7, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(10, 'Dining Tables Delete', 'dining-tables_delete', 'sanctum', 'dining-tables/delete', 7, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(11, 'Dining Tables Show', 'dining-tables_show', 'sanctum', 'dining-tables/show', 7, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(12, 'POS', 'pos', 'sanctum', 'pos', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(13, 'POS Orders', 'pos-orders', 'sanctum', 'pos-orders', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(14, 'Online Orders', 'online-orders', 'sanctum', 'online-orders', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(15, 'Table Orders', 'table-orders', 'sanctum', 'table-orders', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(16, 'K.D.S', 'kitchen-display-system', 'sanctum', 'kitchen-display-system', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(17, 'O.S.S', 'order-status-screen', 'sanctum', 'order-status-screen', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(18, 'Coupons', 'coupons', 'sanctum', 'coupons', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(19, 'Coupons Create', 'coupons_create', 'sanctum', 'coupons/create', 18, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(20, 'Coupons Edit', 'coupons_edit', 'sanctum', 'coupons/edit', 18, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(21, 'Coupons Delete', 'coupons_delete', 'sanctum', 'coupons/delete', 18, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(22, 'Coupons Show', 'coupons_show', 'sanctum', 'coupons/show', 18, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(23, 'Offers', 'offers', 'sanctum', 'offers', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(24, 'Offers Create', 'offers_create', 'sanctum', 'offers/create', 23, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(25, 'Offers Edit', 'offers_edit', 'sanctum', 'offers/edit', 23, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(26, 'Offers Delete', 'offers_delete', 'sanctum', 'offers/delete', 23, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(27, 'Offers Show', 'offers_show', 'sanctum', 'offers/show', 23, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(28, 'Push Notifications', 'push-notifications', 'sanctum', 'push-notifications', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(29, 'Push Notifications Create', 'push-notifications_create', 'sanctum', 'push-notifications/create', 28, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(30, 'Push Notifications Edit', 'push-notifications_edit', 'sanctum', 'push-notifications/edit', 28, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(31, 'Push Notifications Delete', 'push-notifications_delete', 'sanctum', 'push-notifications/delete', 28, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(32, 'Push Notifications Show', 'push-notifications_show', 'sanctum', 'push-notifications/show', 28, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(33, 'Messages', 'messages', 'sanctum', 'messages', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(34, 'Subscribers', 'subscribers', 'sanctum', 'subscribers', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(35, 'Administrators', 'administrators', 'sanctum', 'administrators', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(36, 'Administrators Create', 'administrators_create', 'sanctum', 'administrators/create', 35, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(37, 'Administrators Edit', 'administrators_edit', 'sanctum', 'administrators/edit', 35, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(38, 'Administrators Delete', 'administrators_delete', 'sanctum', 'administrators/delete', 35, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(39, 'Administrators Show', 'administrators_show', 'sanctum', 'administrators/show', 35, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(40, 'Delivery Boys', 'delivery-boys', 'sanctum', 'delivery-boys', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(41, 'Delivery Boys Create', 'delivery-boys_create', 'sanctum', 'delivery-boys/create', 40, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(42, 'Delivery Boys Edit', 'delivery-boys_edit', 'sanctum', 'delivery-boys/edit', 40, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(43, 'Delivery Boys Delete', 'delivery-boys_delete', 'sanctum', 'delivery-boys/delete', 40, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(44, 'Delivery Boys Show', 'delivery-boys_show', 'sanctum', 'delivery-boys/show', 40, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(45, 'Customers', 'customers', 'sanctum', 'customers', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(46, 'Customers Create', 'customers_create', 'sanctum', 'customers/create', 45, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(47, 'Customers Edit', 'customers_edit', 'sanctum', 'customers/edit', 45, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(48, 'Customers Delete', 'customers_delete', 'sanctum', 'customers/delete', 45, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(49, 'Customers Show', 'customers_show', 'sanctum', 'customers/show', 45, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(50, 'Employees', 'employees', 'sanctum', 'employees', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(51, 'Employees Create', 'employees_create', 'sanctum', 'employees/create', 50, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(52, 'Employees Edit', 'employees_edit', 'sanctum', 'employees/edit', 50, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(53, 'Employees Delete', 'employees_delete', 'sanctum', 'employees/delete', 50, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(54, 'Employees Show', 'employees_show', 'sanctum', 'employees/show', 50, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(55, 'Waiters', 'waiters', 'sanctum', 'waiters', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(56, 'Waiters Create', 'waiters_create', 'sanctum', 'waiters/create', 55, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(57, 'Waiters Edit', 'waiters_edit', 'sanctum', 'waiters/edit', 55, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(58, 'Waiters Delete', 'waiters_delete', 'sanctum', 'waiters/delete', 55, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(59, 'Waiters Show', 'waiters_show', 'sanctum', 'waiters/show', 55, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(60, 'Chefs', 'chefs', 'sanctum', 'chefs', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(61, 'Chefs Create', 'chefs_create', 'sanctum', 'chefs/create', 60, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(62, 'Chefs Edit', 'chefs_edit', 'sanctum', 'chefs/edit', 60, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(63, 'Chefs Delete', 'chefs_delete', 'sanctum', 'chefs/delete', 60, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(64, 'Chefs Show', 'chefs_show', 'sanctum', 'chefs/show', 60, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(65, 'Transactions', 'transactions', 'sanctum', 'transactions', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(66, 'Sales Report', 'sales-report', 'sanctum', 'sales-report', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(67, 'Items Report', 'items-report', 'sanctum', 'items-report', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(68, 'Credit Balance Report', 'credit-balance-report', 'sanctum', 'credit-balance-report', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(69, 'Settings', 'settings', 'sanctum', 'settings', 0, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(3, 'App\\Models\\User', 4, 'auth_token', '0f7d165bdcd5e0be3686445db6c524ff3443e82adff15e70fc8fdea377025db3', '[\"*\"]', '2026-03-24 14:18:33', NULL, '2026-03-24 14:18:31', '2026-03-24 14:18:33'),
(4, 'App\\Models\\User', 4, 'auth_token', '8ba890a95f957e8cca81918ceeff8eeb0bea057532b93f1ab726752299ca3466', '[\"*\"]', '2026-04-17 06:47:10', NULL, '2026-03-24 14:18:33', '2026-04-17 06:47:10'),
(6, 'App\\Models\\User', 6, 'auth_token', '116e37a64a79a8e023778e681a5f9fcbd6423b8e3d218c33152b41a5328b53f7', '[\"*\"]', '2026-03-31 01:17:14', NULL, '2026-03-25 08:54:12', '2026-03-31 01:17:14'),
(9, 'App\\Models\\User', 6, 'auth_token', '1630e0d38be1dfce2b6131ff9aa7b87e8007f3419a183c0b7229a6aa7d504461', '[\"*\"]', '2026-03-31 01:17:25', NULL, '2026-03-31 01:17:13', '2026-03-31 01:17:25'),
(12, 'App\\Models\\User', 1, 'auth_token', 'b9d12d67938995ed96ce8e771779ff73a7b69ef4b23ad76ffd3ad0909b0a8dde', '[\"*\"]', '2026-05-12 07:14:01', NULL, '2026-04-10 03:00:54', '2026-05-12 07:14:01'),
(13, 'App\\Models\\User', 8, 'auth_token', '4f1fd30e0a4c9c9d4ca087a7bae9b0d8653b49fdb012d79640cba4b62b412ee6', '[\"*\"]', '2026-05-11 03:23:26', NULL, '2026-04-10 03:03:56', '2026-05-11 03:23:26'),
(14, 'App\\Models\\User', 8, 'auth_token', '18d30e2e23876cb49f9ee9aea9ae2a947d3fcd9e687189363a50b844b3cd2404', '[\"*\"]', '2026-05-06 04:35:01', NULL, '2026-04-10 03:05:05', '2026-05-06 04:35:01'),
(15, 'App\\Models\\User', 9, 'auth_token', '3a29c8a607725182a7f057762c3a2abe5d43035dccee7f12c6077ba40f858f5c', '[\"*\"]', '2026-04-10 03:09:36', NULL, '2026-04-10 03:08:32', '2026-04-10 03:09:36'),
(16, 'App\\Models\\User', 1, 'auth_token', 'b5dc441e8c4b5b7afa0e85a0ef3c69b34d44ec1874f1611b01fb2cdef5c39df5', '[\"*\"]', '2026-04-17 05:37:42', NULL, '2026-04-17 05:35:44', '2026-04-17 05:37:42'),
(17, 'App\\Models\\User', 1, 'auth_token', '49e87c66e2fb383df4737a847201f5bfe535fff621a2f3dda2e3fa3bae5a7193', '[\"*\"]', '2026-05-13 02:40:54', NULL, '2026-04-17 05:36:17', '2026-05-13 02:40:54'),
(18, 'App\\Models\\User', 10, 'auth_token', 'ba3e3c77a0ca0c0524585821eb95558b8939413d33747b5a128299c76ef37788', '[\"*\"]', '2026-04-17 06:34:55', NULL, '2026-04-17 06:32:24', '2026-04-17 06:34:55'),
(19, 'App\\Models\\User', 11, 'auth_token', '83fe6d0a7c797043a7f1c0bfef5aa235321819f36335557557efbd8e955dd03e', '[\"*\"]', '2026-04-17 06:51:53', NULL, '2026-04-17 06:35:32', '2026-04-17 06:51:53'),
(20, 'App\\Models\\User', 12, 'auth_token', '68f34524f22dbf28a8db0d21d97e39cc90dc823f0981322e542ee41678bfd5f3', '[\"*\"]', '2026-04-17 07:04:47', NULL, '2026-04-17 06:39:46', '2026-04-17 07:04:47'),
(21, 'App\\Models\\User', 1, 'auth_token', '3f927bfaa6828672238a39d3e170355abca7dca11654de97aae091d7ea071c97', '[\"*\"]', '2026-04-17 07:20:52', NULL, '2026-04-17 06:42:37', '2026-04-17 07:20:52'),
(22, 'App\\Models\\User', 11, 'auth_token', '2cee2edde9b2219ed99a3e798ccf3648ab603e8d471246859df4684e681a1218', '[\"*\"]', '2026-04-17 06:52:29', NULL, '2026-04-17 06:51:53', '2026-04-17 06:52:29'),
(23, 'App\\Models\\User', 11, 'auth_token', '0c25a03757da9f96dad3f73658bdd2c39a8bde5ea100faafbed81d76b0f134cd', '[\"*\"]', NULL, NULL, '2026-04-17 06:52:11', '2026-04-17 06:52:11'),
(24, 'App\\Models\\User', 11, 'auth_token', 'bd1dcc388370f34dfdb40052aeaee143d672bea7ae1f8389e2572e32bdae6772', '[\"*\"]', '2026-04-17 06:52:58', NULL, '2026-04-17 06:52:27', '2026-04-17 06:52:58'),
(25, 'App\\Models\\User', 11, 'auth_token', '0da601f22a868e3121b0ea8bc55b566f008654eddba0a6c1ac0cb9359bde03f5', '[\"*\"]', '2026-04-17 06:54:56', NULL, '2026-04-17 06:52:57', '2026-04-17 06:54:56'),
(26, 'App\\Models\\User', 11, 'auth_token', '990132539bbeabffed18b1d5e7531fb37560f9d433f93029796e7da108bd6072', '[\"*\"]', '2026-04-17 06:55:52', NULL, '2026-04-17 06:54:57', '2026-04-17 06:55:52'),
(27, 'App\\Models\\User', 11, 'auth_token', '7cb1d010b2049be55c02a80bf853872dd1f9ada1f9001134abc99fa0f973f5fe', '[\"*\"]', '2026-04-17 06:57:46', NULL, '2026-04-17 06:55:51', '2026-04-17 06:57:46'),
(28, 'App\\Models\\User', 11, 'auth_token', '8f6eeeef1dfbb7873dacff20ccde21eef0a628454c51caf22a946ece5c119df2', '[\"*\"]', '2026-04-17 06:58:23', NULL, '2026-04-17 06:57:46', '2026-04-17 06:58:23'),
(29, 'App\\Models\\User', 11, 'auth_token', 'c4519c99edf966d0e284043110b4aa94b6a41887d1a5fd3d35f13ff7dae1bcb8', '[\"*\"]', '2026-04-17 07:00:25', NULL, '2026-04-17 06:58:22', '2026-04-17 07:00:25'),
(30, 'App\\Models\\User', 11, 'auth_token', 'caeb2766d3ae0ad81ce9fb4b18ca987197c3a4dfc1787297e66579c45da273ae', '[\"*\"]', '2026-04-17 07:00:37', NULL, '2026-04-17 07:00:26', '2026-04-17 07:00:37'),
(31, 'App\\Models\\User', 11, 'auth_token', '6085c551b9e2cc95899a631625f584cf6ba12440f42c1796612a3972b9e8b6c2', '[\"*\"]', '2026-04-17 07:04:33', NULL, '2026-04-17 07:00:36', '2026-04-17 07:04:33'),
(32, 'App\\Models\\User', 13, 'auth_token', '94ff569819bdeb84061100b6437fc312dd7b3b4c797942401d1061c4b0d5ed5c', '[\"*\"]', '2026-04-17 12:45:00', NULL, '2026-04-17 12:44:46', '2026-04-17 12:45:00'),
(33, 'App\\Models\\User', 13, 'auth_token', 'ff3b4c86796531ab3d30ec7f1b9521813e5a4d1d230d2b52ebbb037504e5cabd', '[\"*\"]', '2026-04-24 08:03:48', NULL, '2026-04-17 12:45:05', '2026-04-24 08:03:48'),
(34, 'App\\Models\\User', 14, 'auth_token', '8c6623297f6ef50341538e8803af5720ee3b6b85e6ed2e6eb3a60373249f8c8c', '[\"*\"]', '2026-04-23 11:36:16', NULL, '2026-04-17 13:13:17', '2026-04-23 11:36:16'),
(36, 'App\\Models\\User', 1, 'auth_token', '3b71d89f5baa1f0c72e6ff92c92f70a6deaf312951a7d14bbe777879eda52026', '[\"*\"]', '2026-04-25 02:52:41', NULL, '2026-04-22 04:22:59', '2026-04-25 02:52:41'),
(37, 'App\\Models\\User', 1, 'auth_token', '0cf678676cf92c6540ab65de572e03053d2732c871367344ca8028665fb885de', '[\"*\"]', '2026-05-02 04:44:19', NULL, '2026-04-23 10:16:37', '2026-05-02 04:44:19'),
(38, 'App\\Models\\User', 1, 'auth_token', '496cf5fb3bcbd1eb71a942dcff0568d9e66863752e904b3d2e4ba89632106aad', '[\"*\"]', '2026-04-24 07:03:28', NULL, '2026-04-23 10:21:24', '2026-04-24 07:03:28'),
(39, 'App\\Models\\User', 15, 'auth_token', 'e8c81e40bb661ec18e9c84b13ffafa09fac9a520962163a1da98926c1425dd8f', '[\"*\"]', '2026-04-24 00:13:14', NULL, '2026-04-23 23:55:15', '2026-04-24 00:13:14'),
(40, 'App\\Models\\User', 16, 'auth_token', '32a8cfb6653816818db8083c9331c18f92de130b8137342faa14c07e95ccc0b7', '[\"*\"]', '2026-04-24 00:27:14', NULL, '2026-04-24 00:24:27', '2026-04-24 00:27:14'),
(41, 'App\\Models\\User', 16, 'auth_token', '6f7aa425aa65a920101b8a3b4b1b0a4d415090bfa62159f5fbc96d9e4df51592', '[\"*\"]', '2026-04-24 00:28:24', NULL, '2026-04-24 00:27:29', '2026-04-24 00:28:24'),
(42, 'App\\Models\\User', 16, 'auth_token', 'a7cd42851c8b7c0ef7864da339225eecc29cda6ca538d8e80de5805c3ba9af29', '[\"*\"]', '2026-04-24 00:31:37', NULL, '2026-04-24 00:31:20', '2026-04-24 00:31:37'),
(43, 'App\\Models\\User', 16, 'auth_token', '5fc0328fec33a6398b749617e0b7ff5de7635448054c259d4aaef8fbc090d053', '[\"*\"]', '2026-04-26 09:18:55', NULL, '2026-04-24 00:31:48', '2026-04-26 09:18:55'),
(44, 'App\\Models\\User', 17, 'auth_token', 'ac851095b4c3d920f4aa538b5288d6ec4140b6ade4700b07d106e3325aad36b3', '[\"*\"]', '2026-04-29 20:17:15', NULL, '2026-04-24 01:26:40', '2026-04-29 20:17:15'),
(46, 'App\\Models\\User', 1, 'auth_token', 'aebcd612db21cb2af443e5da4795fa7f4f556cba08af709c890cbe630c39d8b8', '[\"*\"]', '2026-04-26 09:32:20', NULL, '2026-04-26 08:54:44', '2026-04-26 09:32:20'),
(47, 'App\\Models\\User', 18, 'auth_token', '402f752d8f1205573708fa080f3d739dcd8f517287ed5b36252b2f69f2e29cbf', '[\"*\"]', '2026-04-26 09:21:54', NULL, '2026-04-26 09:20:45', '2026-04-26 09:21:54'),
(48, 'App\\Models\\User', 18, 'auth_token', '9f31de244179ec35d315056f35a219ffd3e2f9c034b5b611c45b7f707ce9426e', '[\"*\"]', '2026-04-26 23:24:34', NULL, '2026-04-26 23:17:35', '2026-04-26 23:24:34'),
(49, 'App\\Models\\User', 19, 'auth_token', '4186c427f6175dda4542c89729d6b862c280dabfb55de593ae77144caaa738bf', '[\"*\"]', '2026-04-26 23:22:23', NULL, '2026-04-26 23:19:16', '2026-04-26 23:22:23'),
(50, 'App\\Models\\User', 18, 'auth_token', 'f1871dad8f752b97c70a6180d1d1184063311490ef65623eaf9d3c9ad5fad887', '[\"*\"]', '2026-04-27 05:09:58', NULL, '2026-04-27 05:09:33', '2026-04-27 05:09:58'),
(51, 'App\\Models\\User', 17, 'auth_token', '63d288e9660365d5814d138d0846610b949ece657a7a49662a2d6f7a4bd9e1b7', '[\"*\"]', NULL, NULL, '2026-04-29 20:17:16', '2026-04-29 20:17:16'),
(52, 'App\\Models\\User', 18, 'auth_token', 'e089844ae5587f963626b5c127bcd398cd4124988e510ec24d834237359a9b18', '[\"*\"]', '2026-05-01 21:42:20', NULL, '2026-05-01 21:40:13', '2026-05-01 21:42:20'),
(53, 'App\\Models\\User', 10, 'auth_token', 'f92ac7648431a0188f839c2c51e706bd9e2f8c7d0851427c44e469ffc53d226a', '[\"*\"]', '2026-05-12 03:59:28', NULL, '2026-05-11 04:14:05', '2026-05-12 03:59:28'),
(54, 'App\\Models\\User', 10, 'auth_token', '7a49608c9701c897cdf3b00e71ccb7a1b094b6ec4a5f5b26c768106173aedb7f', '[\"*\"]', '2026-05-13 02:42:32', NULL, '2026-05-12 03:59:54', '2026-05-13 02:42:32'),
(55, 'App\\Models\\User', 20, 'auth_token', '00125e02e466135eb357c076fd630476aa2aed25f794e22b2681e8f89aad7662', '[\"*\"]', '2026-05-12 05:59:58', NULL, '2026-05-12 05:59:15', '2026-05-12 05:59:58'),
(56, 'App\\Models\\User', 21, 'auth_token', '3ded0ea599f166c76f495bb4d0ce5955f16515cfdf87d9ac9e12620f0d6c26e4', '[\"*\"]', '2026-05-13 02:31:30', NULL, '2026-05-13 02:16:54', '2026-05-13 02:31:30'),
(57, 'App\\Models\\User', 1, 'auth_token', '87e28c770fa6d13ca271e27a1ea05555dc30432070570a47ba81c2e2610b4add', '[\"*\"]', '2026-05-13 02:23:31', NULL, '2026-05-13 02:23:22', '2026-05-13 02:23:31');

-- --------------------------------------------------------

--
-- Table structure for table `push_notifications`
--

CREATE TABLE `push_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'Customer', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'Delivery Boy', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 'Waiter', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, 'Chef', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 'Branch Manager', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 'POS Operator', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 'Stuff', 'sanctum', '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(9, 'Pranav', 'sanctum', '2026-05-12 05:56:43', '2026-05-12 05:56:43');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(1, 5),
(16, 5),
(17, 5),
(1, 6),
(7, 6),
(12, 6),
(13, 6),
(14, 6),
(15, 6),
(16, 6),
(17, 6),
(28, 6),
(29, 6),
(30, 6),
(31, 6),
(32, 6),
(33, 6),
(40, 6),
(41, 6),
(42, 6),
(43, 6),
(44, 6),
(45, 6),
(46, 6),
(47, 6),
(48, 6),
(49, 6),
(50, 6),
(51, 6),
(52, 6),
(53, 6),
(54, 6),
(55, 6),
(56, 6),
(57, 6),
(58, 6),
(59, 6),
(60, 6),
(61, 6),
(62, 6),
(63, 6),
(64, 6),
(65, 6),
(66, 6),
(1, 7),
(12, 7),
(13, 7),
(13, 9),
(14, 9),
(15, 9),
(16, 9),
(40, 9),
(41, 9),
(42, 9),
(43, 9),
(44, 9);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` json NOT NULL,
  `settingable_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settingable_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `group`, `key`, `payload`, `settingable_type`, `settingable_id`, `created_at`, `updated_at`) VALUES
(1, 'company', 'company_name', '{\"$cast\": null, \"$value\": \"Kahumbo UK\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(2, 'company', 'company_email', '{\"$cast\": null, \"$value\": \"info@kahumbo.co.uk\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(3, 'company', 'company_phone', '{\"$cast\": null, \"$value\": \"+44 7345233213\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(4, 'company', 'company_website', '{\"$cast\": null, \"$value\": \"https://kahumbo.co.uk/\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(5, 'company', 'company_city', '{\"$cast\": null, \"$value\": \"Purley\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(6, 'company', 'company_state', '{\"$cast\": null, \"$value\": \"London\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(7, 'company', 'company_country_code', '{\"$cast\": null, \"$value\": \"GBR\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(8, 'company', 'company_zip_code', '{\"$cast\": null, \"$value\": \"CR8 2LP\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(9, 'company', 'company_address', '{\"$cast\": null, \"$value\": \"942 Brighton Road, Purley,\\nCR8 2LP\"}', NULL, NULL, '2026-03-24 12:52:08', '2026-03-24 12:52:08'),
(10, 'site', 'site_date_format', '{\"$cast\": null, \"$value\": \"d-m-Y\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(11, 'site', 'site_time_format', '{\"$cast\": null, \"$value\": \"h:i A\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(12, 'site', 'site_default_timezone', '{\"$cast\": null, \"$value\": \"Europe/London\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(13, 'site', 'site_default_branch', '{\"$cast\": null, \"$value\": 1}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(14, 'site', 'site_default_currency', '{\"$cast\": null, \"$value\": 1}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(15, 'site', 'site_default_currency_symbol', '{\"$cast\": null, \"$value\": \"£\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(16, 'site', 'site_currency_position', '{\"$cast\": null, \"$value\": 5}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(17, 'site', 'site_digit_after_decimal_point', '{\"$cast\": null, \"$value\": \"2\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(18, 'site', 'site_email_verification', '{\"$cast\": null, \"$value\": 5}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(19, 'site', 'site_phone_verification', '{\"$cast\": null, \"$value\": 10}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(20, 'site', 'site_default_language', '{\"$cast\": null, \"$value\": 1}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(21, 'site', 'site_google_map_key', '{\"$cast\": null, \"$value\": \"AIzaSyD72mmKAgNq12TWWw0GHD1O5tNA5Sei4tw\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(22, 'site', 'site_android_app_link', '{\"$cast\": null, \"$value\": null}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(23, 'site', 'site_ios_app_link', '{\"$cast\": null, \"$value\": null}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(24, 'site', 'site_copyright', '{\"$cast\": null, \"$value\": \"Powered by Indinite\"}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(25, 'site', 'site_language_switch', '{\"$cast\": null, \"$value\": 5}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(26, 'site', 'site_app_debug', '{\"$cast\": null, \"$value\": 10}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(27, 'site', 'site_auto_update', '{\"$cast\": null, \"$value\": 10}', NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(28, 'site', 'site_online_payment_gateway', '{\"$cast\": null, \"$value\": 10}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(29, 'site', 'site_default_sms_gateway', '{\"$cast\": null, \"$value\": null}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(30, 'site', 'site_guest_login', '{\"$cast\": null, \"$value\": 5}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(31, 'site', 'site_default_phone_digit_length', '{\"$cast\": null, \"$value\": 10}', NULL, NULL, '2026-04-23 23:48:42', '2026-04-23 23:48:42'),
(32, 'mail', 'mail_mailer', '{\"$cast\": null, \"$value\": \"smtp\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(33, 'mail', 'mail_host', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(34, 'mail', 'mail_port', '{\"$cast\": null, \"$value\": \"0\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(35, 'mail', 'mail_username', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(36, 'mail', 'mail_password', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(37, 'mail', 'mail_encryption', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(38, 'mail', 'mail_from_name', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(39, 'mail', 'mail_from_email', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(40, 'order_setup', 'order_setup_food_preparation_time', '{\"$cast\": null, \"$value\": \"45\"}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(41, 'order_setup', 'order_setup_schedule_order_slot_duration', '{\"$cast\": null, \"$value\": \"45\"}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(42, 'order_setup', 'order_setup_takeaway', '{\"$cast\": null, \"$value\": 5}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(43, 'order_setup', 'order_setup_delivery', '{\"$cast\": null, \"$value\": 5}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(44, 'order_setup', 'order_setup_free_delivery_kilometer', '{\"$cast\": null, \"$value\": \"2\"}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(45, 'order_setup', 'order_setup_basic_delivery_charge', '{\"$cast\": null, \"$value\": \"1\"}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(46, 'order_setup', 'order_setup_charge_per_kilo', '{\"$cast\": null, \"$value\": \"1\"}', NULL, NULL, '2026-03-24 12:34:57', '2026-03-24 12:34:57'),
(47, 'otp', 'otp_type', '{\"$cast\": null, \"$value\": \"5\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(48, 'otp', 'otp_digit_limit', '{\"$cast\": null, \"$value\": \"4\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(49, 'otp', 'otp_expire_time', '{\"$cast\": null, \"$value\": \"10\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(50, 'notification', 'notification_fcm_public_vapid_key', '{\"$cast\": null, \"$value\": \"BHGAweguxMQ0F6GI_GH6rPao8nHNp1FhCRte3UTnmmgsIhZBUz0wh_F2x_4xywO3g1FaJtZT2n7bWeT-g1GPTxg\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(51, 'notification', 'notification_fcm_api_key', '{\"$cast\": null, \"$value\": \"AIzaSyAmEHBVJDjpH9W9MOUAPsAjrdZPldqxf3Y\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(52, 'notification', 'notification_fcm_auth_domain', '{\"$cast\": null, \"$value\": \"kahumbo-4e6e7.firebaseapp.com\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(53, 'notification', 'notification_fcm_project_id', '{\"$cast\": null, \"$value\": \"kahumbo-4e6e7\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(54, 'notification', 'notification_fcm_storage_bucket', '{\"$cast\": null, \"$value\": \"kahumbo-4e6e7.firebasestorage.app\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(55, 'notification', 'notification_fcm_messaging_sender_id', '{\"$cast\": null, \"$value\": \"3032888630\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(56, 'notification', 'notification_fcm_app_id', '{\"$cast\": null, \"$value\": \"1:3032888630:web:acbd037e2d1242c5292f97\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(57, 'notification', 'notification_fcm_measurement_id', '{\"$cast\": null, \"$value\": \"G-6DSM99PBCB\"}', NULL, NULL, '2026-04-23 10:44:51', '2026-04-23 10:44:51'),
(58, 'notification', 'notification_fcm_json_file', '{\"$cast\": null, \"$value\": {}}', NULL, NULL, '2026-04-23 10:43:22', '2026-04-23 10:43:22'),
(59, 'cookies', 'cookies_details_page_id', '{\"$cast\": null, \"$value\": null}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(60, 'cookies', 'cookies_summary', '{\"$cast\": null, \"$value\": \"\"}', NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50'),
(61, 'theme', 'theme_logo', '{\"$cast\": null, \"$value\": {}}', NULL, NULL, '2026-03-24 18:26:22', '2026-03-24 18:26:22'),
(62, 'theme', 'theme_favicon_logo', '{\"$cast\": null, \"$value\": {}}', NULL, NULL, '2026-03-24 18:26:22', '2026-03-24 18:26:22'),
(63, 'theme', 'theme_footer_logo', '{\"$cast\": null, \"$value\": {}}', NULL, NULL, '2026-03-24 18:26:22', '2026-03-24 18:26:22'),
(64, 'license', 'license_key', '{\"$cast\": null, \"$value\": \"b6d68vy2-m7g5-20r0-5275-h103w73453q120\"}', NULL, NULL, '2026-03-24 14:13:29', '2026-03-24 14:13:29'),
(65, 'social_media', 'social_media_facebook', '{\"$cast\": null, \"$value\": \"https://www.facebook.com/kahumbo.uk\"}', NULL, NULL, '2026-03-24 12:35:48', '2026-03-24 12:35:48'),
(66, 'social_media', 'social_media_youtube', '{\"$cast\": null, \"$value\": \"https://www.tiktok.com/@kahumbo_uk\"}', NULL, NULL, '2026-03-24 12:35:48', '2026-03-24 12:35:48'),
(67, 'social_media', 'social_media_instagram', '{\"$cast\": null, \"$value\": \"https://www.instagram.com/kahumbo_uk/\"}', NULL, NULL, '2026-03-24 12:35:48', '2026-03-24 12:35:48'),
(68, 'social_media', 'social_media_twitter', '{\"$cast\": null, \"$value\": \"https://www.tiktok.com/@kahumbo_uk\"}', NULL, NULL, '2026-03-24 12:35:48', '2026-03-24 12:35:48');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `title`, `description`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Best offers on tasty Drinks', NULL, 5, NULL, NULL, NULL, NULL, '2026-03-24 13:20:33', '2026-03-24 13:20:33'),
(2, 'Hot  Shots at cool Prices', NULL, 5, NULL, NULL, NULL, NULL, '2026-03-24 13:21:00', '2026-03-24 13:21:00'),
(3, 'as', NULL, 5, NULL, NULL, NULL, NULL, '2026-03-24 13:22:31', '2026-03-24 13:22:31');

-- --------------------------------------------------------

--
-- Table structure for table `sms_gateways`
--

CREATE TABLE `sms_gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `misc` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sms_gateways`
--

INSERT INTO `sms_gateways` (`id`, `name`, `slug`, `misc`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'Twilio', 'twilio', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(2, 'Clickatell', 'clickatell', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(3, 'Nexmo', 'nexmo', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(4, 'Msg91', 'msg91', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(5, '2Factor', 'twofactor', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(6, 'Bulksms', 'bulksms', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(7, 'Bulksmsbd', 'bulksmsbd', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49'),
(8, 'Telesign', 'telesign', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-03-24 18:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `social_logins`
--

CREATE TABLE `social_logins` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `misc` longtext COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '5',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `social_logins`
--

INSERT INTO `social_logins` (`id`, `name`, `slug`, `misc`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'google', 'google', 'null', 5, NULL, NULL, NULL, NULL, '2026-03-24 18:15:49', '2026-04-23 11:41:16');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tax_rate` decimal(13,6) NOT NULL,
  `type` tinyint NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `code`, `tax_rate`, `type`, `status`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, 'VAT', 'vat', 20.000000, 10, 5, NULL, NULL, NULL, NULL, '2026-03-24 18:28:44', '2026-03-24 18:28:44');

-- --------------------------------------------------------

--
-- Table structure for table `time_slots`
--

CREATE TABLE `time_slots` (
  `id` bigint UNSIGNED NOT NULL,
  `opening_time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `closing_time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day` tinyint NOT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `time_slots`
--

INSERT INTO `time_slots` (`id`, `opening_time`, `closing_time`, `day`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `created_at`, `updated_at`) VALUES
(1, '11:00', '23:00', 1, NULL, NULL, NULL, NULL, '2026-03-24 13:06:38', '2026-03-24 13:06:38'),
(2, '11:00', '23:00', 2, NULL, NULL, NULL, NULL, '2026-03-24 13:06:57', '2026-03-24 13:06:57'),
(3, '11:00', '23:00', 3, NULL, NULL, NULL, NULL, '2026-03-24 13:07:13', '2026-03-24 13:07:13'),
(4, '11:00', '23:00', 4, NULL, NULL, NULL, NULL, '2026-03-24 13:07:37', '2026-03-24 13:07:37'),
(5, '11:00', '23:00', 5, NULL, NULL, NULL, NULL, '2026-03-24 13:07:58', '2026-03-24 13:07:58'),
(6, '11:00', '23:00', 6, NULL, NULL, NULL, NULL, '2026-03-24 13:08:22', '2026-03-24 13:08:22'),
(7, '11:00', '23:00', 0, NULL, NULL, NULL, NULL, '2026-03-24 13:08:55', '2026-03-24 13:08:55');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `sign` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '+',
  `order_id` bigint UNSIGNED NOT NULL,
  `transaction_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'payment',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT '0',
  `country_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guest` tinyint UNSIGNED NOT NULL DEFAULT '10',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '5' COMMENT '5=Active, 10=Inactive',
  `balance` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `editor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor_id` bigint DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `username`, `email_verified_at`, `password`, `device_token`, `web_token`, `branch_id`, `country_code`, `is_guest`, `status`, `balance`, `creator_type`, `creator_id`, `editor_type`, `editor_id`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'archan Raar', 'madmin@kahumbo.co.uk', '7345233213', 'admin', '2026-03-24 18:15:49', '$2y$12$RASJ1Hx5c8CPcn9FA2tD2.jjPHPCx3yn2aXpVn3BiTQ7XhELxBl.i', NULL, 'eZt0Jlg-E4CUiwqm0HlIsu:APA91bEP2-U9dWIfPPc70ZhM4p1OdDjEpQfd0PQ45SBGIsA4EfJ3IAMMcPb4CunKlePXJbqdcnqCxlrMzL5mPQ6Et-tojth8Dqs8jYA5r9Gtsq4XZaEu234', 0, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-24 18:15:50', '2026-05-13 02:23:31', NULL),
(2, 'Walking Customer', 'walkingcustomer@example.com', '125444455', 'default-customer', '2026-03-24 18:15:50', '$2y$12$ywrVJ91CUc9jkBGtH71t4.GRjBBhUpMFlmzqguWnc0qRow5cpOV/K', NULL, NULL, 0, '+880', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-24 18:15:50', '2026-03-24 18:15:50', NULL),
(3, 'Guest User', NULL, '9898098980', 'guest-user12642', '2026-03-24 13:23:42', '$2y$12$LRfeSi2OeELN3ls.QsxgXewvBcsEkA0uCgi9bYQPFXIRzHa5ZGIS.', NULL, NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-24 13:23:42', '2026-03-24 13:23:42', NULL),
(4, 'Guest User', NULL, '9879879879', 'guest-user40494', '2026-03-24 14:18:31', '$2y$12$ZgN0uzuw1GE7xXRx4G84PO88Lv16ZCLvpAHW1yDjjFhrlCl2xYNK.', 'cnySRRN6RT6kFJ344TiwVs:APA91bHaIZ7U3NVvlJEhNUdNYxXt6z2p80MYj1U-b_0FZmqLvpAc7_fNSzH5xI3HpyzwBn2h8WGNmzWlTQM5BOSpk0PXDXX-_wJQc-OI7QwFyvOfVxDR_fQ', NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-24 14:18:31', '2026-03-24 14:18:33', NULL),
(5, 'Guest User', NULL, '4545258515', 'guest-user22829', '2026-03-24 23:47:23', '$2y$12$eDaVDb8OlwReCaKr6ptI5OHmzb.SxW.CHnxkePe6Fm5VZkXlDQHrm', NULL, NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-24 23:47:23', '2026-03-24 23:47:23', NULL),
(6, 'abhi chauhan', 'chauhanmrabhishek@gmail.com', '4008686861', 'abhi-chauhan', '2026-03-25 08:54:11', '$2y$12$yzhSk0iudbkPspaRzqFiGuxM6sBqMfFXMeySNrgG7BWaEYu9vxQo2', 'e7V9vKxLQrCjc64gqcPnBu:APA91bEiz2bmHspZpeo4tYvBFRHYHKipqIQUgIphzBU3aH03c_u2Sg_xDwAqspbrCm_y--Ky5EicMZxlecZF_7UW18Fr3aWLyuaufRxUIAg_RryS92pEbDg', NULL, 0, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-25 08:54:12', '2026-03-25 08:54:14', NULL),
(7, 'Guest User', NULL, '8663837747', 'guest-user18036', '2026-03-25 08:55:02', '$2y$12$7wsEr6HvvAQghA63/oI0Y.UcZvi8WDgb7mG75guni8kSU1t/Z2c2a', NULL, NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-03-25 08:55:03', '2026-03-25 08:55:03', NULL),
(8, 'Guest User', NULL, '7425356628', 'guest-user19529', '2026-04-10 02:53:21', '$2y$12$nmY4.q8TTCAdzbeuAPCktuFdMY.Rpslk7nsbXo.LojvO6Bja/h4Pe', NULL, 'ceHJP-mZCqY6bJl2cLnXaZ:APA91bHuRRGTC3IdHoPpU9nPRTaQHQYVk4j3fvb1ha2Q_X26yo9Mt-1hF3KMSZn3G5FI7FzlWGog4TXAG5LSZv8A1Y0ZD1dZCydcd60cE0Uond3FU84PfRc', 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-10 02:53:21', '2026-05-11 03:20:54', NULL),
(9, 'Guest User', NULL, '2345678908', 'guest-user11549', '2026-04-10 03:08:31', '$2y$12$FxAm4N9ZelPI/SCyBvZGQeS//1cK2ctTQgWPb8NZRAHhcqWalwv1W', NULL, NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-10 03:08:32', '2026-04-10 03:08:32', NULL),
(10, 'Nipun Vashistha', 'nipun@gmail.com', '1234567891', 'nipun-vashistha', '2026-04-17 06:32:22', '$2y$12$QOE9Yk20lpW2YRy.7AVycupRTyhZqvOpbkhTpZFi/Mpgfpb85nLUy', 'cX5Y6lgKR6aI4SyncXY-Vp:APA91bHRJ2Dtc9fwfycjLigh9KU8hm6YBGzh6vsOSDNzwdtxqdfpdw1MqQHCoWNXFxwtsTF7Ey36AD7DccL9L52zQ0NTBCQwYXC3qXlR_cAWA2lCiXFV-cc', NULL, 0, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-17 06:32:23', '2026-05-11 04:14:07', NULL),
(11, 'nip vas', 'nip@gmail.com', '2345678991', 'nip-vas', '2026-04-17 06:35:31', '$2y$12$xrIOVBY9AOYk4iOaxdLPd.DncfoC4HyRwcMKbCGH7VIhkyYXdSTYq', 'dDHnHSnnTlqlKbA6ZYbWYy:APA91bH8UZ1Cr4a9BgWNrIbtblzbGpcemfT8Kqn9eRgReXicS2sl_hbI25hPUuBsBe0opgZGYIQqOoLhyPlr2j23jGrvwpCO0-NbV2CUXAsVg60f_5BJr5Y', NULL, 0, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-17 06:35:31', '2026-04-17 06:35:33', NULL),
(12, 'Nipun', 'nipusn@gmail.com', '0987121232', 'nipusn996713561', '2026-04-17 06:39:29', '$2y$12$JIAcqqUcpK1L.tFVUD0hVukKrwc6NI6tdZmCBpNTTTjIGP5.MFGQO', 'fpkF-_ypRJeySxGeVwpoKo:APA91bG6Wez621J1lEpaW1OU8dQQNDG5L6MwPmbfRlwCZXhadZwRtsDyz4an86HSULGuy0i_fu3EPl_5zoUEkzkpPt4R_aG0H82Zu3xql6immJEcYl8cmLk', NULL, 1, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-17 06:39:29', '2026-04-17 07:01:34', '2026-04-17 07:01:34'),
(13, 'TEST DELIVERY BOY', 'a@gmail.com', '2987121232', 'a1456792737', '2026-04-17 12:44:24', '$2y$12$kTwdgfIXaBjQPJBlMu4Vhuc/gDNSwpuYF.UY5mHmFlPybkBp2yQAG', '@', NULL, 1, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-17 12:44:24', '2026-04-17 12:44:47', NULL),
(14, 'Guest User', NULL, '1236459870', 'guest-user63479', '2026-04-17 13:13:17', '$2y$12$QDWkpq38ybfRoD0eNEnhQelZb5dgHimGGn7xP22J6RXnVlxAq165u', '@', NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-17 13:13:17', '2026-04-17 13:13:18', NULL),
(15, 'Guest User', NULL, '1234567894', 'guest-user85322', '2026-04-23 23:55:15', '$2y$12$nXFQAX2jg5qorcEumcazVu150NF50COJXns0vHaKdRkXQOOllvXfu', 'eKdAEWCpSnmuvbqyE9SSrN:APA91bF8dn5gfel24THwyt5eOTeNPr3c5X51MY5LD_KcUhTw6VLuxX1AGDOrcyTXu-9dYHDZxv9t0inMRX9680dQpIU1_9R4tASwTAYDjzdFpa2BNRDIsHI', NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-23 23:55:15', '2026-04-23 23:55:17', NULL),
(16, 'Nipun', 'nipun4@gmail.com', '1234567892', 'nipun41660348822', '2026-04-24 00:14:38', '$2y$12$l6icQqeQF5Oj52FB7CkhkORHKi1zuO/3BG2qYPIPPGmJ/H8diC0w6', 'frSCgmubQfW3cq6Ke3iS28:APA91bH0cOBbEmu68b-jGNvh8q_pWRMXoO_u5MGhHhRBXEi__Z--5m61kOcyKpxaknCNsyifXno5Hde4UEfok7m4giSbx4o0sSr7FO9bf0YdEqHiPQq3Gds', NULL, 1, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-24 00:14:38', '2026-04-24 00:31:35', NULL),
(17, 'Demo-customer', 'customer@example.com', '1234567899', 'customer913150644', '2026-04-24 01:03:55', '$2y$12$prPohyoCRaoyEHCgfj.fPON0Da/oHrIZZedMFHupiSnfJiMQaixyO', 'f8aeal21Sk2moGwSIvXhS4:APA91bEBJophmo9DU9_IbGmbLK1UyYxcdlT8-KmqO2PX-sERQrAduRJp7eveVi_7DbWe72Y_edhejGXFX4IGeSChdXJdwbBsZCuFw7OaTgVowlfIB4LjRik', NULL, 0, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-24 01:03:55', '2026-04-24 01:26:42', NULL),
(18, 'deliveryboy-1', 'testdriver@gmail.com', '1234567895', 'testdriver2075102556', '2026-04-26 08:56:58', '$2y$12$QG43t1DCtZfYiNbPHZb8GuyV7A9Ub3DBcJp9CGZRSHsqSCZo.dCnm', 'fUh3c5k_TaGbWJeLErk9Ft:APA91bFoBDfoEg1PIjdRL4hDW3SlU2t4RJktPA1Rrw0upN0-2IXuLtW7LjupEYzx1ZAtaAaWl4OrkWLiZolK16ebLbLgS_P7dJc_Q-bPFUsvsxjhuUlhV3g', NULL, 1, '+44', 10, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-26 08:56:58', '2026-05-01 21:40:14', NULL),
(19, 'Guest User', NULL, '8855223355', 'guest-user23704', '2026-04-26 23:19:16', '$2y$12$dS.Glm9Bc4m1Rql5uOOIR.fUs7XAgbB3NkkI8WeFZ4kYSgKoQ9zUC', 'em0aqyMrSMeTAwuVWbVWd2:APA91bGsB79X_uNn0ys7EMZpCs-rsjyoYE4gvnrmpv0b0B50se7Lmnnx3Fq6cKKRAvIspAIWu3n4PMZAfV6XcYrHQ1DXjnjIt8nckhcL2XCGNzpEAYYBjXc', NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-04-26 23:19:16', '2026-04-26 23:19:17', NULL),
(20, 'Guest User', NULL, '7827661411', 'guest-user42060', '2026-05-12 05:59:14', '$2y$12$xwWVbn.9pmD3083ytYPPAunStlEZsS6MBN2k.q0FoXr4aU.OSM.a6', 'cj_zXPQ5RkKlV17cFikLVT:APA91bH6yXGuy85nncWaDmFKVeJxDBIqcN7YEoMSl3CAP13YhN0AHgSAomAfVnxuTPK2zVEtWIKsDzU6TB4FHZvhjnilV6OPuUC5bIuZKNXlI9VaGL49R_8', NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-05-12 05:59:15', '2026-05-12 05:59:16', NULL),
(21, 'Guest User', NULL, '9004768832', 'guest-user11507', '2026-05-13 02:16:53', '$2y$12$PLQ0N9GAlWzqJHpt2RM00O4kc13ijvZ2Iy03obpC9S5VPEM3wgmvS', 'eEZ8uri5TFyE_m7ahM3W-I:APA91bGBuhIXfDbHylsXb8sI8MN9vw5oAXgHoP6HAi_L4fxRgjl0Zx7y50MgcF-FXSn8RVYfgzLQ4dFesKMt_1EHYXfolq5FYUsfByEv9HGPjTf0IpqCX7Y', NULL, 0, '+44', 5, 5, 0.000000, NULL, NULL, NULL, NULL, NULL, '2026-05-13 02:16:54', '2026-05-13 02:16:55', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `analytics`
--
ALTER TABLE `analytics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `analytic_sections`
--
ALTER TABLE `analytic_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `analytic_sections_analytic_id_foreign` (`analytic_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `default_access`
--
ALTER TABLE `default_access`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dining_tables`
--
ALTER TABLE `dining_tables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dining_tables_slug_unique` (`slug`),
  ADD KEY `dining_tables_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gateway_options`
--
ALTER TABLE `gateway_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_item_category_id_foreign` (`item_category_id`),
  ADD KEY `items_tax_id_foreign` (`tax_id`);

--
-- Indexes for table `item_addons`
--
ALTER TABLE `item_addons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_addons_item_id_foreign` (`item_id`),
  ADD KEY `item_addons_addon_item_id_foreign` (`addon_item_id`);

--
-- Indexes for table `item_attributes`
--
ALTER TABLE `item_attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_categories`
--
ALTER TABLE `item_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_extras`
--
ALTER TABLE `item_extras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_extras_item_id_foreign` (`item_id`);

--
-- Indexes for table `item_variations`
--
ALTER TABLE `item_variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_variations_item_id_foreign` (`item_id`),
  ADD KEY `item_variations_item_attribute_id_foreign` (`item_attribute_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kiosk_machines`
--
ALTER TABLE `kiosk_machines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kiosk_machines_user_id_foreign` (`user_id`),
  ADD KEY `kiosk_machines_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_sections`
--
ALTER TABLE `menu_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_templates`
--
ALTER TABLE `menu_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_user_id_foreign` (`user_id`);

--
-- Indexes for table `message_histories`
--
ALTER TABLE `message_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_histories_message_id_foreign` (`message_id`),
  ADD KEY `message_histories_user_id_foreign` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_alerts`
--
ALTER TABLE `notification_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offer_items`
--
ALTER TABLE `offer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offer_items_offer_id_foreign` (`offer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `order_addresses`
--
ALTER TABLE `order_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_addresses_order_id_foreign` (`order_id`),
  ADD KEY `order_addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_coupons`
--
ALTER TABLE `order_coupons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_coupons_order_id_foreign` (`order_id`),
  ADD KEY `order_coupons_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_branch_id_foreign` (`branch_id`),
  ADD KEY `order_items_item_id_foreign` (`item_id`);

--
-- Indexes for table `otps`
--
ALTER TABLE `otps`
  ADD KEY `otps_phone_index` (`phone`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pages_menu_section_id_foreign` (`menu_section_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `push_notifications`
--
ALTER TABLE `push_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_settingable_type_settingable_id_index` (`settingable_type`,`settingable_id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms_gateways`
--
ALTER TABLE `sms_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_logins`
--
ALTER TABLE `social_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_unique` (`email`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `time_slots`
--
ALTER TABLE `time_slots`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `analytics`
--
ALTER TABLE `analytics`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `analytic_sections`
--
ALTER TABLE `analytic_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `default_access`
--
ALTER TABLE `default_access`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `dining_tables`
--
ALTER TABLE `dining_tables`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gateway_options`
--
ALTER TABLE `gateway_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `item_addons`
--
ALTER TABLE `item_addons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_attributes`
--
ALTER TABLE `item_attributes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `item_categories`
--
ALTER TABLE `item_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `item_extras`
--
ALTER TABLE `item_extras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_variations`
--
ALTER TABLE `item_variations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kiosk_machines`
--
ALTER TABLE `kiosk_machines`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `menu_sections`
--
ALTER TABLE `menu_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_templates`
--
ALTER TABLE `menu_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `message_histories`
--
ALTER TABLE `message_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_alerts`
--
ALTER TABLE `notification_alerts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `offer_items`
--
ALTER TABLE `offer_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_addresses`
--
ALTER TABLE `order_addresses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_coupons`
--
ALTER TABLE `order_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `push_notifications`
--
ALTER TABLE `push_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_gateways`
--
ALTER TABLE `sms_gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `social_logins`
--
ALTER TABLE `social_logins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `time_slots`
--
ALTER TABLE `time_slots`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `analytic_sections`
--
ALTER TABLE `analytic_sections`
  ADD CONSTRAINT `analytic_sections_analytic_id_foreign` FOREIGN KEY (`analytic_id`) REFERENCES `analytics` (`id`);

--
-- Constraints for table `dining_tables`
--
ALTER TABLE `dining_tables`
  ADD CONSTRAINT `dining_tables_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_item_category_id_foreign` FOREIGN KEY (`item_category_id`) REFERENCES `item_categories` (`id`),
  ADD CONSTRAINT `items_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`);

--
-- Constraints for table `item_addons`
--
ALTER TABLE `item_addons`
  ADD CONSTRAINT `item_addons_addon_item_id_foreign` FOREIGN KEY (`addon_item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `item_addons_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Constraints for table `item_extras`
--
ALTER TABLE `item_extras`
  ADD CONSTRAINT `item_extras_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Constraints for table `item_variations`
--
ALTER TABLE `item_variations`
  ADD CONSTRAINT `item_variations_item_attribute_id_foreign` FOREIGN KEY (`item_attribute_id`) REFERENCES `item_attributes` (`id`),
  ADD CONSTRAINT `item_variations_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Constraints for table `kiosk_machines`
--
ALTER TABLE `kiosk_machines`
  ADD CONSTRAINT `kiosk_machines_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `kiosk_machines_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `message_histories`
--
ALTER TABLE `message_histories`
  ADD CONSTRAINT `message_histories_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  ADD CONSTRAINT `message_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `offer_items`
--
ALTER TABLE `offer_items`
  ADD CONSTRAINT `offer_items_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_addresses`
--
ALTER TABLE `order_addresses`
  ADD CONSTRAINT `order_addresses_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_coupons`
--
ALTER TABLE `order_coupons`
  ADD CONSTRAINT `order_coupons_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_coupons_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `order_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_menu_section_id_foreign` FOREIGN KEY (`menu_section_id`) REFERENCES `menu_sections` (`id`);

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
