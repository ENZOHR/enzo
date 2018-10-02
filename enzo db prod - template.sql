-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 08, 2014 at 09:48 AM
-- Server version: 5.5.32-cll
-- PHP Version: 5.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `enzo_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE IF NOT EXISTS `agent` (
  `id` bigint(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'N',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `oib` bigint(11) NOT NULL,
  `client_type_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `cell` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `oib_UNIQUE` (`oib`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `client_ledger`
--

CREATE TABLE IF NOT EXISTS `client_ledger` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `credit` int(11) NOT NULL DEFAULT '0' COMMENT 'credit receive for activity',
  `debit` int(11) NOT NULL DEFAULT '0' COMMENT 'debit to account - credit used to pay for service/product',
  `balance` int(11) DEFAULT NULL COMMENT 'plus for credit, 0 for debit, cannot be minus',
  `desc` varchar(255) DEFAULT NULL COMMENT 'nature of transactions, usually precoded',
  `user_id` int(11) NOT NULL COMMENT 'doublecheck for client,should be clientid logged ',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `client_type`
--

CREATE TABLE IF NOT EXISTS `client_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `client_type`
--

INSERT INTO `client_type` (`id`, `name`) VALUES
(1, 'default');

-- --------------------------------------------------------

--
-- Stand-in structure for view `client_view`
--
CREATE TABLE IF NOT EXISTS `client_view` (
`id` int(11)
,`first_name` varchar(255)
,`last_name` varchar(255)
,`oib` bigint(11)
,`client_type_id` int(11)
,`location_id` int(11)
,`address` varchar(255)
,`phone` varchar(45)
,`cell` varchar(45)
,`email` varchar(150)
,`active` enum('Y','N')
,`client_type_name` varchar(255)
,`count(property.id)` bigint(21)
);
-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `language_id` int(11) NOT NULL COMMENT 'default lang',
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`, `language_id`, `active`) VALUES
(1, 'Hrvatska', 1, 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `country_language`
--

CREATE TABLE IF NOT EXISTS `country_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `country_language`
--

INSERT INTO `country_language` (`id`, `country_id`, `language_id`, `active`) VALUES
(1, 1, 1, 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE IF NOT EXISTS `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer` int(11) DEFAULT NULL,
  `curency` enum('HRK') NOT NULL,
  `validate_code` varchar(32) NOT NULL,
  `promo_code` char(5) NOT NULL,
  `promo_count` int(11) NOT NULL DEFAULT '0',
  `member_service_class_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL COMMENT '	',
  `location_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `service_date` date DEFAULT NULL,
  `service_time` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_address` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(45) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_period` varchar(150) DEFAULT NULL,
  `accept_t_c` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_ordered` enum('N','Y') NOT NULL DEFAULT 'Y',
  `is_delivered` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_delivered_by_email` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_delivered_by_phone` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_delivered_by_post` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_accepted_by_member` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_client_notified` enum('N','Y') DEFAULT 'N',
  `is_validated_by_client` enum('N','Y') NOT NULL DEFAULT 'N',
  `is_validated_by_member` enum('N','Y') NOT NULL DEFAULT 'N',
  `validate_timestamp` datetime DEFAULT NULL,
  `active` enum('N','Y') NOT NULL DEFAULT 'Y',
  `user_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `validate_code_UNIQUE` (`validate_code`),
  UNIQUE KEY `promo_code_UNIQUE` (`promo_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_codes`
--

CREATE TABLE IF NOT EXISTS `coupon_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(5) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=401 ;

--
-- Dumping data for table `coupon_codes`
--

INSERT INTO `coupon_codes` (`id`, `code`, `status`) VALUES
(71, 'P34C7', 0),
(72, 'AMV7E', 0),
(73, 'VLNLG', 0),
(74, 'UF6OB', 0),
(75, 'LMQS8', 0),
(76, 'HFSXC', 0),
(77, 'GRKOZ', 0),
(78, 'TFA9E', 0),
(79, 'WLQ60', 0),
(80, 'P6MBW', 0),
(81, 'C39GC', 0),
(82, 'XWXHW', 0),
(83, 'I1O5H', 0),
(84, 'ACH9I', 0),
(85, 'OCYPK', 0),
(86, '5P9JL', 0),
(87, 'O65AS', 0),
(88, 'J8WOI', 0),
(89, 'RXHA2', 0),
(90, 'TSTJG', 0),
(91, 'S5EVC', 0),
(92, 'X3LBG', 0),
(93, 'YUXGE', 0),
(94, 'GXTMQ', 0),
(95, '4TJ2L', 0),
(96, '3M5AP', 0),
(97, 'CL8ET', 0),
(98, '0AP34', 0),
(99, '5H2HQ', 0),
(100, 'L52MY', 0),
(101, '7IW7I', 0),
(102, '2ERVE', 0),
(103, 'YW2T7', 0),
(104, 'BPVZ8', 0),
(105, 'ZBW9I', 0),
(106, '3EOUO', 0),
(107, 'X0Z1T', 0),
(108, '9USIN', 0),
(109, 'TNQKN', 0),
(110, 'H158T', 0),
(111, '3AVD6', 0),
(112, 'AR7NR', 0),
(113, 'IV0O7', 0),
(114, 'JP21Q', 0),
(115, 'NX2K4', 0),
(116, '7G6M8', 0),
(117, '0WAXH', 0),
(118, 'NL0YU', 0),
(119, 'G5Z9Q', 0),
(120, '7F3BM', 0),
(121, '433GU', 0),
(122, 'TV3BE', 0),
(123, '4P4YV', 0),
(124, '9EP67', 0),
(125, 'IJFVN', 0),
(126, 'FFMCT', 0),
(127, 'Q4HL6', 0),
(128, 'P4RIU', 0),
(129, 'D33PV', 0),
(130, 'OWY65', 0),
(131, '95873', 0),
(132, 'FO2ZU', 0),
(133, 'PLWTQ', 0),
(134, 'PVHEJ', 0),
(135, 'FMRUX', 0),
(136, '5X7GC', 0),
(137, '2DL9Z', 0),
(138, 'F9PBV', 0),
(139, 'LWPGP', 0),
(140, 'XOLNU', 0),
(141, 'RA16A', 0),
(142, '54CC7', 0),
(143, 'IEJAY', 0),
(144, 'KTIFN', 0),
(145, 'MEGP6', 0),
(146, '4T7WM', 0),
(147, '9SESM', 0),
(148, '5NLQF', 0),
(149, 'VAH54', 0),
(150, 'TRNCO', 0),
(151, 'K529P', 0),
(152, '1P8LM', 0),
(153, 'FS8P4', 0),
(154, '6WW6B', 0),
(155, 'VTD42', 0),
(156, 'LDVFT', 0),
(157, 'EBY1P', 0),
(158, 'JSTT9', 0),
(159, 'AIWT5', 0),
(160, 'LIRJJ', 0),
(161, 'AP8B7', 0),
(162, 'X429V', 0),
(163, 'F5K8K', 0),
(164, 'HKL6L', 0),
(165, '81HME', 0),
(166, 'X6LPC', 0),
(167, 'X8CKC', 0),
(168, 'MLZDS', 0),
(169, 'KM11P', 0),
(170, 'N4KUL', 0),
(171, 'EAS2Q', 0),
(172, 'XB3IQ', 0),
(173, 'XA990', 0),
(174, 'AZFI8', 0),
(175, '2FI1T', 0),
(176, 'TJ83A', 0),
(177, '5R0VL', 0),
(178, '5KEC4', 0),
(179, 'GKERO', 0),
(180, 'AXM9S', 0),
(181, 'NEO3Z', 0),
(182, 'TKQBR', 0),
(183, '3QONJ', 0),
(184, 'WBDU5', 0),
(185, 'QVMUS', 0),
(186, '7HZJ2', 0),
(187, 'FELU6', 0),
(188, 'DKKF1', 0),
(189, 'T8J5W', 0),
(190, '3SGKW', 0),
(191, 'WYFNL', 0),
(192, 'CXQI1', 0),
(193, 'W38G2', 0),
(194, 'E69MX', 0),
(195, '9RWQ4', 0),
(196, '9531V', 0),
(197, 'HCKEK', 0),
(198, '83JM5', 0),
(199, 'GS24C', 0),
(200, 'GVPHY', 0),
(201, 'MHWOM', 0),
(202, 'UZN6A', 0),
(203, 'SQY7F', 0),
(204, '4YZ2C', 0),
(205, 'DLYKH', 0),
(206, 'J5FIZ', 0),
(207, 'ODRAE', 0),
(208, 'VZ16K', 0),
(209, 'H0D9X', 0),
(210, 'G91FJ', 0),
(211, '494MS', 0),
(212, '1FB5K', 0),
(213, 'IZIGE', 0),
(214, 'DCL4J', 0),
(215, 'NL2QY', 0),
(216, 'YLXBP', 0),
(217, '446L8', 0),
(218, 'ZPB0H', 0),
(219, 'TQ4UV', 0),
(220, 'WEBXL', 0),
(221, '20LE4', 0),
(222, '48HI1', 0),
(223, 'IHF24', 0),
(224, '4HLQJ', 0),
(225, 'IWU56', 0),
(226, '3JZB1', 0),
(227, '4TRW5', 0),
(228, '3IM13', 0),
(229, 'MM3MQ', 0),
(230, '44BY2', 0),
(231, 'HOPFZ', 0),
(232, 'B8GP8', 0),
(233, 'RA1EO', 0),
(234, 'QJJ5A', 0),
(235, 'F6U57', 0),
(236, '94AW0', 0),
(237, '93SYU', 0),
(238, 'FVTIN', 0),
(239, 'XYUF5', 0),
(240, 'WFAGF', 0),
(241, 'I8B3I', 0),
(242, 'M3WL2', 0),
(243, 'STEEN', 0),
(244, 'LY193', 0),
(245, 'VCTN9', 0),
(246, 'EOZ9L', 0),
(247, '3LSB2', 0),
(248, 'X3BAL', 0),
(249, 'Z4KMQ', 0),
(250, '6PQEB', 0),
(251, 'JNYJ7', 0),
(252, 'UJ6G9', 0),
(253, 'I7IO8', 0),
(254, 'C54FQ', 0),
(255, 'DS3CQ', 0),
(256, '3ZHRF', 0),
(257, '4NDCI', 0),
(258, 'IYURJ', 0),
(259, 'T62SO', 0),
(260, '5RKKM', 0),
(261, '92677', 0),
(262, 'F941X', 0),
(263, 'JYU91', 0),
(264, 'X4AKX', 0),
(265, 'JZGHJ', 0),
(266, 'BARY8', 0),
(267, 'D2JWJ', 0),
(268, 'SKL9E', 0),
(269, 'IFS4W', 0),
(270, 'L3UVR', 0),
(271, 'BJWDJ', 0),
(272, 'WCXJ7', 0),
(273, 'L42US', 0),
(274, '48KZV', 0),
(275, 'W0367', 0),
(276, 'U4RX7', 0),
(277, 'AYP78', 0),
(278, 'AYVRF', 0),
(279, '7JVQI', 0),
(280, 'ZKSXG', 0),
(281, 'QR6Y4', 0),
(282, '9ECX4', 0),
(283, 'LW156', 0),
(284, 'JORTP', 0),
(285, '23XQI', 0),
(286, 'DVKWR', 0),
(287, '9V8PT', 0),
(288, '7618G', 0),
(289, '9E9AT', 0),
(290, 'ZW4ZH', 0),
(291, 'UAPM9', 0),
(292, 'O6AD9', 0),
(293, 'ZIEDQ', 0),
(294, '0G4EL', 0),
(295, 'PPJMU', 0),
(296, '5IV6Q', 0),
(297, 'LKEW1', 0),
(298, 'VLVP4', 0),
(299, 'TKW7X', 0),
(300, '7CV1N', 0),
(301, 'XXJ6C', 0),
(302, 'PLZ4S', 0),
(303, '52FUT', 0),
(304, 'JDGSX', 0),
(305, 'GI8B3', 0),
(306, '19YHV', 0),
(307, '4D6TZ', 0),
(308, 'O2FCS', 0),
(309, '02UZI', 0),
(310, 'OPYSY', 0),
(311, '3PH9H', 0),
(312, 'D3J78', 0),
(313, '2L51L', 0),
(314, 'Z7WHJ', 0),
(315, 'QFRY0', 0),
(316, '6QNKX', 0),
(317, '2E5BE', 0),
(318, 'VCLVX', 0),
(319, 'F6E27', 0),
(320, 'Y6BFA', 0),
(321, 'MH2RB', 0),
(322, '3DRUQ', 0),
(323, 'HNJ29', 0),
(324, 'GW8JM', 0),
(325, 'MASI3', 0),
(326, 'A7VT1', 0),
(327, 'GOJ9F', 0),
(328, 'ID1C3', 0),
(329, '2CZQQ', 0),
(330, '1IN4M', 0),
(331, 'B7DZO', 0),
(332, '6JBS6', 0),
(333, '8F5CB', 0),
(334, 'BOCE3', 0),
(335, 'YP097', 0),
(336, 'YPLYU', 0),
(337, 'PO93L', 0),
(338, 'H4TKN', 0),
(339, 'QGSIP', 0),
(340, 'S66ZR', 0),
(341, '7SITJ', 0),
(342, 'A9PFJ', 0),
(343, 'ZYHPI', 0),
(344, 'FRO10', 0),
(345, 'EFF6A', 0),
(346, '74D5I', 0),
(347, '66E69', 0),
(348, 'U72NF', 0),
(349, '0E5PU', 0),
(350, 'YQVMH', 0),
(351, 'W4N4H', 0),
(352, 'KPSXJ', 0),
(353, 'KTU0M', 0),
(354, 'ODIGA', 0),
(355, '9U8KU', 0),
(356, '5PH1E', 0),
(357, 'XPS15', 0),
(358, '4T7K9', 0),
(359, 'DQWR1', 0),
(360, '5BPZX', 0),
(361, 'O5AVJ', 0),
(362, '1YJGN', 0),
(363, 'VQUSG', 0),
(364, '37FTG', 0),
(365, 'GHTAO', 0),
(366, 'YN2Z4', 0),
(367, 'QRD0X', 0),
(368, '1XTG7', 0),
(369, 'VJ9YY', 0),
(370, 'BY51I', 0),
(371, 'YZ34A', 0),
(372, 'XWHAW', 0),
(373, 'FQOZH', 0),
(374, 'EVRSK', 0),
(375, '7MK36', 0),
(376, 'TCZNQ', 0),
(377, 'XLIJT', 0),
(378, 'OSAJQ', 0),
(379, 'NKKO4', 0),
(380, 'NPZXW', 0),
(381, 'XMMDH', 0),
(382, '956ZC', 0),
(383, 'MEDEZ', 0),
(384, 'LDTMX', 0),
(385, '9FUT7', 0),
(386, 'OMM5Q', 0),
(387, 'XC4D0', 0),
(388, 'GIMZ7', 0),
(389, '3SMSC', 0),
(390, 'KBXE8', 0),
(391, 'WXIZ3', 0),
(392, 'ITRIW', 0),
(393, 'TO1HW', 0),
(394, 'MWA75', 0),
(395, 'CHEQ6', 0),
(396, '9Z2HD', 0),
(397, 'UEP6B', 0),
(398, 'JA8R6', 0),
(399, 'OJ2MZ', 0),
(400, 'K9SYW', 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `coupon_view`
--
CREATE TABLE IF NOT EXISTS `coupon_view` (
`id` int(11)
,`offer` int(11)
,`curency` enum('HRK')
,`validate_code` varchar(32)
,`promo_code` char(5)
,`promo_count` int(11)
,`member_service_class_id` int(11)
,`client_id` int(11)
,`member_id` int(11)
,`location_id` int(11)
,`property_id` int(11)
,`service_date` date
,`service_time` varchar(255)
,`contact_name` varchar(255)
,`contact_address` varchar(255)
,`contact_phone` varchar(45)
,`contact_email` varchar(255)
,`accept_t_c` enum('N','Y')
,`is_ordered` enum('N','Y')
,`is_delivered` enum('N','Y')
,`is_delivered_by_email` enum('N','Y')
,`is_delivered_by_phone` enum('N','Y')
,`is_delivered_by_post` enum('N','Y')
,`is_accepted_by_member` enum('N','Y')
,`is_client_notified` enum('N','Y')
,`is_validated_by_client` enum('N','Y')
,`is_validated_by_member` enum('N','Y')
,`validate_timestamp` datetime
,`active` enum('N','Y')
,`user_id` int(11)
,`timestamp` datetime
);
-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `name`) VALUES
(1, 'hrvatski');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `region_id` int(11) NOT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `region_id_idx` (`region_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=770 ;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `name`, `region_id`, `active`) VALUES
(1, 'Dugo Selo', 1, 'Y'),
(2, 'Ivanić Grad', 1, 'Y'),
(3, 'Jastrebarsko', 1, 'Y'),
(4, 'Samobor', 1, 'Y'),
(5, 'Sveta Nedelja', 1, 'Y'),
(6, 'Sveti Ivan Zelina', 1, 'Y'),
(7, 'Velika Gorica', 1, 'Y'),
(8, 'Vrbovec', 1, 'Y'),
(9, 'Zaprešić', 1, 'Y'),
(10, 'Bedenica', 1, 'Y'),
(11, 'Bistra', 1, 'Y'),
(12, 'Brckovljani', 1, 'Y'),
(13, 'Brdovec', 1, 'Y'),
(14, 'Dubrava', 1, 'Y'),
(15, 'Dubravica', 1, 'Y'),
(16, 'Farkaševac', 1, 'Y'),
(17, 'Gradec', 1, 'Y'),
(18, 'Jakovlje', 1, 'Y'),
(19, 'Klinča Sela', 1, 'Y'),
(20, 'Kloštar Ivanić', 1, 'Y'),
(21, 'Krašić', 1, 'Y'),
(22, 'Kravarsko', 1, 'Y'),
(23, 'Križ', 1, 'Y'),
(24, 'Luka', 1, 'Y'),
(25, 'Marija Gorica', 1, 'Y'),
(26, 'Orle', 1, 'Y'),
(27, 'Pisarovina', 1, 'Y'),
(28, 'Pokupsko', 1, 'Y'),
(29, 'Preseka', 1, 'Y'),
(30, 'Pušća', 1, 'Y'),
(31, 'Rakovec', 1, 'Y'),
(32, 'Rugvica', 1, 'Y'),
(33, 'Stupnik', 1, 'Y'),
(34, 'Žumberak', 1, 'Y'),
(35, 'Donja Stubica', 2, 'Y'),
(36, 'Klanjec', 2, 'Y'),
(37, 'Krapina', 2, 'Y'),
(38, 'Oroslavje', 2, 'Y'),
(39, 'Pregrada', 2, 'Y'),
(40, 'Zabok', 2, 'Y'),
(41, 'Zlatar', 2, 'Y'),
(42, 'Bedekovčina', 2, 'Y'),
(43, 'Budinščina', 2, 'Y'),
(44, 'Desinić', 2, 'Y'),
(45, 'Đurmanec', 2, 'Y'),
(46, 'Gornja Stubica', 2, 'Y'),
(47, 'Hrašćina', 2, 'Y'),
(48, 'Hum na Sutli', 2, 'Y'),
(49, 'Jesenje', 2, 'Y'),
(50, 'Konjščina', 2, 'Y'),
(51, 'Kraljevec na Sutli', 2, 'Y'),
(52, 'Krapinske Toplice', 2, 'Y'),
(53, 'Kumrovec', 2, 'Y'),
(54, 'Lobor', 2, 'Y'),
(55, 'Mače', 2, 'Y'),
(56, 'Marija Bistrica', 2, 'Y'),
(57, 'Mihovljan', 2, 'Y'),
(58, 'Novi Golubovec', 2, 'Y'),
(59, 'Petrovsko', 2, 'Y'),
(60, 'Radoboj', 2, 'Y'),
(61, 'Stubičke Toplice', 2, 'Y'),
(62, 'Sveti Križ Začretje', 2, 'Y'),
(63, 'Tuhelj', 2, 'Y'),
(64, 'Veliko Trgovišće', 2, 'Y'),
(65, 'Zagorska Sela', 2, 'Y'),
(66, 'Zlatar Bistrica', 2, 'Y'),
(67, 'Glina', 3, 'Y'),
(68, 'Hrvatska Kostajnica', 3, 'Y'),
(69, 'Kutina', 3, 'Y'),
(70, 'Novska', 3, 'Y'),
(71, 'Petrinja', 3, 'Y'),
(72, 'Popovača', 3, 'Y'),
(73, 'Sisak', 3, 'Y'),
(74, 'Donji Kukuruzari', 3, 'Y'),
(75, 'Dvor', 3, 'Y'),
(76, 'Gvozd', 3, 'Y'),
(77, 'Hrvatska Dubica', 3, 'Y'),
(78, 'Jasenovac', 3, 'Y'),
(79, 'Lekenik', 3, 'Y'),
(80, 'Lipovljani', 3, 'Y'),
(81, 'Majur', 3, 'Y'),
(82, 'Martinska Ves', 3, 'Y'),
(83, 'Sunja', 3, 'Y'),
(84, 'Topusko', 3, 'Y'),
(85, 'Velika Ludina', 3, 'Y'),
(86, 'Duga Resa', 4, 'Y'),
(87, 'Karlovac', 4, 'Y'),
(88, 'Ogulin', 4, 'Y'),
(89, 'Ozalj', 4, 'Y'),
(90, 'Slunj', 4, 'Y'),
(91, 'Barilović', 4, 'Y'),
(92, 'Bosiljevo', 4, 'Y'),
(93, 'Cetingrad', 4, 'Y'),
(94, 'Draganić', 4, 'Y'),
(95, 'Generalski Stol', 4, 'Y'),
(96, 'Josipdol', 4, 'Y'),
(97, 'Kamanje', 4, 'Y'),
(98, 'Krnjak', 4, 'Y'),
(99, 'Lasinja', 4, 'Y'),
(100, 'Netretić', 4, 'Y'),
(101, 'Plaški', 4, 'Y'),
(102, 'Rakovica', 4, 'Y'),
(103, 'Ribnik', 4, 'Y'),
(104, 'Saborsko', 4, 'Y'),
(105, 'Tounj', 4, 'Y'),
(106, 'Vojnić', 4, 'Y'),
(107, 'Žakanje', 4, 'Y'),
(108, 'Ivanec', 5, 'Y'),
(109, 'Lepoglava', 5, 'Y'),
(110, 'Ludbreg', 5, 'Y'),
(111, 'Novi Marof', 5, 'Y'),
(112, 'Varaždin', 5, 'Y'),
(113, 'Varaždinske Toplice', 5, 'Y'),
(114, 'Bednja', 5, 'Y'),
(115, 'Beretinec', 5, 'Y'),
(116, 'Breznica', 5, 'Y'),
(117, 'Breznički Hum', 5, 'Y'),
(118, 'Cestica', 5, 'Y'),
(119, 'Donja Voća', 5, 'Y'),
(120, 'Gornji Kneginec', 5, 'Y'),
(121, 'Jalžabet', 5, 'Y'),
(122, 'Klenovnik', 5, 'Y'),
(123, 'Ljubešćica', 5, 'Y'),
(124, 'Mali Bukovec', 5, 'Y'),
(125, 'Martijanec', 5, 'Y'),
(126, 'Maruševec', 5, 'Y'),
(127, 'Petrijanec', 5, 'Y'),
(128, 'Sračinec', 5, 'Y'),
(129, 'Sveti Đurđ', 5, 'Y'),
(130, 'Sveti Ilija', 5, 'Y'),
(131, 'Trnovec Bartolovečki', 5, 'Y'),
(132, 'Veliki Bukovec', 5, 'Y'),
(133, 'Vidovec', 5, 'Y'),
(134, 'Vinica', 5, 'Y'),
(135, 'Visoko', 5, 'Y'),
(136, 'Đurđevac', 6, 'Y'),
(137, 'Koprivnica', 6, 'Y'),
(138, 'Križevci', 6, 'Y'),
(139, 'Drnje', 6, 'Y'),
(140, 'Đelekovec', 6, 'Y'),
(141, 'Ferdinandovac', 6, 'Y'),
(142, 'Gola', 6, 'Y'),
(143, 'Gornja Rijeka', 6, 'Y'),
(144, 'Hlebine', 6, 'Y'),
(145, 'Kalinovac', 6, 'Y'),
(146, 'Kalnik', 6, 'Y'),
(147, 'Kloštar Podravski', 6, 'Y'),
(148, 'Koprivnički Bregi', 6, 'Y'),
(149, 'Koprivnički Ivanec', 6, 'Y'),
(150, 'Legrad', 6, 'Y'),
(151, 'Molve', 6, 'Y'),
(152, 'Novigrad Podravski', 6, 'Y'),
(153, 'Novo Virje', 6, 'Y'),
(154, 'Peteranec', 6, 'Y'),
(155, 'Podravske Sesvete', 6, 'Y'),
(156, 'Rasinja', 6, 'Y'),
(157, 'Sokolovac', 6, 'Y'),
(158, 'Sveti Ivan Žabno', 6, 'Y'),
(159, 'Sveti Petar Orehovec', 6, 'Y'),
(160, 'Virje', 6, 'Y'),
(161, 'Bjelovar', 7, 'Y'),
(162, 'Čazma', 7, 'Y'),
(163, 'Daruvar', 7, 'Y'),
(164, 'Garešnica', 7, 'Y'),
(165, 'Grubišno Polje', 7, 'Y'),
(166, 'Berek', 7, 'Y'),
(167, 'Dežanovac', 7, 'Y'),
(168, 'Đulovac', 7, 'Y'),
(169, 'Hercegovac', 7, 'Y'),
(170, 'Ivanska', 7, 'Y'),
(171, 'Kapela', 7, 'Y'),
(172, 'Končanica', 7, 'Y'),
(173, 'Nova Rača', 7, 'Y'),
(174, 'Rovišće', 7, 'Y'),
(175, 'Severin', 7, 'Y'),
(176, 'Sirač', 7, 'Y'),
(177, 'Šandrovac', 7, 'Y'),
(178, 'Štefanje', 7, 'Y'),
(179, 'Velika Pisanica', 7, 'Y'),
(180, 'Velika Trnovitica', 7, 'Y'),
(181, 'Veliki Grđevac', 7, 'Y'),
(182, 'Veliko Trojstvo', 7, 'Y'),
(183, 'Zrinski Topolovac', 7, 'Y'),
(184, 'Bakar', 8, 'Y'),
(185, 'Cres', 8, 'Y'),
(186, 'Crikvenica', 8, 'Y'),
(187, 'Čabar', 8, 'Y'),
(188, 'Delnice', 8, 'Y'),
(189, 'Kastav', 8, 'Y'),
(190, 'Kraljevica', 8, 'Y'),
(191, 'Krk', 8, 'Y'),
(192, 'Mali Lošinj', 8, 'Y'),
(193, 'Novi Vinodolski', 8, 'Y'),
(194, 'Opatija', 8, 'Y'),
(195, 'Rab', 8, 'Y'),
(196, 'Rijeka', 8, 'Y'),
(197, 'Vrbovsko', 8, 'Y'),
(198, 'Baška', 8, 'Y'),
(199, 'Brod Moravice', 8, 'Y'),
(200, 'Čavle', 8, 'Y'),
(201, 'Dobrinj', 8, 'Y'),
(202, 'Fužine', 8, 'Y'),
(203, 'Jelenje', 8, 'Y'),
(204, 'Klana', 8, 'Y'),
(205, 'Kostrena', 8, 'Y'),
(206, 'Lokve', 8, 'Y'),
(207, 'Lopar', 8, 'Y'),
(208, 'Lovran', 8, 'Y'),
(209, 'Malinska-Dubašnica', 8, 'Y'),
(210, 'Matulji', 8, 'Y'),
(211, 'Mošćenička Draga', 8, 'Y'),
(212, 'Mrkopalj', 8, 'Y'),
(213, 'Omišalj', 8, 'Y'),
(214, 'Punat', 8, 'Y'),
(215, 'Ravna Gora', 8, 'Y'),
(216, 'Skrad', 8, 'Y'),
(217, 'Vinodolska općina (sjedište Bribir)', 8, 'Y'),
(218, 'Viškovo', 8, 'Y'),
(219, 'Vrbnik', 8, 'Y'),
(220, 'Gospić', 9, 'Y'),
(221, 'Novalja', 9, 'Y'),
(222, 'Otočac', 9, 'Y'),
(223, 'Senj', 9, 'Y'),
(224, 'Brinje', 9, 'Y'),
(225, 'Donji Lapac', 9, 'Y'),
(226, 'Karlobag', 9, 'Y'),
(227, 'Lovinac', 9, 'Y'),
(228, 'Perušić', 9, 'Y'),
(229, 'Plitvička jezera (sjedište Korenica)', 9, 'Y'),
(230, 'Udbina', 9, 'Y'),
(231, 'Vrhovine', 9, 'Y'),
(232, 'Orahovica', 10, 'Y'),
(233, 'Slatina', 10, 'Y'),
(234, 'Virovitica', 10, 'Y'),
(235, 'Crnac', 10, 'Y'),
(236, 'Čačinci', 10, 'Y'),
(237, 'Čađavica', 10, 'Y'),
(238, 'Gradina', 10, 'Y'),
(239, 'Lukač', 10, 'Y'),
(240, 'Mikleuš', 10, 'Y'),
(241, 'Nova Bukovica', 10, 'Y'),
(242, 'Pitomača', 10, 'Y'),
(243, 'Sopje', 10, 'Y'),
(244, 'Suhopolje', 10, 'Y'),
(245, 'Špišić Bukovica', 10, 'Y'),
(246, 'Voćin', 10, 'Y'),
(247, 'Zdenci', 10, 'Y'),
(248, 'Kutjevo', 11, 'Y'),
(249, 'Lipik', 11, 'Y'),
(250, 'Pakrac', 11, 'Y'),
(251, 'Pleternica', 11, 'Y'),
(252, 'Požega', 11, 'Y'),
(253, 'Brestovac', 11, 'Y'),
(254, 'Čaglin', 11, 'Y'),
(255, 'Jakšić', 11, 'Y'),
(256, 'Kaptol', 11, 'Y'),
(257, 'Velika', 11, 'Y'),
(258, 'Nova Gradiška', 12, 'Y'),
(259, 'Slavonski Brod', 12, 'Y'),
(260, 'Bebrina', 12, 'Y'),
(261, 'Brodski Stupnik', 12, 'Y'),
(262, 'Bukovlje', 12, 'Y'),
(263, 'Cernik', 12, 'Y'),
(264, 'Davor', 12, 'Y'),
(265, 'Donji Andrijevci', 12, 'Y'),
(266, 'Dragalić', 12, 'Y'),
(267, 'Garčin', 12, 'Y'),
(268, 'Gornja Vrba', 12, 'Y'),
(269, 'Gornji Bogićevci', 12, 'Y'),
(270, 'Gundinci', 12, 'Y'),
(271, 'Klakar', 12, 'Y'),
(272, 'Nova Kapela', 12, 'Y'),
(273, 'Okučani', 12, 'Y'),
(274, 'Oprisavci', 12, 'Y'),
(275, 'Oriovac', 12, 'Y'),
(276, 'Podcrkavlje', 12, 'Y'),
(277, 'Rešetari', 12, 'Y'),
(278, 'Sibinj', 12, 'Y'),
(279, 'Sikirevci', 12, 'Y'),
(280, 'Slavonski Šamac', 12, 'Y'),
(281, 'Stara Gradiška', 12, 'Y'),
(282, 'Staro Petrovo Selo', 12, 'Y'),
(283, 'Velika Kopanica', 12, 'Y'),
(284, 'Vrbje', 12, 'Y'),
(285, 'Vrpolje', 12, 'Y'),
(286, 'Benkovac', 13, 'Y'),
(287, 'Biograd na Moru', 13, 'Y'),
(288, 'Nin', 13, 'Y'),
(289, 'Obrovac', 13, 'Y'),
(290, 'Pag', 13, 'Y'),
(291, 'Zadar', 13, 'Y'),
(292, 'Bibinje', 13, 'Y'),
(293, 'Galovac', 13, 'Y'),
(294, 'Gračac', 13, 'Y'),
(295, 'Jasenice', 13, 'Y'),
(296, 'Kali', 13, 'Y'),
(297, 'Kolan', 13, 'Y'),
(298, 'Kukljica', 13, 'Y'),
(299, 'Lišane Ostrovičke', 13, 'Y'),
(300, 'Novigrad', 13, 'Y'),
(301, 'Pakoštane', 13, 'Y'),
(302, 'Pašman', 13, 'Y'),
(303, 'Polača', 13, 'Y'),
(304, 'Poličnik', 13, 'Y'),
(305, 'Posedarje', 13, 'Y'),
(306, 'Povljana', 13, 'Y'),
(307, 'Preko', 13, 'Y'),
(308, 'Privlaka', 13, 'Y'),
(309, 'Ražanac', 13, 'Y'),
(310, 'Sali', 13, 'Y'),
(311, 'Stankovci', 13, 'Y'),
(312, 'Starigrad', 13, 'Y'),
(313, 'Sukošan', 13, 'Y'),
(314, 'Sveti Filip i Jakov', 13, 'Y'),
(315, 'Škabrnja', 13, 'Y'),
(316, 'Tkon', 13, 'Y'),
(317, 'Vir', 13, 'Y'),
(318, 'Vrsi', 13, 'Y'),
(319, 'Zemunik Donji', 13, 'Y'),
(320, 'Beli Manastir', 14, 'Y'),
(321, 'Belišće', 14, 'Y'),
(322, 'Donji Miholjac', 14, 'Y'),
(323, 'Đakovo', 14, 'Y'),
(324, 'Našice', 14, 'Y'),
(325, 'Osijek', 14, 'Y'),
(326, 'Valpovo', 14, 'Y'),
(327, 'Antunovac', 14, 'Y'),
(328, 'Bilje', 14, 'Y'),
(329, 'Bizovac', 14, 'Y'),
(330, 'Čeminac', 14, 'Y'),
(331, 'Čepin', 14, 'Y'),
(332, 'Darda', 14, 'Y'),
(333, 'Donja Motičina', 14, 'Y'),
(334, 'Draž', 14, 'Y'),
(335, 'Drenje', 14, 'Y'),
(336, 'Đurđenovac', 14, 'Y'),
(337, 'Erdut', 14, 'Y'),
(338, 'Ernestinovo', 14, 'Y'),
(339, 'Feričanci', 14, 'Y'),
(340, 'Gorjani', 14, 'Y'),
(341, 'Jagodnjak', 14, 'Y'),
(342, 'Kneževi Vinogradi', 14, 'Y'),
(343, 'Koška', 14, 'Y'),
(344, 'Levanjska Varoš', 14, 'Y'),
(345, 'Magadenovac', 14, 'Y'),
(346, 'Marijanci', 14, 'Y'),
(347, 'Petlovac', 14, 'Y'),
(348, 'Petrijevci', 14, 'Y'),
(349, 'Podgorač', 14, 'Y'),
(350, 'Podravska Moslavina', 14, 'Y'),
(351, 'Popovac', 14, 'Y'),
(352, 'Punitovci', 14, 'Y'),
(353, 'Satnica Đakovačka', 14, 'Y'),
(354, 'Semeljci', 14, 'Y'),
(355, 'Strizivojna', 14, 'Y'),
(356, 'Šodolovci', 14, 'Y'),
(357, 'Trnava', 14, 'Y'),
(358, 'Viljevo', 14, 'Y'),
(359, 'Viškovci', 14, 'Y'),
(360, 'Vladislavci', 14, 'Y'),
(361, 'Vuka', 14, 'Y'),
(362, 'Drniš', 15, 'Y'),
(363, 'Knin', 15, 'Y'),
(364, 'Skradin', 15, 'Y'),
(365, 'Šibenik', 15, 'Y'),
(366, 'Vodice', 15, 'Y'),
(367, 'Bilice', 15, 'Y'),
(368, 'Biskupija', 15, 'Y'),
(369, 'Civljane', 15, 'Y'),
(370, 'Ervenik', 15, 'Y'),
(371, 'Kijevo', 15, 'Y'),
(372, 'Kistanje', 15, 'Y'),
(373, 'Murter-Kornati', 15, 'Y'),
(374, 'Pirovac', 15, 'Y'),
(375, 'Primošten', 15, 'Y'),
(376, 'Promina (sjedište Oklaj)', 15, 'Y'),
(377, 'Rogoznica', 15, 'Y'),
(378, 'Ružić (sjedište Gradac)', 15, 'Y'),
(379, 'Tisno', 15, 'Y'),
(380, 'Tribunj', 15, 'Y'),
(381, 'Unešić', 15, 'Y'),
(444, 'Ilok', 16, 'Y'),
(445, 'Otok', 16, 'Y'),
(446, 'Vinkovci', 16, 'Y'),
(447, 'Vukovar', 16, 'Y'),
(448, 'Županja', 16, 'Y'),
(449, 'Andrijaševci', 16, 'Y'),
(450, 'Babina Greda', 16, 'Y'),
(451, 'Bogdanovci', 16, 'Y'),
(452, 'Borovo', 16, 'Y'),
(453, 'Bošnjaci', 16, 'Y'),
(454, 'Cerna', 16, 'Y'),
(455, 'Drenovci', 16, 'Y'),
(456, 'Gradište', 16, 'Y'),
(457, 'Gunja', 16, 'Y'),
(458, 'Ivankovo', 16, 'Y'),
(459, 'Jarmina', 16, 'Y'),
(460, 'Lovas', 16, 'Y'),
(461, 'Markušica', 16, 'Y'),
(462, 'Negoslavci', 16, 'Y'),
(463, 'Nijemci', 16, 'Y'),
(464, 'Nuštar', 16, 'Y'),
(465, 'Privlaka (Vinkovci)', 16, 'Y'),
(466, 'Stari Jankovci', 16, 'Y'),
(467, 'Stari Mikanovci', 16, 'Y'),
(468, 'Štitar', 16, 'Y'),
(469, 'Tompojevci', 16, 'Y'),
(470, 'Tordinci', 16, 'Y'),
(471, 'Tovarnik', 16, 'Y'),
(472, 'Trpinja', 16, 'Y'),
(473, 'Vođinci', 16, 'Y'),
(474, 'Vrbanja', 16, 'Y'),
(585, 'Hvar', 17, 'Y'),
(586, 'Imotski', 17, 'Y'),
(587, 'Kaštela (sjedište Kaštel Sućurac)', 17, 'Y'),
(588, 'Komiža', 17, 'Y'),
(589, 'Makarska', 17, 'Y'),
(590, 'Omiš', 17, 'Y'),
(591, 'Sinj', 17, 'Y'),
(592, 'Solin', 17, 'Y'),
(593, 'Split', 17, 'Y'),
(594, 'Stari Grad', 17, 'Y'),
(595, 'Supetar', 17, 'Y'),
(596, 'Trilj', 17, 'Y'),
(597, 'Trogir', 17, 'Y'),
(598, 'Vis', 17, 'Y'),
(599, 'Vrgorac', 17, 'Y'),
(600, 'Vrlika', 17, 'Y'),
(601, 'Baška Voda', 17, 'Y'),
(602, 'Bol', 17, 'Y'),
(603, 'Brela', 17, 'Y'),
(604, 'Cista Provo', 17, 'Y'),
(605, 'Dicmo (sjedište Kraj)', 17, 'Y'),
(606, 'Dugi Rat', 17, 'Y'),
(607, 'Dugopolje', 17, 'Y'),
(608, 'Gradac', 17, 'Y'),
(609, 'Hrvace', 17, 'Y'),
(610, 'Jelsa', 17, 'Y'),
(611, 'Klis', 17, 'Y'),
(612, 'Lećevica', 17, 'Y'),
(613, 'Lokvičići', 17, 'Y'),
(614, 'Lovreć', 17, 'Y'),
(615, 'Marina', 17, 'Y'),
(616, 'Milna', 17, 'Y'),
(617, 'Muć', 17, 'Y'),
(618, 'Nerežišća', 17, 'Y'),
(619, 'Okrug(sjedište Okrug Gornji)', 17, 'Y'),
(620, 'Otok (Cetina)', 17, 'Y'),
(621, 'Podbablje (sjedište Drum)', 17, 'Y'),
(622, 'Podgora', 17, 'Y'),
(623, 'Podstrana', 17, 'Y'),
(624, 'Postira', 17, 'Y'),
(625, 'Prgomet', 17, 'Y'),
(626, 'Primorski Dolac', 17, 'Y'),
(627, 'Proložac', 17, 'Y'),
(628, 'Pučišća', 17, 'Y'),
(629, 'Runovići', 17, 'Y'),
(630, 'Seget (sjedište Seget Donji)', 17, 'Y'),
(631, 'Selca', 17, 'Y'),
(632, 'Sućuraj', 17, 'Y'),
(633, 'Sutivan', 17, 'Y'),
(634, 'Šestanovac', 17, 'Y'),
(635, 'Šolta (sjedište Grohote)', 17, 'Y'),
(636, 'Tučepi', 17, 'Y'),
(637, 'Zadvarje', 17, 'Y'),
(638, 'Zagvozd', 17, 'Y'),
(639, 'Zmijavci', 17, 'Y'),
(681, 'Buje-Buie', 18, 'Y'),
(682, 'Buzet', 18, 'Y'),
(683, 'Labin', 18, 'Y'),
(684, 'Novigrad – Cittanova', 18, 'Y'),
(685, 'Pazin', 18, 'Y'),
(686, 'Poreč - Parenzo', 18, 'Y'),
(687, 'Pula - Pola', 18, 'Y'),
(688, 'Rovinj - Rovigno', 18, 'Y'),
(689, 'Umag - Umago', 18, 'Y'),
(690, 'Vodnjan - Dignano', 18, 'Y'),
(691, 'Bale - Valle', 18, 'Y'),
(692, 'Barban', 18, 'Y'),
(693, 'Brtonigla – Verteneglio', 18, 'Y'),
(694, 'Cerovlje', 18, 'Y'),
(695, 'Fažana – Fasana', 18, 'Y'),
(696, 'Funtana – Fontane', 18, 'Y'),
(697, 'Gračišće', 18, 'Y'),
(698, 'Grožnjan – Grisignana', 18, 'Y'),
(699, 'Kanfanar', 18, 'Y'),
(700, 'Karojba', 18, 'Y'),
(701, 'Kaštelir–Labinci – Castelliere-S. Domenica', 18, 'Y'),
(702, 'Kršan', 18, 'Y'),
(703, 'Lanišće', 18, 'Y'),
(704, 'Ližnjan – Lisignano', 18, 'Y'),
(705, 'Lupoglav', 18, 'Y'),
(706, 'Marčana', 18, 'Y'),
(707, 'Medulin', 18, 'Y'),
(708, 'Motovun – Montona', 18, 'Y'),
(709, 'Oprtalj – Portole', 18, 'Y'),
(710, 'Pićan', 18, 'Y'),
(711, 'Raša', 18, 'Y'),
(712, 'Sveta Nedelja (Nedešćina)', 18, 'Y'),
(713, 'Sveti Lovreč', 18, 'Y'),
(714, 'Sveti Petar u Šumi', 18, 'Y'),
(715, 'Svetvinčenat', 18, 'Y'),
(716, 'Tar-Vabriga – Torre–Abrega', 18, 'Y'),
(717, 'Tinjan', 18, 'Y'),
(718, 'Višnjan – Visignano', 18, 'Y'),
(719, 'Vižinada – Visinada', 18, 'Y'),
(720, 'Vrsar – Orsera', 18, 'Y'),
(721, 'Žminj', 18, 'Y'),
(722, 'Dubrovnik', 19, 'Y'),
(723, 'Korčula', 19, 'Y'),
(724, 'Metković', 19, 'Y'),
(725, 'Opuzen', 19, 'Y'),
(726, 'Ploče', 19, 'Y'),
(727, 'Blato', 19, 'Y'),
(728, 'Dubrovačko primorje (sjedište Slano)', 19, 'Y'),
(729, 'Janjina', 19, 'Y'),
(730, 'Konavle (sjedište Cavtat)', 19, 'Y'),
(731, 'Kula Norinska', 19, 'Y'),
(732, 'Lastovo', 19, 'Y'),
(733, 'Lumbarda', 19, 'Y'),
(734, 'Mljet (sjedište Babino Polje)', 19, 'Y'),
(735, 'Orebić', 19, 'Y'),
(736, 'Pojezerje (sjedište Otrić-Seoci)', 19, 'Y'),
(737, 'Slivno (sjedište Vlaka)', 19, 'Y'),
(738, 'Smokvica', 19, 'Y'),
(739, 'Ston', 19, 'Y'),
(740, 'Trpanj', 19, 'Y'),
(741, 'Vela Luka', 19, 'Y'),
(742, 'Zažablje (sjedište Mlinište)', 19, 'Y'),
(743, 'Župa dubrovačka (sjedište Srebreno)', 19, 'Y'),
(744, 'Čakovec', 20, 'Y'),
(745, 'Mursko Središće', 20, 'Y'),
(746, 'Prelog', 20, 'Y'),
(747, 'Belica', 20, 'Y'),
(748, 'Dekanovec', 20, 'Y'),
(749, 'Domašinec', 20, 'Y'),
(750, 'Donja Dubrava', 20, 'Y'),
(751, 'Donji Kraljevec', 20, 'Y'),
(752, 'Donji Vidovec', 20, 'Y'),
(753, 'Goričan', 20, 'Y'),
(754, 'Gornji Mihaljevec', 20, 'Y'),
(755, 'Kotoriba', 20, 'Y'),
(756, 'Mala Subotica', 20, 'Y'),
(757, 'Nedelišće', 20, 'Y'),
(758, 'Orehovica', 20, 'Y'),
(759, 'Podturen', 20, 'Y'),
(760, 'Pribislavec', 20, 'Y'),
(761, 'Selnica', 20, 'Y'),
(762, 'Strahoninec', 20, 'Y'),
(763, 'Sveta Marija', 20, 'Y'),
(764, 'Sveti Juraj na Bregu (sjedište Lopatinec)', 20, 'Y'),
(765, 'Sveti Martin na Muri', 20, 'Y'),
(766, 'Šenkovec', 20, 'Y'),
(767, 'Štrigova', 20, 'Y'),
(768, 'Vratišinec', 20, 'Y'),
(769, 'Zagreb', 21, 'Y');

-- --------------------------------------------------------

--
-- Stand-in structure for view `location_view`
--
CREATE TABLE IF NOT EXISTS `location_view` (
`id` int(11)
,`name` varchar(255)
,`region_id` int(11)
,`active` enum('Y','N')
,`country_id` int(11)
,`default_language` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE IF NOT EXISTS `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `oib` bigint(11) NOT NULL,
  `member_type_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `apt_no` varchar(255) DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `mob` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `con1` enum('Y','N') NOT NULL DEFAULT 'N',
  `con2` enum('Y','N') NOT NULL DEFAULT 'N',
  `con3` enum('Y','N') NOT NULL DEFAULT 'N',
  `con4` enum('Y','N') NOT NULL DEFAULT 'N',
  `confirmed` enum('Y','N') NOT NULL DEFAULT 'N',
  `confirmed_datetime` datetime DEFAULT NULL,
  `confirmed_user_id` varchar(45) DEFAULT NULL,
  `logged` enum('Y','N') NOT NULL DEFAULT 'N',
  `logged_datetime` datetime DEFAULT NULL,
  `logged_user_id` int(11) DEFAULT NULL,
  `listed` enum('Y','N') NOT NULL DEFAULT 'N',
  `listed_datetime` datetime DEFAULT NULL,
  `listed_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oib_UNIQUE` (`oib`),
  KEY `type_id_idx` (`member_type_id`),
  KEY `loc_id_idx` (`location_id`),
  KEY `location_id` (`location_id`),
  KEY `location_id_2` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `member_ledger`
--

CREATE TABLE IF NOT EXISTS `member_ledger` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `credit` int(11) NOT NULL DEFAULT '0' COMMENT 'credit receive for activity',
  `debit` int(11) NOT NULL DEFAULT '0' COMMENT 'debit to account - credit used to pay for service/product',
  `balance` int(11) DEFAULT NULL COMMENT 'plus for credit, 0 for debit, cannot be minus',
  `desc` varchar(255) DEFAULT NULL COMMENT 'nature of transactions, usually precoded',
  `user_id` int(11) NOT NULL COMMENT 'doublecheck for client,should be clientid logged ',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `member_loc`
--

CREATE TABLE IF NOT EXISTS `member_loc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'N',
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `member_services_view`
--
CREATE TABLE IF NOT EXISTS `member_services_view` (
`id` int(11)
,`service_class_id` int(11)
,`member_id` int(11)
,`offer` int(11)
,`currency` char(3)
,`timestamp` datetime
,`user_id` bigint(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `member_service_class`
--

CREATE TABLE IF NOT EXISTS `member_service_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_class_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `offer` int(11) NOT NULL COMMENT 'price EUR',
  `newV` enum('N','Y') NOT NULL DEFAULT 'N',
  `currency` char(3) NOT NULL,
  `timestamp` datetime NOT NULL,
  `user_id` bigint(11) NOT NULL COMMENT 'member id who updated record',
  `active` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `serv_class_idx` (`service_class_id`),
  KEY `member_idx` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `member_service_rating`
--

CREATE TABLE IF NOT EXISTS `member_service_rating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL COMMENT '# stars awarded',
  `active` enum('N','Y') NOT NULL DEFAULT 'N',
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `member_service_rating_log`
--

CREATE TABLE IF NOT EXISTS `member_service_rating_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_service_rating_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `member_tmp`
--

CREATE TABLE IF NOT EXISTS `member_tmp` (
  `reg_broj` varchar(16) DEFAULT NULL,
  `huec` varchar(2) DEFAULT NULL,
  `naziv` varchar(64) DEFAULT NULL,
  `oib` bigint(11) DEFAULT NULL,
  `poslodavac` varchar(128) DEFAULT NULL,
  `zupanija` varchar(64) DEFAULT NULL,
  `grad` varchar(64) DEFAULT NULL,
  `adresa` varchar(64) DEFAULT NULL,
  `tel` varchar(32) DEFAULT NULL,
  `mob` varchar(32) DEFAULT NULL,
  `modul_1` varchar(2) DEFAULT NULL,
  `modul_2` varchar(2) DEFAULT NULL,
  `modul_3` varchar(2) DEFAULT NULL,
  `modul_4` varchar(2) DEFAULT NULL,
  `ovalstenje` varchar(16) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registered` enum('Y','N') NOT NULL DEFAULT 'N',
  `email` varchar(64) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `member_type`
--

CREATE TABLE IF NOT EXISTS `member_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `member_type`
--

INSERT INTO `member_type` (`id`, `name`) VALUES
(1, 'default');

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `client_id` int(11) NOT NULL,
  `property_type` int(11) NOT NULL,
  `propert_client_type_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `isnew` enum('N','Y') NOT NULL DEFAULT 'N',
  `street` varchar(45) DEFAULT NULL,
  `street_no` varchar(45) DEFAULT NULL,
  `apt_no` varchar(45) DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `mob` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id_idx` (`client_id`),
  KEY `property_id_idx` (`property_type`),
  KEY `location_id_idx` (`location_id`),
  KEY `property_client_type_prop_idx` (`propert_client_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `property_client_types`
--

CREATE TABLE IF NOT EXISTS `property_client_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_type_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'name to display',
  PRIMARY KEY (`id`),
  KEY `propert_type_user_idx` (`property_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `property_client_types`
--

INSERT INTO `property_client_types` (`id`, `property_type_id`, `name`) VALUES
(1, 1, 'stan'),
(2, 2, 'kuća'),
(3, 2, 'vikendica'),
(4, 2, 'apartman'),
(5, 2, 'poslovni prostor'),
(6, 2, 'zgrada');

-- --------------------------------------------------------

--
-- Table structure for table `property_type`
--

CREATE TABLE IF NOT EXISTS `property_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `property_type`
--

INSERT INTO `property_type` (`id`, `name`) VALUES
(3, 'Slozena nestambena zgrada'),
(2, 'Stambena i nestambena zgrada'),
(1, 'Stan u stambenoj zgradi');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE IF NOT EXISTS `region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `country_id_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`id`, `name`, `country_id`, `active`) VALUES
(1, 'ZAGREBAČKA', 1, 'Y'),
(2, 'KRAPINSKO-ZAGORSKA', 1, 'Y'),
(3, 'SISAČKO-MOSLAVAČKA', 1, 'Y'),
(4, 'KARLOVAČKA', 1, 'Y'),
(5, 'VARAŽDINSKA', 1, 'Y'),
(6, 'KOPRIVNIČKO-KRIŽEVAČKA', 1, 'Y'),
(7, 'BJELOVARSKO-BILOGORSKA', 1, 'Y'),
(8, 'PRIMORSKO-GORANSKA', 1, 'Y'),
(9, 'LIČKO-SENJSKA', 1, 'Y'),
(10, 'VIROVITIČKO-PODRAVSKA', 1, 'Y'),
(11, 'POŽEŠKO-SLAVONSKA', 1, 'Y'),
(12, 'BRODSKO-POSAVSKA', 1, 'Y'),
(13, 'ZADARSKA', 1, 'Y'),
(14, 'OSJEČKO-BARANJSKA', 1, 'Y'),
(15, 'ŠIBENSKO-KNINSKA', 1, 'Y'),
(16, 'VUKOVARSKO-SRIJEMSKA', 1, 'Y'),
(17, 'SPLITSKO-DALMATINSKA', 1, 'Y'),
(18, 'ISTARSKA', 1, 'Y'),
(19, 'DUBROVAČKO-NERETVANSKA', 1, 'Y'),
(20, 'MEĐIMURSKA', 1, 'Y'),
(21, 'GRAD ZAGREB', 1, 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `service_type` int(11) NOT NULL,
  `active` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `name`, `service_type`, `active`) VALUES
(1, 'Energetski certifikat', 1, 'Y'),
(2, 'Energetski pregled', 2, 'Y'),
(3, 'Energetski pregled i certifikat', 3, 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `service_class`
--

CREATE TABLE IF NOT EXISTS `service_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `offer_min` int(11) NOT NULL DEFAULT '0',
  `offer_max` int(11) NOT NULL,
  `m_min` int(11) DEFAULT NULL,
  `m_max` int(11) DEFAULT NULL,
  `new` enum('N','Y') NOT NULL DEFAULT 'Y',
  `currency` char(3) DEFAULT NULL,
  `active` enum('N','Y') DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `service_idx` (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `service_class`
--

INSERT INTO `service_class` (`id`, `service_id`, `property_id`, `name`, `offer_min`, `offer_max`, `m_min`, `m_max`, `new`, `currency`, `active`) VALUES
(1, 1, 1, 'STAN U STAMBENOJ ZGRADI', 600, 1200, 0, 1000000, 'N', 'HRK', 'Y'),
(2, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (50 - 250 m2)', 700, 1400, 50, 250, 'Y', 'HRK', 'Y'),
(3, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (250 - 400 m2 - poljopr. do 600 m2)', 875, 1750, 251, 400, 'Y', 'HRK', 'Y'),
(4, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (400/poljopr. od 600 - 1.000 m2)', 1115, 2300, 401, 1000, 'Y', 'HRK', 'Y'),
(5, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (1.001 - 5.000 m2)', 3100, 6200, 1001, 5000, 'Y', 'HRK', 'Y'),
(6, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (5.001 - 10.000 m2)', 4700, 9400, 5001, 10000, 'Y', 'HRK', 'Y'),
(7, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (10.001 - 20.000 m2)', 7150, 14300, 10001, 20000, 'Y', 'HRK', 'Y'),
(8, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (20.001 - 50.000 m2)', 7920, 26400, 20001, 50000, 'Y', 'HRK', 'Y'),
(9, 1, 2, 'STAMBENA I NESTAMBENA ZGRADA (> 50.000 m2)', 9510, 31700, 50001, 1000000, 'Y', 'HRK', 'Y'),
(10, 2, 1, 'STAN U STAMBENOJ ZGRADI', 750, 1500, 0, 1000000, 'N', 'HRK', 'Y'),
(11, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (50 - 250 m2)', 1650, 3300, 50, 250, 'N', 'HRK', 'Y'),
(12, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (250 - 400 m2 - poljopr. do 600 m2)', 2500, 5000, 251, 400, 'N', 'HRK', 'Y'),
(13, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (400/poljopr. od 600 - 1.000 m2)', 4370, 2300, 401, 1000, 'N', 'HRK', 'Y'),
(14, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (1.001 - 5.000 m2)', 11780, 6200, 1001, 5000, 'N', 'HRK', 'Y'),
(15, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (5.001 - 10.000 m2)', 17860, 9400, 5001, 10000, 'N', 'HRK', 'Y'),
(16, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (10.001 - 20.000 m2)', 27170, 14300, 10001, 20000, 'N', 'HRK', 'Y'),
(17, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (20.001 - 50.000 m2)', 30096, 26400, 20001, 50000, 'N', 'HRK', 'Y'),
(18, 2, 2, 'STAMBENA I NESTAMBENA ZGRADA (> 50.000 m2)', 36138, 31700, 50000, 1000000, 'N', 'HRK', 'Y'),
(19, 3, 1, 'STAN U STAMBENOJ ZGRADI', 1350, 2700, 0, 1000000, 'N', 'HRK', 'Y'),
(20, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (50 - 250 m2)', 2375, 4750, 50, 250, 'N', 'HRK', 'Y'),
(21, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (250 - 400 m2 - poljopr. do 600 m2)', 3700, 7400, 251, 400, 'N', 'HRK', 'Y'),
(22, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (400/poljopr. od 600 - 1.000 m2)', 5750, 11500, 401, 1000, 'N', 'HRK', 'Y'),
(23, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (1.001 - 5.000 m2)', 15500, 31000, 1001, 5000, 'N', 'HRK', 'Y'),
(24, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (5.001 - 10.000 m2)', 23500, 47000, 5001, 10000, 'N', 'HRK', 'Y'),
(25, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (10.001 - 20.000 m2)', 35750, 71500, 10001, 20000, 'N', 'HRK', 'Y'),
(26, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (20.001 - 50.000 m2)', 39600, 132000, 20001, 50000, 'N', 'HRK', 'Y'),
(27, 3, 2, 'STAMBENA I NESTAMBENA ZGRADA (> 50.000 m2)', 47550, 158500, 50000, 1000000, 'N', 'HRK', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `service_type`
--

CREATE TABLE IF NOT EXISTS `service_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `service_type`
--

INSERT INTO `service_type` (`id`, `name`) VALUES
(1, 'Energetski certifikat'),
(2, 'Energetski pregled'),
(3, 'Energetski Pregled i Certifikat\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(11) NOT NULL,
  `type` enum('client','member','agent','administrator','manager') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'client',
  `confirmed` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `activation_key` int(6) NOT NULL,
  `activation` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tmp_pass` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sec_q` int(2) DEFAULT NULL,
  `sec_a` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure for view `client_view`
--
DROP TABLE IF EXISTS `client_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`enzo`@`localhost` SQL SECURITY DEFINER VIEW `client_view` AS select `client`.`id` AS `id`,`client`.`first_name` AS `first_name`,`client`.`last_name` AS `last_name`,`client`.`oib` AS `oib`,`client`.`client_type_id` AS `client_type_id`,`client`.`location_id` AS `location_id`,`client`.`address` AS `address`,`client`.`phone` AS `phone`,`client`.`cell` AS `cell`,`client`.`email` AS `email`,`client`.`active` AS `active`,`client_type`.`name` AS `client_type_name`,count(`property`.`id`) AS `count(property.id)` from ((`client` left join `client_type` on((`client`.`client_type_id` = `client_type`.`id`))) left join `property` on((`property`.`client_id` = `client`.`id`))) where (`client`.`active` = 'Y');

-- --------------------------------------------------------

--
-- Structure for view `coupon_view`
--
DROP TABLE IF EXISTS `coupon_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`enzo`@`localhost` SQL SECURITY DEFINER VIEW `coupon_view` AS select `coupon`.`id` AS `id`,`coupon`.`offer` AS `offer`,`coupon`.`curency` AS `curency`,`coupon`.`validate_code` AS `validate_code`,`coupon`.`promo_code` AS `promo_code`,`coupon`.`promo_count` AS `promo_count`,`coupon`.`member_service_class_id` AS `member_service_class_id`,`coupon`.`client_id` AS `client_id`,`coupon`.`member_id` AS `member_id`,`coupon`.`location_id` AS `location_id`,`coupon`.`property_id` AS `property_id`,`coupon`.`service_date` AS `service_date`,`coupon`.`service_time` AS `service_time`,`coupon`.`contact_name` AS `contact_name`,`coupon`.`contact_address` AS `contact_address`,`coupon`.`contact_phone` AS `contact_phone`,`coupon`.`contact_email` AS `contact_email`,`coupon`.`accept_t_c` AS `accept_t_c`,`coupon`.`is_ordered` AS `is_ordered`,`coupon`.`is_delivered` AS `is_delivered`,`coupon`.`is_delivered_by_email` AS `is_delivered_by_email`,`coupon`.`is_delivered_by_phone` AS `is_delivered_by_phone`,`coupon`.`is_delivered_by_post` AS `is_delivered_by_post`,`coupon`.`is_accepted_by_member` AS `is_accepted_by_member`,`coupon`.`is_client_notified` AS `is_client_notified`,`coupon`.`is_validated_by_client` AS `is_validated_by_client`,`coupon`.`is_validated_by_member` AS `is_validated_by_member`,`coupon`.`validate_timestamp` AS `validate_timestamp`,`coupon`.`active` AS `active`,`coupon`.`user_id` AS `user_id`,`coupon`.`timestamp` AS `timestamp` from `coupon`;

-- --------------------------------------------------------

--
-- Structure for view `location_view`
--
DROP TABLE IF EXISTS `location_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`enzo`@`localhost` SQL SECURITY DEFINER VIEW `location_view` AS select `location`.`id` AS `id`,`location`.`name` AS `name`,`location`.`region_id` AS `region_id`,`location`.`active` AS `active`,`country`.`id` AS `country_id`,`country`.`language_id` AS `default_language` from ((`location` left join `region` on((`location`.`region_id` = `region`.`id`))) left join `country` on((`region`.`country_id` = `country`.`id`))) where ((`location`.`active` = 'Y') and (`region`.`active` = 'Y') and (`country`.`active` = 'Y'));

-- --------------------------------------------------------

--
-- Structure for view `member_services_view`
--
DROP TABLE IF EXISTS `member_services_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`enzo`@`localhost` SQL SECURITY DEFINER VIEW `member_services_view` AS select `member_service_class`.`id` AS `id`,`member_service_class`.`service_class_id` AS `service_class_id`,`member_service_class`.`member_id` AS `member_id`,`member_service_class`.`offer` AS `offer`,`member_service_class`.`currency` AS `currency`,`member_service_class`.`timestamp` AS `timestamp`,`member_service_class`.`user_id` AS `user_id` from `member_service_class`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
         