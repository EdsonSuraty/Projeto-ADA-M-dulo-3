-- Cria primeiro as tabelas e depois executa o resto. Eu puxei o script direto do DBGate, adicionando a criação dos indexs, e as chaves estrangeiras.

CREATE TABLE `CARRO` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `MODELO` VARCHAR(255) NOT NULL,
  `COR` ENUM ('preto','branco','prata') NOT NULL,
  `QUILOMETRAGEM_ATUAL` INT NULL DEFAULT 0 ,
  `FK_ID_MONTADORA` INT NOT NULL,
  `FK_ID_CATEGORIA` INT NOT NULL,
  `STATUS_LOCACAO` TINYINT NULL DEFAULT 1 ,
  `FK_ID_VERSAO` INT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `CATEGORIA` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `NOME` VARCHAR(255) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `CLIENTE` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `NOME` VARCHAR(255) NOT NULL,
  `FK_LOCACAO_ATUAL` INT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `ENDERECO` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `RUA / AV` VARCHAR(255) NOT NULL,
  `NUMERO` INT NOT NULL,
  `COMPLEMENTO` VARCHAR(255) NULL,
  `CEP` VARCHAR(10) NOT NULL,
  `CIDADE` VARCHAR(255) NOT NULL,
  `UF` VARCHAR(2) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `LOCACAO` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `DATA_LOCACAO` DATE NOT NULL,
  `DATA_DEVOLUCAO` DATE NULL,
  `QUILOMETRAGEM_INICIAL` INT NOT NULL,
  `QUILOMETRAGEM_FINAL` INT NULL,
  `FK_ID_CARRO` INT NOT NULL,
  `MODALIDADE_LOCACAO` ENUM ('diaria') NOT NULL,
  `FK_ID_UNIDADE_LOCACAO` INT NOT NULL,
  `FK_ID_UNIDADE_DEVOLUCAO` INT NULL,
  `FK_ID_CLIENTE` INT NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `MONTADORA` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `NOME` VARCHAR(255) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `UNIDADE` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `NOME` VARCHAR(255) NOT NULL,
  `FK_ID_ENDERECO` INT NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE TABLE `VERSAO` ( 
  `ID` INT AUTO_INCREMENT NOT NULL,
  `DESCRICAO` VARCHAR(255) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`ID`)
);
CREATE INDEX `FK_ID_CATEGORIA` 
ON `CARRO` (
  `FK_ID_CATEGORIA` ASC
);
CREATE INDEX `FK_ID_MONTADORA` 
ON `CARRO` (
  `FK_ID_MONTADORA` ASC
);
CREATE INDEX `FK_ID_VERSAO` 
ON `CARRO` (
  `FK_ID_VERSAO` ASC
);
CREATE INDEX `FK_LOCACAO_ATUAL` 
ON `CLIENTE` (
  `FK_LOCACAO_ATUAL` ASC
);
CREATE INDEX `FK_ID_UNIDADE_DEVOLUCAO` 
ON `LOCACAO` (
  `FK_ID_UNIDADE_DEVOLUCAO` ASC
);
CREATE INDEX `FK_ID_UNIDADE_LOCACAO` 
ON `LOCACAO` (
  `FK_ID_UNIDADE_LOCACAO` ASC
);
CREATE INDEX `FK_ID_CARRO` 
ON `LOCACAO` (
  `FK_ID_CARRO` ASC
);
CREATE INDEX `FK_ID_CLIENTE` 
ON `LOCACAO` (
  `FK_ID_CLIENTE` ASC
);
CREATE INDEX `FK_ID_ENDERECO` 
ON `UNIDADE` (
  `FK_ID_ENDERECO` ASC
);
ALTER TABLE `CARRO` ADD CONSTRAINT `FK_ID_CATEGORIA` FOREIGN KEY (`FK_ID_CATEGORIA`) REFERENCES `CATEGORIA` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `CARRO` ADD CONSTRAINT `FK_ID_MONTADORA` FOREIGN KEY (`FK_ID_MONTADORA`) REFERENCES `MONTADORA` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `CARRO` ADD CONSTRAINT `FK_ID_VERSAO` FOREIGN KEY (`FK_ID_VERSAO`) REFERENCES `VERSAO` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `CLIENTE` ADD CONSTRAINT `FK_LOCACAO_ATUAL` FOREIGN KEY (`FK_LOCACAO_ATUAL`) REFERENCES `LOCACAO` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `LOCACAO` ADD CONSTRAINT `FK_ID_CARRO` FOREIGN KEY (`FK_ID_CARRO`) REFERENCES `CARRO` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `LOCACAO` ADD CONSTRAINT `FK_ID_CLIENTE` FOREIGN KEY (`FK_ID_CLIENTE`) REFERENCES `CLIENTE` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `LOCACAO` ADD CONSTRAINT `FK_ID_UNIDADE_DEVOLUCAO` FOREIGN KEY (`FK_ID_UNIDADE_DEVOLUCAO`) REFERENCES `UNIDADE` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `LOCACAO` ADD CONSTRAINT `FK_ID_UNIDADE_LOCACAO` FOREIGN KEY (`FK_ID_UNIDADE_LOCACAO`) REFERENCES `UNIDADE` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `UNIDADE` ADD CONSTRAINT `FK_ID_ENDERECO` FOREIGN KEY (`FK_ID_ENDERECO`) REFERENCES `ENDERECO` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
