-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 08, 2014 at 09:54 AM
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

--
-- Dumping data for table `agent`
--

INSERT INTO `agent` (`id`, `name`, `active`) VALUES
(36918078303, 'Dejan Dulikravić', 'Y'),
(38225243636, 'Vedran Vins Seman', 'Y'),
(51917706585, 'Dario', 'Y');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `name`, `oib`, `member_type_id`, `location_id`, `street`, `apt_no`, `tel`, `mob`, `email`, `active`, `con1`, `con2`, `con3`, `con4`, `confirmed`, `confirmed_datetime`, `confirmed_user_id`, `logged`, `logged_datetime`, `logged_user_id`, `listed`, `listed_datetime`, `listed_user_id`) VALUES
(1, 'DARIO VINS', 51917706585, 0, 0, 'ulica', 'F-657/299', NULL, '38766910743', 'dariovins@gmail.com', 'N', 'Y', 'Y', 'Y', 'Y', 'N', NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL),
(2, 'DEAN ČIZMAR', 75388854238, 0, 0, 'Boškovićeva 18', 'F-657/201', NULL, '0915194193', 'deancizmar@gmail.com', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL),
(3, 'BOROJEVIĆ DUŠKO', 26640499090, 0, 0, 'ĐureBasaričeka6', 'F-236/2013', NULL, '091 224 8863', 'dusko.borojevic@kc.t-com.hr', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL),
(4, 'DAVIDOVIĆ ŽELIMIR', 50319913673, 0, 0, 'Zagreb Jagićeva 29', 'F-185/2012', NULL, '098/484-860', 'zelimir.davidovic@biro29.hr', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL),
(5, 'Žarko Pintar', 65340328857, 0, 0, 'Jakova Gotovca 28', 'F-1082011', NULL, '098227730', 'zarko.pintar@enc.com.hr', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL),
(6, 'GROZDANIĆ MILIVOJ', 86769546972, 0, 0, 'Maksimilijana Vrhovca 54', 'F-5/2010', NULL, '091/6454-865', 'milivoj.grozdanic@gmail.com', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3186 ;

--
-- Dumping data for table `member_loc`
--

INSERT INTO `member_loc` (`id`, `member_id`, `location_id`, `active`, `date_from`, `date_to`) VALUES
(437, 3, 769, 'N', NULL, NULL),
(438, 3, 744, 'N', NULL, NULL),
(439, 3, 745, 'N', NULL, NULL),
(440, 3, 746, 'N', NULL, NULL),
(441, 3, 747, 'N', NULL, NULL),
(442, 3, 748, 'N', NULL, NULL),
(443, 3, 749, 'N', NULL, NULL),
(444, 3, 750, 'N', NULL, NULL),
(445, 3, 751, 'N', NULL, NULL),
(446, 3, 752, 'N', NULL, NULL),
(447, 3, 753, 'N', NULL, NULL),
(448, 3, 754, 'N', NULL, NULL),
(449, 3, 755, 'N', NULL, NULL),
(450, 3, 756, 'N', NULL, NULL),
(451, 3, 757, 'N', NULL, NULL),
(452, 3, 758, 'N', NULL, NULL),
(453, 3, 759, 'N', NULL, NULL),
(454, 3, 760, 'N', NULL, NULL),
(455, 3, 761, 'N', NULL, NULL),
(456, 3, 762, 'N', NULL, NULL),
(457, 3, 763, 'N', NULL, NULL),
(458, 3, 764, 'N', NULL, NULL),
(459, 3, 765, 'N', NULL, NULL),
(460, 3, 766, 'N', NULL, NULL),
(461, 3, 767, 'N', NULL, NULL),
(462, 3, 768, 'N', NULL, NULL),
(463, 3, 585, 'N', NULL, NULL),
(464, 3, 586, 'N', NULL, NULL),
(465, 3, 587, 'N', NULL, NULL),
(466, 3, 588, 'N', NULL, NULL),
(467, 3, 589, 'N', NULL, NULL),
(468, 3, 590, 'N', NULL, NULL),
(469, 3, 591, 'N', NULL, NULL),
(470, 3, 592, 'N', NULL, NULL),
(471, 3, 593, 'N', NULL, NULL),
(472, 3, 594, 'N', NULL, NULL),
(473, 3, 595, 'N', NULL, NULL),
(474, 3, 596, 'N', NULL, NULL),
(475, 3, 597, 'N', NULL, NULL),
(476, 3, 598, 'N', NULL, NULL),
(477, 3, 599, 'N', NULL, NULL),
(478, 3, 600, 'N', NULL, NULL),
(479, 3, 601, 'N', NULL, NULL),
(480, 3, 602, 'N', NULL, NULL),
(481, 3, 603, 'N', NULL, NULL),
(482, 3, 604, 'N', NULL, NULL),
(483, 3, 605, 'N', NULL, NULL),
(484, 3, 606, 'N', NULL, NULL),
(485, 3, 607, 'N', NULL, NULL),
(486, 3, 608, 'N', NULL, NULL),
(487, 3, 609, 'N', NULL, NULL),
(488, 3, 610, 'N', NULL, NULL),
(489, 3, 611, 'N', NULL, NULL),
(490, 3, 612, 'N', NULL, NULL),
(491, 3, 613, 'N', NULL, NULL),
(492, 3, 614, 'N', NULL, NULL),
(493, 3, 615, 'N', NULL, NULL),
(494, 3, 616, 'N', NULL, NULL),
(495, 3, 617, 'N', NULL, NULL),
(496, 3, 618, 'N', NULL, NULL),
(497, 3, 619, 'N', NULL, NULL),
(498, 3, 620, 'N', NULL, NULL),
(499, 3, 621, 'N', NULL, NULL),
(500, 3, 622, 'N', NULL, NULL),
(501, 3, 623, 'N', NULL, NULL),
(502, 3, 624, 'N', NULL, NULL),
(503, 3, 625, 'N', NULL, NULL),
(504, 3, 626, 'N', NULL, NULL),
(505, 3, 627, 'N', NULL, NULL),
(506, 3, 628, 'N', NULL, NULL),
(507, 3, 629, 'N', NULL, NULL),
(508, 3, 630, 'N', NULL, NULL),
(509, 3, 631, 'N', NULL, NULL),
(510, 3, 632, 'N', NULL, NULL),
(511, 3, 633, 'N', NULL, NULL),
(512, 3, 634, 'N', NULL, NULL),
(513, 3, 635, 'N', NULL, NULL),
(514, 3, 636, 'N', NULL, NULL),
(515, 3, 637, 'N', NULL, NULL),
(516, 3, 638, 'N', NULL, NULL),
(517, 3, 639, 'N', NULL, NULL),
(518, 3, 362, 'N', NULL, NULL),
(519, 3, 363, 'N', NULL, NULL),
(520, 3, 364, 'N', NULL, NULL),
(521, 3, 365, 'N', NULL, NULL),
(522, 3, 366, 'N', NULL, NULL),
(523, 3, 367, 'N', NULL, NULL),
(524, 3, 368, 'N', NULL, NULL),
(525, 3, 369, 'N', NULL, NULL),
(526, 3, 370, 'N', NULL, NULL),
(527, 3, 371, 'N', NULL, NULL),
(528, 3, 372, 'N', NULL, NULL),
(529, 3, 373, 'N', NULL, NULL),
(530, 3, 374, 'N', NULL, NULL),
(531, 3, 375, 'N', NULL, NULL),
(532, 3, 376, 'N', NULL, NULL),
(533, 3, 377, 'N', NULL, NULL),
(534, 3, 378, 'N', NULL, NULL),
(535, 3, 379, 'N', NULL, NULL),
(536, 3, 380, 'N', NULL, NULL),
(537, 3, 381, 'N', NULL, NULL),
(538, 3, 286, 'N', NULL, NULL),
(539, 3, 287, 'N', NULL, NULL),
(540, 3, 288, 'N', NULL, NULL),
(541, 3, 289, 'N', NULL, NULL),
(542, 3, 290, 'N', NULL, NULL),
(543, 3, 291, 'N', NULL, NULL),
(544, 3, 292, 'N', NULL, NULL),
(545, 3, 293, 'N', NULL, NULL),
(546, 3, 294, 'N', NULL, NULL),
(547, 3, 295, 'N', NULL, NULL),
(548, 3, 296, 'N', NULL, NULL),
(549, 3, 297, 'N', NULL, NULL),
(550, 3, 298, 'N', NULL, NULL),
(551, 3, 299, 'N', NULL, NULL),
(552, 3, 300, 'N', NULL, NULL),
(553, 3, 301, 'N', NULL, NULL),
(554, 3, 302, 'N', NULL, NULL),
(555, 3, 303, 'N', NULL, NULL),
(556, 3, 304, 'N', NULL, NULL),
(557, 3, 305, 'N', NULL, NULL),
(558, 3, 306, 'N', NULL, NULL),
(559, 3, 307, 'N', NULL, NULL),
(560, 3, 308, 'N', NULL, NULL),
(561, 3, 309, 'N', NULL, NULL),
(562, 3, 310, 'N', NULL, NULL),
(563, 3, 311, 'N', NULL, NULL),
(564, 3, 312, 'N', NULL, NULL),
(565, 3, 313, 'N', NULL, NULL),
(566, 3, 314, 'N', NULL, NULL),
(567, 3, 315, 'N', NULL, NULL),
(568, 3, 316, 'N', NULL, NULL),
(569, 3, 317, 'N', NULL, NULL),
(570, 3, 318, 'N', NULL, NULL),
(571, 3, 319, 'N', NULL, NULL),
(572, 3, 161, 'N', NULL, NULL),
(573, 3, 162, 'N', NULL, NULL),
(574, 3, 163, 'N', NULL, NULL),
(575, 3, 164, 'N', NULL, NULL),
(576, 3, 165, 'N', NULL, NULL),
(577, 3, 166, 'N', NULL, NULL),
(578, 3, 167, 'N', NULL, NULL),
(579, 3, 168, 'N', NULL, NULL),
(580, 3, 169, 'N', NULL, NULL),
(581, 3, 170, 'N', NULL, NULL),
(582, 3, 171, 'N', NULL, NULL),
(583, 3, 172, 'N', NULL, NULL),
(584, 3, 173, 'N', NULL, NULL),
(585, 3, 174, 'N', NULL, NULL),
(586, 3, 175, 'N', NULL, NULL),
(587, 3, 176, 'N', NULL, NULL),
(588, 3, 177, 'N', NULL, NULL),
(589, 3, 178, 'N', NULL, NULL),
(590, 3, 179, 'N', NULL, NULL),
(591, 3, 180, 'N', NULL, NULL),
(592, 3, 181, 'N', NULL, NULL),
(593, 3, 182, 'N', NULL, NULL),
(594, 3, 183, 'N', NULL, NULL),
(595, 3, 136, 'N', NULL, NULL),
(596, 3, 137, 'N', NULL, NULL),
(597, 3, 138, 'N', NULL, NULL),
(598, 3, 139, 'N', NULL, NULL),
(599, 3, 140, 'N', NULL, NULL),
(600, 3, 141, 'N', NULL, NULL),
(601, 3, 142, 'N', NULL, NULL),
(602, 3, 143, 'N', NULL, NULL),
(603, 3, 144, 'N', NULL, NULL),
(604, 3, 145, 'N', NULL, NULL),
(605, 3, 146, 'N', NULL, NULL),
(606, 3, 147, 'N', NULL, NULL),
(607, 3, 148, 'N', NULL, NULL),
(608, 3, 149, 'N', NULL, NULL),
(609, 3, 150, 'N', NULL, NULL),
(610, 3, 151, 'N', NULL, NULL),
(611, 3, 152, 'N', NULL, NULL),
(612, 3, 153, 'N', NULL, NULL),
(613, 3, 154, 'N', NULL, NULL),
(614, 3, 155, 'N', NULL, NULL),
(615, 3, 156, 'N', NULL, NULL),
(616, 3, 157, 'N', NULL, NULL),
(617, 3, 158, 'N', NULL, NULL),
(618, 3, 159, 'N', NULL, NULL),
(619, 3, 160, 'N', NULL, NULL),
(620, 3, 108, 'N', NULL, NULL),
(621, 3, 109, 'N', NULL, NULL),
(622, 3, 110, 'N', NULL, NULL),
(623, 3, 111, 'N', NULL, NULL),
(624, 3, 112, 'N', NULL, NULL),
(625, 3, 113, 'N', NULL, NULL),
(626, 3, 114, 'N', NULL, NULL),
(627, 3, 115, 'N', NULL, NULL),
(628, 3, 116, 'N', NULL, NULL),
(629, 3, 117, 'N', NULL, NULL),
(630, 3, 118, 'N', NULL, NULL),
(631, 3, 119, 'N', NULL, NULL),
(632, 3, 120, 'N', NULL, NULL),
(633, 3, 121, 'N', NULL, NULL),
(634, 3, 122, 'N', NULL, NULL),
(635, 3, 123, 'N', NULL, NULL),
(636, 3, 124, 'N', NULL, NULL),
(637, 3, 125, 'N', NULL, NULL),
(638, 3, 126, 'N', NULL, NULL),
(639, 3, 127, 'N', NULL, NULL),
(640, 3, 128, 'N', NULL, NULL),
(641, 3, 129, 'N', NULL, NULL),
(642, 3, 130, 'N', NULL, NULL),
(643, 3, 131, 'N', NULL, NULL),
(644, 3, 132, 'N', NULL, NULL),
(645, 3, 133, 'N', NULL, NULL),
(646, 3, 134, 'N', NULL, NULL),
(647, 3, 135, 'N', NULL, NULL),
(1629, 5, 769, 'N', NULL, NULL),
(1630, 5, 7, 'N', NULL, NULL),
(1632, 6, 107, 'N', NULL, NULL),
(1633, 6, 106, 'N', NULL, NULL),
(1634, 6, 105, 'N', NULL, NULL),
(1635, 6, 104, 'N', NULL, NULL),
(1636, 6, 103, 'N', NULL, NULL),
(1637, 6, 102, 'N', NULL, NULL),
(1638, 6, 101, 'N', NULL, NULL),
(1639, 6, 100, 'N', NULL, NULL),
(1640, 6, 99, 'N', NULL, NULL),
(1641, 6, 98, 'N', NULL, NULL),
(1642, 6, 97, 'N', NULL, NULL),
(1643, 6, 96, 'N', NULL, NULL),
(1644, 6, 95, 'N', NULL, NULL),
(1645, 6, 94, 'N', NULL, NULL),
(1646, 6, 93, 'N', NULL, NULL),
(1647, 6, 92, 'N', NULL, NULL),
(1648, 6, 91, 'N', NULL, NULL),
(1649, 6, 90, 'N', NULL, NULL),
(1650, 6, 89, 'N', NULL, NULL),
(1651, 6, 88, 'N', NULL, NULL),
(1652, 6, 87, 'N', NULL, NULL),
(1653, 6, 86, 'N', NULL, NULL),
(1654, 2, 769, 'N', NULL, NULL),
(1655, 2, 1, 'N', NULL, NULL),
(1656, 2, 3, 'N', NULL, NULL),
(1657, 2, 4, 'N', NULL, NULL),
(1658, 2, 5, 'N', NULL, NULL),
(1659, 2, 7, 'N', NULL, NULL),
(1660, 2, 8, 'N', NULL, NULL),
(1661, 2, 9, 'N', NULL, NULL),
(1662, 2, 19, 'N', NULL, NULL),
(1663, 2, 25, 'N', NULL, NULL),
(1664, 2, 27, 'N', NULL, NULL),
(1665, 2, 33, 'N', NULL, NULL),
(2948, 4, 745, 'N', NULL, NULL),
(2949, 4, 746, 'N', NULL, NULL),
(2950, 4, 747, 'N', NULL, NULL),
(2951, 4, 748, 'N', NULL, NULL),
(2952, 4, 749, 'N', NULL, NULL),
(2953, 4, 750, 'N', NULL, NULL),
(2954, 4, 751, 'N', NULL, NULL),
(2955, 4, 752, 'N', NULL, NULL),
(2956, 4, 753, 'N', NULL, NULL),
(2957, 4, 754, 'N', NULL, NULL),
(2958, 4, 755, 'N', NULL, NULL),
(2959, 4, 756, 'N', NULL, NULL),
(2960, 4, 757, 'N', NULL, NULL),
(2961, 4, 758, 'N', NULL, NULL),
(2962, 4, 759, 'N', NULL, NULL),
(2963, 4, 760, 'N', NULL, NULL),
(2964, 4, 761, 'N', NULL, NULL),
(2965, 4, 762, 'N', NULL, NULL),
(2966, 4, 763, 'N', NULL, NULL),
(2967, 4, 764, 'N', NULL, NULL),
(2968, 4, 765, 'N', NULL, NULL),
(2969, 4, 766, 'N', NULL, NULL),
(2970, 4, 767, 'N', NULL, NULL),
(2971, 4, 768, 'N', NULL, NULL),
(2972, 4, 722, 'N', NULL, NULL),
(2973, 4, 723, 'N', NULL, NULL),
(2974, 4, 724, 'N', NULL, NULL),
(2975, 4, 725, 'N', NULL, NULL),
(2976, 4, 726, 'N', NULL, NULL),
(2977, 4, 727, 'N', NULL, NULL),
(2978, 4, 728, 'N', NULL, NULL),
(2979, 4, 729, 'N', NULL, NULL),
(2980, 4, 730, 'N', NULL, NULL),
(2981, 4, 731, 'N', NULL, NULL),
(2982, 4, 732, 'N', NULL, NULL),
(2983, 4, 733, 'N', NULL, NULL),
(2984, 4, 734, 'N', NULL, NULL),
(2985, 4, 735, 'N', NULL, NULL),
(2986, 4, 736, 'N', NULL, NULL),
(2987, 4, 737, 'N', NULL, NULL),
(2988, 4, 738, 'N', NULL, NULL),
(2989, 4, 739, 'N', NULL, NULL),
(2990, 4, 740, 'N', NULL, NULL),
(2991, 4, 741, 'N', NULL, NULL),
(2992, 4, 742, 'N', NULL, NULL),
(2993, 4, 743, 'N', NULL, NULL),
(2994, 4, 585, 'N', NULL, NULL),
(2995, 4, 586, 'N', NULL, NULL),
(2996, 4, 587, 'N', NULL, NULL),
(2997, 4, 588, 'N', NULL, NULL),
(2998, 4, 589, 'N', NULL, NULL),
(2999, 4, 590, 'N', NULL, NULL),
(3000, 4, 591, 'N', NULL, NULL),
(3001, 4, 592, 'N', NULL, NULL),
(3002, 4, 593, 'N', NULL, NULL),
(3003, 4, 594, 'N', NULL, NULL),
(3004, 4, 595, 'N', NULL, NULL),
(3005, 4, 596, 'N', NULL, NULL),
(3006, 4, 597, 'N', NULL, NULL),
(3007, 4, 598, 'N', NULL, NULL),
(3008, 4, 599, 'N', NULL, NULL),
(3009, 4, 600, 'N', NULL, NULL),
(3010, 4, 601, 'N', NULL, NULL),
(3011, 4, 602, 'N', NULL, NULL),
(3012, 4, 603, 'N', NULL, NULL),
(3013, 4, 604, 'N', NULL, NULL),
(3014, 4, 605, 'N', NULL, NULL),
(3015, 4, 606, 'N', NULL, NULL),
(3016, 4, 607, 'N', NULL, NULL),
(3017, 4, 608, 'N', NULL, NULL),
(3018, 4, 609, 'N', NULL, NULL),
(3019, 4, 610, 'N', NULL, NULL),
(3020, 4, 611, 'N', NULL, NULL),
(3021, 4, 612, 'N', NULL, NULL),
(3022, 4, 613, 'N', NULL, NULL),
(3023, 4, 614, 'N', NULL, NULL),
(3024, 4, 615, 'N', NULL, NULL),
(3025, 4, 616, 'N', NULL, NULL),
(3026, 4, 617, 'N', NULL, NULL),
(3027, 4, 618, 'N', NULL, NULL),
(3028, 4, 619, 'N', NULL, NULL),
(3029, 4, 620, 'N', NULL, NULL),
(3030, 4, 621, 'N', NULL, NULL),
(3031, 4, 622, 'N', NULL, NULL),
(3032, 4, 623, 'N', NULL, NULL),
(3033, 4, 624, 'N', NULL, NULL),
(3034, 4, 625, 'N', NULL, NULL),
(3035, 4, 626, 'N', NULL, NULL),
(3036, 4, 627, 'N', NULL, NULL),
(3037, 4, 628, 'N', NULL, NULL),
(3038, 4, 629, 'N', NULL, NULL),
(3039, 4, 630, 'N', NULL, NULL),
(3040, 4, 631, 'N', NULL, NULL),
(3041, 4, 632, 'N', NULL, NULL),
(3042, 4, 633, 'N', NULL, NULL),
(3043, 4, 634, 'N', NULL, NULL),
(3044, 4, 635, 'N', NULL, NULL),
(3045, 4, 636, 'N', NULL, NULL),
(3046, 4, 637, 'N', NULL, NULL),
(3047, 4, 638, 'N', NULL, NULL),
(3048, 4, 639, 'N', NULL, NULL),
(3049, 4, 444, 'N', NULL, NULL),
(3050, 4, 445, 'N', NULL, NULL),
(3051, 4, 446, 'N', NULL, NULL),
(3052, 4, 447, 'N', NULL, NULL),
(3053, 4, 448, 'N', NULL, NULL),
(3054, 4, 449, 'N', NULL, NULL),
(3055, 4, 450, 'N', NULL, NULL),
(3056, 4, 451, 'N', NULL, NULL),
(3057, 4, 452, 'N', NULL, NULL),
(3058, 4, 453, 'N', NULL, NULL),
(3059, 4, 454, 'N', NULL, NULL),
(3060, 4, 455, 'N', NULL, NULL),
(3061, 4, 456, 'N', NULL, NULL),
(3062, 4, 457, 'N', NULL, NULL),
(3063, 4, 458, 'N', NULL, NULL),
(3064, 4, 459, 'N', NULL, NULL),
(3065, 4, 460, 'N', NULL, NULL),
(3066, 4, 461, 'N', NULL, NULL),
(3067, 4, 462, 'N', NULL, NULL),
(3068, 4, 463, 'N', NULL, NULL),
(3069, 4, 464, 'N', NULL, NULL),
(3070, 4, 465, 'N', NULL, NULL),
(3071, 4, 466, 'N', NULL, NULL),
(3072, 4, 467, 'N', NULL, NULL),
(3073, 4, 468, 'N', NULL, NULL),
(3074, 4, 469, 'N', NULL, NULL),
(3075, 4, 470, 'N', NULL, NULL),
(3076, 4, 471, 'N', NULL, NULL),
(3077, 4, 472, 'N', NULL, NULL),
(3078, 4, 473, 'N', NULL, NULL),
(3079, 4, 474, 'N', NULL, NULL),
(3080, 4, 362, 'N', NULL, NULL),
(3081, 4, 363, 'N', NULL, NULL),
(3082, 4, 364, 'N', NULL, NULL),
(3083, 4, 365, 'N', NULL, NULL),
(3084, 4, 366, 'N', NULL, NULL),
(3085, 4, 367, 'N', NULL, NULL),
(3086, 4, 368, 'N', NULL, NULL),
(3087, 4, 369, 'N', NULL, NULL),
(3088, 4, 370, 'N', NULL, NULL),
(3089, 4, 371, 'N', NULL, NULL),
(3090, 4, 372, 'N', NULL, NULL),
(3091, 4, 373, 'N', NULL, NULL),
(3092, 4, 374, 'N', NULL, NULL),
(3093, 4, 375, 'N', NULL, NULL),
(3094, 4, 376, 'N', NULL, NULL),
(3095, 4, 377, 'N', NULL, NULL),
(3096, 4, 378, 'N', NULL, NULL),
(3097, 4, 379, 'N', NULL, NULL),
(3098, 4, 380, 'N', NULL, NULL),
(3099, 4, 381, 'N', NULL, NULL),
(3100, 4, 320, 'N', NULL, NULL),
(3101, 4, 321, 'N', NULL, NULL),
(3102, 4, 322, 'N', NULL, NULL),
(3103, 4, 323, 'N', NULL, NULL),
(3104, 4, 324, 'N', NULL, NULL),
(3105, 4, 325, 'N', NULL, NULL),
(3106, 4, 326, 'N', NULL, NULL),
(3107, 4, 327, 'N', NULL, NULL),
(3108, 4, 328, 'N', NULL, NULL),
(3109, 4, 329, 'N', NULL, NULL),
(3110, 4, 330, 'N', NULL, NULL),
(3111, 4, 331, 'N', NULL, NULL),
(3112, 4, 332, 'N', NULL, NULL),
(3113, 4, 333, 'N', NULL, NULL),
(3114, 4, 334, 'N', NULL, NULL),
(3115, 4, 335, 'N', NULL, NULL),
(3116, 4, 336, 'N', NULL, NULL),
(3117, 4, 337, 'N', NULL, NULL),
(3118, 4, 338, 'N', NULL, NULL),
(3119, 4, 339, 'N', NULL, NULL),
(3120, 4, 340, 'N', NULL, NULL),
(3121, 4, 341, 'N', NULL, NULL),
(3122, 4, 342, 'N', NULL, NULL),
(3123, 4, 343, 'N', NULL, NULL),
(3124, 4, 344, 'N', NULL, NULL),
(3125, 4, 345, 'N', NULL, NULL),
(3126, 4, 346, 'N', NULL, NULL),
(3127, 4, 347, 'N', NULL, NULL),
(3128, 4, 348, 'N', NULL, NULL),
(3129, 4, 349, 'N', NULL, NULL),
(3130, 4, 350, 'N', NULL, NULL),
(3131, 4, 351, 'N', NULL, NULL),
(3132, 4, 352, 'N', NULL, NULL),
(3133, 4, 353, 'N', NULL, NULL),
(3134, 4, 354, 'N', NULL, NULL),
(3135, 4, 355, 'N', NULL, NULL),
(3136, 4, 356, 'N', NULL, NULL),
(3137, 4, 357, 'N', NULL, NULL),
(3138, 4, 358, 'N', NULL, NULL),
(3139, 4, 359, 'N', NULL, NULL),
(3140, 4, 360, 'N', NULL, NULL),
(3141, 4, 361, 'N', NULL, NULL),
(3142, 4, 286, 'N', NULL, NULL),
(3143, 4, 287, 'N', NULL, NULL),
(3144, 4, 288, 'N', NULL, NULL),
(3145, 4, 289, 'N', NULL, NULL),
(3146, 4, 290, 'N', NULL, NULL),
(3147, 4, 291, 'N', NULL, NULL),
(3148, 4, 292, 'N', NULL, NULL),
(3149, 4, 293, 'N', NULL, NULL),
(3150, 4, 294, 'N', NULL, NULL),
(3151, 4, 295, 'N', NULL, NULL),
(3152, 4, 296, 'N', NULL, NULL),
(3153, 4, 297, 'N', NULL, NULL),
(3154, 4, 298, 'N', NULL, NULL),
(3155, 4, 299, 'N', NULL, NULL),
(3156, 4, 300, 'N', NULL, NULL),
(3157, 4, 301, 'N', NULL, NULL),
(3158, 4, 302, 'N', NULL, NULL),
(3159, 4, 303, 'N', NULL, NULL),
(3160, 4, 304, 'N', NULL, NULL),
(3161, 4, 305, 'N', NULL, NULL),
(3162, 4, 306, 'N', NULL, NULL),
(3163, 4, 307, 'N', NULL, NULL),
(3164, 4, 308, 'N', NULL, NULL),
(3165, 4, 309, 'N', NULL, NULL),
(3166, 4, 310, 'N', NULL, NULL),
(3167, 4, 311, 'N', NULL, NULL),
(3168, 4, 312, 'N', NULL, NULL),
(3169, 4, 313, 'N', NULL, NULL),
(3170, 4, 314, 'N', NULL, NULL),
(3171, 4, 315, 'N', NULL, NULL),
(3172, 4, 316, 'N', NULL, NULL),
(3173, 4, 317, 'N', NULL, NULL),
(3174, 4, 318, 'N', NULL, NULL),
(3175, 4, 319, 'N', NULL, NULL),
(3176, 4, 248, 'N', NULL, NULL),
(3177, 4, 249, 'N', NULL, NULL),
(3178, 4, 250, 'N', NULL, NULL),
(3179, 4, 251, 'N', NULL, NULL),
(3180, 4, 252, 'N', NULL, NULL),
(3181, 4, 253, 'N', NULL, NULL),
(3182, 4, 254, 'N', NULL, NULL),
(3183, 4, 255, 'N', NULL, NULL),
(3184, 4, 256, 'N', NULL, NULL),
(3185, 4, 257, 'N', NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=200 ;

--
-- Dumping data for table `member_service_class`
--

INSERT INTO `member_service_class` (`id`, `service_class_id`, `member_id`, `offer`, `newV`, `currency`, `timestamp`, `user_id`, `active`) VALUES
(122, 9, 2, 38040, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(123, 9, 2, 31700, 'Y', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(124, 3, 2, 2090, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(125, 3, 2, 1479, 'Y', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(126, 2, 2, 1375, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(127, 2, 2, 1325, 'Y', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(128, 1, 2, 1192, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(129, 18, 2, 105196, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(130, 12, 2, 4505, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(131, 11, 2, 3180, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(132, 10, 2, 1423, 'N', 'HRK', '2014-03-21 02:38:12', 75388854238, 'Y'),
(150, 9, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(151, 9, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(152, 8, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(153, 8, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(154, 7, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(155, 7, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(156, 6, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(157, 6, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(158, 5, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(159, 5, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(160, 4, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(161, 4, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(162, 3, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(163, 3, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(164, 2, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(165, 2, 3, 0, 'Y', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(166, 1, 3, 0, 'N', 'HRK', '2014-03-21 05:32:04', 26640499090, 'N'),
(177, 1, 5, 0, 'N', 'HRK', '2014-03-22 07:34:25', 65340328857, 'N'),
(178, 10, 5, 0, 'N', 'HRK', '2014-03-22 07:34:25', 65340328857, 'N'),
(182, 1, 6, 0, 'N', 'HRK', '2014-03-26 08:41:05', 86769546972, 'N'),
(192, 3, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(193, 3, 4, 0, 'Y', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(194, 1, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(195, 18, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(196, 16, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(197, 14, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(198, 11, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N'),
(199, 10, 4, 0, 'N', 'HRK', '2014-04-03 07:09:37', 50319913673, 'N');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=349 ;

--
-- Dumping data for table `member_tmp`
--

INSERT INTO `member_tmp` (`reg_broj`, `huec`, `naziv`, `oib`, `poslodavac`, `zupanija`, `grad`, `adresa`, `tel`, `mob`, `modul_1`, `modul_2`, `modul_3`, `modul_4`, `ovalstenje`, `id`, `registered`, `email`) VALUES
('P-21/2010', 'DA', 'DANKIĆ SLIEPČEVIĆ NATAŠA', NULL, 'INVESTINŽENJERING d.o.o.', 'Grad Zagreb', 'Zagreb', 'Tuškanova 41', '01/4551-144', '098/298-392', 'DA', 'DA', 'DA', 'DA', '10.5.2014.', 1, 'N', 'natasa.dankic@gin.hr'),
('F-23/2010', NULL, 'PIPAL BRANKA', NULL, 'Ured ovlaštene arhitektice Branka Pipal', 'Grad Zagreb', 'Zagreb', 'G. Krkleca 22', '01/3898-786', '098/684-501', 'DA', 'DA', 'DA', 'NE', '23.7.2016.', 2, 'N', 'vitomir.pipal@zg.htnet.hr'),
('P-23/2010', 'DA', 'BORKOVIĆ TONI', NULL, 'Energetski institut Hrvoje Požar', 'Grad Zagreb', 'Zagreb', 'Savska 163', '01/ 6326-114', '098/470-939', 'DA', 'DA', 'DA', 'NE', '11.7.2016.', 3, 'N', 'toni.borkovic@eihp.hr'),
('P-23/2010', 'DA', 'ZIDAR MARGARETA', NULL, 'Energetski institut Hrvoje Požar', 'Grad Zagreb', 'Zagreb', 'Savska 163', '01/ 6326 108', NULL, 'DA', 'DA', 'DA', 'DA', '11.7.2016.', 4, 'N', 'mzidar@eihp.hr'),
('P-23/2010', 'DA', 'HRS BORKOVIĆ ŽELJKA', NULL, 'Energetski institut Hrvoje Požar', 'Grad Zagreb', 'Zagreb', 'Savska 163', '01 6326 138', NULL, 'DA', 'DA', 'DA', 'DA', NULL, 5, 'N', 'zhrs@eihp.hr'),
('P-23/2010', 'DA', 'MALINOVAC PUČEK MARINA', NULL, 'Energetski institut Hrvoje Požar', 'Grad Zagreb', 'Zagreb', 'Savska 163', '01/ 6326 168', NULL, 'DA', 'DA', 'DA', 'DA', '11.07.2016.', 6, 'N', 'mmalinovec@eihp.hr'),
('P-23/2010', 'DA', 'PREBEG FILIP', NULL, 'Energetski institut Hrvoje Požar', 'Grad Zagreb', 'Zagreb', 'Savska 163', '01/ 6326 164', NULL, 'DA', 'DA', 'DA', 'DA', '11.07.2016.', 7, 'N', 'fprebeg@eihp.hr'),
('F-24/2010', 'DA', 'KURETIĆ HRVOJE', NULL, 'DOMUS PLUS d.o.o.', 'Grad Zagreb', 'Zagreb', 'Gajeva 51', '01 2365 549', '091 5904 115', 'DA', 'NE', 'DA', 'NE', '26.7.2016.', 8, 'N', 'hrvoje.kuretic@domusplus.hr'),
('F-25/2010', 'DA', 'COBOVIĆ DARKO', NULL, 'CENTAR ZA ENERGETSKO CERTIFICIRANJE', 'Grad Zagreb', 'Zagreb', 'Mahatme Gandhija 3', '01 379 3344', '091 2512 238', 'DA', 'NE', 'DA', 'NE', '21.2.2016.', 9, 'N', 'darko.cobovic@gmail.com'),
('P-27/2010', 'DA', 'ŠIKIĆ DAVIDOVIĆ DUBRAVKA', NULL, 'BIRO 29 d.o.o.', 'Grad Zagreb', 'Zagreb', 'Jagićeva 29', '01/ 3740-091', '098 290052', 'DA', 'NE', 'DA', 'DA', NULL, 10, 'N', 'dubravka.sikic-davidovic@biro29.hr'),
('F-28/2010', NULL, 'KRSTULOVIĆ-OPARA LOVRE, prof. dr. sc.', NULL, 'Fakultet elektrotehnike, strojarstva i brodogradnje, Sveučilište u Splitu', 'Splitsko Dalmatinska', 'Split', 'Spinčićeva 2D', '021 / 30-5981', NULL, 'DA', 'DA', 'DA', 'NE', '12.7.2016.', 11, 'N', 'Lovre.Krstulovic-Opara@fesb.hr'),
('P-28/2010', 'DA', 'ŠUŠKOVIĆ MAJA', NULL, 'DID-ing. d.o.o.', 'Grad Zagreb', 'Zagreb', 'Klaićeva 62', '01 3705381', '0915766481', 'DA', 'NE', 'DA', 'NE', '22.7.2016.', 12, 'N', 'diding@inet.hr'),
('F-29/2010', NULL, 'ŽUPANIĆ BORIS', NULL, 'TRIPICO D.O.O.', 'Varaždinska', 'Ivanec', 'Akademika Mirka Maleza 46A', '042/784-110', NULL, 'DA', 'NE', 'DA', 'NE', '2.10.2016.', 13, 'N', 'tripico_doo@optinet.hr'),
('F-30/2010', NULL, 'NEMEC TATJANA', NULL, 'NEMEC TATJANA ured ovlaštenog inženjera gradevinarstva', 'Grad Zagreb', 'Zagreb', 'Božidara Magovca 149', NULL, '0989177443', 'DA', 'NE', 'DA', 'NE', '23.10.2016.', 14, 'N', NULL),
('P-30/2010', 'DA', 'PAVIĆ TOMISLAV', NULL, 'ENERGONOVA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Novačka 333', '01/234-3376', '091/234-3376', 'DA', 'DA', 'DA', 'DA', '12.11.2016.', 15, 'N', 'tomislav.pavic@energonova.hr'),
('F-31/2010', NULL, 'PETRANOVIĆ ZLATKO', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Ivana Broza 44', NULL, '098 257873', 'DA', 'NE', 'DA', 'NE', '13.9.2016.', 16, 'N', 'zpetrano@gmail.com'),
('P-31/2010', 'DA', 'KLASIĆ EMA', NULL, 'LAMBOT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Duvanjska 26', '01/3750-816', '098/907 6780', 'NE', 'NE', 'DA', 'DA', '30.08.2016.', 17, 'N', 'ema.klasic@zg.t-com.hr'),
('F-32/2010', 'DA', 'ŠPOLJARIĆ DOMAGOJ', NULL, 'OSTRAKON d.o.o.', 'Grad Zagreb', 'Zagreb', 'Kozarčeva 39', '01 3694 927', '098 313 190', 'DA', 'NE', 'DA', 'NE', '30.8.2016.', 18, 'N', 'ostrakon.ostrakon@gmail.com'),
('P-32/2010', 'DA', 'JAKOMIN ANDREJ', NULL, 'MODUL E3 d.o.o.', 'Grad Zagreb', 'Zagreb', 'Mladice 14', '01/3450-530', '091/5241-684', 'DA', 'NE', 'DA', 'DA', '12.9.2016.', 19, 'N', 'andrej.jakomin1@zg.t-com.hr'),
('P-31/2010', 'DA', 'ZLONOGA MARKO', NULL, 'MODUL E3 d.o.o.', 'Grad Zagreb', 'Zagreb', 'Mladice 14', '01/6140-665', '091/7633-236', 'DA', 'NE', 'DA', 'NE', '12.9.2016.', 20, 'N', 'marko.zlonoga@zg.t-com.hr'),
('F-34/2010', NULL, 'RUDOLF DENIS', NULL, 'Ured ovlaštenog inženjera gradevinarstva Denis Rudolf', 'Istarska', 'Rovinj', 'R. Schaudina 7', '052/811180', NULL, 'DA', 'NE', 'DA', 'NE', '23.7.2016.', 21, 'N', NULL),
('P-34/2010', 'DA', 'DVORŠĆAK VELIMIR', NULL, 'MULTIMONT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Babonićeva 56A', '01/4633-835', '098/504-612', 'DA', 'DA', 'DA', 'NE', '24.7.2016.', 22, 'N', 'multimont.zagreb@zg.t-com.hr'),
('P-44/2010', 'DA', 'BUŠIĆ INES', NULL, 'FORMING d.o.o.', 'Splitsko Dalmatinska', 'Kaštel Novi', 'Cesta dr. F. Tuđmana 767', '021/230-423', '091/2304-232', 'DA', 'NE', 'DA', 'DA', '22.7.2016.', 23, 'N', 'forming-ibusic@st.t-com.hr'),
('P-46/2010', 'DA', 'RADOVČIĆ ANA', NULL, 'NET.STUDIO ARANEA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Bogovićeva 4', '01/4813-800', '091/5285-449', 'DA', 'DA', 'DA', 'DA', '1.8.2016.', 24, 'N', 'ana@netstudioaranea.hr'),
('F-47/2010', 'DA', 'HREN ARNOLD', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Kozarčeva 39', '01 4821 373', '099 2006 543', 'DA', 'DA', 'DA', 'DA', '17.9.2016.', 25, 'N', 'arnold@ence.hr'),
('P-47/2010', 'DA', 'BARDIĆ SLAVICA', NULL, 'HELB d.o.o.', 'Zagrebačka', 'Dugo Selo', 'Slavka Kolara 4', '01/2781-443', '098/9840-747', 'NE', 'NE', 'DA', 'DA', '25.7.2016.', 26, 'N', 'slavica.bardic@helb.hr'),
('F-49/2010', 'DA', 'ŠTIMAC TONKO', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Dedići 61A', '01 6326 114', '091 463 511', 'DA', 'NE', 'DA', 'NE', '30.9.2016.', 27, 'N', 'tonkos@yahoo.com'),
('F-50/2010', 'DA', 'ČAČIĆ JURE', NULL, 'ARHITEKTING d.o.o.', 'Zadarska', 'Zadar', 'Franje Fanceva 49', '023 221 114', '098 1604 150', 'DA', 'NE', 'DA', 'NE', '22.10.2016.', 28, 'N', 'arhitekting@zd.t-com.hr'),
('F-58/2010', 'DA', 'BAŠIĆ GORAN', NULL, NULL, 'Istarska', 'Pula', 'Karlovačka 14', '052 535 655', '098 402 100', 'DA', 'NE', 'DA', 'NE', '23.10.2016.', 29, 'N', 'goran.basic@pu.t-com.hr'),
('F-59/2010', NULL, 'HRESTAK DENIS', NULL, 'APIS IT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Kikićeva 13', '01 3855 101', NULL, 'DA', 'NE', 'DA', 'NE', '23.10.2016.', 30, 'N', 'denis.hrestak@apis-it.hr'),
('P-59/2010', 'DA', 'KARABIĆ RADOVAN', NULL, 'ELEKTRON d.o.o.', 'Primorsko Goranska', 'Krk', 'Vršanska 26f', '051/222-620', '098/327 929', 'DA', 'DA', 'DA', 'DA', '16.9.2016.', 31, 'N', 'direktor@elektron-krk.hr'),
('F-60/2010', NULL, 'KOVAČEC MIROSLAV', NULL, 'HEP ESCO d.o.o.', 'Krapinsko-zagorska', 'Jesenje', 'Gornje Jesenje, Gornje Jesenje 19A', '01/6322-613', NULL, 'DA', 'DA', 'NE', 'NE', '23.9.2016.', 32, 'N', 'miroslav.kovacec@hep.hr'),
('P-69/2010', 'DA', 'VASER STJEPAN', NULL, 'Elsi Hitech group, d.o.o.', 'Međimurska', 'Čakovec', 'I. Mažuranića 2', '040/310-453', '098/241-106', 'DA', 'NE', 'DA', 'NE', NULL, 33, 'N', 'stjepan.vaser@ck.t-com.hr'),
('F-71/2010', 'DA', 'TONKOVIĆ-BIŠĆAN KARMEN', NULL, 'Elektroprojekt d.d. ', 'Grad Zagreb', 'Zagreb', 'Hrastin prilaz 2', '01 6307 734', '099 2433 053', 'DA', 'NE', 'DA', 'NE', '18.11.2016.', 34, 'N', 'karmen.tonkovic-biscan@elektroprojekt.hr'),
('F-72/2010', NULL, 'SINČIĆ VANJA', NULL, 'OPATIJA PROJEKT ABBAZIA d.o.o.', 'Primorsko Goranska', 'Opatija', 'J. Rakovca 19', '051/271-172', '098/258-457', 'DA', 'NE', 'DA', 'NE', '29.11.2016.', 35, 'N', 'opatija-abb@ri.t-com.hr'),
('F-73/2010', 'DA', 'BEŠLIĆ MARKO', NULL, NULL, 'Zadarska', 'Zadar', 'Novogradiška 10', '023 300 104', '099 2161 992', 'DA', 'DA', 'DA', 'NE', '4.12.2016.', 36, 'N', 'marko.beslic@gmail.com'),
('F-66/2010', NULL, 'ĐERZIĆ DAMIR', NULL, 'Sektor za građenje i održavanje komunalne infrastrukture', 'Grad Zagreb', 'Zagreb', 'Počiteljska 11', '01 610-0742', NULL, 'DA', 'DA', 'DA', 'NE', '30.9.2016.', 37, 'N', 'Damir.Derzic@zagreb.hr'),
('P-66/2010', 'DA', 'BADROV BLAIĆ ANAMARIJA', NULL, 'AB PROJEKTIRANJE I GRAĐENJE d.o.o.', 'Grad Zagreb', 'Zagreb', 'Mlinovi 133', '01/4637-003', '098/1601-433', 'DA', 'NE', 'DA', 'NE', '22.11.2016.', 38, 'N', 'anamarija.badrov@zg.t-com.hr'),
('P-79/2010', 'DA', 'KRVAVICA RENATA', NULL, 'K2 d.o.o.', 'Zagrebačka', 'Samobor', 'Većeslava Kolara 19', '01/3377958', '098/460-616', 'DA', 'NE', 'DA', 'DA', '11.12.2016.', 39, 'N', 'k2@sk.t-com.hr'),
('F-80/2010', NULL, 'BIKIĆ MARIO', NULL, '3M PROJEKT d.o.o.', 'Vukovarsko Srijemska', 'Vinkovci', 'Hercegovačka 19', '032/338-776', '098/1923-321', 'DA', 'NE', 'DA', 'NE', '18.12.2016.', 40, 'N', 'mario.bikic@vk.t-com.hr'),
('F-81/2010', NULL, 'RADOVIĆ GORIČANEC ALEMKA ', NULL, 'URED OVLAŠTENE ARHITEKTICE RADOVIĆ GORIČANEC ALEMIKA', 'Istarska', 'Labin', 'Prilaz Vala 10', '052/851 400', NULL, 'DA', 'NE', 'DA', 'NE', '11.12.2016.', 41, 'N', 'alemka.radovic@gmail.com'),
('F-83/2010', NULL, 'ROCCO CLAUDIO', NULL, 'Ured ovlaštenog inženjera ROCCO CLAUDIO', 'Istarska', 'Rovinj', 'Ratarska 4', '052 842-273', NULL, 'DA', 'NE', 'DA', 'NE', '16.10.2016.', 42, 'N', NULL),
('F-85/2010', NULL, 'CSERVENÁK FERENC', NULL, '4-D studio d.o.o. ', 'Primorsko Goranska', 'Kastav', 'Rubeši 15', '051-225-380', '098-166-8506, 091-797-4141', 'DA', 'NE', 'DA', 'NE', '12.12.2016.', 43, 'N', 'cseriferi@gmail.com '),
('P-88/2010', 'DA', 'JANČIKOVIĆ SAŠA', NULL, 'REDPET d.o.o.', 'Grad Zagreb', 'Zagreb', 'Hercegovačka 103', '01/3755-722', '098/1749-352, 091/2456-408', 'DA', 'DA', 'DA', 'DA', '9.12.2016.', 44, 'N', 'sasa@redpet.hr'),
('F-89/2010', NULL, 'BUČEVIĆ ZVONIMIR', NULL, NULL, 'Osječko-baranjska', 'Osijek', 'Martina Divalta 28', NULL, '098 373 321, 097 737 0223', 'DA', 'DA', 'DA', 'NE', '27.12.2016.', 45, 'N', 'zvonimirbucevic@gmail.com'),
('F-94/2010', 'DA', 'KOLAR EMIL', NULL, 'TAENIA d.o.o.', 'Vukovarsko Srijemska', 'Vukovar', 'Petra Preradovića 41', '032/413-467', '098/346-618', 'DA', 'DA', 'DA', 'DA', '13.01.2014.', 46, 'N', 'emil@taenia.hr'),
('F-95/2011', 'DA', 'BARBIR JOSIP', NULL, NULL, 'Varaždinska', 'Varaždin', 'Trakošćanska 24', NULL, '099 6105 355', 'DA', 'DA', 'DA', 'NE', '30.12.2016.', 47, 'N', 'josip.barbir@vz.t-com.hr'),
('F-99/2011', 'DA', 'NAHOD MAJA-MARIJA, mr. sc.', NULL, 'GRAĐEVINSKI FAKULTET, SVEUČILIŠTE U ZAGREBU', 'Grad Zagreb', 'Zagreb', 'Ivana Antunovića 21', NULL, '098 9054 437', 'DA', 'NE', 'DA', 'NE', '30.3.2014.', 48, 'N', 'majan@grad.hr'),
('F-165/2012', NULL, 'KATIĆ VJEKO', NULL, 'KAT GRADITELJSTVO d.o.o.', 'Grad Zagreb', 'Zagreb', 'Don Boscova 10', '01 3490619', NULL, 'DA', 'NE', 'DA', 'NE', '30.3.2015.', 49, 'N', NULL),
('F-166/2012', 'DA', 'KAIĆ FRANKO', NULL, 'STUDIO KAIĆ d.o.o.', 'Istarska', 'Pula', 'Epulonova 21', '052 381 450', '098 254 154', 'DA', 'NE', 'DA', 'NE', '6.3.2015.', 50, 'N', 'franko.kaic@pu.t-com.hr'),
('F-168/2012', NULL, 'PALISKA DAVOR', NULL, 'OPG DAVOR PALISKA', 'Sisačko-moslavačka', 'Glina', 'Majske Poljane 42', NULL, '098 290308', 'DA', 'DA', 'DA', 'NE', '2.4.2015.', 51, 'N', NULL),
('F-169/2012', NULL, 'MARČETIĆ DANIEL', NULL, 'SAMOSTALNI URED ZA PROJEKTIRANJE DANIJEL MARČETIĆ ', 'Primorsko Goranska', 'Kraljevica', 'Šmrika, Burići 8', '031 811 433', NULL, 'DA', 'NE', 'DA', 'NE', '30.4.2015.', 52, 'N', NULL),
('F-170/2012', NULL, 'MARINIĆ ANTO', NULL, 'Ured za gradnje i obnove crkvenih objekata - Đakovačko-osječka nadbiskupija', 'Brodsko-posavska', 'Slavonski Brod', 'Požeška 54', '035/465-114', NULL, 'DA', 'NE', 'DA', 'NE', '30.4.2015.', 53, 'N', NULL),
('F-171/2012', NULL, 'POPOVIĆ DANILO', NULL, 'DANILO POPOVIĆ, URED OVL.ING.', 'Osječko-baranjska', 'Osijek', 'Vijenac Kraljeve Kutjeske 4', NULL, '098 178 9356', 'DA', 'NE', 'DA', 'NE', '3.5.2015.', 54, 'N', NULL),
('F-173/2012', NULL, 'MARUŠIĆ GORAN', NULL, 'PROJEKT d. o. o.', 'Primorsko Goranska', 'Rijeka', 'Nike Katunara 4', '051 332767', NULL, 'DA', 'NE', 'DA', 'NE', '30.4.2015.', 55, 'N', NULL),
('F-176/2012', NULL, 'GREGUREC ZAGRAJSKI IVANA', NULL, NULL, 'Zadarska', 'Nin', 'Zaton, Put Pliše 39A', NULL, '091 558 2704, 095 907 0688', 'DA', 'NE', 'DA', 'NE', '27.4.2015.', 56, 'N', NULL),
('F-177/2012', NULL, 'DROPULIĆ ZLATKO', NULL, 'DALMIS d. o. o.', 'Istarska', 'Pula', 'Pješčana uvala I ogranak 7', '052 210490', '099 484224', 'DA', 'NE', 'DA', 'NE', '2.5.2015.', 57, 'N', NULL),
('F-179/2012', NULL, 'MRAKOVČIĆ MAROVIĆ ALEKSANDRA SAŠA', NULL, 'CERTIFIKATOR d.o.o.', 'Primorsko Goranska', 'Kostrena', 'Kostrenskih boraca 1', '051 289199', NULL, 'DA', 'NE', 'DA', 'NE', '30.4.2015.', 58, 'N', 'sasa.mrakovcic@ri.htnet.hr'),
('F-181/2012', NULL, 'GÄRTNER MARIJAN', NULL, 'GIVA D.O.O.', 'Zagrebačka', 'Samobor', 'Marka Vukasovića 16', '01/3361121', '098/233-414', 'DA', 'NE', 'DA', 'NE', '31.5.2015.', 59, 'N', 'givasamobor@inet.hr'),
('F-182/2012', NULL, 'ŠANTAK SILVESTAR', NULL, 'Riteh d.o.o.', 'Grad Zagreb', 'Zagreb', 'Srijemska 11A', '01 6430 376', NULL, 'DA', 'DA', 'DA', 'NE', '30.5.2015.', 60, 'N', NULL),
('F-184/2012', NULL, 'HREHOROVIĆ DINKO', NULL, 'ĐAKOVAČKI VODOVOD d.o.o.', 'Osječko-baranjska', 'Đakovo', 'V. Lisinskog 18', '031/813564, 031/821826', NULL, 'DA', 'NE', 'DA', 'NE', '31.5.2015.', 61, 'N', 'dj.vodovod@inet.hr'),
('F-185/2012', 'DA', 'DAVIDOVIĆ ŽELIMIR', NULL, 'BIRO 29 d.o.o.', 'Grad Zagreb', 'Zagreb', 'Jagićeva 29', '01/3740-091', '098/484-860', 'DA', 'NE', 'DA', 'NE', '19.7.2016.', 62, 'N', 'zelimir.davidovic@biro29.hr'),
('F-188/2012', NULL, 'VIDAKOVIĆ SANJA', NULL, 'MEGA POLIS D.O.O.', 'Zadarska', 'Zadar', 'Dalmatinskog sabora 4', '023/647-376', NULL, 'DA', 'NE', 'DA', 'NE', '10.7.2015.', 63, 'N', 'megapolis.zd@gmail.com'),
('F-189/2012', NULL, 'KUZMANIĆ ANA', NULL, 'Kuzmanić&Šimunović Projekt d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Put Žnjana', '021 27 05 11', '095 54 99 971', 'DA', 'NE', 'DA', 'NE', '19.7.2015.', 64, 'N', 'ana@kuzmanic-simunovic.hr'),
('F-190/2012', NULL, 'MEDURIĆ-JAVOR RUŽICA', NULL, 'Gradska uprava Rijeka', 'Primorsko Goranska', 'Rijeka', 'Brig 70A', '051 209-238', NULL, 'DA', 'NE', 'DA', 'NE', '25.7.2015.', 65, 'N', 'ruzica.meduric-javor@rijeka.hr'),
('F-191/2012', 'DA', 'KOS ŽELJKO', NULL, 'IGP RISAL', 'Varaždinska', 'Varaždin', 'Ivana Rangera 16', '042 639 260', '098 757 989', 'DA', 'NE', 'DA', 'NE', '12.7.2015.', 66, 'N', 'kos.vz@live.com'),
('P-191/2012', 'DA', 'BUKŠA MLADEN', NULL, 'POSITOR d.o.o.', 'Zadarska', 'Zadar', 'Josipa Eugena Tomića 14', '023/311-202', '091/512-0464', 'DA', 'DA', 'DA', 'DA', '28.12.2014.', 67, 'N', 'mladen.buksa@email.t-com.hr'),
('F-192/2012', 'DA', 'VRHOVNIK BOŽO', NULL, 'N-Di d.o.o.', 'Grad Zagreb', 'Zagreb', 'Nova cesta 113', '01 4818 982', '098 186 1082', 'DA', 'NE', 'DA', 'NE', '21.9.2015.', 68, 'N', 'bozo.vrhovnik@gmail.com'),
('F-193/2012', 'DA', 'HLADEK IGOR', NULL, 'DOM NA KVADRAT d.o.o.', 'Vukovarsko Srijemska', 'Županja', 'Osječka 52', '032/837-924', '098/9775-821', 'DA', 'DA', 'NE', 'NE', '27.7.2015.', 69, 'N', 'igor.hladek@vk.t-com.hr'),
('F-195/2012', NULL, 'LILIĆ JASMINKA', NULL, 'URED OVLAŠTENOG ING. GRAĐEVINARSTVA JASMINKA LILIĆ ', 'Primorsko Goranska', 'Rijeka', 'Švalbina 7', '051 422 906', NULL, 'DA', 'NE', 'DA', 'NE', '6.11.2015.', 70, 'N', NULL),
('F-196/2012', NULL, 'LIPŠINIĆ VLATKA', NULL, 'URED OVLAŠTENE ARHITEKTICE VLATKA LIPŠINIĆ ', 'Karlovačka', 'Karlovac', 'Tadije Smičiklasa 5C', '047 656 021', '099 260 06 16', 'DA', 'NE', 'DA', 'NE', '5.11.2015.', 71, 'N', 'vlatka.lipsinic@ka.t-com.hr'),
('F-198/2012', NULL, 'BENČIĆ TOMISLAV', NULL, 'Termoplin d.d.', 'Varaždinska', 'Varaždin', 'Ivanečka 29', '042 231 444', '091 232 4439', 'DA', 'DA', 'DA', 'NE', '12.11.2015.', 72, 'N', 'bencic@termoplin.com'),
('P-198/2012', 'DA', 'BRALA VJEKOSLAV', NULL, 'BRALA PROJEKT d.o.o.', 'Zadarska', 'Zadar', 'Put Kotlara 18b', '023 311 692', '091 9537 805', 'DA', 'NE', 'DA', 'NE', '02.05.2015.', 73, 'N', 'bralaprojekt@gmail.com'),
('F-199/2012', NULL, 'MARUŠIĆ ANKA', NULL, 'MARUŠIĆ ANKA, URED OVLAŠTENOG INŽENJERA GRAĐEVINARSTVA ', 'Vukovarsko Srijemska', 'Vrbanja', 'Soljani, Matije Gupca 48', NULL, '098 316 177, 099 228 8601', 'DA', 'NE', 'DA', 'NE', '24.12.2015.', 74, 'N', NULL),
('F-200/2012', NULL, 'MILIČEVIĆ VLATKO', NULL, 'URED OVLAŠTENOG INŽENJERA GRAĐEVINARSTVA VLATKO MILIČEVIĆ', 'Splitsko Dalmatinska', 'Split', 'Kijevska 1', '021 786-405', '098 226-188', 'DA', 'NE', 'DA', 'NE', '12.11.2015.', 75, 'N', 'info.energetski.certifikati@gmail.com'),
('F-201/2013', NULL, 'GARMA TONKO, dr. sc.', NULL, 'Fakultet elektrotehnike, strojarstva i brodogradnje - Sveučilište u Splitu', 'Splitsko Dalmatinska', 'Split', 'Marina Getaldića 9', '021 305 803', NULL, 'DA', 'DA', 'DA', 'NE', '13.5.2016.', 76, 'N', 'Tonko.Garma@fesb.hr'),
('F-202/2012', NULL, 'MILETA DAVOR', NULL, 'OMEGA M d.o.o.', 'Istarska', 'Labin', 'Presika 29A', '052 855 522', '098 258 988', 'DA', 'NE', 'DA', 'NE', '16.11.2015.', 77, 'N', 'omega-m@pu.t-com.hr'),
('F-206/2012', NULL, 'CRNKOVIĆ GORDANA', NULL, 'Margor-prom d.o.o.', 'Grad Zagreb', 'Zagreb', 'Humboldtova 12', NULL, '091 566 9983', 'DA', 'NE', 'DA', 'NE', '16.11.2015.', 78, 'N', 'certifikat@margor.hr'),
('F-208/2012', NULL, 'MILARDOVIĆ MARIN', NULL, 'MD BIRO d.o.o.', 'Zadarska', 'Zadar', 'Put Murata 12', '023 214058', NULL, 'DA', 'NE', 'DA', 'NE', '24.12.2015.', 79, 'N', NULL),
('F-210/2013', NULL, 'SLAVIĆ ZDRAVKO', NULL, 'Ured ovlaštenog INŽENJERA GRAĐEVINARSTVA ZDRAVKO SLAVIĆ ', 'Virovitičko-podravska', 'Virovitica', 'Trg kralja Petra Svačića 23', '033/729-879', NULL, 'DA', 'NE', 'DA', 'NE', '1.2.2016.', 80, 'N', NULL),
('F-211/2013', NULL, 'NOVAK SILVIO', NULL, 'Knauf insulation d.o.o.', 'Varaždinska', 'Varaždin', 'Zagrebačka 53B', '042 401 383', '091 611 3312', 'DA', 'DA', 'DA', 'NE', '19.2.2016.', 81, 'N', 'silvio.novak@knaufinsulation.com'),
('F-212/2013', NULL, 'MARČINKOVIĆ ZLATKO', NULL, 'MARČINKOVIĆ D.O.O.', 'Sisačko-moslavačka', 'Dvor', 'Divuša, Unčani 79', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '26.3.2016.', 82, 'N', 'marcinkovic@sk.htnet.hr'),
('P-213/2012', 'DA', 'BALIĆ KREŠIMIR', NULL, 'ENERGIJA PROJEKTIRANJE d.o.o.', 'Grad Zagreb', 'Zagreb', 'Ante Mike Tripala 1', NULL, '095/4441-113', 'DA', 'NE', 'DA', 'NE', '30.05.2015.', 83, 'N', 'kresimir@energija-projektiranje.eu'),
('F-214/2013', NULL, 'POLJAK-GUNJEVIĆ DARIJA', NULL, 'HYPO ALPE-ADRIA NEKRETNINE d.o.o.', 'Osječko-baranjska', 'Osijek', 'Ilirska 71', '031/231-578', NULL, 'DA', 'NE', 'DA', 'NE', '26.3.2016.', 84, 'N', 'darija.poljak-gunjevic@hypo-alpe-adria.hr'),
('P-216/2012', 'DA', 'GILJANOVIĆ JOSIP', NULL, 'GILAN d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Kralja Zvonimira 14', '021 457 824', '098 370 697', 'DA', 'DA', 'DA', 'DA', '3.12.2015.', 85, 'N', 'josip.giljanovic@gilan.hr'),
('F-217/2013', NULL, 'GARAFULIĆ ENDRI', NULL, 'PRIRODOSLOVNO-MATEMATIČKI FAKULTET, SVEUČILIŠTE U SPLITU', 'Splitsko Dalmatinska', 'Split', 'Sedam Kaštela 6', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '25.3.2016.', 86, 'N', 'Endri.Garafulic@pmfst.hr'),
('F-218/2013', 'DA', 'MORSAN IVANČICA', NULL, 'ISSA DIZAJV d.o.o.', 'Grad Zagreb', 'Zagreb', 'Kustošijanska 88', '01 233 0821', '095 8929 146', 'DA', 'NE', 'DA', 'NE', '2.4.2016.', 87, 'N', 'ivancica.morsan@gmail.com'),
('F-219/2013', NULL, 'RADICA GOJMIR, izv. prof. dr. sc.', NULL, 'Fakultet elektrotehnike, strojarstva i brodogradnje - Sveučilište u Splitu', 'Splitsko Dalmatinska', 'Split', 'Tolstojeva 43', NULL, NULL, 'DA', 'DA', 'DA', 'NE', '2.4.2016.', 88, 'N', 'gojmir.radica@fesb.hr'),
('F-220/2013', NULL, 'JURIŠKOVIĆ MLADEN', NULL, 'ATELJE-ARHITEKT D. O. O.', 'Brodsko-posavska', 'Nova Gradiška', 'Frankopanska 39', '035 362468, ', NULL, 'DA', 'NE', 'DA', 'NE', '29.3.2016.', 89, 'N', 'atelje-arhitekt@sb.t-com.hr'),
('F-221/2013', NULL, 'MAJDANDŽIĆ LJUBOMIR, dr. sc.', NULL, 'Energetski institut Hrvoje Požar', 'Grad Zagreb', 'Zagreb', 'Jeronima Kavanjina 14', NULL, NULL, 'DA', 'DA', 'DA', 'NE', '2.4.2016.', 90, 'N', 'ljubomir.majdandzic@zg.t-com.hr'),
('F-222/2013', NULL, 'OREČIĆ TIHOMIR', NULL, 'TIHOMAR NEKRETNINE d.o.o.', 'Grad Zagreb', 'Zagreb', 'Aleja Blaža Jurišića 85', '01 2370717', NULL, 'DA', 'NE', 'DA', 'NE', '16.4.2016.', 91, 'N', NULL),
('F-223/2013', 'DA', 'TARNIK KREŠIMIR', NULL, 'Ured ovlaštenog inženjera građevinarstva Tarnik', 'Grad Zagreb', 'Zagreb', 'Višnjica 29', '01 549 5130', '091 736 8785', 'DA', 'NE', 'DA', 'NE', '2.4.2016.', 92, 'N', 'kresimir@tarnik-grad.hr'),
('F-226/2013', NULL, 'CAPEK MARKO', NULL, NULL, 'Varaždinska', 'Varaždin', 'Marka Marulića 9', NULL, '098 / 9770 898', 'DA', 'DA', 'DA', 'NE', '23.4.2016.', 93, 'N', 'marko.capek@gmail.com'),
('F-227/2013', NULL, 'DRMAČ ILJA', NULL, 'UNDP Hrvatska', 'Grad Zagreb', 'Zagreb', 'Ostrogovićeva 12', NULL, NULL, 'DA', 'DA', 'DA', 'NE', '23.4.2016.', 94, 'N', 'ilja.drmac@undp.org'),
('F-228/2013', NULL, 'ČAČIĆ GORAN', NULL, 'UNDP Hrvatska', 'Sisačko-moslavačka', 'Sisak', 'Odranska 8', '01 63 31 881', NULL, 'DA', 'DA', 'DA', 'NE', '16.4.2016.', 95, 'N', 'goran.cacic@undp.org'),
('P-228/2012', 'DA', 'TUDOR ROBERT', NULL, 'STUDIO INFRAS d.o.o.', 'Zagrebačka', 'Ivaničko Graberje', 'Zagrebačka 30', '01 2820 499', '098 601166', 'DA', 'NE', 'DA', 'NE', '17.7.2015.', 96, 'N', 'studio-infras@studio-infras.hr'),
('F-229/2013', NULL, 'IVANIŠEVIĆ BRUNA', NULL, 'Ured ovlaštene arhitektice Ivanišević Bruna', 'Splitsko Dalmatinska', 'Split', 'Pupačićeva 1', '020 358599', '098 9714-964, 091 5680923', 'DA', 'DA', 'DA', 'NE', '22.7.2016.', 97, 'N', 'bruna.ivanisevic@st.t-com.hr'),
('F-231/2013', NULL, 'GOTTWEIN HEINRICH', NULL, 'UPI-2M d.o.o.', 'Grad Zagreb', 'Zagreb', 'Hanamanova 11', '01 3772 089', NULL, 'DA', 'NE', 'DA', 'NE', '24.4.2016.', 98, 'N', 'heinrich_gottwein@upi-2m.hr'),
('F-232/2013', 'DA', 'FILIPOVIĆ DAMIR', NULL, 'Green Energy Expert d.o.o.', 'Primorsko-goranska', 'Rijeka', 'Mate Balote 59', '051 623-053', '095 902 5523', 'DA', 'DA', 'DA', 'DA', '13.5.2016.', 99, 'N', 'damir@gee.hr'),
('F-233/2013', NULL, 'REISZ PATRIK', NULL, 'SIRRAH-PROJEKT d.o.o.', 'Osječko-baranjska', 'Osijek', 'Šetalište Vjekoslava Hengla 2', '031/250-000', NULL, 'DA', 'NE', 'DA', 'NE', '24.4.2016.', 100, 'N', 'patrik@sirrah.hr'),
('F-283/2013', NULL, 'FERJANČIĆ EMIL', NULL, NULL, 'Istarska', 'Vodnjan', 'Galižana, Prividal 19', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '13.9.2016.', 101, 'N', 'emil.ferjancic@pu.t-com.hr'),
('F-285/2013', NULL, 'BAJT DAMIR', NULL, 'S.B.Plinomont d.o.o. ', 'Grad Zagreb', 'Zagreb', 'Sesvete, Obrež 41', '01 2005 318, 01 2009 855, 01 200', '091/ 2209 859', 'DA', 'DA', 'DA', 'NE', '16.9.2016.', 102, 'N', 'damir.bajt@sb-plinomont.hr'),
('F-288/2013', NULL, 'KAPETER DRAŽEN', NULL, 'URED OVLAŠTENOG INŽENJERA GRAĐEVINARSTVA - KAPETER DRAŽEN', 'Osječko-baranjska', 'Osijek', 'Svete Ane 40', '031/506-825', NULL, 'DA', 'NE', 'DA', 'NE', '20.9.2016.', 103, 'N', 'drazen.kapeter@os.t-com.hr'),
('F-289/2013', NULL, 'GLUHAK KREŠIMIR', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Sesvete, Ivana Sandelića 19', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '20.9.2016.', 104, 'N', 'kresimir.gluhak@koncar-dst.hr'),
('F-291/2013', NULL, 'PAVIĆ LJILJANA', NULL, 'Arhitektonski ured', 'Istarska', 'Pula', 'Laginjina 3', NULL, '098/959-7336', 'DA', 'NE', 'DA', 'NE', '20.9.2016.', 105, 'N', 'ljiljana.pavic@pu.t-com.hr'),
('F-293/2013', 'DA', 'VRDOLJAK SNJEŽANA', NULL, 'ZAGREB-PROJEKT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Zemljakova 9', '01 604 0350', '098 417 344', 'DA', 'DA', 'DA', 'DA', '24.9.2016.', 106, 'N', 'snjezana@zagreb-projekt.hr'),
('F-294/2013', NULL, 'PAZMAN DRAGO', NULL, 'PAZMAN GRADNJA d.o.o.', 'Zagrebačka', 'Dugo Selo', 'Kažotićeva 1/4', '01 2753250', NULL, 'DA', 'NE', 'DA', 'NE', '23.9.2016.', 107, 'N', NULL),
('F-297/2013', NULL, 'ŠARIĆ MLADEN', NULL, 'BIZOVAČKE TOPLICE d.d.', 'Osječko-baranjska', 'Osijek', 'Gornjodravska obala 88', '031/685-280', NULL, 'DA', 'DA', 'DA', 'NE', '25.9.2016.', 108, 'N', NULL),
('F-299/2013', NULL, 'IVKOVČIĆ BRANKO', NULL, 'KOLONADA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Maksimirska 107', '01/2310796', NULL, 'DA', 'NE', 'DA', 'NE', '30.9.2016.', 109, 'N', NULL),
('F-300/2013', NULL, 'AHEL JAKOV', NULL, 'AKTIS PROJEKT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Fonova 4', '01/3756-470', NULL, 'DA', 'NE', 'DA', 'NE', '30.9.2016.', 110, 'N', 'jakov.ahel@zg.t-com.hr'),
('F-302/2013', NULL, 'MIŠKOVIĆ NIKOLA', NULL, 'Fakultet elektrotehnike i računarstva', 'Grad Zagreb', 'Zagreb', 'Rendićeva 12', '01 6129-815', NULL, 'DA', 'DA', 'DA', 'NE', '30.9.2016.', 111, 'N', 'nikola.miskovic@fer.hr'),
('F-304/2013', NULL, 'TRIBULJAK HRVOJE', NULL, 'PRESOFLEX GRADNJA d.o.o.', 'Brodsko-posavska', 'Slavonski Brod', 'Slavonija 1 2/2', '034 440 812', '099 44 00 788', 'DA', 'NE', 'DA', 'NE', '30.9.2016.', 112, 'N', 'hrvoje.tribuljak@presoflex-gradnja.hr'),
('F-306/2013', NULL, 'STANKOVIĆ MILVANA', NULL, NULL, 'Istarska', 'Pula', 'Varoš 66', '052 517 233', '098254317', 'DA', 'NE', 'DA', 'NE', '1.10.2016.', 113, 'N', 'milvana.stankovic@gmail.com'),
('F-307/2013', NULL, 'CURMAN BRANIMIR', NULL, 'CURMAN Projekt d.o.o.', 'Grad Zagreb', 'Zagreb', 'Nad Lipom 9', NULL, '098 663 118', 'DA', 'DA', 'DA', 'NE', '30.9.2016.', 114, 'N', 'branimir.curman@gmail.com'),
('F-309/2013', NULL, 'ANDRAŠI ŽELJKO', NULL, 'ARVUMTEH d.o.o.', 'Osječko-baranjska', 'Osijek', 'Dubrovačka ulica 46', '031/200-396', NULL, 'DA', 'NE', 'DA', 'NE', '2.10.2016.', 115, 'N', 'arvumteh@os.t-com.hr'),
('F-310/2013', 'DA', 'FINK IGOR', NULL, 'H5 d.o.o.', 'Grad Zagreb', 'Zagreb', 'Žuti Jarak 1', '01 204 2148', '091 479 4334', 'DA', 'DA', 'DA', 'DA', '1.10.2016.', 116, 'N', 'igor.fink@hpet.hr'),
('F-312/2013', NULL, 'ČAKLOVIĆ PREDRAG', NULL, 'TREZOR-INVEST d.o.o.', 'Grad Zagreb', 'Zagreb', 'Ilica 134', ' 01/4686-300', NULL, 'DA', 'DA', 'DA', 'NE', '30.9.2016.', 117, 'N', 'predrag.caklovic@trezorinvest.hr'),
('F-313/2013', 'DA', 'KOKIĆ MARIJAN', NULL, 'Ured ovlaštenog inženjera elektroteknike Marijan Kokić', 'Grad Zagreb', 'Zagreb', 'Črnomerec 101', '01 3770 947', '091 333 6512', 'DA', 'NE', 'DA', 'NE', '2.10.2016.', 118, 'N', 'marijan.kokic@h-1.hr'),
('F-317/2013', NULL, 'KUREPA MILICA', NULL, 'URED OVLAŠTENOG INŽENJERA GRAĐEVINARSTVA - KUREPA MILICA', 'Osječko-baranjska', 'Osijek', 'Fruškogorska 6C', '031/372-201', NULL, 'DA', 'NE', 'DA', 'NE', '7.10.2016.', 119, 'N', 'milica.kurepa@os.htnet.hr'),
('P-317/2013', 'DA', 'ĐORIĆ-KOSANOVIĆ ALEKSANDRA', NULL, 'RADAL d.o.o.', 'Primorsko-goranska', 'Rijeka', 'Drage Šćitara 5', '051 625 468', '098 559 501', 'DA', 'DA', 'DA', 'DA', '24.7.2016.', 120, 'N', 'radal@ri.t-com.hr'),
('F-319/2013', NULL, 'MRČELA DRAGANA', NULL, 'Fakultet elektrotehnike, strojarstva i brodogradnje - Sveučilište u Splitu', 'Splitsko Dalmatinska', 'Split', 'Terzićeva 11', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '10.10.2016.', 121, 'N', 'Dragana.Mrcela@fesb.hr'),
('F-322/2013', NULL, 'HRGA JURAJ', NULL, 'ENG PROJEKT doo', 'Splitsko Dalmatinska', 'Split', 'Hercegovačka 42', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '22.10.2016.', 122, 'N', 'juraj.hrga@engprojekt.hr'),
('F-323/2013', NULL, 'KRANJEC MARIO', NULL, 'GROMATIC KR d.o.o. ', 'Grad Zagreb', 'Zagreb', 'Domašinečka 4', '049 461 068', NULL, 'DA', 'DA', 'DA', 'NE', '22.10.2016.', 123, 'N', 'mario@gromatic.hr'),
('F-324/2013', NULL, 'ILIĆ DAMIR', NULL, 'DOGMA UPRAVLJANJE d.o.o', 'Istarska', 'Opatija', 'Ičići, Travičići 11', '051/301-554', '091/225-0779', 'DA', 'DA', 'DA', 'NE', '21.10.2016.', 124, 'N', 'info@dogma-upravljanje.com'),
('F-325/2013', NULL, 'ĆURIN ALEN', NULL, 'Riteh d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Terzićeva 7', NULL, '091 440 4064', 'DA', 'NE', 'DA', 'NE', '21.10.2016.', 125, 'N', 'curin@riteh.eu'),
('F-329/2013', NULL, 'BUNARĐIJA ŽELJKO', NULL, 'Dom-ing d.o.o', 'Sisačko-moslavačka', 'Sisak', 'Ferde Livadića 12', '044/573-488', '098/261-525', 'DA', 'NE', 'DA', 'NE', '21.10.2016.', 126, 'N', 'zeljko.bunardjija@sk.t-com.hr'),
('F-330/2013', NULL, 'ŠKOPAC BRUNO', NULL, 'HEP-Proizvodnja d.o.o. - Pogon Plomin', 'Istarska', 'Labin', 'Jadranska 38', '052 872-354', '098-254-972', 'DA', 'NE', 'DA', 'NE', '22.10.2016.', 127, 'N', 'bruno.skopac@hep.hr '),
('F-332/2013', NULL, 'STOŠIĆ SANJIN', NULL, 'TERMOPROJEKT BOTICA d.o.o.', 'Zadarska', 'Zadar', 'Put Kotlara 18 B', '023/322-605', NULL, 'DA', 'NE', 'DA', 'NE', '25.10.2016.', 128, 'N', NULL),
('F-333/2013', NULL, 'MANDRA DAMIR', NULL, 'Ured Mandra', 'Zadarska', 'Zadar', 'Put Murvice 39', NULL, '095 901 5266', 'DA', 'NE', 'DA', 'NE', '28.10.2016.', 129, 'N', 'ured.mandra@gmail.com'),
('F-335/2013', NULL, 'KRIZMANIĆ ZDRAVKO', NULL, 'ZO-INVEST d.o.o.', 'Zagrebačka', 'Sveta Nedelja(Zagrebačka)', 'Strmec Samoborski, Jasena 18', '01/4629-908', NULL, 'DA', 'NE', 'DA', 'NE', '29.10.2016.', 130, 'N', 'zdravko.krizmanic@zoinvest.hr'),
('F-370/2013', 'DA', 'GEDŽIĆ FRANO', NULL, 'GEDŽIĆ GRADNJA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Hrvatski Leskovac, Povrtlarska 18', NULL, '098 9816 220', 'DA', 'DA', 'DA', 'NE', '13.11.2016.', 131, 'N', 'gedzic.gradnja@zg.t-com.hr'),
('F-371/2013', NULL, 'NIGOVIĆ VLADO', NULL, 'NIVELA-SISAK d.o.o.', 'Sisačko-moslavačka', 'Sisak', 'Tina Ujevića 27', '044/534613', NULL, 'DA', 'NE', 'DA', 'NE', '11.11.2016.', 132, 'N', 'nivela@sk.t-com.hr'),
('F-372/2013', NULL, 'ŠIŠIĆ PETAR', NULL, 'VJEŠTAK d.o.o', 'Osječko-baranjska', 'Osijek', 'Zvečevska 21', '031/203434', NULL, 'DA', 'DA', 'DA', 'NE', '23.12.2016.', 133, 'N', 'vjestak@os.hinet.hr'),
('F-373/2013', NULL, 'RUNJE SLAVEN', NULL, NULL, 'Splitsko Dalmatinska', 'Split', 'Stepinčeva 14', '021-455-006', '091-151-1612, 091-2000-893', 'DA', 'NE', 'DA', 'NE', '12.11.2016.', 134, 'N', 'slaven.runje@st.t-com.hr, slaven.runje@gmail.com'),
('F-375/2013', NULL, 'BAUER RENATO', NULL, 'Novigrad inženjering d.o.o.', 'Istarska', 'Novigrad (Istarska)', 'Zagorska 22', '052 726 458', '098 982 6742', 'DA', 'NE', 'DA', 'NE', '15.11.2016.', 135, 'N', NULL),
('F-378/2013', NULL, 'ČARAPAR IVAN', NULL, NULL, 'Sisačko-moslavačka', 'Kutina', 'Vinogradska 64', NULL, '0915400468', 'DA', 'NE', 'DA', 'NE', '15.11.2016.', 136, 'N', NULL),
('F-379/2013', NULL, 'ČESI BOŽICA', NULL, 'ETZ D.D.', 'Osječko-baranjska', 'Osijek', 'Mije Kišpatića 42', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '14.11.2016.', 137, 'N', 'etz@etz.hr'),
('P-379/2013', 'DA', 'VUKOVIĆ IVAN', NULL, 'AGENCERT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Gospodska 32', '01 3462 182', '098 938 1426', 'DA', 'DA', 'DA', 'NE', '7.10.2016.', 138, 'N', 'agencert.doo@gmail.com'),
('F-380/2013', NULL, 'PROFACA MARIJA', NULL, 'KOTA d.o.o.', 'Zadarska', 'Zadar', 'Miroslava Krleže 1G', '023 305282', NULL, 'DA', 'NE', 'DA', 'NE', '18.11.2016.', 139, 'N', NULL),
('P-380/2013', 'DA', 'STIPIĆ ROBERT', NULL, 'HOLDON d.o.o.', 'Zagrebačka', 'Ivanić-Grad', 'Trg Vladimira Nazora 15', '01/2831-483', '091/1788-047', 'DA', 'DA', 'DA', 'DA', '4.10.2016.', 140, 'N', 'rstipic@holdon.hr'),
('F-381/2013', NULL, 'CINDRIĆ MARIJAN', NULL, 'NACRT CINDRIĆ d.o.o.', 'Osječko-baranjska', 'Osijek', 'Cetinska 15', '031 275138', NULL, 'DA', 'NE', 'DA', 'NE', '18.11.2016.', 141, 'N', NULL),
('F-382/2013', NULL, 'FILEŠ SLAVKO', NULL, 'FILRAD D.O.O.', 'Međimurska', 'Nedelišće', 'Macinec, Trnavska 9', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '18.11.2016.', 142, 'N', 'danica.files@ck.t-com.hr'),
('F-383/2013', NULL, 'PERINOVIĆ ROMANO', NULL, 'CALIGA d.o.o.', 'Zadarska', 'Zadar', 'Postrojbi specijalne policije Zadar 8', '023 302714', '098 207908', 'DA', 'NE', 'DA', 'NE', '21.11.2016.', 143, 'N', NULL),
('F-384/2013', NULL, 'KAZIJA ZVONIMIR', NULL, 'URED OVLAŠTENOG INŽENJERA GRAĐEVINARSTVA', 'Zadarska', 'Pakoštane', 'Kneza Trpimira 8', '023 381 083', '091 9736 720', 'DA', 'NE', 'DA', 'NE', '21.11.2016.', 144, 'N', 'info@kazija-projekt.hr'),
('F-386/2013', NULL, 'GLIGO ZLATKO', NULL, 'MENS d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Sedam Kaštela 6', '021 347151', '091/6528-388', 'DA', 'NE', 'DA', 'NE', '22.11.2016.', 145, 'N', 'mens@st.t-com.hr'),
('F-387/2013', NULL, 'GROSEK ZRINKA', NULL, 'URED OVLAŠTENE ARHITEKTICE ZRINKA GROSEK', 'Grad Zagreb', 'Zagreb', 'Oporovečki Majdaki 21', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '21.11.2016.', 146, 'N', 'zrinka.grosek@zg.t-com.hr'),
('F-390/2013', NULL, 'VOJKOVIĆ TEO', NULL, 'Pročelnik gradske uprave Split', 'Splitsko Dalmatinska', 'Vis', 'Podstražje, Bargujac 49', '021/310-332', NULL, 'DA', 'NE', 'DA', 'NE', '26.11.2016.', 147, 'N', 'teo.vojkovic@split.hr'),
('F-391/2013', NULL, 'KUSANOVIĆ TINO', NULL, 'Upravni odjel za komunalno-vodni sustav, zaštitu okoliša i graditeljstvo - Grad Vodice', 'Šibensko Kninska', 'Vodice', 'Put Gaćeleza 2', '022/444-910', NULL, 'DA', 'NE', 'DA', 'NE', '21.11.2016.', 148, 'N', 'tino.kusanovic@grad-vodice.hr'),
('F-392/2013', NULL, 'OŽBOLT GORAN', NULL, 'Stalni sudski vještak građevinske struke Osijek', 'Osječko-baranjska', 'Osijek', 'Šetalište kardinala Franje Šepera 1C', '031/213 262', NULL, 'DA', 'NE', 'DA', 'NE', '25.11.2016.', 149, 'N', 'ozbolt@os.t-com.hr'),
('F-393/2013', NULL, 'OPALA DENIS', NULL, 'Ličko-senjska županija, Upravni odjel za graditeljstvo, zaštitu okoliša i prirode te komunalno gospodarstvo, Odsjek za graditelj', 'Ličko Senjska', 'Senj', 'Sveti Juraj, Sveti Juraj 146A', '053/882-821', '098/882-784', 'DA', 'NE', 'DA', 'NE', '26.11.2016.', 150, 'N', 'denis.opala@gmail.com'),
('F-394/2013', NULL, 'BAŠLJAN MIRKO', NULL, 'Mi-GRAD d.o.o.', 'Grad Zagreb', 'Zagreb', 'Donji Rim 31', '01 2344944', '098 288558', 'DA', 'NE', 'DA', 'NE', '25.11.2016.', 151, 'N', NULL),
('F-395/2013', NULL, 'ROPAC EDDY', NULL, 'IZOLIRTEHNIKA d.o.o', 'Primorsko Goranska', 'Rijeka', 'Bujska 3B', '051/261178', NULL, 'DA', 'NE', 'DA', 'NE', '25.11.2016.', 152, 'N', 'izolirtehnika@ri.tel.hr'),
('F-397/2013', NULL, 'HERCEG GORDAN', NULL, 'HEKOTEH D.O.O.', 'Grad Zagreb', 'Zagreb', 'Mallinova 34', '01 6224468', NULL, 'DA', 'NE', 'DA', 'NE', '27.11.2016.', 153, 'N', NULL),
('F-398/2013', NULL, 'ŽIC IVAN', NULL, 'Studio Žic j.d.o.o.', 'Grad Zagreb', 'Zagreb', 'Heinzlova 47B', '01 4627 002', '091 5665 610', 'DA', 'NE', 'DA', 'NE', '26.11.2016.', 154, 'N', 'studiozic.ivan@gmail.com'),
('F-412/2013', NULL, 'MATIJEVIĆ PETAR', NULL, 'Viši referent za prostorno uređenje Požeško-slavonske županije', 'Požeško-slavonska', 'Velika', 'Trg bana J. Jelačića 5A', '034 290 239', NULL, 'DA', 'NE', 'DA', 'NE', '2.12.2016.', 155, 'N', 'petar.matijevic@pszupanija.hr'),
('F-415/2013', NULL, 'JEROSIMIĆ MIROSLAV', NULL, NULL, 'Karlovačka', 'Karlovac', 'Prilaz Većeslava Holjevca 10', NULL, '091 5288375', 'DA', 'NE', 'DA', 'NE', '2.12.2016.', 156, 'N', NULL),
('F-417/2013', NULL, 'VODJEREK ZLATKO', NULL, 'ELVOD', 'Bjelovarsko-bilogorska', 'Hercegovac', 'Moslavačka 177', '04/524561', '0992586892', 'DA', 'DA', 'DA', 'NE', '5.12.2016.', 157, 'N', 'zlatko.vodjerek@bj.t-com.hr'),
('F-418/2013', NULL, 'LONČAREVIĆ ŽIBRET LEA', NULL, 'FAI d.o.o.', 'Grad Zagreb', 'Zagreb', 'Gredička 12', '01/6040-164', NULL, 'DA', 'NE', 'DA', 'NE', '3.12.2016.', 158, 'N', 'fai@zg.t-com.hr'),
('F-419/2013', NULL, 'MELIĆ DAVOR', NULL, 'ARHITEKA d.o.o.', 'Karlovačka', 'Karlovac', 'Mirka Seljana 30', '047 415710', NULL, 'DA', 'NE', 'DA', 'NE', '4.12.2016.', 159, 'N', 'arhiteka@ka.t-com.hr'),
('F-421/2013', NULL, 'CERINSKI MIROSLAV', NULL, 'GOLSTAK d.o.o.', 'Grad Zagreb', 'Zagreb', 'Lenucijeva 33', '01 2361356', '091 3638353', 'DA', 'NE', 'DA', 'NE', '4.12.2016.', 160, 'N', NULL),
('F-443/2013', NULL, 'POLAK ŽIVKOVIĆ KORALJKA', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Branimirova 65', '01/6009-418', NULL, 'DA', 'NE', 'DA', 'NE', '18.12.2016.', 161, 'N', 'k.polak@zagrebacka-zupanija.hr'),
('F-444/2013', NULL, 'ĐUKA RADIĆ TANJA', NULL, 'LUXOR MULTISERVIS D.O.O.', 'Grad Zagreb', 'Zagreb', 'Pavla Hatza 26', '01/3011-379', '098/411-852', 'DA', 'NE', 'DA', 'NE', '17.12.2016.', 162, 'N', NULL),
('F-448/2013', NULL, 'CRNKOVIĆ SPOMENKA', NULL, 'ATELIER AC d.o.o.', 'Grad Zagreb', 'Zagreb', 'Ratkajev prolaz 10', '01/4620-862', NULL, 'DA', 'NE', 'DA', 'NE', '23.12.2016.', 163, 'N', NULL),
('F-449/2013', NULL, 'BIRNBAUM KREŠIMIR', NULL, 'ADITON d.o.o.', 'Osječko-baranjska', 'Osijek', 'Josipovac, Osječka 171', '031/497-541', NULL, 'DA', 'DA', 'DA', 'NE', '23.12.2016.', 164, 'N', 'kreso.aditon@gmail.com'),
('F-452/2013', NULL, 'MARIĆ DRVOLIČANIN TONĆI', NULL, 'URED OVLAŠTENOG INŽENJERA GRAĐEVINE TONĆI MARIĆ-DRVOLIČANIN', 'Splitsko Dalmatinska', 'Sinj', 'Karakašica 90B', '021 700 201', '099 754 49 88', 'DA', 'NE', 'DA', 'NE', '19.12.2016.', 165, 'N', 'drvolicanin@gmail.com'),
('F-454/2013', NULL, 'BAJIĆ MARINKO', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Trnjanska cesta 48', NULL, '098210988', 'DA', 'NE', 'DA', 'NE', '18.12.2016.', 166, 'N', NULL),
('F-455/2013', NULL, 'IVKOVIĆ SRĐAN', NULL, 'SAECULUM d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Ive Tijardovića 12', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '23.12.2016.', 167, 'N', 'sivkovic@inet.hr'),
('F-465/2013', NULL, 'PALISKA ŽELJKO', NULL, 'EMIS d. o. o.', 'Istarska', 'Labin', 'Prilaz Griža 6', '052 854912', '095 843 40 28', 'DA', 'NE', 'DA', 'NE', '27.12.2016.', 168, 'N', 'zeljko.paliska2@pu.t-com.hr'),
('F-466/2013', NULL, 'GELIĆ LEON', NULL, 'Energetski certifikat - Split', 'Splitsko Dalmatinska', 'Solin', 'Mravnice, 27.rujna 10A', NULL, '098 264 272, 091 9166 440', 'DA', 'NE', 'DA', 'NE', '27.12.2016.', 169, 'N', 'lgv.leon@gmail.com'),
('F-470/2014', 'DA', 'BABIĆ VUJIĆ ZRINKA', NULL, 'Ured ovlaštenog arhitekta Zrinka Babić Vujić', 'Grad Zagreb', 'Zagreb', 'Ulica Grada Mainza 32', '01 3711 716', '098 1795 537', 'DA', 'NE', 'DA', 'NE', '21.1.2017.', 170, 'N', 'zrinka.vujic@gmail.com'),
('F-481/2014', NULL, 'GREBENAR LIDIJA', NULL, 'APG-INŽENJERING d.o.o.', 'Zagrebačka', 'Dugo Selo', 'J. Zorića 62', NULL, '098/476 726', 'DA', 'NE', 'DA', 'NE', '29.1.2017.', 171, 'N', 'apg-inzenjering@zg.t-com.hr'),
('F-482/2014', NULL, 'BOSNIĆ NATALI', NULL, 'ARHITEKTURA ČETIRI d.o.o.', 'Grad Zagreb', 'Zagreb', '13. Podbrežje 13A', '01/3646-721', NULL, 'DA', 'NE', 'DA', 'NE', '29.1.2017.', 172, 'N', 'arhitektura4@gmail.com'),
('F-483/2014', NULL, 'KOVAČEVIĆ ALEKSANDAR', NULL, 'NATURA LUX d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Stepinčeva 39', '021 783 490', '095 44 44 552', 'DA', 'DA', 'DA', 'NE', '31.1.2017.', 173, 'N', 'info@natura-lux.com'),
('P-514/2014', 'DA', 'KORUNDA ZLATKO', NULL, 'KOPGRAD STUDIO d.o.o.', 'Grad Zagreb', 'Zagreb', 'Baštijanova 41/a', '01 779 4440', '098 384 321', 'DA', 'DA', 'DA', 'DA', NULL, 174, 'N', 'zlatko.korunda@kopgradstudio.hr'),
('F-1/2010', 'DA', 'DUBOŠ ŽELJKO', NULL, 'DUBOŠ GRADNJA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Čavoglavska 3', '01/6570-773', '098/136 6972', 'DA', 'DA', 'DA', 'NE', '6.9.2016.', 175, 'N', 'zeljko.dubos@zg.t-com.hr'),
('F-2/2010', 'DA', 'HRDALO IVICA', NULL, 'LIBERTAS KONZALTING d.o.o.', 'Dubrovačko Neretvanska ', 'Dubrovnik', 'Stjepana Cvijića 7A', '020 418 804', '098 344 544', 'DA', 'DA', 'DA', 'DA', '5.12.2016.', 176, 'N', 'vjestak-ing.hrdalo@du.t-com.hr '),
('F-3/2010', 'DA', 'DUBRAVIĆ SENAHID', NULL, 'Tehnograd-ing d.o.o.', 'Grad Zagreb', 'Zagreb', 'Zlatarska 23', '01 3643 785', '098 304 802', 'DA', 'NE', 'DA', 'NE', '22.7.2016.', 177, 'N', 'tehnograd-ing@tehnograd-ing.hr '),
('F-4/2010', 'NE', 'ROBOZ VLADIMIR, mr. sc.', NULL, 'SENEX GRAD d.o.o.', 'Grad Zagreb', 'Zagreb', 'Goljak 42', '01 482 3070', '092 217 2435', 'DA', 'NE', 'DA', 'NE', '18.7.2016.', 178, 'N', 'vladimir.roboz@public.carnet.hr'),
('F-5/2010', 'DA', 'GROZDANIĆ MILIVOJ', NULL, 'VGM d.o.o.', 'Karlovačka', 'Karlovac', 'Maksimilijana Vrhovca 54', '047/422-234', '091/6454-865', 'DA', 'DA', 'DA', 'DA', '30.05.2013.', 179, 'N', 'milivoj.grozdanic@gmail.com'),
('P-6/2010', 'DA', 'GABRIĆ LUKA', NULL, 'DOMINO d.o.o.', 'Osječko-baranjska', 'Osijek', 'Šumska 2', NULL, '091/333 9333', 'DA', 'DA', 'DA', 'DA', '5.7.2016.', 180, 'N', 'luki.gabric@gmail.com'),
('F-7/2010', 'DA', 'JUKIĆ NEZNANOVIĆ TAJANA', NULL, 'Gradska uprava Rijeka', 'Primorsko Goranska', 'Kastav', 'Spinčići 140 ', '051 494 180', '098 9742 458', 'DA', 'NE', 'DA', 'NE', '31.05.2013.', 181, 'N', 'tajana.jukic@ri.t-com.hr'),
('F-8/2010', 'NE', 'MATIJEVIĆ ZRINSKI NIKOLINA', NULL, 'Ured ovlaštenog inženjera građevinarstva Matijević Zrinski Nikolina', 'Primorsko Goranska', 'Rijeka', 'Marohnićeva 18', '051 403 620', '091 507 3971', 'DA', 'DA', 'DA', 'NE', '20.8.2016.', 182, 'N', 'nikolina.zrinski@post.t-com.hr'),
('F-9/2010', 'DA', 'TOMULIĆ ROBERT', NULL, 'POTENS PROJEKT d. o. o.', 'Primorsko Goranska', 'Rijeka', 'Crnčićeva 1', '051 499 797', '095 900 1756', 'DA', 'NE', 'DA', 'NE', '29.7.2016.', 183, 'N', 'rtomulic@gmail.com'),
('F-10/2010', 'NE', 'BEZJAK MLADEN, dr. sc.', NULL, 'INSTITUT IGH d.d.', 'Grad Zagreb', 'Zagreb', 'Petrinjska 45', '01 6125454', '098 9844087', 'DA', 'DA', 'NE', 'NE', '6.5.2014.', 184, 'N', 'mladen.bezjak@igh.hr'),
('F-11/2010', 'DA', 'JURKOVIĆ TOMO', NULL, 'GPN "KATARINA"', 'Ličko Senjska', 'Gospić', 'Zagrebačka 16', '053 572 067', '098 245 981', 'DA', 'NE', 'DA', 'NE', '6.8.2016.', 185, 'N', 'katarina@gs.htnet.hr'),
('P-11/2010', 'DA', 'ŽUPAN ŽELJKO', NULL, 'ŽUPAN PROJEKT d.o.o.', 'Zagrebačka', 'Jakovlje', 'Zagorska 15A', '01/3351-031', '091/5091-117', 'DA', 'NE', 'DA', 'NE', '23.7.2016.', 186, 'N', 'zupan.zeljko@gmail.com'),
('F-12/2010', NULL, 'SLUNJSKI DRAŽEN', NULL, NULL, 'Osječko-baranjska', 'Osijek', 'Zvečevska 20', NULL, '098/476-283', 'DA', 'DA', 'DA', 'NE', '5.7.2016.', 187, 'N', 'drazen.slunjski@osijek.hr'),
('P-13/2010', 'DA', 'VUKOVIĆ VARGA NEVENKA', NULL, 'PRINCOM d.o.o.', 'Međimurska', 'Čakovec', 'M. Krleže 44', '040/364-744', '091/2047-771', 'DA', 'NE', 'DA', 'NE', '28.5.2015.', 188, 'N', 'nena.varga@vip.hr'),
('F-14/2010', 'Čl', 'DODIK IVAN', NULL, NULL, 'Zagrebačka', 'Zaprešić', 'Prigorska 18', '01/2381-381', NULL, 'DA', 'NE', 'DA', 'NE', '13.7.2016.', 189, 'N', 'ivan.dodik@ina.hr'),
('P-14/2010', 'DA', 'JAHODA ARSEN', NULL, 'MUHLOS d.o.o. ', 'Splitsko Dalmatinska', 'Split', 'Zrinsko-Frankopanska 62', '021/380-716', '098/341-362', 'DA', 'NE', 'DA', 'NE', NULL, 190, 'N', 'arsen.jahoda@st.htnet.hr'),
('F-15/2010', 'DA', 'KUHARIĆ ZVONIMIR', NULL, 'DC-8 d.o.o.', 'Grad Zagreb', 'Zagreb', 'Jadranska 24', '01/3775-667', '091/377 5667', 'DA', 'DA', 'DA', 'NE', '16.11.2013.', 191, 'N', 'info@dc8.hr'),
('F-16/2010', NULL, 'ŠTEFANAC IVAN', NULL, 'PROJEKTANT d.o.o.', 'Osječko-baranjska', 'Osijek', 'Ulica Hrvatske Republike 24', '031/225-246', NULL, 'DA', 'NE', 'DA', 'NE', '23.7.2016.', 192, 'N', 'ivan.stefanac@zuios.hr '),
('F-17/2010', NULL, 'BENAZIĆ ARMANDO', NULL, 'V. T. M. d. o. o.', 'Istarska', 'Poreč', 'Rapska 6', '052/427147', '091/219 5651', 'DA', 'DA', 'DA', 'NE', '26.7.2016.', 193, 'N', 'benazic@vtm.hr'),
('P-17/2010', 'DA', 'GEČEK DARKO', NULL, 'VIVAK d.o.o.', 'Varaždinska', 'Ivanec', 'Kaniža 41', '042/782-066', '091/5633-574', 'DA', 'NE', 'DA', 'NE', '2.9.2016.', 194, 'N', 'darko.gecek@vz.t-com.hr'),
('F-18/2010', 'DA', 'PARENTA GORAN', NULL, 'GRAFING-A d.o.o.', 'Grad Zagreb', 'Zagreb', 'Lomnička 5', '01 6190 708', '098 221 296', 'DA', 'NE', 'DA', 'NE', '2.9.2016.', 195, 'N', 'info@grafin-a.hr'),
('F-19/2010', NULL, 'BERTON TATJANA', NULL, 'URED OVLAŠTENE ARHITEKTICE TATJANA BERTON', 'Istarska', 'Pazin', 'Katun Trviški 71', '052/624-841', NULL, 'DA', 'NE', 'DA', 'NE', '20.7.2016.', 196, 'N', 'arhitekt-tatjana.berton@pu.t-com.hr'),
('P-35/2010', 'DA', 'VUKADINOVIĆ VINKO', NULL, 'ZAVOD ZA INTEGRALNU KONTROLU d.o.o.', 'Grad Zagreb', 'Zagreb', 'Maksimirska 57a', '01/2329-636', '091/5369-039', 'DA', 'DA', 'DA', 'DA', '6.5.2014.', 197, 'N', 'vinko.vukadinovic@pregled-dizala.hr'),
('P-36/2010', 'DA', 'PIVAC PETER', NULL, 'PIVAC GRADNJA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Kaptolska 46', '01/3648-544', '091/3648-544', 'DA', 'NE', 'DA', 'DA', '25.7.2016.', 198, 'N', 'pivac-gradnja@zg.t-com.hr'),
('F-37/2010', 'DA', 'BOTUŠIĆ BREBRIĆ JASNA', NULL, 'Elektroprojekt d.d. ', 'Grad Zagreb', 'Zagreb', 'Prilaz Gjure Deželića 74', '01 6307 904', '098 9625 780', 'DA', 'NE', 'DA', 'NE', '16.9.2016.', 199, 'N', 'jasna.brebic@elektroprojekt.hr'),
('F-39/2010', NULL, 'POLJIČANIN IVAN', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Bukovačka 155A', '01 24 45 268', NULL, 'NE', 'NE', 'NE', 'DA', '27.2.2014.', 200, 'N', NULL),
('F-40/2010', 'DA', 'FRANIĆ MARIO', NULL, 'Ured ovlaštenog inženjera građevinarstva Franić Mario', 'Primorsko Goranska', 'Rijeka', 'Medovićeva 29', '051 837 037', '091 7938 016', 'DA', 'DA', 'NE', 'NE', '27.11.2016.', 201, 'N', 'mario.franic@epiec.hr'),
('F-41/2010', 'DA', 'STIPETIĆ BORIS', NULL, 'B.net Hrvatska d.o.o.', 'Grad Zagreb', 'Zagreb', 'Avenija Dubrovnik 16', '01/7778-111', '091/6566-160', 'DA', 'NE', 'DA', 'NE', NULL, 202, 'N', 'stipetic.boris@gmail.com'),
('P-50/2010', 'DA', 'HORVAT FERENCZ', NULL, 'METROALFA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Karlovačka cesta 4L', '01/5555-740', '091/4488-903', 'DA', 'DA', 'DA', 'DA', '21.10.2016.', 203, 'N', 'metroalfa@metroalfa.hr'),
('F-51/2010', NULL, 'ČULINA MARKO', NULL, 'URED OVLAŠTENOG ARHITEKTE MARKO ČULINA', 'Zadarska', 'Zadar', 'M. Klaića 4', NULL, '095 810 5283', 'DA', 'NE', 'DA', 'NE', '20.9.2016.', 204, 'N', 'marko@markoculina.com'),
('F-52/2010', 'DA', 'SEKE LIDIJA', NULL, 'Ured ovlaštene arhitektice Lidija Seke', 'Grad Zagreb', 'Zagreb', 'Vrbanićeva 18', '01 4649 500', '091 5143 657', 'NE', 'NE', 'DA', 'DA', '26.7.2016.', 205, 'N', 'lidijas35@gmail.com'),
('F-53/2010', NULL, 'STOPIĆ FRANJO', NULL, 'URED OVLAŠTENOG INŽENJERA STROJARSTVA STOPIĆ FRANJO', 'Zagrebačka', 'Dugo Selo', 'Marina Držića 15', NULL, NULL, 'DA', 'DA', 'NE', 'NE', '2.4.2016.', 206, 'N', 'franjo.stopic@zg.t-com.hr'),
('P-60/2010', 'DA', 'OREŠKOVIĆ DAMIR', NULL, 'EXSTO PROJEKT d.o.o.', 'Osječko-baranjska', 'Našice', 'Petra Preradovića 3', '031 611 396', '091 338 0600', 'DA', 'NE', 'DA', 'NE', '21.10.2016.', 207, 'N', 'exsto1@inet.hr'),
('F-61/2010', 'DA', 'MARIĆ MARIJA', NULL, 'Z PROFIL d.o.o.', 'Grad Zagreb', 'Zagreb', 'Potočani 11 ', '01/4637-681', '098/481-191', 'DA', 'NE', 'DA', 'NE', '28. 10. 2013.', 208, 'N', 'marko.maric10@zg.t-com.hr'),
('F-62/2010', 'Čl', 'HLADKI DUBRAVKO', NULL, 'Elektroprojekt d.d.', 'Grad Zagreb', 'Zagreb', 'Sesvete, Bjelovarska 26', '01/6307-729', NULL, 'DA', 'DA', 'DA', 'NE', '19.9.2016.', 209, 'N', 'dubravko.hladki@elektroprojekt.hr'),
('F-63/2010', 'Čl', 'PETROVIĆ NENAD', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Mihanovićeva 16', '01/ 6307-777', NULL, 'DA', 'DA', 'DA', 'NE', '20.9.2016.', 210, 'N', 'nenad.petrovic@elektroprojekt.hr'),
('F-64/2010', 'Čl', 'CRNKOVIĆ MISLAV', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Jahorinska 41', '01/ 6307-777', NULL, 'DA', 'DA', 'DA', 'NE', '20.9.2016.', 211, 'N', 'mislav.crnkovic@elektroprojekt.hr'),
('P-64/2010', 'DA', 'HRASTOVIĆ DARIO', NULL, 'HRASTOVIĆ INŽENJERING d.o.o.', 'Osječko-baranjska', 'Đakovo', 'Ulica Petra Svačića 37', NULL, '098-221-6503', 'DA', 'DA', 'DA', 'DA', '15.11.2016.', 212, 'N', 'dario.hrastovic@gmail.com'),
('F-76/2010', NULL, 'PAŽIN MILA', NULL, 'URED OVLAŠTENOG INŽENJERA GRAĐEVINE Mila Pažin', 'Splitsko Dalmatinska', 'Split', 'Obrov 10', '021486603', '098347279', 'DA', 'DA', 'DA', 'NE', '9.10.2016.', 213, 'N', 'mila.pazin.ured@st.t-com.hr'),
('P-76/2010', 'DA', 'STOJKOVIĆ ROBERT', NULL, 'SPECULUM d.o.o.', 'Grad Zagreb', 'Zagreb', 'Bartolići 49', NULL, '091/4566-899', 'DA', 'DA', 'DA', 'DA', NULL, 214, 'N', 'robert@speculum.hr'),
('P-76/2010', 'DA', 'BEVANDA JOZO', NULL, 'SPECULUM d.o.o.', 'Grad Zagreb', 'Zagreb', 'Bartolići 49', '01/3692-486', '091/7223-035', 'DA', 'DA', 'DA', 'DA', NULL, 215, 'N', 'jozo.bevanda@speculum.hr'),
('F-77/2010', NULL, 'ŠABANOVIĆ SVETLANA', NULL, 'ULJANIK IRI d.d.', 'Istarska', 'Vodnjan', 'Majmajola 56', '052 373 636', NULL, 'DA', 'NE', 'DA', 'NE', '23.12.2016.', 216, 'N', 'svetlana.sabanovic@uljanik.hr'),
('P-83/2010', 'DA', 'KURETIĆ HRVOJE', NULL, 'DOMUS PLUS d.o.o.', 'Grad Zagreb', 'Zagreb', 'Ribnjak 12', '01/2365-549', '091/5904-115', 'DA', 'DA', 'DA', 'DA', '31.03.2014.', 217, 'N', 'hrvoje.kuretic1@domusplus.hr'),
('F-86/2010', NULL, 'JOVANOVIĆ STORIĆ ANDREA', NULL, 'ARHETIP d.o.o.', 'Primorsko Goranska', 'Rijeka', 'M. Albaharija 7', '051 345 014', '091 200 8419', 'DA', 'NE', 'DA', 'NE', '18.12.2016.', 218, 'N', 'arhetipdoo@gmail.com'),
('F-87/2010', NULL, 'NIKOLIĆ ŽELJANA', NULL, 'FAKULTET GRAĐEVINARSTVA, ARHITEKTURE I GEODEZIJE, SVEUČILIŠTE U SPLITU', 'Splitsko Dalmatinska', 'Split', 'Getaldićeva 14', '021/303-332', NULL, 'DA', 'DA', 'DA', 'NE', '30.12.2016.', 219, 'N', 'zeljana.nikolic@gradst.hr'),
('P-89/2010', 'DA', 'IVŠIĆ VLASTA', NULL, 'GEOARH d.o.o.', 'Vukovarsko Srijemska', 'Vinkovci', 'Ulica Hrvatskih žrtava 19', '032 332 678', '098 494 613', 'DA', 'DA', 'DA', 'DA', '10.12.2016.', 220, 'N', 'vlasta.ivsic@geoarh.hr'),
('F-90/2010', NULL, 'RELJIĆ PAVLE', NULL, 'Ured ovlaštenog inženjera građevinarstva Pavle Reljić', 'Zadarska', 'Zadar', 'Benka Benkovića 22', NULL, '091 570 0635', 'DA', 'DA', 'DA', 'NE', '9.1.2016.', 221, 'N', NULL),
('P-97/2010', 'DA', 'TROPČIĆ ZEKAN GORANKA', NULL, 'KLIMAPROING d.o.o.', 'Grad Zagreb', 'Zagreb', 'Zelengaj 45/1 B', '01/4579-220', '098/359-172', 'DA', 'DA', 'DA', 'DA', '14.1.2017.', 222, 'N', 'tropcic.g@klimaproing.hr'),
('F-101/2011', NULL, 'KRAŠ MIROSLAV', NULL, 'CGC d.o.o.', 'Varaždinska', 'Varaždin', 'Krste Hegedušića 13', '042 320560', '098 390747', 'DA', 'NE', 'DA', 'NE', '24.3.2014.', 223, 'N', NULL),
('F-102/2011', NULL, 'KOTNIK LJUDEVIT', NULL, 'ENERGETSKI OPUS d.o.o.', 'Grad Zagreb', 'Zagreb', 'Površnica 1B', '01 2955112', '099/2120040', 'DA', 'DA', 'DA', 'NE', '23.3.2014.', 224, 'N', 'ljkotnik@gmail.com'),
('F-103/2011', 'DA', 'KAIĆ BOGUNOVIĆ SANJA', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Ksaver 61', '01 4677 559', '091 4677 559', 'DA', 'DA', 'NE', 'NE', '30.12.2016.', 225, 'N', 's.kaic.22@gmail.com'),
('F-104/2011', 'DA', 'BARANIĆ MARTINA', NULL, NULL, 'Šibensko Kninska', 'Šibenik', '8. dalmatinske udarne brigade 8', '022 3338 952', '099 3338 952', 'DA', 'DA', 'DA', 'DA', '27.3.2014.', 226, 'N', 'martina.baranic@net.hr');
INSERT INTO `member_tmp` (`reg_broj`, `huec`, `naziv`, `oib`, `poslodavac`, `zupanija`, `grad`, `adresa`, `tel`, `mob`, `modul_1`, `modul_2`, `modul_3`, `modul_4`, `ovalstenje`, `id`, `registered`, `email`) VALUES
('F-105/2011', NULL, 'BARIŠIĆ-MARIĆ PETAR', NULL, 'Obrt za popravak i instalaciju plina PLINING', 'Splitsko Dalmatinska', 'Makarska', 'Akčićev prolaz S2/3', '021 610-419', '099 2191-200', 'DA', 'DA', 'DA', 'NE', '24.3.2014.', 227, 'N', NULL),
('F-107/2011', NULL, 'HEBRANG ALEN', NULL, 'IPZ d.d.', 'Grad Zagreb', 'Zagreb', 'Palinovečka 19M', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '24.3.2014.', 228, 'N', 'alen.hebrang@ipz.hr'),
('F-111/2011', 'Čl', 'ČARAPOVIĆ LUKA', NULL, 'Ured ovlaštenog inženjera strojarstva ČARAPOVIĆ LUKA', 'Brodsko-posavska', 'Garčin', 'Trnjani, Zadubravlje, Slavonska 140', '01/7775-572 ', '098 263-399, 099 2633-999', 'DA', 'DA', 'DA', 'NE', '24.3.2014.', 229, 'N', 'luka.carapovic@hkis.hr'),
('P-111/2011', 'DA', 'VUKMIROVIĆ TAMARA', NULL, 'IVAARCH d.o.o.', 'Grad Zagreb', 'Zagreb', 'Zelenjak 54', '01 2421 296', '099 4817 646', 'DA', 'NE', 'DA', 'NE', '25.3.2014.', 230, 'N', 'ivaarch@gmail.com'),
('F-113/2011', 'DA', 'ŠČAPEC STJEPAN', NULL, 'PLIN KONJŠČINA d.o.o.', 'Krapinsko-zagorska', 'Zlatar', 'Martinečka 48', '049 465 592', '098 531 419', 'DA', 'DA', 'NE', 'NE', '9.5.2014.', 231, 'N', 'stjepan.scapec@kr.t-com.hr'),
('P-113/2011', 'DA', 'VRDOLJAK GORAN', NULL, 'TEB kompleksni sustavi i rješenja d.o.o.', 'Grad Zagreb', 'Zagreb', 'Vončinina 2', '01 4609 888', '098 212 534', 'DA', 'DA', 'DA', 'DA', '23.3.2014.', 232, 'N', 'goran.vrdoljak@teb-css.hr'),
('F-117/2011', NULL, 'ZORETIĆ VLASTA', NULL, 'FLANATES GRUPA d.o.o.', 'Istarska', 'Labin', 'Rabac, Raška 15', NULL, '098/421-324', 'DA', 'NE', 'DA', 'NE', '10.5.2014.', 233, 'N', 'flanates-grupa@pu.t-com.hr'),
('F-118/2011', NULL, 'MATTICCHIO LUKA', NULL, 'AD arhitektura i dizajn d.o.o. Pula', 'Istarska', 'Pula', 'Karlovačka 23', '052 381 081', '098 701 898', 'DA', 'NE', 'DA', 'NE', '11.5.2014.', 234, 'N', 'ad@pu.t-com.hr, info@energetski-certifikat.info'),
('F-119/2011', NULL, 'HLUCHÝ VLADIMIR', NULL, 'HEPTA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Milke Trnine 3', '01/6143-678', '098 238377', 'DA', 'NE', 'DA', 'NE', '9.5.2014.', 235, 'N', 'hepta@zg.t-com.hr'),
('F-121/2011', 'DA', 'ALJINOVIĆ GOJAK TONKA', NULL, 'Ured ovlaštenog inž.građ. Tonka Aljinović Gojak', 'Splitsko Dalmatinska', 'Makarska', 'Veliko Brdo, Prodani br. 4', '021 697 518', '091 2014 688', 'DA', 'NE', 'DA', 'NE', '11.5.2014.', 236, 'N', 'tonka.aljinovic@st.t-com.hr'),
('F-125/2011', NULL, 'PIETRI ROK', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Gustava Krkleca 14', NULL, '0914454544', 'DA', 'NE', 'DA', 'NE', '4.5.2014.', 237, 'N', 'rok.pietri@liftmodus.hr'),
('F-126/2011', NULL, 'NOVAK VESNA', NULL, 'URED OVLAŠTENE ARHITEKTICE VESNA NOVAK', 'Vukovarsko Srijemska', 'Vinkovci', 'Ulica Ljudevita Gaja 17A', '032 / 332880', NULL, 'DA', 'NE', 'DA', 'NE', '7.7.2014.', 238, 'N', NULL),
('F-127/2011', 'DA', 'MILIDRAG IVAN', NULL, 'EURCO d.d. ', 'Vukovarsko Srijemska', 'Vinkovci', 'A. Starčevića 4', '032 336 100', '099 3360 103', 'DA', 'NE', 'DA', 'NE', '28.7.2014.', 239, 'N', 'ivan@eurco.hr'),
('F-129/2011', 'DA', 'PERANIĆ JOGUNICA ISKRA', NULL, 'KEA d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Marmontova 14', '021 212 800', '098 397 100', 'DA', 'DA', 'NE', 'NE', '28.7.2014.', 240, 'N', NULL),
('F-130/2011', 'Čl', 'SKORUPSKI IVAN', NULL, 'Velteh d.o.o.', 'Grad Zagreb', 'Zagreb', 'Fra Andrije Kačića Miošića 16', '01/6547-376', '098/522-998', 'DA', 'NE', 'DA', 'NE', '21.6.2014.', 241, 'N', 'ivan.skorupski@velteh.hr'),
('F-131/2011', NULL, 'KUĆAS IVAN', NULL, '2 VI INŽENJERING', 'Zagrebačka', 'Jastrebarsko', 'Dr. Franje Tuđmana 2', '01 627 2749', NULL, 'DA', 'DA', 'DA', 'NE', '25.3.2016.', 242, 'N', NULL),
('F-132/2011', 'DA', 'KNEGO DALIBOR', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Dobri dol 50', NULL, '091 5398 950', 'DA', 'DA', 'DA', 'NE', '19.7.2014.', 243, 'N', 'dalibor.knego@gmail.com'),
('P-133/2011', 'DA', 'BUDIJA NEVEN', NULL, 'URED TRI T d.o.o.', 'Grad Zagreb', 'Zagreb', 'Šetalište 150. brigade 8', '01/3864-033', '099/2008-011', 'DA', 'DA', 'DA', 'DA', '4.5.2014.', 244, 'N', 'neven.budija@u3t.hr'),
('F-134/2011', NULL, 'GAGULA DRAŽAN', NULL, 'INSTITUT IGH d.d.', 'Grad Zagreb', 'Zagreb', 'Lučko, Ježdovec, Mikulini 15', '01/6125-648', NULL, 'DA', 'NE', 'DA', 'NE', '22.9.2014.', 245, 'N', 'drazan.gagula@igh.hr'),
('F-136/2011', NULL, 'SENIČIĆ JOSIP', NULL, 'Total Milenium d.o.o.', 'Zagrebačka', 'Jakovlje', 'Jakovljanska 24', '01 335118', '091 5134196', 'DA', 'DA', 'DA', 'NE', '1.8.2014.', 246, 'N', 'josip.senicic@zg.t-com.hr, info@energetskicertifikati.com.hr'),
('F-137/2011', 'DA', 'VULAS DANIELA', NULL, NULL, 'Splitsko Dalmatinska', 'Split', 'Šetalište bačvice 8', NULL, '098 677 661', 'DA', 'NE', 'DA', 'NE', '2.8.2014.', 247, 'N', 'daniela.vulas@gmail.com'),
('F-138/2011', NULL, 'JAKOVLJEVIĆ VALENTIN', NULL, 'VALSIL d.o.o.', 'Sisačko-moslavačka', 'Kutina', 'Dubrovačka 2', '044 68 26 61, 044 67 94 15', '091 25 15 363, 098 63 14 32', 'DA', 'NE', 'DA', 'NE', '2.8.2014.', 248, 'N', 'valentin@valsil.hr'),
('F-140/2011', NULL, 'RADIĆ ŽELJKO', NULL, 'CERES d.o.o.', 'Šibensko Kninska', 'Šibenik', 'Šibenskih vatrogasaca 18', '022 212363', NULL, 'DA', 'NE', 'DA', 'NE', '1.8.2014.', 249, 'N', NULL),
('F-141/2011', NULL, 'BOŠKOVIĆ MARIJA', NULL, 'TAG D.O.O.', 'Splitsko Dalmatinska', 'Split', 'Marasovića 6', '021/399-012', NULL, 'DA', 'NE', 'DA', 'NE', '5.10.2014.', 250, 'N', 'tag@st.htnet.hr'),
('P-141/2011', 'DA', 'MARIĆ ŽELJKO', NULL, 'EURCO d.o.o.', 'Vukovarsko Srijemska', 'Vinkovci', NULL, '032/336-100', '099/3360-104', 'DA', 'NE', 'DA', 'NE', NULL, 251, 'N', 'zeljko.maric@eurco.hr'),
('P-141/2011', 'DA', 'MILIDRAG IVAN', NULL, 'EURCO d.o.o.', 'Vukovarsko Srijemska', 'Vinkovci', NULL, '032/336-100', '099/3360-103', 'DA', 'NE', 'DA', 'NE', NULL, 252, 'N', 'ivan@eurco.hr'),
('F-142/2011', NULL, 'STRNIŠČAK TOMISLAV, mr. sc.', NULL, NULL, 'Zagrebačka', 'Šenkovec', 'Gorčica 10', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '5.10.2014.', 253, 'N', 'tomislav.strniscak@ck.t-comhr '),
('F-143/2011', NULL, 'MIKIČIĆ ANDRIJA', NULL, 'EXPERT d.o.o.', 'Osječko-baranjska', 'Donji Miholjac', 'Ivana Gorana Kovačića 8', '031 615077', '098 502521', 'DA', 'NE', 'DA', 'NE', '5.10.2014.', 254, 'N', 'andrija@expert-doo.hr'),
('F-144/2011', NULL, 'HULJAK KREŠIMIR', NULL, NULL, 'Krapinsko-zagorska', 'Mače', 'Mače 29E', NULL, '091 1607225', 'DA', 'DA', 'DA', 'NE', '17.10.2014.', 255, 'N', 'kresimir.huljak@kr.t-com.hr '),
('P-144/2011', 'DA', 'REICH SANJA', NULL, ' ITVZ PROJEKT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Brozova 6a', '01/3688-580', '099/2312-383', 'DA', 'DA', 'DA', 'DA', '20.06.2014.', 256, 'N', 'sanja.reich@itvz.hr'),
('F-146/2011', NULL, 'ZLATOPER HRVOJE DUJO', NULL, 'Lučka uprava Šibenik', 'Šibensko Kninska', 'Šibenik', 'Kralja Zvonimira 132', '022 218 001', NULL, 'DA', 'NE', 'DA', 'NE', '17.10.2014.', 257, 'N', 'hrvoje.zlatoper@portauthority-sibenik.hr'),
('P-146/2011', 'DA', 'ŠURLIN MARKO', NULL, 'ING ATEST d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Hrvatske mornarice 1a', '021/340-140', '098/328-497', 'DA', 'DA', 'DA', 'DA', '22.11.2014.', 258, 'N', 'm.surlin@ingatest.hr'),
('F-147/2011', NULL, 'ŠTEVANJA MATE', NULL, 'Tectra d.o.o.', 'Grad Zagreb', 'Zagreb', 'Lončareva 1', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '25.11.2014.', 259, 'N', 'service@tectra.hr'),
('F-148/2011', NULL, 'POPOVIĆ IVO', NULL, 'Ured ovlaštenog arhitekta Popović Ivo', 'Primorsko Goranska', 'Rijeka', 'Fužinska 40', '051 541 503', NULL, 'DA', 'NE', 'DA', 'NE', '16.11.2014.', 260, 'N', NULL),
('F-149/2011', NULL, 'BAKIĆ JAKOV', NULL, 'URED OVLAŠTENOG INŽENJERA STROJARSTVA Jakov Bakić', 'Zadarska', 'Zadar', 'Put Murata 22C', '023/ 230-841', '091/ 253 26 18', 'DA', 'NE', 'DA', 'NE', '16.11.2014.', 261, 'N', 'jakov.bakic@zd.t-com.hr '),
('F-150/2011', NULL, 'GULIĆ VLADIMIR', NULL, 'CAD PROJEKT d.o.o.', 'Istarska', 'Poreč', 'Mate Balota 6', NULL, '0914348449', 'DA', 'NE', 'DA', 'NE', '18.11.2014.', 262, 'N', 'vladimir.gulic@pu.t-com.hr'),
('F-151/2011', NULL, 'SHIHABI KAMEL', NULL, 'DIZAIN-ING d.o.o.', 'Šibensko Kninska', 'Drniš', 'Zagrebačka 18', '022/887-132', '098/266-786', 'DA', 'NE', 'DA', 'NE', '8.12.2014.', 263, 'N', 'dizain-ing@si.htnet.hr'),
('F-152/2011', NULL, 'NIKŠIĆ BOŽIDAR', NULL, 'EUROKON d.o.o.', 'Ličko Senjska', 'Otočac', 'Ličko Lešće, Sinac 188A', '053/ 771 378', '091/ 530 73 02', 'DA', 'NE', 'DA', 'NE', '28.12.2014.', 264, 'N', 'eurokon@eurokon.net'),
('F-153/2011', NULL, 'ROŽMAN BRČIĆ ANDRIJANA', NULL, 'Ured ovlaštenog inženjera građenivarstva Rožman Brčić Andrijana', 'Primorsko Goranska', 'Lovran', 'Cesta 43. istarske divizije 1/4', '051 276 201, 051 587 886', NULL, 'DA', 'NE', 'DA', 'NE', '28.12.2014.', 265, 'N', NULL),
('F-154/2011', NULL, 'RIBIĆ GORAN', NULL, 'Tesla d.o.o.', 'Varaždinska', 'Klenovnik', 'Horvatsko 18', '042 488 070', '098 162 79 34', 'DA', 'NE', 'DA', 'NE', '28.12.2014.', 266, 'N', 'info@tesla.com.hr'),
('F-156/2011', NULL, 'RAŠIĆ IVAN', NULL, 'MIG d.o.o.', 'Brodsko-posavska', 'Klakar', 'Ruščica, Ruščičkih žrtava 41', '035/443-521', NULL, 'DA', 'NE', 'DA', 'NE', '28.12.2014.', 267, 'N', 'mig1@sb.t-com.hr'),
('P-156/2011', 'DA', 'DOVIĆ DAMIR', NULL, 'FAKULTET STROJARSTVA I BRODOGRADNJE SVEUČILIŠTA U ZAGREBU', 'Grad Zagreb', 'Zagreb', 'Ivana Lučića 5', '01/6168-174', '091/6168-174', 'DA', 'DA', 'DA', 'DA', '02.08.2014.', 268, 'N', 'ddovic@fsb.hr'),
('F-157/2011', NULL, 'ČEPO JURE', NULL, 'M-profil d.o.o.', 'Grad Zagreb', 'Zagreb', 'Vlahe Stulića 18', NULL, '099/2199923', 'DA', 'DA', 'DA', 'NE', '8.2.2015.', 269, 'N', 'jure.cepo@gmail.com '),
('P-175/2011', 'DA', 'ARTUKOVIĆ JANKO', NULL, 'H5 d.o.o.', 'Grad Zagreb', 'Zagreb', 'A. Šenoe 65a', '01 204 2148', '091 3794 333', 'DA', 'DA', 'DA', 'DA', '12.7.2016.', 270, 'N', 'janko.artukovic@hpet.hr'),
('F-158/2012', 'DA', 'KUDIĆ EDIN', NULL, 'KUDIĆ PROJEKT d.o.o.', 'Istarska', 'Pula', 'Velog Jože 6', NULL, '091 1425 451', 'DA', 'NE', 'DA', 'NE', '14.3.2015.', 271, 'N', 'kudic_projekt@hotmail.com'),
('F-159/2012', NULL, 'SMOKOVIĆ MATOŠEVIĆ SANDRA', NULL, NULL, 'Istarska', 'Poreč', 'Gregovo III/6', '052 422-616', '098-982-57-94', 'DA', 'DA', 'DA', 'NE', '26.3.2015.', 272, 'N', NULL),
('F-160/2012', NULL, 'PETROVIĆ ŽELJKO', NULL, 'FEBUS d.o.o.', 'Bjelovarsko-bilogorska', 'Daruvar', 'Radićeva 17', '043 333740', NULL, 'DA', 'NE', 'DA', 'NE', '27.3.2015.', 273, 'N', NULL),
('F-161/2012', NULL, 'BUBNIČ VALTER', NULL, NULL, 'Istarska', 'Umag', 'Zemljoradnička 21', '052 743 609', '098 874 560', 'DA', 'NE', 'DA', 'NE', '6.3.2015.', 274, 'N', NULL),
('F-234/2013', NULL, 'KRANJČEC DINO', NULL, 'Prigorka Stanogradnja', 'Grad Zagreb', 'Zagreb', 'Sesvete, Dobrodolski odvojak 12', NULL, '091/ 514 4617', 'DA', 'NE', 'DA', 'NE', '24.4.2016.', 275, 'N', 'dinokranjcec@yahoo.com'),
('F-235/2013', NULL, 'JURICA DOMAGOJ', NULL, 'J&J DOM PROJEKT d.o.o.', 'Zagrebačka', 'Dugo Selo', 'Marije Jurić Zagorke 49', '01 278 0071', '091 275 1046', 'DA', 'NE', 'DA', 'NE', '8.4.2016.', 276, 'N', 'domagoj.jurica@zg.t-com.hr'),
('F-236/2013', NULL, 'BOROJEVIĆ DUŠKO', NULL, 'URED OVLAŠTENOG INŽENJERA STROJARSTVA DUŠKO BOROJEVIĆ', 'Koprivničko-križevačka', 'Koprivnica', 'Đure Basaričeka 6', '048 624 626', '091 224 8863', 'DA', 'DA', 'DA', 'NE', '13.5.2016.', 277, 'N', 'dusko.borojevic@kc.t-com.hr'),
('F-237/2013', NULL, 'UTJEŠINOVIĆ MILE', NULL, 'ISTROPA d. o. o.', 'Istarska', 'Fažana', 'Braće Ilić 52', '052 521 969', '091 56 76 315', 'DA', 'NE', 'DA', 'NE', '11.7.2016.', 278, 'N', 'mile.utjesinovic@pu.htnet.hr'),
('P-237/2012', 'DA', 'HRS BORKOVIĆ ŽELJKA', NULL, 'PLANETARIS d.o.o.', 'Grad Zagreb', 'Zagreb', 'Vlaška 58', '01/4550-440', '098/302-785', 'DA', 'DA', 'DA', 'DA', NULL, 279, 'N', 'zeljka.hrs.borkovic@planetaris.com'),
('F-239/2013', NULL, 'BARIĆ IVONA', NULL, 'Ured ovlaštenog arhitekta MARIO KRŠĆANSKI', 'Virovitičko-podravska', 'Orahovica', 'Kralja Zvonimira 284', '033/673-263', NULL, 'DA', 'NE', 'DA', 'NE', '23.5.2016.', 280, 'N', 'baric.ivona@gmail.com'),
('F-240/2013', NULL, 'CAFUK VELIMIR', NULL, 'GRADUS d.o.o.', 'Varaždinska', 'Varaždin', 'Jalkovečka 30', '042 214175', NULL, 'DA', 'DA', 'DA', 'NE', '27.5.2016.', 281, 'N', NULL),
('F-241/2013', NULL, 'VUČKOVIĆ GORAN', NULL, 'VUČKOVIĆ GORAN, URED OVLAŠTENOG INŽENJERA GRAĐEVINE', 'Zagrebačka', 'Zaprešić', 'Lužnička 10', '01 3643 418', NULL, 'DA', 'NE', 'DA', 'NE', '4.6.2016.', 282, 'N', NULL),
('F-243/2013', NULL, 'KOVAČEVIĆ MARTINA', NULL, NULL, 'Međimurska', 'Čakovec', 'Ivana pl. Zajca 17', NULL, '099-7043-022, 099/1911-459', 'DA', 'NE', 'DA', 'NE', '12.7.2016.', 283, 'N', 'martina.kovacevic@ck.t-com.hr'),
('F-245/2013', NULL, 'GRGIN DINA', NULL, 'RIMC D.O.O.', 'Zagrebačka', 'Samobor', 'Sv. Martin pod Okićem, Konščica 116', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '5.6.2016.', 284, 'N', 'dina.grgin@rimc.hr'),
('F-247/2013', 'DA', 'KAMENICA SELMA', NULL, 'RIMC PROJEKT d.o.o.', 'Grad Zagreb', 'Zagreb', 'Paška 10C', NULL, '091/5440-212', 'DA', 'NE', 'DA', 'NE', '11.7.2016.', 285, 'N', 'skamenica@gmail.com'),
('F-248/2013', NULL, 'ERCEG BRANKICA', NULL, 'Ured ovlaštene arhitektice Brankica Erceg', 'Šibensko Kninska', 'Skradin', 'Postolarska 4', '022/331-338', NULL, 'DA', 'NE', 'DA', 'NE', '18.7.2016.', 286, 'N', 'brankicaerceg@gmail.com'),
('F-250/2013', NULL, 'VELJANČIĆ BRANKO', NULL, 'ENERGOCERT', 'Zadarska', 'Zadar', 'Andrije Hebranga 5', '01 33 90 249', '095 96 80 966', 'DA', 'DA', 'DA', 'NE', '19.7.2016.', 287, 'N', 'branko.veljancic@globalnet.hr'),
('F-254/2013', NULL, 'SALOPEK DRAGUTIN', NULL, 'SPIN d.o.o.', 'Koprivničko-križevačka', 'Križevci', 'Kosovec 13', '048/ 711 891', '091/ 5670913', 'DA', 'DA', 'DA', 'NE', '26.7.2016.', 288, 'N', NULL),
('F-256/2013', NULL, 'IVOŠEVIĆ MILOŠ', NULL, 'ELEKTROINŽENJERING - IVOŠEVIĆ d. o. o.', 'Brodsko-posavska', 'Nova Gradiška', 'J. J. Strossmayera 19', '035 362821', NULL, 'DA', 'NE', 'DA', 'NE', '24.7.2016.', 289, 'N', NULL),
('P-257/2013', 'DA', 'PANČIĆ ROBERT', NULL, 'MOMENT SILE d.o.o.', 'Dubrovačko Neretvanska ', 'Dubrovnik', 'Marka Marojice 55', '020 356 964', '099 2634 877', 'DA', 'DA', 'DA', 'DA', '29.4.2016.', 290, 'N', 'robert.pancic@momentsile.hr'),
('F-258/2013', NULL, 'SALITREŽIĆ NIVES', NULL, 'SIRRAH-PROJEKT d.o.o.', 'Osječko-baranjska', 'Osijek', 'Gornjodravska obala 91C', '031/250-000', NULL, 'DA', 'NE', 'DA', 'NE', '22.7.2016.', 291, 'N', 'nives@sirrah.hr '),
('F-259/2013', NULL, 'GRAHOVIĆ ZLATKO', NULL, 'Obrt za građevinarstvo ZG-ING', 'Karlovačka', 'Karlovac', 'Tadije Smičiklasa 5C', NULL, '091 656 02 01', 'DA', 'NE', 'DA', 'NE', '12.8.2016.', 292, 'N', NULL),
('F-261/2013', NULL, 'ŠEBEŠTJAN ŽELJKO', NULL, 'ZAVOD ZA KONTROLU KVALITETE I CONZULTING d.o.o.', 'Međimurska', 'Kotoriba', 'Stjepana Radića 15', '040 31 09 71', '099 80 49 079 ', 'DA', 'DA', 'DA', 'NE', '31.7.2016.', 293, 'N', 'zeljko@zkkc.eu'),
('F-262/2013', NULL, 'SLADONJA VLADIMIR', NULL, 'SINGRAD d. o. o.', 'Istarska', 'Poreč', 'R. Stipe 28', '052 453487', NULL, 'DA', 'NE', 'DA', 'NE', '6.8.2016.', 294, 'N', NULL),
('F-263/2013', NULL, 'POLJAK SINIŠA', NULL, NULL, 'Splitsko Dalmatinska', 'Split', 'Kralja Zvonimira 63', NULL, '098 852155', 'DA', 'DA', 'DA', 'NE', '1.8.2016.', 295, 'N', 'eae@eae.hr, sinisa.poljak@st.htnet.hr'),
('F-264/2013', NULL, 'KUNIĆ GABRIEL', NULL, 'Ovlašteni ured za energetski pregled i izradu energtskih certifikata', 'Koprivničko-križevačka', 'Križevci', 'Majurec-cesta 163', NULL, '091 357 21 14', 'DA', 'NE', 'DA', 'NE', '14.8.2016.', 296, 'N', NULL),
('F-265/2013', NULL, 'MESIĆ DRAŽEN', NULL, 'Komunalije-Plin d.o.o.', 'Koprivničko-križevačka', 'Đurđevac', 'Stjepana Radića 87', '048/812-662', '098/374-589', 'DA', 'NE', 'DA', 'NE', '30.8.2016.', 297, 'N', NULL),
('F-268/2013', NULL, 'KLEMENC NADA', NULL, 'Klemenc d.o.o.', 'Istarska', 'Opatija', 'Ičići, Poljantska cesta 1', '051 273026', '098 981 83 34', 'DA', 'NE', 'DA', 'NE', '2.9.2016.', 298, 'N', 'nada.klemenc@ri.t-com.hr'),
('F-269/2013', NULL, 'IVKOVIĆ JADRANKA', NULL, 'TEMPUS PROJEKT d.o.o.', 'Splitsko Dalmatinska', 'Sinj', 'Kneza Branimira 4', '01 2469 034', '091 2469 034', 'DA', 'NE', 'DA', 'NE', '2.9.2016.', 299, 'N', 'jadranka.ivkovic@tempus-projekt.hr '),
('P-270/2013', 'DA', 'LJUBOJEVIĆ HRVOJE', NULL, 'TENZOR d.o.o.', 'Grad Zagreb', 'Zagreb', 'Hvarska 4a', '01 550 9784', '095 444 3033', 'DA', 'NE', 'DA', 'NE', '26.3.2016.', 300, 'N', 'hrvoje.ljubojevic@tenzor.hr'),
('F-274/2013', NULL, 'ŽIVKOVIĆ BOJAN', NULL, 'IDEA D.O.O.', 'Međimurska', 'Čakovec', 'Slavka Kolara 87', '040/395-935', NULL, 'DA', 'NE', 'DA', 'NE', '17.9.2016.', 301, 'N', 'idea1@ck.t-com.hr'),
('F-275/2013', NULL, 'ČULINOVIĆ DRAGUTIN', NULL, 'DRILL Co. d.o.o.', 'Grad Zagreb', 'Zagreb', 'Mladena Vodičke 5', NULL, '098 345030 ', 'DA', 'NE', 'DA', 'NE', '16.9.2016.', 302, 'N', NULL),
('F-276/2013', NULL, 'FARAGUNA ROBERT', NULL, 'NOJFERT OBRT ZA GRADITELJSTVO', 'Istarska', 'Labin', 'Ladenci 39', '052 85 70 06', NULL, 'DA', 'NE', 'DA', 'NE', '11.9.2016.', 303, 'N', NULL),
('F-277/2013', NULL, 'ROMIĆ PETAR', NULL, 'Zavod za integralnu kontrolu d.o.o.', 'Grad Zagreb', 'Zagreb', 'Trnsko 11A', NULL, '091/454 2223', 'DA', 'DA', 'DA', 'NE', '11.9.2016.', 304, 'N', 'petar.romic@energetsko-certificiranje.hr'),
('F-337/2013', NULL, 'IVON DOMAGOJ', NULL, 'Ured ovlaštenog inženjera strojarstva IVON DOMAGOJ', 'Zadarska', 'Zadar', 'Šibenska 7C', '023 326-449', NULL, 'DA', 'NE', 'DA', 'NE', '25.10.2016.', 305, 'N', NULL),
('F-338/2013', NULL, 'GALOVIĆ GORAN', NULL, 'Galović inženjering d.o.o.', 'Istarska', 'Umag', 'Školska 5A', '052743722', '098243745', 'DA', 'NE', 'DA', 'NE', '24.10.2016.', 306, 'N', 'goran.galovic@gmail.com'),
('F-340/2013', NULL, 'VIRT IVA', NULL, '„ STUDIO K „ d.o.o.', 'Zadarska', 'Zadar', 'Bana Josipa Jelačića 1A', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '25.10.2016.', 307, 'N', 'iva@studiok.hr'),
('F-342/2013', NULL, 'MIRKOVIĆ MARIJAN', NULL, 'Ured ovlaštenog arhitekta Marijan Mirković', 'Grad Zagreb', 'Zagreb', 'Milana Rešetara 42', '01 580 1131', '091 565 0360', 'DA', 'NE', 'DA', 'NE', '25.10.2016.', 308, 'N', 'marijan.mirkovic@gmail.com'),
('F-345/2013', NULL, 'TOMLJENOVIĆ SLAVKO', NULL, 'Odjel inspekcijskog nadzora - MZOPU', 'Požeško-slavonska', 'Požega', 'D. Cesarića 15', '034/ 271-130', NULL, 'DA', 'NE', 'DA', 'NE', '24.10.2016.', 309, 'N', 'gradjevinska.inspekcija@mzopu.hr'),
('F-346/2013', NULL, 'DAUTOVIĆ DRAGO', NULL, NULL, 'Vukovarsko Srijemska', 'Vinkovci', 'Vatrogasna 23', NULL, '099 68 98 88 77', 'DA', 'NE', 'DA', 'NE', '25.10.2016.', 310, 'N', 'dautovic.drago@gmail.com'),
('F-347/2013', NULL, 'ŠTRELOV KARDUM MAJA', NULL, 'Arhitektonski studio G&B. ', 'Grad Zagreb', 'Zagreb', 'Hvarska 1', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '30.10.2016.', 311, 'N', 'maja.strelov_kardum@gib.hr'),
('P-347/2013', 'DA', 'FILIPOVIĆ EDI', NULL, 'Green Energy Expert d.o.o.', 'Grad Zagreb', 'Zagreb', 'Petra Hektorovića 2', '01 777 7980', '095 902 5545', 'DA', 'DA', 'DA', 'DA', '19.9.2016.', 312, 'N', 'edi@gee.hr'),
('F-348/2013', NULL, 'MISLOVIĆ DAVOR', NULL, 'DIABLO PROJEKT d.o.o', 'Međimurska', 'Čakovec', 'Travnička 66', '040/363649', '098/213-362', 'DA', 'NE', 'DA', 'NE', '28.10.2016.', 313, 'N', 'info@diablo-projekt.hr'),
('F-349/2013', NULL, 'MIRČETA DANIJEL', NULL, 'CONSILIO', 'Grad Zagreb', 'Zagreb', 'Palinovečka 35', '01/3891-325', '091/4921-633', 'DA', 'DA', 'DA', 'NE', '31.10.2016.', 314, 'N', 'danijel.mirceta@consilio.hr'),
('F-350/2013', NULL, 'GRIZELJ MARIO', NULL, 'VERIDON d.o.o.', 'Grad Zagreb', 'Zagreb', 'Vukomerec 24b', '01/4815-089', NULL, 'DA', 'NE', 'DA', 'NE', '31.10.2016.', 315, 'N', NULL),
('F-351/2013', NULL, 'GUGIĆ DARKO', NULL, NULL, 'Grad Zagreb', 'Zagreb', 'Radoslava Cimermana 40', NULL, NULL, 'DA', 'DA', 'DA', 'NE', '31.10.2016.', 316, 'N', 'darko.gugic@verdispar.hr'),
('F-352/2013', NULL, 'DIDOVIĆ SLAVEN', NULL, 'DIS PROJEKT d.o.o.', 'Zagrebačka', 'Dugo Selo', 'Zagrebačka ulica 145', NULL, '098/648-385', 'DA', 'DA', 'DA', 'NE', '30.10.2016.', 317, 'N', 'slaven.didovic@dis-projekt.hr'),
('F-353/2013', NULL, 'MLINAREVIĆ KAMILO', NULL, 'INŽENJERSKO PROJEKTNI BIRO d.o.o.', 'Osječko-baranjska', 'Osijek', 'Valpovačka 5', NULL, '098 1755489', 'DA', 'NE', 'DA', 'NE', '31.10.2016.', 318, 'N', NULL),
('F-357/2013', NULL, 'KOŠMERL ZORAN', NULL, 'HAL d.o.o.', 'Varaždinska', 'Varaždin', 'O. Price 8', '042 233 360', NULL, 'DA', 'NE', 'DA', 'NE', '11.11.2016.', 319, 'N', 'hal@hal-croatia.com'),
('F-358/2013', NULL, 'POPOČOVSKI ČEDOMIR', NULL, 'URED OVLAŠTENOG ARHITEKTA - POPOČOVSKI ČEDOMIR', 'Grad Zagreb', 'Zagreb', 'Zadarska 4', '01/3094-775', NULL, 'DA', 'NE', 'DA', 'NE', '7.11.2016.', 320, 'N', NULL),
('F-359/2013', NULL, 'MILOBARA DAMIR', NULL, NULL, 'Koprivničko-križevačka', 'Križevci', 'M. C. Nehajeva 32', NULL, '091 1877 037', 'DA', 'NE', 'DA', 'NE', '7.11.2016.', 321, 'N', 'milobara.damir@inet.hr'),
('F-362/2013', NULL, 'KOLAR BENAK ŽELJKA', NULL, 'Trio-projekt d.o.o.', 'Grad Zagreb', 'Zagreb', 'Nikole Pavića 7', NULL, '099 3864111', 'DA', 'NE', 'DA', 'NE', '12.11.2016.', 322, 'N', 'zeljka@trio-projekt.hr'),
('P-362/2013', 'DA', 'KLOBUČARIĆ MARIO', NULL, 'Međimurska energetska agencija d.o.o.', 'Međimurska', 'Čakovec', 'Bana J.Jelačića 22', '040 395 559', '099 265 6398', 'DA', 'DA', 'DA', 'DA', '26.9.2016.', 323, 'N', 'mario.klobucaric@menea.hr'),
('F-364/2013', NULL, 'MANCE DRAŽEN', NULL, 'GORING d.o.o.', 'Varaždinska', 'Ravna Gora', 'Branimira Markovića 18', '051 818707', NULL, 'DA', 'NE', 'DA', 'NE', '8.11.2016.', 324, 'N', NULL),
('F-365/2013', NULL, 'STIPANIČEV DARKO, prof. dr. sc.', NULL, 'Fakultet elektrotehnike, strojarstva i brodogradnje - Sveučilište u Splitu', 'Splitsko Dalmatinska', 'Split', 'A. G. Matoša 26', '021 305 643', NULL, 'DA', 'NE', 'DA', 'NE', '13.11.2016.', 325, 'N', 'darko.stipanicev@fesb.hr'),
('F-366/2013', NULL, 'GMAJNIĆ KREŠIMIR', NULL, '"KROVOGRADNJA" GRAĐEVINSKI OBRT VL. KREŠIMIR GMAJNIĆ', 'Grad Zagreb', 'Zagreb', 'Rim 5', NULL, '098/278-176', 'DA', 'NE', 'DA', 'NE', '8.11.2016.', 326, 'N', NULL),
('F-367/2013', NULL, 'KLEPAC IVAN', NULL, 'I.T.C. d.o.o.', 'Krapinsko-zagorska', 'Oroslavje', 'Ljudevita Gaja 4', '049 284 218', '098 250045', 'DA', 'NE', 'DA', 'NE', '7.11.2016.', 327, 'N', NULL),
('F-400/2013', NULL, 'SRPAK NENAD', NULL, 'NEIMAR GRADITELJSTVO I URED OVLAŠTENOG INŽENJERA', 'Međimurska', 'Mursko Središće', 'Josipa Šajnovića 4', '040 543575', NULL, 'DA', 'NE', 'DA', 'NE', '28.11.2016.', 328, 'N', NULL),
('F-403/2013', NULL, 'KRANJČIĆ DRAGAN', NULL, 'KRANJČIĆ obrt za energetsko certificiranje', 'Istarska', 'Buzet', 'Naselje Goričica 13', NULL, '091 154 2368', 'DA', 'NE', 'DA', 'NE', '29.11.2016.', 329, 'N', NULL),
('F-404/2013', NULL, 'LEVAK MARIN', NULL, 'CESTAR d.o.o', 'Brodsko-posavska', 'Slavonski Brod', 'Andrije Štampara 61', '035/270-015', NULL, 'DA', 'NE', 'DA', 'NE', '4.12.2016.', 330, 'N', 'cestar@cestarsb.hr '),
('F-405/2013', NULL, 'BROZ MLADEN', NULL, NULL, 'Sisačko-moslavačka', 'Sisak', 'A. Cesarca 113', NULL, '091/4522906', 'DA', 'NE', 'DA', 'NE', '2.12.2016.', 331, 'N', NULL),
('P-405/2013', 'DA', 'VIDOŠEVIĆ IGOR', NULL, 'ALEA FORMA d.o.o.', 'Grad Zagreb', 'Zagreb', 'Savica I. 127', NULL, '098 227 987', 'DA', 'DA', 'DA', 'DA', '18.12.2016.', 332, 'N', 'igor.vidosevic@alea.hr'),
('F-407/2013', NULL, 'KOLARIĆ VLADIMIR', NULL, 'INKOL d.o.o.', 'Međimurska', 'Čakovec', 'Travnik 35', '040 391 013', NULL, 'DA', 'NE', 'DA', 'NE', '2.12.2016.', 333, 'N', NULL),
('F-410/2013', NULL, 'CAPIĆ VILIM', NULL, 'HOYER d.o.o', 'Osječko-baranjska', 'Osijek', 'Fruškogorska 8A', '031/302-933', NULL, 'DA', 'NE', 'DA', 'NE', '29.11.2016.', 334, 'N', 'vilim.capic@os.t-com.hr '),
('F-423/2013', 'DA', 'BANIĆ GORDAN', NULL, 'BAR-ing d.o.o.', 'Grad Zagreb', 'Zagreb', 'Draškovićeva 23', '01 4648 028', '091 502 8099', 'DA', 'NE', 'DA', 'NE', '4.12.2016.', 335, 'N', 'gordan.banic@zg.t-com.hr'),
('F-427/2013', NULL, 'CVITAK FILIP', NULL, 'AGRO INŽENJERING d.o.o.', 'Grad Zagreb', 'Zagreb', 'Trakošćanska 2', NULL, NULL, 'DA', 'DA', 'DA', 'NE', '10.12.2016.', 336, 'N', 'filip@a-i.hr'),
('F-428/2013', NULL, 'OREŠKOVIĆ HRVOJE', NULL, 'ING. OREŠKOVIĆ d.o.o.', 'Grad Zagreb', 'Zagreb', 'Nova cesta 121', '01 3095-045', '091 7920-365', 'DA', 'NE', 'DA', 'NE', '11.12.2016.', 337, 'N', 'hrvoje.oreskovic7@zg.htnet.hr'),
('F-431/2013', NULL, 'STULIĆ LUCIJA', NULL, 'A.K.I. d.o.o.', 'Grad Zagreb', 'Zagreb', 'Jarnovićeva 17D', '01/6000-555', NULL, 'DA', 'NE', 'DA', 'NE', '9.12.2016.', 338, 'N', 'lucija.stulic@aki-biro.hr'),
('F-432/2013', NULL, 'JAGNJIĆ ZDENKO', NULL, NULL, 'Osječko-baranjska', 'Osijek', 'Zrmanjska 62', NULL, '098 205570', 'DA', 'DA', 'DA', 'NE', '9.12.2016.', 339, 'N', 'zdenko.jagnjic@t.ht.hr'),
('F-435/2013', NULL, 'DELIĆ INGRID', NULL, NULL, 'Splitsko Dalmatinska', 'Split', 'Tolstojeva 20', '021/771-662, 021/621-226', '098/638-555', 'DA', 'NE', 'DA', 'NE', '9.12.2016.', 340, 'N', 'ingrid.delic@xnet.hr'),
('F-436/2013', NULL, 'JUNUZOVIĆ ASMIR', NULL, 'ACOA d.o.o', 'Grad Zagreb', 'Zagreb', 'Donje Vrapče 53A', '01 3790897', '098 294682', 'DA', 'NE', 'DA', 'NE', '10.12.2016.', 341, 'N', NULL),
('F-438/2013', NULL, 'WOLF VARGA INES', NULL, 'PROTECTUM d.o.o.', 'Grad Zagreb', 'Zagreb', 'Vurovčica 9', '01 3843759', NULL, 'DA', 'NE', 'DA', 'NE', '10.12.2016.', 342, 'N', NULL),
('F-439/2013', NULL, 'KALUĐER GORDANA', NULL, 'Kombel d.o.o.', 'Osječko-baranjska', 'Belišće', 'Lj. Posavskog 25', NULL, NULL, 'DA', 'NE', 'DA', 'NE', '12.12.2016.', 343, 'N', 'gordana.kaludjer@kombel.hr'),
('F-441/2013', NULL, 'BARIĆ IVAN', NULL, 'BIMEL d.o.o.', 'Osječko-baranjska', 'Osijek', 'Kozjačka 86', '031 1395426', '099 3510432', 'DA', 'NE', 'DA', 'NE', '11.12.2016.', 344, 'N', NULL),
('F-473/2014', NULL, 'KARADŽA DAMIR', NULL, 'PLING d.o.o.', 'Splitsko Dalmatinska', 'Split', 'Matice hrvatske 16', '021 21 23 90', NULL, 'DA', 'NE', 'DA', 'NE', '21.1.2017.', 345, 'N', NULL),
('F-474/2014', NULL, 'JADRIJEV OLIVER', NULL, 'Građevinar d.o.o.', 'Zadarska', 'Zadar', 'Put Petrića 49B', '023/220-218', '091/32 77 105', 'DA', 'NE', 'DA', 'NE', '19.1.2017.', 346, 'N', 'gradjevinar.doo.zadar@zd.t-com.hr'),
('F-475/2014', NULL, 'KARAMATIĆ IVO', NULL, '"K-ing" građevinarstvo i trgovina', 'Dubrovačko Neretvanska ', 'Ploče', 'Komin, Banja, Plinjanska 34', '020 670 870', '098 323 866', 'DA', 'DA', 'DA', 'NE', '20.1.2017.', 347, 'N', NULL),
('F-476/2014', NULL, 'VEŽA MARIO', NULL, 'Končar – Institut za elektrotehniku', 'Grad Zagreb', 'Zagreb', 'Zagrebačka cesta 201', NULL, NULL, 'DA', 'DA', 'DA', 'NE', '29.1.2017.', 348, 'N', 'mveza@koncar-institut.hr');

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

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `type`, `confirmed`, `activation_key`, `activation`, `tmp_pass`, `pass`, `sec_q`, `sec_a`) VALUES
(26640499090, 'member', 'Y', 59615361, 'caf1a3dfb505ffed0d024130f58c5cfa', '00c71bed74255b09004e5702509ce2c3', '0d37bd688a84fcb173abba3cd27e25e4', 0, 'Koprivnica'),
(36918078303, 'agent', 'Y', 0, '', '', 'bfdad9f8160aba8287368f7c857fd674', NULL, NULL),
(50319913673, 'member', 'Y', 25267731, 'e369853df766fa44e1ed0ff613f563bd', '537336a9885aaaf328ddd52a402aa466', '86d83819b014c8adaf1dddb4199f3b1d', 0, 'lobor grad'),
(51917706585, 'member', 'Y', 93804115, 'fc49306d97602c8ed1be1dfbf0835ead', '0aab70441483d52002a83df802f4b68e', '5dc69da7102e5170e27c8f22fc9a00c7', 0, 'sa'),
(65340328857, 'member', 'Y', 23124326, '2823f4797102ce1a1aec05359cc16dd9', '6dc6f9d20154cd4cfd9603afc2cae454', '3a44720f074f0c69be32b657534b42b8', 0, 'Zagreb'),
(75388854238, 'member', 'Y', 18090829, '1385974ed5904a438616ff7bdb3f7439', 'cb6ac00ea286feeed822a7504291cb14', 'd14cae0a3f6f147e3bf69cb46839e835', 4, 'steiner'),
(86769546972, 'member', 'Y', 99953108, '7634ea65a4e6d9041cfd3f7de18e334a', '2c53ac79e69b471a472226aeff2a2b46', 'ac1478001f7e8dc4db6bb7d8bb0b8e42', 4, 'AleksiÄ‡');

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