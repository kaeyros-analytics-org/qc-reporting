-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 16 avr. 2024 à 12:43
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `afriland`
--

-- --------------------------------------------------------

--
-- Structure de la table `autre_somme_client`
--

DROP TABLE IF EXISTS `autre_somme_client`;
CREATE TABLE IF NOT EXISTS `autre_somme_client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `autre_somme_client`
--

INSERT INTO `autre_somme_client` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 35000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `banque_ets`
--

DROP TABLE IF EXISTS `banque_ets`;
CREATE TABLE IF NOT EXISTS `banque_ets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `banque_ets`
--

INSERT INTO `banque_ets` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 45000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `bon_de_caisse`
--

DROP TABLE IF EXISTS `bon_de_caisse`;
CREATE TABLE IF NOT EXISTS `bon_de_caisse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `bon_de_caisse`
--

INSERT INTO `bon_de_caisse` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 25600, 20000, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `compte_a_vue`
--

DROP TABLE IF EXISTS `compte_a_vue`;
CREATE TABLE IF NOT EXISTS `compte_a_vue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `compte_a_vue`
--

INSERT INTO `compte_a_vue` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 35000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `compte_bloque`
--

DROP TABLE IF EXISTS `compte_bloque`;
CREATE TABLE IF NOT EXISTS `compte_bloque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `compte_bloque`
--

INSERT INTO `compte_bloque` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 700, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `compte_cheques`
--

DROP TABLE IF EXISTS `compte_cheques`;
CREATE TABLE IF NOT EXISTS `compte_cheques` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `compte_cheques`
--

INSERT INTO `compte_cheques` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 60000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `compte_courant`
--

DROP TABLE IF EXISTS `compte_courant`;
CREATE TABLE IF NOT EXISTS `compte_courant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `compte_courant`
--

INSERT INTO `compte_courant` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 500000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `compte_livret`
--

DROP TABLE IF EXISTS `compte_livret`;
CREATE TABLE IF NOT EXISTS `compte_livret` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `compte_livret`
--

INSERT INTO `compte_livret` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 60000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `depot_a_terme`
--

DROP TABLE IF EXISTS `depot_a_terme`;
CREATE TABLE IF NOT EXISTS `depot_a_terme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `depot_a_terme`
--

INSERT INTO `depot_a_terme` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 35000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `depot_garantie`
--

DROP TABLE IF EXISTS `depot_garantie`;
CREATE TABLE IF NOT EXISTS `depot_garantie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `depot_garantie`
--

INSERT INTO `depot_garantie` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 300000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `disposition_a_payer`
--

DROP TABLE IF EXISTS `disposition_a_payer`;
CREATE TABLE IF NOT EXISTS `disposition_a_payer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `disposition_a_payer`
--

INSERT INTO `disposition_a_payer` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 300000, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `flash_cash`
--

DROP TABLE IF EXISTS `flash_cash`;
CREATE TABLE IF NOT EXISTS `flash_cash` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `flash_cash`
--

INSERT INTO `flash_cash` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 654780, 0, '2024-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `valeur_non_indique`
--

DROP TABLE IF EXISTS `valeur_non_indique`;
CREATE TABLE IF NOT EXISTS `valeur_non_indique` (
  `id` int NOT NULL AUTO_INCREMENT,
  `retail_banking` int NOT NULL,
  `corporate_banking` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `valeur_non_indique`
--

INSERT INTO `valeur_non_indique` (`id`, `retail_banking`, `corporate_banking`, `date`) VALUES
(1, 45000, 0, '2024-01-01');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
