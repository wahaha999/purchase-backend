/*
SQLyog Trial v13.1.8 (64 bit)
MySQL - 10.4.28-MariaDB : Database - ecommerce
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ecommerce` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_nopad_ci */;

USE `ecommerce`;

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

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

/*Data for the table `failed_jobs` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2019_05_03_000001_create_customer_columns',1),
(4,'2019_05_03_000002_create_subscriptions_table',1),
(5,'2019_05_03_000003_create_subscription_items_table',1),
(6,'2019_08_19_000000_create_failed_jobs_table',1),
(7,'2019_12_14_000001_create_personal_access_tokens_table',1),
(8,'2023_10_26_035613_create_products_table',1),
(9,'2023_10_26_082738_add_type_to_users_table',1),
(10,'2023_10_26_111430_add_columns_to_products_table',1),
(11,'2023_10_26_160714_create_purchases_table',1),
(12,'2023_10_27_110308_add_column_to_users_table',2);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `type` enum('b2c','b2b') NOT NULL DEFAULT 'b2c',
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`created_at`,`updated_at`,`name`,`description`,`price`,`type`,`image`) values 
(1,'2023-10-26 21:41:05','2023-10-26 21:41:11','MacBook Air 13.3','Laptop - Apple M1 chip - 8GB Memory - 256GB SSD - Space Gray',999.99,'b2b','/assets/images/macbook.jpg'),
(2,'2023-10-26 21:42:42','2023-10-26 21:42:46','TCL - 50','Class Q5 Q-Class 4K QLED HDR Smart TV with Google TV',269.99,'b2c','/assets/images/tcl.jpg');

/*Table structure for table `purchases` */

DROP TABLE IF EXISTS `purchases`;

CREATE TABLE `purchases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `card_num` varchar(255) NOT NULL,
  `card_brand` varchar(255) NOT NULL,
  `receipt_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `purchases_session_id_unique` (`session_id`),
  KEY `purchases_user_id_foreign` (`user_id`),
  KEY `purchases_product_id_foreign` (`product_id`),
  CONSTRAINT `purchases_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `purchases` */

insert  into `purchases`(`id`,`user_id`,`product_id`,`session_id`,`card_num`,`card_brand`,`receipt_url`,`created_at`,`updated_at`) values 
(2,14,1,'cs_test_a1S8AT0hpeGS9zAzRRAwVEHXm5mmzImxezzlupOOqEG5wDZy3NasRHZxi5','4242','visa','https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTzVIcmlBQU1MbXN5dDdHKKOe76kGMga1SXHNTss6LBa6S0UhwucAxiP4Ysr-519wgoijrhYHOL131IBrtHyWVJfNFtOIrOaqCZ4s','2023-10-27 14:54:27','2023-10-27 14:54:27'),
(3,14,2,'cs_test_a1T8WSrs34Wjud5y4jK4Dm35GsPljD4c8uNsb450QGdDJMqLmELlZRJrD7','4242','visa','https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTzVIcmlBQU1MbXN5dDdHKNCp76kGMgYE8huhDPY6LBZ7iQ9D9VUPM7qKFMMUvGAI-9SdpkHwECJPUWJhGtQl4bCCMp0Vuj5TAZsr','2023-10-27 15:18:40','2023-10-27 15:18:40'),
(4,14,2,'cs_test_a1OUcNs0XLYLUbuEsiGwr3Pg00J6GK4Nx5HwrtUxXv4yYyHQMPVwNFIiLE','4242','visa','https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTzVIcmlBQU1MbXN5dDdHKP6s76kGMgYu0YsX1Z46LBYpPAzm3G9zdD6jSFCo3TsYqBu6ZPkQxMpSrgZQE-TFwHC9tMDadwXpIYOn','2023-10-27 15:25:51','2023-10-27 15:25:51'),
(5,14,1,'cs_test_a18DYt9jJkaOV4cbpSVhrIdQv5PrmFdorw3IHgE7h7uc7jlkaQ0rUoHV8g','4242','visa','https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTzVIcmlBQU1MbXN5dDdHKPHS76kGMgbND0oPewI6LBaZmdFllN--RqYuuvXrYxtEaRH44cy6fIAtgQonmPEZhU5j_eCcizLMrAgU','2023-10-27 16:46:41','2023-10-27 16:46:41');

/*Table structure for table `subscription_items` */

DROP TABLE IF EXISTS `subscription_items`;

CREATE TABLE `subscription_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint(20) unsigned NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_product` varchar(255) NOT NULL,
  `stripe_price` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscription_items_subscription_id_stripe_price_unique` (`subscription_id`,`stripe_price`),
  UNIQUE KEY `subscription_items_stripe_id_unique` (`stripe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscription_items` */

/*Table structure for table `subscriptions` */

DROP TABLE IF EXISTS `subscriptions`;

CREATE TABLE `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_status` varchar(255) NOT NULL,
  `stripe_price` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriptions_stripe_id_unique` (`stripe_id`),
  KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `subscriptions` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(255) DEFAULT NULL,
  `pm_type` varchar(255) DEFAULT NULL,
  `pm_last_four` varchar(4) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','b2c','b2b','user') NOT NULL DEFAULT 'user',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_stripe_id_index` (`stripe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`,`stripe_id`,`pm_type`,`pm_last_four`,`trial_ends_at`,`role`,`status`) values 
(1,'John','john.loveall3426@gmail.com',NULL,'$2y$10$XPm8SY7pLUG3ce/X02WxG.Y0ggzdN9MpjXZKzthBJyRaAmDogJ1ya',NULL,'2023-10-26 21:39:44','2023-10-27 12:25:42',NULL,NULL,NULL,NULL,'admin','1'),
(2,'Kyle','kyle@gmail.com',NULL,'$2y$10$7wQUU2wo0NfiUdZ9V/kXoOjaCM1M6qXsc4YX7GGxinGCDZeq7DR6K',NULL,'2023-10-26 22:59:02','2023-10-26 22:59:02',NULL,NULL,NULL,NULL,'user','1'),
(14,'James Franzo','james.franzo5053@gmail.com',NULL,'$2y$10$VDpglP8FjzI9xb6qGTjSruUQ2Zg525Nn5py1Hv2EhLoTNH7UbpiGC',NULL,'2023-10-27 14:52:58','2023-10-27 16:46:40',NULL,NULL,NULL,NULL,'b2b','1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
