-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 23, 2024 at 12:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `VINISYS`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `P1` (IN `p_COLHEITA_ID` INT, IN `p_TRABALHADOR_COLABORADOR_numero` INT, IN `p_horas` INT, IN `p_remuneracao` INT)   BEGIN

DECLARE total_remuneracao INT DEFAULT 0;

INSERT INTO PARTICIPA (COLHEITA_ID, TRABALHADOR_COLABORADOR_numero, horas, remuneracao) VALUES (p_COLHEITA_ID, p_TRABALHADOR_COLABORADOR_numero, p_horas, p_remuneracao);

SELECT SUM(remuneracao) INTO total_remuneracao FROM PARTICIPA where COLHEITA_ID = p_COLHEITA_ID;

SELECT total_remuneracao AS TotalRemuneracao;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `P2` (IN `p_REGIAO_ID` INT, IN `p_PRODUTOR_ID` INT, IN `p_COLHEITA_ID` INT, IN `p_ano` INT, IN `p_data_inicio` DATE, IN `p_data_fim` DATE, IN `p_quantidade` INT)   BEGIN
    INSERT INTO COLHEITA (REGIAO_ID, PRODUTOR_ID, COLHEITA_ID, ano, data_inicio, data_fim, quantidade)
    VALUES (p_REGIAO_ID, p_PRODUTOR_ID, p_COLHEITA_ID, p_ano, p_data_inicio, p_data_fim, p_quantidade);
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `F1` (`p_COLHEITA_ID` INT) RETURNS INT(11)  BEGIN
    DECLARE total_horas INT DEFAULT 0;

    SELECT SUM(horas) INTO total_horas
    FROM PARTICIPA
    WHERE COLHEITA_ID = p_COLHEITA_ID;

    RETURN total_horas;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `F2` (`p_CASTA_ID` INT) RETURNS INT(11)  BEGIN
    DECLARE total_area INT DEFAULT 0;

    SELECT SUM(area_cultivada) INTO total_area
    FROM PRODUZ
    WHERE CASTA_ID = p_CASTA_ID;

    RETURN total_area;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ACOMPANHA`
--

CREATE TABLE `ACOMPANHA` (
  `COLHEITA_ID` int(11) NOT NULL,
  `ENOLOGO_COLABORADOR_numero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `CASTA`
--

CREATE TABLE `CASTA` (
  `CASTA_ID` int(11) NOT NULL,
  `tipo_uva` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `CASTA`
--

INSERT INTO `CASTA` (`CASTA_ID`, `tipo_uva`) VALUES
(1, 'champanhe'),
(2, 'concord'),
(3, 'kyoho');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENTE`
--

CREATE TABLE `CLIENTE` (
  `numero_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(100) DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `nif` char(9) DEFAULT NULL,
  `morada` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `CLIENTE`
--

INSERT INTO `CLIENTE` (`numero_cliente`, `nome_cliente`, `tipo`, `nif`, `morada`) VALUES
(1, 'Igor Margarida', 'Privado', '123456789', 'Santa Apolónia'),
(2, 'Rodrigo Multas', 'Empresa', '999999999', 'Rua da PSP');

-- --------------------------------------------------------

--
-- Table structure for table `COLABORADOR`
--

CREATE TABLE `COLABORADOR` (
  `numero` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `COLABORADOR`
--

INSERT INTO `COLABORADOR` (`numero`, `nome`) VALUES
(1, 'João Miguel'),
(2, 'Joana Maria'),
(3, 'Ana Carmina'),
(4, 'Vasco Magalhães');

-- --------------------------------------------------------

--
-- Table structure for table `COLHEITA`
--

CREATE TABLE `COLHEITA` (
  `REGIAO_ID` int(11) NOT NULL,
  `PRODUTOR_ID` int(11) NOT NULL,
  `COLHEITA_ID` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `COLHEITA`
--

INSERT INTO `COLHEITA` (`REGIAO_ID`, `PRODUTOR_ID`, `COLHEITA_ID`, `ano`, `data_inicio`, `data_fim`, `quantidade`) VALUES
(2, 1, 3, 2020, '2024-12-16', '2025-01-01', 12343);

-- --------------------------------------------------------

--
-- Table structure for table `CONTEM`
--

CREATE TABLE `CONTEM` (
  `CASTA_ID` int(11) NOT NULL,
  `EDICAO_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `DEVOLUCAO`
--

CREATE TABLE `DEVOLUCAO` (
  `CLIENTE_numero_cliente` int(11) NOT NULL,
  `FATURA_num_fatura` int(11) NOT NULL,
  `DEVOLUCAO_ID` int(11) NOT NULL,
  `data_devol` date DEFAULT NULL,
  `montante` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `DEVOLVIDO`
--

CREATE TABLE `DEVOLVIDO` (
  `VINHO_ID` int(11) NOT NULL,
  `DEVOLUCAO_ID` int(11) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `preco` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `EDICAO`
--

CREATE TABLE `EDICAO` (
  `VINHO_ID` int(11) NOT NULL,
  `EDICAO_ID` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `EDICAO`
--

INSERT INTO `EDICAO` (`VINHO_ID`, `EDICAO_ID`, `ano`, `tipo`, `volume`) VALUES
(1, 1, 2024, 'tinto', 123456);

-- --------------------------------------------------------

--
-- Stand-in structure for view `empresas_maiores_compras`
-- (See below for the actual view)
--
CREATE TABLE `empresas_maiores_compras` (
`numero` int(11)
,`nome` varchar(100)
,`nif` char(9)
,`morada` varchar(100)
,`numero_total_faturas` bigint(21)
,`volume_compras` double
);

-- --------------------------------------------------------

--
-- Table structure for table `ENOLOGO`
--

CREATE TABLE `ENOLOGO` (
  `COLABORADOR_numero` int(11) NOT NULL,
  `especializacao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `ENOLOGO`
--

INSERT INTO `ENOLOGO` (`COLABORADOR_numero`, `especializacao`) VALUES
(2, 'consistência'),
(4, 'qualidade');

-- --------------------------------------------------------

--
-- Table structure for table `FATURA`
--

CREATE TABLE `FATURA` (
  `CLIENTE_numero_cliente` int(11) NOT NULL,
  `num_fatura` int(11) NOT NULL,
  `data_fatura` date DEFAULT NULL,
  `valor_total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `FATURA`
--

INSERT INTO `FATURA` (`CLIENTE_numero_cliente`, `num_fatura`, `data_fatura`, `valor_total`) VALUES
(1, 1, '2024-12-22', 100);

-- --------------------------------------------------------

--
-- Table structure for table `GANHA`
--

CREATE TABLE `GANHA` (
  `EDICAO_ID` int(11) NOT NULL,
  `PREMIO_ID` int(11) NOT NULL,
  `data_distincao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `GANHA`
--

INSERT INTO `GANHA` (`EDICAO_ID`, `PREMIO_ID`, `data_distincao`) VALUES
(1, 1, '2024-12-22');

-- --------------------------------------------------------

--
-- Table structure for table `INCIDE`
--

CREATE TABLE `INCIDE` (
  `COLHEITA_ID` int(11) NOT NULL,
  `VINHA_codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `ITEM`
--

CREATE TABLE `ITEM` (
  `VINHO_ID` int(11) NOT NULL,
  `FATURA_num_fatura` int(11) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `dimensao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `ITEM`
--

INSERT INTO `ITEM` (`VINHO_ID`, `FATURA_num_fatura`, `quantidade`, `preco`, `dimensao`) VALUES
(1, 1, 10, 10, '100');

-- --------------------------------------------------------

--
-- Table structure for table `PARTICIPA`
--

CREATE TABLE `PARTICIPA` (
  `COLHEITA_ID` int(11) NOT NULL,
  `TRABALHADOR_COLABORADOR_numero` int(11) NOT NULL,
  `horas` int(11) DEFAULT NULL,
  `remuneracao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Triggers `PARTICIPA`
--
DELIMITER $$
CREATE TRIGGER `T2` AFTER INSERT ON `PARTICIPA` FOR EACH ROW BEGIN
	DECLARE colheita_count INT;

    SELECT COUNT(*) INTO colheita_count
    FROM PARTICIPA
    WHERE COLHEITA_ID = NEW.COLHEITA_ID;

    IF colheita_count = 1 THEN
        UPDATE COLHEITA
        SET data_inicio = CURDATE()
        WHERE COLHEITA_ID = NEW.COLHEITA_ID;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `PREMIO`
--

CREATE TABLE `PREMIO` (
  `PREMIO_ID` int(11) NOT NULL,
  `nome_distincao` varchar(30) DEFAULT NULL,
  `entidade` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `PREMIO`
--

INSERT INTO `PREMIO` (`PREMIO_ID`, `nome_distincao`, `entidade`) VALUES
(1, 'bolas', 'quingue ove da uaine');

-- --------------------------------------------------------

--
-- Table structure for table `PRODUTOR`
--

CREATE TABLE `PRODUTOR` (
  `REGIAO_ID` int(11) NOT NULL,
  `PRODUTOR_ID` int(11) NOT NULL,
  `nome_vinicola` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `morada` varchar(100) DEFAULT NULL,
  `codigo_postal` char(8) DEFAULT NULL,
  `telefone` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `PRODUTOR`
--

INSERT INTO `PRODUTOR` (`REGIAO_ID`, `PRODUTOR_ID`, `nome_vinicola`, `email`, `morada`, `codigo_postal`, `telefone`) VALUES
(1, 1, 'Marcindes', 'marcindes@marcindes.marcindes', 'rua marcindes', '12341234', '123456789');

-- --------------------------------------------------------

--
-- Table structure for table `PRODUZ`
--

CREATE TABLE `PRODUZ` (
  `VINHA_codigo` int(11) NOT NULL,
  `CASTA_ID` int(11) NOT NULL,
  `area_cultivada` int(11) DEFAULT NULL,
  `data_plantacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Triggers `PRODUZ`
--
DELIMITER $$
CREATE TRIGGER `T1` AFTER INSERT ON `PRODUZ` FOR EACH ROW begin
	declare total_area INT;

    SELECT SUM(area_cultivada) INTO total_area
    FROM PRODUZ
    WHERE VINHA_codigo = NEW.VINHA_codigo AND CASTA_ID = NEW.CASTA_ID;


    UPDATE PRODUZ
    SET area_cultivada = total_area
    WHERE VINHA_codigo = NEW.VINHA_codigo AND CASTA_ID = NEW.CASTA_ID;
    
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `Q1`
-- (See below for the actual view)
--
CREATE TABLE `Q1` (
`VinhaCodigo` int(11)
,`VinhaNome` varchar(50)
,`CastaID` int(11)
,`CastaTipo` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Q2`
-- (See below for the actual view)
--
CREATE TABLE `Q2` (
`VINHO_ID` int(11)
,`NomeVinho` varchar(50)
,`NumeroPremios` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Q3`
-- (See below for the actual view)
--
CREATE TABLE `Q3` (
`VINHO_ID` int(11)
,`NomeVinho` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Q4`
-- (See below for the actual view)
--
CREATE TABLE `Q4` (
`regiao` varchar(50)
,`casta` varchar(30)
,`area_total` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Q5`
-- (See below for the actual view)
--
CREATE TABLE `Q5` (
`VINHO_ID` int(11)
,`nome_vinho` varchar(50)
,`valor_total_devolucao` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Q6`
-- (See below for the actual view)
--
CREATE TABLE `Q6` (
`PRODUTOR_ID` int(11)
,`produtor` varchar(100)
,`VINHO_ID` int(11)
,`vinho` varchar(50)
,`quantidade_vendida` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `REGIAO`
--

CREATE TABLE `REGIAO` (
  `REGIAO_ID` int(11) NOT NULL,
  `denominacao` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `REGIAO`
--

INSERT INTO `REGIAO` (`REGIAO_ID`, `denominacao`) VALUES
(1, 'Douro'),
(2, 'Alentejo');

-- --------------------------------------------------------

--
-- Table structure for table `TRABALHA`
--

CREATE TABLE `TRABALHA` (
  `PRODUTOR_ID` int(11) NOT NULL,
  `COLABORADOR_numero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `TRABALHADOR`
--

CREATE TABLE `TRABALHADOR` (
  `TRABALHADOR_COLABORADOR_numero` int(11) DEFAULT NULL,
  `COLABORADOR_numero` int(11) NOT NULL,
  `funcao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Table structure for table `VINHA`
--

CREATE TABLE `VINHA` (
  `codigo` int(11) NOT NULL,
  `nome_vinha` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `VINHA`
--

INSERT INTO `VINHA` (`codigo`, `nome_vinha`) VALUES
(1, 'panelas'),
(2, 'frigideiras');

-- --------------------------------------------------------

--
-- Table structure for table `VINHO`
--

CREATE TABLE `VINHO` (
  `REGIAO_ID` int(11) NOT NULL,
  `PRODUTOR_ID` int(11) NOT NULL,
  `VINHO_ID` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `data_engarraf` date DEFAULT NULL,
  `teor_alcoolico` float DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `classificacao` varchar(30) DEFAULT NULL,
  `aroma` varchar(30) DEFAULT NULL,
  `sabor` varchar(30) DEFAULT NULL,
  `cor` varchar(30) DEFAULT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `VINHO`
--

INSERT INTO `VINHO` (`REGIAO_ID`, `PRODUTOR_ID`, `VINHO_ID`, `nome`, `data_engarraf`, `teor_alcoolico`, `tipo`, `classificacao`, `aroma`, `sabor`, `cor`, `stock`) VALUES
(1, 1, 1, 'Marcindes LDA', '2024-12-22', 14, 'tinto', '5', 'floral', 'amargo', 'vermelho', 100),
(2, 1, 2, 'KEEP', '2024-12-31', 50, 'preto', '10', 'incrivel', 'lendário', 'perfeita', 2147483647);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vinhos_produtores`
-- (See below for the actual view)
--
CREATE TABLE `vinhos_produtores` (
`nome_produtor` varchar(100)
,`nome_vinho` varchar(50)
,`tipo_vinho` varchar(30)
,`teor_alcoolico` float
,`regiao_vinho` varchar(50)
,`ano_edicao` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `empresas_maiores_compras`
--
DROP TABLE IF EXISTS `empresas_maiores_compras`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `empresas_maiores_compras`  AS SELECT `c`.`numero_cliente` AS `numero`, `c`.`nome_cliente` AS `nome`, `c`.`nif` AS `nif`, `c`.`morada` AS `morada`, count(`f`.`num_fatura`) AS `numero_total_faturas`, sum(`i`.`quantidade` * `i`.`preco`) AS `volume_compras` FROM ((`CLIENTE` `c` join `FATURA` `f` on(`c`.`numero_cliente` = `f`.`CLIENTE_numero_cliente`)) join `ITEM` `i` on(`f`.`num_fatura` = `i`.`FATURA_num_fatura`)) GROUP BY `c`.`numero_cliente`, `c`.`nome_cliente`, `c`.`nif`, `c`.`morada` ORDER BY sum(`i`.`quantidade` * `i`.`preco`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `Q1`
--
DROP TABLE IF EXISTS `Q1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Q1`  AS SELECT `V`.`codigo` AS `VinhaCodigo`, `V`.`nome_vinha` AS `VinhaNome`, `C`.`CASTA_ID` AS `CastaID`, `C`.`tipo_uva` AS `CastaTipo` FROM ((`VINHA` `V` join `PRODUZ` `P` on(`V`.`codigo` = `P`.`VINHA_codigo`)) join `CASTA` `C` on(`P`.`CASTA_ID` = `C`.`CASTA_ID`)) ORDER BY `V`.`nome_vinha` ASC, `C`.`tipo_uva` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `Q2`
--
DROP TABLE IF EXISTS `Q2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Q2`  AS SELECT `V`.`VINHO_ID` AS `VINHO_ID`, `V`.`nome` AS `NomeVinho`, count(`G`.`PREMIO_ID`) AS `NumeroPremios` FROM ((`VINHO` `V` join `EDICAO` `E` on(`V`.`VINHO_ID` = `E`.`VINHO_ID`)) join `GANHA` `G` on(`E`.`EDICAO_ID` = `G`.`EDICAO_ID`)) GROUP BY `V`.`VINHO_ID`, `V`.`nome` ORDER BY count(`G`.`PREMIO_ID`) DESC LIMIT 0, 3 ;

-- --------------------------------------------------------

--
-- Structure for view `Q3`
--
DROP TABLE IF EXISTS `Q3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Q3`  AS SELECT DISTINCT `E1`.`VINHO_ID` AS `VINHO_ID`, `V`.`nome` AS `NomeVinho` FROM ((((`EDICAO` `E1` join `EDICAO` `E2` on(`E1`.`VINHO_ID` = `E2`.`VINHO_ID` and `E1`.`ano` = `E2`.`ano` - 1)) join `GANHA` `G1` on(`E1`.`EDICAO_ID` = `G1`.`EDICAO_ID`)) join `GANHA` `G2` on(`E2`.`EDICAO_ID` = `G2`.`EDICAO_ID`)) join `VINHO` `V` on(`E1`.`VINHO_ID` = `V`.`VINHO_ID`)) ORDER BY `V`.`nome` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `Q4`
--
DROP TABLE IF EXISTS `Q4`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Q4`  AS SELECT `r`.`denominacao` AS `regiao`, `c`.`tipo_uva` AS `casta`, sum(`p`.`area_cultivada`) AS `area_total` FROM (((((`PRODUZ` `p` join `VINHA` `v` on(`p`.`VINHA_codigo` = `v`.`codigo`)) join `INCIDE` `i` on(`v`.`codigo` = `i`.`VINHA_codigo`)) join `COLHEITA` `co` on(`i`.`COLHEITA_ID` = `co`.`COLHEITA_ID`)) join `REGIAO` `r` on(`co`.`REGIAO_ID` = `r`.`REGIAO_ID`)) join `CASTA` `c` on(`p`.`CASTA_ID` = `c`.`CASTA_ID`)) GROUP BY `r`.`denominacao`, `c`.`tipo_uva` ORDER BY `r`.`denominacao` ASC, sum(`p`.`area_cultivada`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `Q5`
--
DROP TABLE IF EXISTS `Q5`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Q5`  AS SELECT `v`.`VINHO_ID` AS `VINHO_ID`, `v`.`nome` AS `nome_vinho`, sum(`d`.`quantidade` * `d`.`preco`) AS `valor_total_devolucao` FROM ((`DEVOLVIDO` `d` join `DEVOLUCAO` `dev` on(`d`.`DEVOLUCAO_ID` = `dev`.`DEVOLUCAO_ID`)) join `VINHO` `v` on(`d`.`VINHO_ID` = `v`.`VINHO_ID`)) WHERE extract(year from `dev`.`data_devol`) = 2023 GROUP BY `v`.`VINHO_ID`, `v`.`nome` HAVING sum(`d`.`quantidade` * `d`.`preco`) > 100 ;

-- --------------------------------------------------------

--
-- Structure for view `Q6`
--
DROP TABLE IF EXISTS `Q6`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Q6`  AS SELECT `p`.`PRODUTOR_ID` AS `PRODUTOR_ID`, `p`.`nome_vinicola` AS `produtor`, `v`.`VINHO_ID` AS `VINHO_ID`, `v`.`nome` AS `vinho`, sum(`i`.`quantidade`) AS `quantidade_vendida` FROM ((`ITEM` `i` join `VINHO` `v` on(`i`.`VINHO_ID` = `v`.`VINHO_ID`)) join `PRODUTOR` `p` on(`v`.`PRODUTOR_ID` = `p`.`PRODUTOR_ID`)) GROUP BY `p`.`PRODUTOR_ID`, `p`.`nome_vinicola`, `v`.`VINHO_ID`, `v`.`nome` ORDER BY `p`.`PRODUTOR_ID` ASC, sum(`i`.`quantidade`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `vinhos_produtores`
--
DROP TABLE IF EXISTS `vinhos_produtores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vinhos_produtores`  AS SELECT `p`.`nome_vinicola` AS `nome_produtor`, `v`.`nome` AS `nome_vinho`, `v`.`tipo` AS `tipo_vinho`, `v`.`teor_alcoolico` AS `teor_alcoolico`, `r`.`denominacao` AS `regiao_vinho`, `e`.`ano` AS `ano_edicao` FROM (((`VINHO` `v` join `PRODUTOR` `p` on(`v`.`PRODUTOR_ID` = `p`.`PRODUTOR_ID`)) join `REGIAO` `r` on(`v`.`REGIAO_ID` = `r`.`REGIAO_ID`)) join `EDICAO` `e` on(`v`.`VINHO_ID` = `e`.`VINHO_ID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ACOMPANHA`
--
ALTER TABLE `ACOMPANHA`
  ADD PRIMARY KEY (`COLHEITA_ID`,`ENOLOGO_COLABORADOR_numero`),
  ADD KEY `FK_ENOLOGO_ACOMPANHA_COLHEITA` (`ENOLOGO_COLABORADOR_numero`);

--
-- Indexes for table `CASTA`
--
ALTER TABLE `CASTA`
  ADD PRIMARY KEY (`CASTA_ID`);

--
-- Indexes for table `CLIENTE`
--
ALTER TABLE `CLIENTE`
  ADD PRIMARY KEY (`numero_cliente`);

--
-- Indexes for table `COLABORADOR`
--
ALTER TABLE `COLABORADOR`
  ADD PRIMARY KEY (`numero`);

--
-- Indexes for table `COLHEITA`
--
ALTER TABLE `COLHEITA`
  ADD PRIMARY KEY (`COLHEITA_ID`),
  ADD KEY `FK_COLHEITA_pertence_REGIAO` (`REGIAO_ID`),
  ADD KEY `FK_COLHEITA_destinada_PRODUTOR` (`PRODUTOR_ID`);

--
-- Indexes for table `CONTEM`
--
ALTER TABLE `CONTEM`
  ADD PRIMARY KEY (`CASTA_ID`,`EDICAO_ID`),
  ADD KEY `FK_EDICAO_CONTEM_CASTA` (`EDICAO_ID`);

--
-- Indexes for table `DEVOLUCAO`
--
ALTER TABLE `DEVOLUCAO`
  ADD PRIMARY KEY (`DEVOLUCAO_ID`),
  ADD KEY `FK_DEVOLUCAO_realiza_CLIENTE` (`CLIENTE_numero_cliente`),
  ADD KEY `FK_DEVOLUCAO_origina_FATURA` (`FATURA_num_fatura`);

--
-- Indexes for table `DEVOLVIDO`
--
ALTER TABLE `DEVOLVIDO`
  ADD PRIMARY KEY (`VINHO_ID`,`DEVOLUCAO_ID`),
  ADD KEY `FK_DEVOLUCAO_DEVOLVIDO_VINHO` (`DEVOLUCAO_ID`);

--
-- Indexes for table `EDICAO`
--
ALTER TABLE `EDICAO`
  ADD PRIMARY KEY (`EDICAO_ID`),
  ADD KEY `FK_EDICAO_tem_VINHO` (`VINHO_ID`);

--
-- Indexes for table `ENOLOGO`
--
ALTER TABLE `ENOLOGO`
  ADD PRIMARY KEY (`COLABORADOR_numero`);

--
-- Indexes for table `FATURA`
--
ALTER TABLE `FATURA`
  ADD PRIMARY KEY (`num_fatura`),
  ADD KEY `FK_FATURA_emitida_CLIENTE` (`CLIENTE_numero_cliente`);

--
-- Indexes for table `GANHA`
--
ALTER TABLE `GANHA`
  ADD PRIMARY KEY (`EDICAO_ID`,`PREMIO_ID`),
  ADD KEY `FK_PREMIO_GANHA_EDICAO` (`PREMIO_ID`);

--
-- Indexes for table `INCIDE`
--
ALTER TABLE `INCIDE`
  ADD PRIMARY KEY (`COLHEITA_ID`,`VINHA_codigo`),
  ADD KEY `FK_VINHA_INCIDE_COLHEITA` (`VINHA_codigo`);

--
-- Indexes for table `ITEM`
--
ALTER TABLE `ITEM`
  ADD PRIMARY KEY (`VINHO_ID`,`FATURA_num_fatura`),
  ADD KEY `FK_ITEM_noname_FATURA` (`FATURA_num_fatura`);

--
-- Indexes for table `PARTICIPA`
--
ALTER TABLE `PARTICIPA`
  ADD PRIMARY KEY (`COLHEITA_ID`,`TRABALHADOR_COLABORADOR_numero`),
  ADD KEY `FK_TRABALHADOR_PARTICIPA_COLHEITA` (`TRABALHADOR_COLABORADOR_numero`);

--
-- Indexes for table `PREMIO`
--
ALTER TABLE `PREMIO`
  ADD PRIMARY KEY (`PREMIO_ID`);

--
-- Indexes for table `PRODUTOR`
--
ALTER TABLE `PRODUTOR`
  ADD PRIMARY KEY (`PRODUTOR_ID`),
  ADD KEY `FK_PRODUTOR_tem_REGIAO` (`REGIAO_ID`);

--
-- Indexes for table `PRODUZ`
--
ALTER TABLE `PRODUZ`
  ADD PRIMARY KEY (`VINHA_codigo`,`CASTA_ID`),
  ADD KEY `FK_CASTA_PRODUZ_VINHA` (`CASTA_ID`);

--
-- Indexes for table `REGIAO`
--
ALTER TABLE `REGIAO`
  ADD PRIMARY KEY (`REGIAO_ID`);

--
-- Indexes for table `TRABALHA`
--
ALTER TABLE `TRABALHA`
  ADD PRIMARY KEY (`PRODUTOR_ID`,`COLABORADOR_numero`),
  ADD KEY `FK_COLABORADOR_TRABALHA_PRODUTOR` (`COLABORADOR_numero`);

--
-- Indexes for table `TRABALHADOR`
--
ALTER TABLE `TRABALHADOR`
  ADD PRIMARY KEY (`COLABORADOR_numero`),
  ADD KEY `FK_TRABALHADOR_chefia_TRABALHADOR` (`TRABALHADOR_COLABORADOR_numero`);

--
-- Indexes for table `VINHA`
--
ALTER TABLE `VINHA`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `VINHO`
--
ALTER TABLE `VINHO`
  ADD PRIMARY KEY (`VINHO_ID`),
  ADD KEY `FK_VINHO_associado_REGIAO` (`REGIAO_ID`),
  ADD KEY `FK_VINHO_produzido_PRODUTOR` (`PRODUTOR_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `COLHEITA`
--
ALTER TABLE `COLHEITA`
  MODIFY `COLHEITA_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ACOMPANHA`
--
ALTER TABLE `ACOMPANHA`
  ADD CONSTRAINT `FK_COLHEITA_ACOMPANHA_ENOLOGO` FOREIGN KEY (`COLHEITA_ID`) REFERENCES `COLHEITA` (`COLHEITA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ENOLOGO_ACOMPANHA_COLHEITA` FOREIGN KEY (`ENOLOGO_COLABORADOR_numero`) REFERENCES `ENOLOGO` (`COLABORADOR_numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `COLHEITA`
--
ALTER TABLE `COLHEITA`
  ADD CONSTRAINT `FK_COLHEITA_destinada_PRODUTOR` FOREIGN KEY (`PRODUTOR_ID`) REFERENCES `PRODUTOR` (`PRODUTOR_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_COLHEITA_pertence_REGIAO` FOREIGN KEY (`REGIAO_ID`) REFERENCES `REGIAO` (`REGIAO_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `CONTEM`
--
ALTER TABLE `CONTEM`
  ADD CONSTRAINT `FK_CASTA_CONTEM_EDICAO` FOREIGN KEY (`CASTA_ID`) REFERENCES `CASTA` (`CASTA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EDICAO_CONTEM_CASTA` FOREIGN KEY (`EDICAO_ID`) REFERENCES `EDICAO` (`EDICAO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `DEVOLUCAO`
--
ALTER TABLE `DEVOLUCAO`
  ADD CONSTRAINT `FK_DEVOLUCAO_origina_FATURA` FOREIGN KEY (`FATURA_num_fatura`) REFERENCES `FATURA` (`num_fatura`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DEVOLUCAO_realiza_CLIENTE` FOREIGN KEY (`CLIENTE_numero_cliente`) REFERENCES `CLIENTE` (`numero_cliente`) ON UPDATE CASCADE;

--
-- Constraints for table `DEVOLVIDO`
--
ALTER TABLE `DEVOLVIDO`
  ADD CONSTRAINT `FK_DEVOLUCAO_DEVOLVIDO_VINHO` FOREIGN KEY (`DEVOLUCAO_ID`) REFERENCES `DEVOLUCAO` (`DEVOLUCAO_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHO_DEVOLVIDO_DEVOLUCAO_` FOREIGN KEY (`VINHO_ID`) REFERENCES `VINHO` (`VINHO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EDICAO`
--
ALTER TABLE `EDICAO`
  ADD CONSTRAINT `FK_EDICAO_tem_VINHO` FOREIGN KEY (`VINHO_ID`) REFERENCES `VINHO` (`VINHO_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `ENOLOGO`
--
ALTER TABLE `ENOLOGO`
  ADD CONSTRAINT `FK_ENOLOGO_COLABORADOR` FOREIGN KEY (`COLABORADOR_numero`) REFERENCES `COLABORADOR` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `FATURA`
--
ALTER TABLE `FATURA`
  ADD CONSTRAINT `FK_FATURA_emitida_CLIENTE` FOREIGN KEY (`CLIENTE_numero_cliente`) REFERENCES `CLIENTE` (`numero_cliente`) ON UPDATE CASCADE;

--
-- Constraints for table `GANHA`
--
ALTER TABLE `GANHA`
  ADD CONSTRAINT `FK_EDICAO_GANHA_PREMIO` FOREIGN KEY (`EDICAO_ID`) REFERENCES `EDICAO` (`EDICAO_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PREMIO_GANHA_EDICAO` FOREIGN KEY (`PREMIO_ID`) REFERENCES `PREMIO` (`PREMIO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `INCIDE`
--
ALTER TABLE `INCIDE`
  ADD CONSTRAINT `FK_COLHEITA_INCIDE_VINHA` FOREIGN KEY (`COLHEITA_ID`) REFERENCES `COLHEITA` (`COLHEITA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHA_INCIDE_COLHEITA` FOREIGN KEY (`VINHA_codigo`) REFERENCES `VINHA` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ITEM`
--
ALTER TABLE `ITEM`
  ADD CONSTRAINT `FK_FATURA_ITEM_VINHO` FOREIGN KEY (`FATURA_num_fatura`) REFERENCES `FATURA` (`num_fatura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ITEM_noname_FATURA` FOREIGN KEY (`FATURA_num_fatura`) REFERENCES `FATURA` (`num_fatura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ITEM_representa_VINHO` FOREIGN KEY (`VINHO_ID`) REFERENCES `VINHO` (`VINHO_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHO_ITEM_FATURA` FOREIGN KEY (`VINHO_ID`) REFERENCES `VINHO` (`VINHO_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `PARTICIPA`
--
ALTER TABLE `PARTICIPA`
  ADD CONSTRAINT `FK_COLHEITA_PARTICIPA_TRABALHADOR` FOREIGN KEY (`COLHEITA_ID`) REFERENCES `COLHEITA` (`COLHEITA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TRABALHADOR_PARTICIPA_COLHEITA` FOREIGN KEY (`TRABALHADOR_COLABORADOR_numero`) REFERENCES `TRABALHADOR` (`COLABORADOR_numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `PRODUTOR`
--
ALTER TABLE `PRODUTOR`
  ADD CONSTRAINT `FK_PRODUTOR_tem_REGIAO` FOREIGN KEY (`REGIAO_ID`) REFERENCES `REGIAO` (`REGIAO_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `PRODUZ`
--
ALTER TABLE `PRODUZ`
  ADD CONSTRAINT `FK_CASTA_PRODUZ_VINHA` FOREIGN KEY (`CASTA_ID`) REFERENCES `CASTA` (`CASTA_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHA_PRODUZ_CASTA` FOREIGN KEY (`VINHA_codigo`) REFERENCES `VINHA` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TRABALHA`
--
ALTER TABLE `TRABALHA`
  ADD CONSTRAINT `FK_COLABORADOR_TRABALHA_PRODUTOR` FOREIGN KEY (`COLABORADOR_numero`) REFERENCES `COLABORADOR` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUTOR_TRABALHA_COLABORADOR` FOREIGN KEY (`PRODUTOR_ID`) REFERENCES `PRODUTOR` (`PRODUTOR_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TRABALHADOR`
--
ALTER TABLE `TRABALHADOR`
  ADD CONSTRAINT `FK_TRABALHADOR_COLABORADOR` FOREIGN KEY (`COLABORADOR_numero`) REFERENCES `COLABORADOR` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TRABALHADOR_chefia_TRABALHADOR` FOREIGN KEY (`TRABALHADOR_COLABORADOR_numero`) REFERENCES `TRABALHADOR` (`COLABORADOR_numero`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `VINHO`
--
ALTER TABLE `VINHO`
  ADD CONSTRAINT `FK_VINHO_associado_REGIAO` FOREIGN KEY (`REGIAO_ID`) REFERENCES `REGIAO` (`REGIAO_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VINHO_produzido_PRODUTOR` FOREIGN KEY (`PRODUTOR_ID`) REFERENCES `PRODUTOR` (`PRODUTOR_ID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
