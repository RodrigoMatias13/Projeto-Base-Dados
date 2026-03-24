-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 02-Nov-2024 às 19:26
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `vinisys`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `casta`
--

CREATE TABLE `casta` (
  `casta_ID` int(11) NOT NULL,
  `tipoUva` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `tipoCliente_tipoCliente_ID` int(11) NOT NULL,
  `nome` text DEFAULT NULL,
  `nif` int(11) NOT NULL,
  `morada` text DEFAULT NULL,
  `número` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `colaborador`
--

CREATE TABLE `colaborador` (
  `numero` int(11) NOT NULL,
  `nome` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `colheita`
--

CREATE TABLE `colheita` (
  `regiao_denominacao` varchar(255) NOT NULL,
  `enologos_colaborador_numero` int(11) NOT NULL,
  `produtor_email` varchar(255) NOT NULL,
  `anoColheita` int(11) NOT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date DEFAULT NULL,
  `quantidade` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `devolução`
--

CREATE TABLE `devolução` (
  `dataDevolução` date NOT NULL,
  `devolução_ID` int(11) NOT NULL,
  `montante` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `edicao`
--

CREATE TABLE `edicao` (
  `edicao_ID` int(11) NOT NULL,
  `tipoEdicao_tipoEdicao_ID` int(11) NOT NULL,
  `vinho_nome` varchar(255) NOT NULL,
  `casta_casta_ID` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `volumeProducao` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `enologos`
--

CREATE TABLE `enologos` (
  `colaborador_numero` int(11) NOT NULL,
  `especializacao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fatura`
--

CREATE TABLE `fatura` (
  `numero` int(11) NOT NULL,
  `montanteTotal` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `infotrabalhador`
--

CREATE TABLE `infotrabalhador` (
  `trabalhador_ID` int(11) NOT NULL,
  `remuneracao` double NOT NULL,
  `horas` int(11) NOT NULL,
  `colheita_anoColheita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `linhafatura`
--

CREATE TABLE `linhafatura` (
  `fatura_numero` int(11) NOT NULL,
  `devolução_devolução_ID` int(11) DEFAULT NULL,
  `linhaFatura_ID` int(11) NOT NULL,
  `nºGarrafas` int(11) DEFAULT NULL,
  `dimensão` double DEFAULT NULL,
  `preço` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Acionadores `linhafatura`
--
DELIMITER $$
CREATE TRIGGER `delete_montanteTotal` AFTER DELETE ON `linhafatura` FOR EACH ROW BEGIN
  UPDATE fatura
  SET montanteTotal = (SELECT SUM(preço) FROM linhaFatura WHERE fatura_numero = OLD.fatura_numero)
  WHERE numero = OLD.fatura_numero;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_montanteTotal` AFTER INSERT ON `linhafatura` FOR EACH ROW BEGIN
  UPDATE fatura
  SET montanteTotal = (SELECT SUM(montante) FROM linhaFatura WHERE fatura_numero = NEW.fatura_numero)
  WHERE numero = NEW.fatura_numero;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `notasdegustacao`
--

CREATE TABLE `notasdegustacao` (
  `notasDegustacao_ID` int(11) NOT NULL,
  `aroma` text DEFAULT NULL,
  `sabor` text DEFAULT NULL,
  `cor` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `plantação`
--

CREATE TABLE `plantação` (
  `plantação_ID` int(11) NOT NULL,
  `vinha_codigoID` int(11) NOT NULL,
  `casta_casta_ID` int(11) NOT NULL,
  `dataPlantação` date NOT NULL,
  `áreaCultivada` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtor`
--

CREATE TABLE `produtor` (
  `vinho_nome` varchar(255) NOT NULL,
  `nome` text DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `morada` text DEFAULT NULL,
  `cpp` int(11) DEFAULT NULL,
  `telefone` int(11) DEFAULT NULL,
  `colaborador_numero` int(11) NOT NULL,
  `colheita_anoColheita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `prémio`
--

CREATE TABLE `prémio` (
  `prémio_ID` int(11) NOT NULL,
  `edicao_edicao_ID` int(11) NOT NULL,
  `dataPrémio` date NOT NULL,
  `nome` varchar(255) NOT NULL,
  `entidade` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `quantidadevenda`
--

CREATE TABLE `quantidadevenda` (
  `quantidade` int(11) NOT NULL,
  `vinho_ID` int(11) NOT NULL,
  `quantidade_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `regiao`
--

CREATE TABLE `regiao` (
  `denominacao` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipocliente`
--

CREATE TABLE `tipocliente` (
  `tipoCliente_ID` int(11) NOT NULL,
  `tipo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipoedicao`
--

CREATE TABLE `tipoedicao` (
  `tipoEdicao_ID` int(11) NOT NULL,
  `tipo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipovinho`
--

CREATE TABLE `tipovinho` (
  `tipoVinho_ID` int(11) NOT NULL,
  `tipo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `trabalhador`
--

CREATE TABLE `trabalhador` (
  `colheita_dataInicio` date NOT NULL,
  `trabalhador_colaborador_numero` int(11) NOT NULL,
  `horas` int(11) DEFAULT NULL,
  `chefe_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

CREATE TABLE `venda` (
  `vinho_ID` varchar(255) NOT NULL,
  `cliente_nif` int(11) NOT NULL,
  `dataVenda` date NOT NULL,
  `venda_ID` int(11) NOT NULL,
  `fatura_fatura_ID` int(11) NOT NULL,
  `quantidade_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vinha`
--

CREATE TABLE `vinha` (
  `colheita_anoColheita` int(11) NOT NULL,
  `colheita_dataInicio` date NOT NULL,
  `codigoID` int(11) NOT NULL,
  `nome` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vinho`
--

CREATE TABLE `vinho` (
  `vinho_ID` int(11) NOT NULL,
  `regiao_denominacao` varchar(255) NOT NULL,
  `produtor_email` varchar(255) NOT NULL,
  `venda_venda_ID` int(11) NOT NULL,
  `dataEngarrafamento` date NOT NULL,
  `tipoVinho_tipoVinho_ID` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `teorAlcool` double DEFAULT NULL,
  `classificacao` double DEFAULT NULL,
  `edicao_edicao_ID` int(11) NOT NULL,
  `notasDegustacao_notasDegustacao_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `casta`
--
ALTER TABLE `casta`
  ADD PRIMARY KEY (`casta_ID`);

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`nif`),
  ADD KEY `FK_cliente_tipoCliente` (`tipoCliente_tipoCliente_ID`);

--
-- Índices para tabela `colaborador`
--
ALTER TABLE `colaborador`
  ADD PRIMARY KEY (`numero`);

--
-- Índices para tabela `colheita`
--
ALTER TABLE `colheita`
  ADD PRIMARY KEY (`anoColheita`),
  ADD UNIQUE KEY `anoColheita` (`anoColheita`),
  ADD UNIQUE KEY `anoColheita_2` (`anoColheita`),
  ADD KEY `FK_colheita_colheitaDe_regiao` (`regiao_denominacao`),
  ADD KEY `FK_colheita_acompanha_enologos` (`enologos_colaborador_numero`),
  ADD KEY `FK_colheita_noname_produtor` (`produtor_email`);

--
-- Índices para tabela `devolução`
--
ALTER TABLE `devolução`
  ADD PRIMARY KEY (`devolução_ID`);

--
-- Índices para tabela `edicao`
--
ALTER TABLE `edicao`
  ADD PRIMARY KEY (`edicao_ID`),
  ADD KEY `FK_edicao_casta` (`casta_casta_ID`),
  ADD KEY `FK_edicao_tipoEdicao` (`tipoEdicao_tipoEdicao_ID`);

--
-- Índices para tabela `enologos`
--
ALTER TABLE `enologos`
  ADD PRIMARY KEY (`colaborador_numero`);

--
-- Índices para tabela `fatura`
--
ALTER TABLE `fatura`
  ADD PRIMARY KEY (`numero`);

--
-- Índices para tabela `infotrabalhador`
--
ALTER TABLE `infotrabalhador`
  ADD UNIQUE KEY `trabalhador_ID` (`trabalhador_ID`),
  ADD UNIQUE KEY `colheita_colheitaAno` (`colheita_anoColheita`);

--
-- Índices para tabela `linhafatura`
--
ALTER TABLE `linhafatura`
  ADD PRIMARY KEY (`linhaFatura_ID`),
  ADD UNIQUE KEY `fatura_numero` (`fatura_numero`),
  ADD UNIQUE KEY `devolução_devolução_ID` (`devolução_devolução_ID`);

--
-- Índices para tabela `notasdegustacao`
--
ALTER TABLE `notasdegustacao`
  ADD PRIMARY KEY (`notasDegustacao_ID`);

--
-- Índices para tabela `plantação`
--
ALTER TABLE `plantação`
  ADD PRIMARY KEY (`plantação_ID`),
  ADD KEY `FK_casta_plantação_vinha_` (`casta_casta_ID`),
  ADD KEY `FK_vinha_plantação_casta_` (`vinha_codigoID`);

--
-- Índices para tabela `produtor`
--
ALTER TABLE `produtor`
  ADD PRIMARY KEY (`email`),
  ADD KEY `FK_produtor_colaborador` (`colaborador_numero`),
  ADD KEY `FK_produtor_colheita` (`colheita_anoColheita`);

--
-- Índices para tabela `prémio`
--
ALTER TABLE `prémio`
  ADD PRIMARY KEY (`prémio_ID`),
  ADD UNIQUE KEY `edicao_edicao_ID` (`edicao_edicao_ID`);

--
-- Índices para tabela `quantidadevenda`
--
ALTER TABLE `quantidadevenda`
  ADD UNIQUE KEY `vinho_ID` (`vinho_ID`,`quantidade_ID`),
  ADD KEY `quantidade_ID` (`quantidade_ID`);

--
-- Índices para tabela `regiao`
--
ALTER TABLE `regiao`
  ADD PRIMARY KEY (`denominacao`);

--
-- Índices para tabela `tipocliente`
--
ALTER TABLE `tipocliente`
  ADD PRIMARY KEY (`tipoCliente_ID`);

--
-- Índices para tabela `tipoedicao`
--
ALTER TABLE `tipoedicao`
  ADD PRIMARY KEY (`tipoEdicao_ID`);

--
-- Índices para tabela `tipovinho`
--
ALTER TABLE `tipovinho`
  ADD PRIMARY KEY (`tipoVinho_ID`);

--
-- Índices para tabela `trabalhador`
--
ALTER TABLE `trabalhador`
  ADD PRIMARY KEY (`trabalhador_colaborador_numero`),
  ADD UNIQUE KEY `chefe_ID` (`chefe_ID`) USING BTREE;

--
-- Índices para tabela `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`venda_ID`),
  ADD UNIQUE KEY `fatura_fatura_ID` (`fatura_fatura_ID`),
  ADD UNIQUE KEY `cliente_nif` (`cliente_nif`),
  ADD UNIQUE KEY `vinho_ID` (`vinho_ID`),
  ADD UNIQUE KEY `quantidade_ID` (`quantidade_ID`);

--
-- Índices para tabela `vinha`
--
ALTER TABLE `vinha`
  ADD PRIMARY KEY (`codigoID`),
  ADD KEY `FK_vinha_plantadas_colheita` (`colheita_anoColheita`,`colheita_dataInicio`);

--
-- Índices para tabela `vinho`
--
ALTER TABLE `vinho`
  ADD PRIMARY KEY (`vinho_ID`),
  ADD UNIQUE KEY `venda_venda_ID` (`venda_venda_ID`),
  ADD KEY `FK_vinho_tipoVinho` (`tipoVinho_tipoVinho_ID`),
  ADD KEY `FK_vinho_regiao` (`regiao_denominacao`),
  ADD KEY `FK_vinho_produtor` (`produtor_email`),
  ADD KEY `FK_vinho_notasDegustacao` (`notasDegustacao_notasDegustacao_ID`),
  ADD KEY `FK_vinho_edicao` (`edicao_edicao_ID`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_cliente_tipoCliente` FOREIGN KEY (`tipoCliente_tipoCliente_ID`) REFERENCES `tipocliente` (`tipoCliente_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `colaborador`
--
ALTER TABLE `colaborador`
  ADD CONSTRAINT `colaborador_ibfk_1` FOREIGN KEY (`numero`) REFERENCES `enologos` (`colaborador_numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `colheita`
--
ALTER TABLE `colheita`
  ADD CONSTRAINT `FK_colheita_noname_produtor` FOREIGN KEY (`produtor_email`) REFERENCES `produtor` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `colheita_ibfk_1` FOREIGN KEY (`enologos_colaborador_numero`) REFERENCES `enologos` (`colaborador_numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `edicao`
--
ALTER TABLE `edicao`
  ADD CONSTRAINT `FK_edicao_casta` FOREIGN KEY (`casta_casta_ID`) REFERENCES `casta` (`casta_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_edicao_tipoEdicao` FOREIGN KEY (`tipoEdicao_tipoEdicao_ID`) REFERENCES `tipoedicao` (`tipoEdicao_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `infotrabalhador`
--
ALTER TABLE `infotrabalhador`
  ADD CONSTRAINT `infotrabalhador_ibfk_1` FOREIGN KEY (`trabalhador_ID`) REFERENCES `trabalhador` (`trabalhador_colaborador_numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `infotrabalhador_ibfk_2` FOREIGN KEY (`colheita_anoColheita`) REFERENCES `colheita` (`anoColheita`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `linhafatura`
--
ALTER TABLE `linhafatura`
  ADD CONSTRAINT `linhaFatura_ibfk_1` FOREIGN KEY (`fatura_numero`) REFERENCES `fatura` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `linhaFatura_ibfk_2` FOREIGN KEY (`devolução_devolução_ID`) REFERENCES `devolução` (`devolução_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `plantação`
--
ALTER TABLE `plantação`
  ADD CONSTRAINT `FK_casta_plantação_vinha_` FOREIGN KEY (`casta_casta_ID`) REFERENCES `casta` (`casta_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_vinha_plantação_casta_` FOREIGN KEY (`vinha_codigoID`) REFERENCES `vinha` (`codigoID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `produtor`
--
ALTER TABLE `produtor`
  ADD CONSTRAINT `FK_produtor_colaborador` FOREIGN KEY (`colaborador_numero`) REFERENCES `colaborador` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_produtor_colheita` FOREIGN KEY (`colheita_anoColheita`) REFERENCES `colheita` (`anoColheita`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `prémio`
--
ALTER TABLE `prémio`
  ADD CONSTRAINT `prémio_ibfk_1` FOREIGN KEY (`edicao_edicao_ID`) REFERENCES `edicao` (`edicao_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `quantidadevenda`
--
ALTER TABLE `quantidadevenda`
  ADD CONSTRAINT `quantidadeVenda_ibfk_1` FOREIGN KEY (`vinho_ID`) REFERENCES `vinho` (`vinho_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `quantidadeVenda_ibfk_2` FOREIGN KEY (`quantidade_ID`) REFERENCES `venda` (`quantidade_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `regiao`
--
ALTER TABLE `regiao`
  ADD CONSTRAINT `regiao_ibfk_1` FOREIGN KEY (`denominacao`) REFERENCES `colheita` (`regiao_denominacao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `trabalhador`
--
ALTER TABLE `trabalhador`
  ADD CONSTRAINT `FK_trabalhador_chefe` FOREIGN KEY (`chefe_ID`) REFERENCES `trabalhador` (`trabalhador_colaborador_numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_trabalhador_colaborador` FOREIGN KEY (`trabalhador_colaborador_numero`) REFERENCES `colaborador` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`fatura_fatura_ID`) REFERENCES `fatura` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`cliente_nif`) REFERENCES `cliente` (`nif`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `vinha`
--
ALTER TABLE `vinha`
  ADD CONSTRAINT `vinha_ibfk_1` FOREIGN KEY (`colheita_anoColheita`) REFERENCES `colheita` (`anoColheita`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `vinho`
--
ALTER TABLE `vinho`
  ADD CONSTRAINT `FK_vinho_edicao` FOREIGN KEY (`edicao_edicao_ID`) REFERENCES `edicao` (`edicao_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_vinho_notasDegustacao` FOREIGN KEY (`notasDegustacao_notasDegustacao_ID`) REFERENCES `notasdegustacao` (`notasDegustacao_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_vinho_produtor` FOREIGN KEY (`produtor_email`) REFERENCES `produtor` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_vinho_regiao` FOREIGN KEY (`regiao_denominacao`) REFERENCES `regiao` (`denominacao`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_vinho_tipoVinho` FOREIGN KEY (`tipoVinho_tipoVinho_ID`) REFERENCES `tipovinho` (`tipoVinho_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vinho_ibfk_1` FOREIGN KEY (`venda_venda_ID`) REFERENCES `venda` (`venda_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
