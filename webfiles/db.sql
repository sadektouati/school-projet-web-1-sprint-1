-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 19, 2023 at 05:44 PM
-- Server version: 10.6.5-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stampe_saddek`
--

-- --------------------------------------------------------

--
-- Table structure for table `enchere`
--

DROP TABLE IF EXISTS `enchere`;
CREATE TABLE IF NOT EXISTS `enchere` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `debut` date DEFAULT NULL,
  `fin` date DEFAULT NULL,
  `prix_plancher` int(11) DEFAULT NULL,
  `offre_actuel` int(11) DEFAULT NULL,
  `offre_actuel_membre` varchar(50) DEFAULT NULL,
  `quantite_mise` int(11) DEFAULT NULL,
  `a_coup_de_coeur_lord` tinyint(4) DEFAULT NULL,
  `est_enligne` tinyint(4) DEFAULT NULL,
  `titre` varchar(200) NOT NULL,
  `commentaire` text NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_enchere_utilisateur1_idx` (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `enchere`
--

INSERT INTO `enchere` (`id`, `debut`, `fin`, `prix_plancher`, `offre_actuel`, `offre_actuel_membre`, `quantite_mise`, `a_coup_de_coeur_lord`, `est_enligne`, `titre`, `commentaire`, `id_utilisateur`) VALUES
(1, '0000-00-00', '0000-00-00', 55554, NULL, NULL, 5, 1, 1, 'une enchere', 'This should work fine:\n\n{{ \'http://\' ~ app.request.host }}\nTo add a filter - like \'trans\' - in the same tag use\n\n{{ (\'http://\' ~ app.request.host) | trans }}\nAs Adam Elsodaney points out, you can also use string interpolation, this does require double quoted strings:\n\n{{ \"http://#{app.request.host}\" }}\nShare\nImprove this answer\nFollow\nedited Feb 2, 2022 at 22:41\nbobbel\'s user avatar\nbobbel\n3,30922 gold badges2626 silver badges4242 bronze badges\nanswered Oct 9, 2011 at 16:33\nAlessandro Desantis\'s user avatar\nAlessandro Desantis\n13.9k11 gold badge2525 silver badges3131 bronze badges\n4\nThanks for you answer. But it appears that | trans filter doesn\'t work on that (eg: {{ \'test_\' ~ name | trans }} won\'t translate my items. Do you have an idea how to do that? thx! – \nguillaumepotier\n Jan 8, 2012 at 14:21\n14\nYes, you have to create a variable to hold the concate', 1),
(2, '2000-01-15', '2000-02-25', 55554, NULL, NULL, NULL, NULL, 1, 'une auction Russel\'s Stamp', 'consectetur adipisicing elit. Voluptatum cupiditate iste quae mollitia, facilis voluptatibus explicabo, similique officiis asperiores incidunt cumque? Mollitia odio odit non iure qui reiciendis deleniti tenetur!Lorem ipsum dolor, sit amet ', 1),
(3, '2022-01-10', '2021-02-15', 10, NULL, NULL, NULL, NULL, 1, 'Juste uen enchere', 'juste un petit commentaire', 2);

-- --------------------------------------------------------

--
-- Table structure for table `etat`
--

DROP TABLE IF EXISTS `etat`;
CREATE TABLE IF NOT EXISTS `etat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `etat`
--

INSERT INTO `etat` (`id`, `nom`) VALUES
(1, 'Bon'),
(2, 'Nouveau'),
(3, 'Antic'),
(4, 'Autre');

-- --------------------------------------------------------

--
-- Table structure for table `favoris`
--

DROP TABLE IF EXISTS `favoris`;
CREATE TABLE IF NOT EXISTS `favoris` (
  `date_d_ajout` datetime NOT NULL DEFAULT current_timestamp(),
  `id_utilisateur` int(11) NOT NULL,
  `id_enchere` int(11) NOT NULL,
  KEY `fk_favoris_utilisateur1_idx` (`id_utilisateur`),
  KEY `fk_favoris_enchere1_idx` (`id_enchere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fichier` varchar(45) NOT NULL,
  `est_principale` tinyint(4) DEFAULT NULL,
  `id_timbre` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fichier_UNIQUE` (`fichier`),
  KEY `fk_image_timbre_idx` (`id_timbre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `pays`
--

INSERT INTO `pays` (`id`, `nom`) VALUES
(1, 'Algerie'),
(2, 'Quebec'),
(3, 'Canada'),
(4, 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `placer_mise`
--

DROP TABLE IF EXISTS `placer_mise`;
CREATE TABLE IF NOT EXISTS `placer_mise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `valeur` int(11) DEFAULT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_enchere` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_placer_mise_utilisateur1_idx` (`id_utilisateur`),
  KEY `fk_placer_mise_enchere1_idx` (`id_enchere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
CREATE TABLE IF NOT EXISTS `privilege` (
  `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `privilege`
--

INSERT INTO `privilege` (`id`, `nom`) VALUES
(2, 'Admin'),
(1, 'Régulier');

-- --------------------------------------------------------

--
-- Table structure for table `timbre`
--

DROP TABLE IF EXISTS `timbre`;
CREATE TABLE IF NOT EXISTS `timbre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `est_principal` tinyint(1) NOT NULL,
  `date_de_creation` date DEFAULT NULL,
  `tirage` int(11) DEFAULT NULL,
  `largeur` int(11) DEFAULT NULL,
  `longueur` int(11) DEFAULT NULL,
  `certifie` tinyint(1) DEFAULT NULL,
  `id_enchere` int(11) NOT NULL,
  `id_etat` int(11) NOT NULL,
  `id_pays` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_timbre_enchere1_idx` (`id_enchere`),
  KEY `fk_timbre_etat1_idx` (`id_etat`),
  KEY `fk_timbre_pays1_idx` (`id_pays`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `timbre`
--

INSERT INTO `timbre` (`id`, `nom`, `est_principal`, `date_de_creation`, `tirage`, `largeur`, `longueur`, `certifie`, `id_enchere`, `id_etat`, `id_pays`) VALUES
(2, 'nom de timbre auction', 0, '1050-02-14', 200, 10, 14, 0, 1, 1, 2),
(3, 'un timbre de collection', 1, '1050-02-14', 14, 200, 45, 1, 3, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `mot_de_passe` varchar(80) NOT NULL,
  `courriel` varchar(100) NOT NULL,
  `date_inscrit` datetime DEFAULT current_timestamp(),
  `id_privilege` tinyint(4) UNSIGNED DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`courriel`),
  KEY `id_privilege` (`id_privilege`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `mot_de_passe`, `courriel`, `date_inscrit`, `id_privilege`) VALUES
(1, 'bila', '$2y$10$gvbRe/UI7izIC.Ce0HQLYeFjh8G7pPaXIaakTwcSC5ba95Y0u5CLK', 'bilal2dddd@hotmail.com', NULL, NULL),
(2, 'Elon Musk Not One', '$2y$10$QkEo65s71KX7jlaEhLJ8hOTbYmFZRp51jxjddMvsiduAZddm5LlSG', 'elon@email.net', NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `fk_enchere_utilisateur1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `favoris`
--
ALTER TABLE `favoris`
  ADD CONSTRAINT `fk_favoris_enchere1` FOREIGN KEY (`id_enchere`) REFERENCES `enchere` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_favoris_utilisateur1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `fk_image_timbre` FOREIGN KEY (`id_timbre`) REFERENCES `timbre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `placer_mise`
--
ALTER TABLE `placer_mise`
  ADD CONSTRAINT `fk_placer_mise_enchere1` FOREIGN KEY (`id_enchere`) REFERENCES `enchere` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_placer_mise_utilisateur1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `timbre`
--
ALTER TABLE `timbre`
  ADD CONSTRAINT `fk_timbre_enchere1` FOREIGN KEY (`id_enchere`) REFERENCES `enchere` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_timbre_etat1` FOREIGN KEY (`id_etat`) REFERENCES `etat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_timbre_pays1` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `fk_util_privs` FOREIGN KEY (`id_privilege`) REFERENCES `privilege` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
