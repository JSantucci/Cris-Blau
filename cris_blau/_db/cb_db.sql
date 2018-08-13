-- MySQL Script generated by MySQL Workbench
-- 11/01/16 15:19:33
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cb_db
-- -----------------------------------------------------
-- Banco de dados direcionado para empresa de festas sob medida.
-- Autores: Gabriel Dezan Busarello, João Pedro Ferreira Santucci, João  Vitor Spieker, Lucas Janning
-- Data de Criação:13/09/2016

-- -----------------------------------------------------
-- Schema cb_db
--
-- Banco de dados direcionado para empresa de festas sob medida.
-- Autores: Gabriel Dezan Busarello, João Pedro Ferreira Santucci, João  Vitor Spieker, Lucas Janning
-- Data de Criação:13/09/2016
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cb_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cb_db` ;

-- -----------------------------------------------------
-- Table `cb_db`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`users` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`users` (
  `id` TINYINT(3) ZEROFILL UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar o indentificador único de cada usuário.',
  `username` VARCHAR(20) NOT NULL COMMENT 'Campo destinado a armazenar os nomes de usuário.',
  `password` CHAR(32) NOT NULL COMMENT 'Campo destinado a armazenar as senhas dos usuários, que serão criptografadas em MD5. ',
  `permission` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar as permissões dos usuários. \nValores: 0 - Administrador\n              1 - Colaborador',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar todos os usuários.';


-- -----------------------------------------------------
-- Table `cb_db`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`employees` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`employees` (
  `id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar o indentificador único de cada colaborador.',
  `users_id` TINYINT(3) ZEROFILL UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de usuários em colaboradores.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Campo destinado a armazenar os nomes dos colaboradores.',
  `email` VARCHAR(70) NOT NULL COMMENT 'Campo destinado a armazenar os e-mails dos colaboradores.',
  `phone` BIGINT(15) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os telefones dos colaboradores.',
  `birthdate` DATE NOT NULL COMMENT 'Campo destinado a armazenar as datas de nascimento dos colaboradores.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_employees_users1_idx` (`users_id` ASC)  COMMENT '',
  CONSTRAINT `fk_employees_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cb_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os colaboradores.';


-- -----------------------------------------------------
-- Table `cb_db`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`cities` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`cities` (
  `id` TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos da cidade',
  `name` VARCHAR(30) NOT NULL COMMENT 'Campo destinado a armazenar os nomes das cidades.',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar as cidades.';


-- -----------------------------------------------------
-- Table `cb_db`.`districts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`districts` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`districts` (
  `id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indeficadores únicos de bairro.',
  `cities_id` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de cidades em bairros.',
  `name` VARCHAR(25) NOT NULL COMMENT 'Campo destinado a armazenar os nomes dos bairros.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_districts_cities1_idx` (`cities_id` ASC)  COMMENT '',
  CONSTRAINT `fk_districts_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `cb_db`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os bairros.';


-- -----------------------------------------------------
-- Table `cb_db`.`locals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`locals` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`locals` (
  `id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar o indentificar único dos locais.',
  `districts_id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de bairros em locais.',
  `name` VARCHAR(30) NOT NULL COMMENT 'Campo destinado a armazenar os nomes dos locais.',
  `area` DECIMAL(7,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar as áreas dos locais(m²).',
  `height` DECIMAL(4,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar as alturas dos locais(m).',
  `cep` INT(8) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os CEPs dos locais.',
  `street` VARCHAR(40) NOT NULL COMMENT 'Campo destinado a armazenar os logradouros dos locais.',
  `number` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os números dos locais.',
  `rent_value` DECIMAL(6,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os valores para aluguel dos locais.',
  `description` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar as descrições dos locais.',
  `complement` VARCHAR(20) NULL COMMENT 'Campo destinado a armazenar os complementos dos locais.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_locals_districts1_idx` (`districts_id` ASC)  COMMENT '',
  CONSTRAINT `fk_locals_districts1`
    FOREIGN KEY (`districts_id`)
    REFERENCES `cb_db`.`districts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os locais pertencentes a empresa destinados a eventos.';


-- -----------------------------------------------------
-- Table `cb_db`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`clients` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`clients` (
  `id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos dos clientes.',
  `districts_id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de bairros em clientes.',
  `name` VARCHAR(45) NOT NULL COMMENT 'Campo destinado a armazenar os nomes dos clientes.',
  `email` VARCHAR(70) NOT NULL COMMENT 'Campo destinado a armazenar os e-mails dos clientes.',
  `phone` BIGINT(15) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os telefones dos clientes.',
  `birthdate` DATE NOT NULL COMMENT 'Campo destinado a armazenar as datas de nascimento dos clientes.',
  `rg` VARCHAR(10) NOT NULL COMMENT 'Campo destinado a armazenar o RG dos clientes.',
  `cpf` BIGINT(11) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o CPF dos clientes.',
  `cep` INT(8) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o CEP do endereço dos clientes.',
  `street` VARCHAR(40) NOT NULL COMMENT 'Campo destinado a armazenar o Logradouro do endereço dos clientes.',
  `number` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o Número da casa dos clientes.',
  `complement` VARCHAR(20) NULL COMMENT 'Campo destinado a armazenar o Complemento do endereço dos clientes.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_clients_districts1_idx` (`districts_id` ASC)  COMMENT '',
  CONSTRAINT `fk_clients_districts1`
    FOREIGN KEY (`districts_id`)
    REFERENCES `cb_db`.`districts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os clientes.';


-- -----------------------------------------------------
-- Table `cb_db`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`events` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`events` (
  `id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos dos eventos.',
  `clients_id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de clientes em eventos.',
  `districts_id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de bairros em eventos.',
  `locals_id` TINYINT(2) UNSIGNED ZEROFILL NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de locais em eventos.',
  `local` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o tipo de local em que será realizado o evento.\nPossibilidades: Locais da Empresa\n                        Local do Cliente\n                        Outros Locais \n',
  `cep` INT(8) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os CEPs dos locais nos quais serão realizados os eventos. Caso seja escolhido um local da empresa ou local do cliente, o campo é preenchido automaticamente, caso seja escolhido outros locais é necessário preencher este campo.',
  `street` VARCHAR(40) NOT NULL COMMENT 'Campo destinado a armazenar os logradouros dos locais nos quais serão realizados os eventos. Caso seja escolhido um local da empresa ou local do cliente, o campo é preenchido automaticamente, caso seja escolhido outros locais é necessário preencher este campo.',
  `number` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar os números dos locais nos quais serão realizados os eventos. Caso seja escolhido um local da empresa ou local do cliente, o campo é preenchido automaticamente, caso seja escolhido outros locais é necessário preencher este campo.',
  `event_date` DATE NOT NULL COMMENT 'Campo destinado a armazenar as datas de realização dos eventos.',
  `event_time` TIME NOT NULL COMMENT 'Campo destinado a armazenar os horários de realização dos eventos.',
  `discount` DECIMAL(5,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o desconto que será dado em cima do valor atual do evento.',
  `entry_fee` DECIMAL(5,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a taxa de entrada do pagamento do evento.',
  `status` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o status do evento.\nTipos:0 - Pendente\n          1 - Confirmado\n          2 - Realizado',
  `rent_value` DECIMAL(6,2) UNSIGNED NULL COMMENT 'Campo destinado a armazenar o valor de aluguel para o local do evento.',
  `delivery_fee` DECIMAL(4,2) UNSIGNED NULL COMMENT 'Campo destinado a armazenar a taxa de entrega do evento.',
  `complement` VARCHAR(20) NULL COMMENT 'Campo destinado a armazenar o complemento do local no qual será realizado o evento. Caso seja escolhido um local da empresa ou local do cliente, o campo é preenchido automaticamente, caso seja escolhido outros locais é necessário preencher este campo.',
  `observation` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar uma observação sobre o evento.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_events_clients1_idx` (`clients_id` ASC)  COMMENT '',
  INDEX `fk_events_locals1_idx` (`locals_id` ASC)  COMMENT '',
  INDEX `fk_events_districts1_idx` (`districts_id` ASC)  COMMENT '',
  CONSTRAINT `fk_events_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `cb_db`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_events_locals1`
    FOREIGN KEY (`locals_id`)
    REFERENCES `cb_db`.`locals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_events_districts1`
    FOREIGN KEY (`districts_id`)
    REFERENCES `cb_db`.`districts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os eventos.';


-- -----------------------------------------------------
-- Table `cb_db`.`delivery_route`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`delivery_route` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`delivery_route` (
  `users_id` TINYINT(3) ZEROFILL UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de usuários em rotas de entrega.',
  `events_id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de eventos na rotade entrega.',
  `order_number` TINYINT(2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a ordem dos eventos a serem entregues nas rotas de entrega.',
  PRIMARY KEY (`users_id`, `events_id`)  COMMENT '',
  INDEX `fk_delivery_route_events1_idx` (`events_id` ASC)  COMMENT '',
  CONSTRAINT `fk_delivery_route_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cb_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_route_events1`
    FOREIGN KEY (`events_id`)
    REFERENCES `cb_db`.`events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar as rotas de entrega.';


-- -----------------------------------------------------
-- Table `cb_db`.`items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`items` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`items` (
  `id` SMALLINT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos dos itens',
  `name` VARCHAR(40) NOT NULL COMMENT 'Campo destinado a armazenar os nomes dos itens.',
  `quantity` TINYINT(3) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a quantidade existente de cada item.',
  `value` DECIMAL(6,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o valor unitário de cada item.',
  `description` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar as descrições dos itens.',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os itens.';


-- -----------------------------------------------------
-- Table `cb_db`.`kits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`kits` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`kits` (
  `id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos dos kits.',
  `name` VARCHAR(20) NOT NULL COMMENT 'Campo destinado a armazenar os nomes dos kits.',
  `discount` DECIMAL(5,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o desconto em cima do valor atual do kit.',
  `description` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar as descrições dos kits.',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os Kits.';


-- -----------------------------------------------------
-- Table `cb_db`.`canceled_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`canceled_events` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`canceled_events` (
  `id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos dos eventos cancelados.',
  `clients_id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de clientes em eventos cancelados.',
  `locals_id` TINYINT(2) UNSIGNED ZEROFILL NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de locais em eventos cancelados.',
  `event_date` DATE NOT NULL COMMENT 'Campo destinado a armazenar a data que o evento seria realizado.',
  `local` TINYINT(1) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o tipo de local no qual seria realizado o evento cancelado.\nTipos: Locais da Empresa\n           Local do Cliente\n           Outro Locais\n',
  `reason` CHAR(2) NOT NULL COMMENT 'Campo destinado a armazenar o motivo do cancelamento do evento.',
  `repaymant` DECIMAL(6,2) UNSIGNED NULL COMMENT 'Campo destinado a armazenar o valor do ressarcimento pago ao cliente pelo cancelamento do evento.',
  `forfeit` DECIMAL(6,2) UNSIGNED NULL COMMENT 'Campo destinado a armazenar o valor da multa paga pelo cliente pelo cancelamento do evento.',
  `comment` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar os comentários relacionados ao cancelamento do evento.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_canceled_events_locals1_idx` (`locals_id` ASC)  COMMENT '',
  INDEX `fk_canceled_events_clients1_idx` (`clients_id` ASC)  COMMENT '',
  CONSTRAINT `fk_canceled_events_locals1`
    FOREIGN KEY (`locals_id`)
    REFERENCES `cb_db`.`locals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canceled_events_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `cb_db`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os eventos cancelados.';


-- -----------------------------------------------------
-- Table `cb_db`.`expenses_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`expenses_types` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`expenses_types` (
  `id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar os indentificadores únicos dos tipos de despesas.',
  `name` VARCHAR(25) NOT NULL COMMENT 'Campo destinado a armazenar os nomes das despesas.',
  `comment` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar os comentários relacionados aos tipos de despesas.',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os tipos de despesas.';


-- -----------------------------------------------------
-- Table `cb_db`.`expenses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`expenses` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`expenses` (
  `id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Campo destinado a armazenar o indentificador único de despesas.',
  `expenses_types_id` TINYINT(2) UNSIGNED ZEROFILL NOT NULL COMMENT '',
  `date` DATE NOT NULL COMMENT 'Campo destinado a armazenar a data de despesa.',
  `value` DECIMAL(7,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o valor da despesa.',
  `description` VARCHAR(255) NULL COMMENT 'Campo destinado a armazenar a descrição da despesa.',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_expenses_expenses_types1_idx` (`expenses_types_id` ASC)  COMMENT '',
  CONSTRAINT `fk_expenses_expenses_types1`
    FOREIGN KEY (`expenses_types_id`)
    REFERENCES `cb_db`.`expenses_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar as despesas.';


-- -----------------------------------------------------
-- Table `cb_db`.`kits_has_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`kits_has_items` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`kits_has_items` (
  `kits_id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de Kits na entidade associativa.',
  `items_id` SMALLINT(4) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de itens na entidade associativa.',
  `item_quantity` TINYINT(2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a quntidade de itens em cada Kit.',
  `actual_value` DECIMAL(6,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o valor atual do kit.',
  PRIMARY KEY (`kits_id`, `items_id`)  COMMENT '',
  INDEX `fk_kits_has_items_items1_idx` (`items_id` ASC)  COMMENT '',
  INDEX `fk_kits_has_items_kits_idx` (`kits_id` ASC)  COMMENT '',
  CONSTRAINT `fk_kits_has_items_kits`
    FOREIGN KEY (`kits_id`)
    REFERENCES `cb_db`.`kits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kits_has_items_items1`
    FOREIGN KEY (`items_id`)
    REFERENCES `cb_db`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os itens presentes em cada kit.';


-- -----------------------------------------------------
-- Table `cb_db`.`events_has_kits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`events_has_kits` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`events_has_kits` (
  `events_id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de eventos na entidade associativa.',
  `kits_id` TINYINT(3) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de kits na entidade associativa.',
  `kit_quantity` TINYINT(2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a quantidade de kits no evento.',
  `actual_value` DECIMAL(6,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o valor atual de todos os kits dentro do eventos.',
  PRIMARY KEY (`events_id`, `kits_id`)  COMMENT '',
  INDEX `fk_events_has_kits_kits1_idx` (`kits_id` ASC)  COMMENT '',
  INDEX `fk_events_has_kits_events1_idx` (`events_id` ASC)  COMMENT '',
  CONSTRAINT `fk_events_has_kits_events1`
    FOREIGN KEY (`events_id`)
    REFERENCES `cb_db`.`events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_events_has_kits_kits1`
    FOREIGN KEY (`kits_id`)
    REFERENCES `cb_db`.`kits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cb_db`.`events_has_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cb_db`.`events_has_items` ;

CREATE TABLE IF NOT EXISTS `cb_db`.`events_has_items` (
  `events_id` SMALLINT(5) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de eventos na entidade associativa.',
  `items_id` SMALLINT(4) UNSIGNED ZEROFILL NOT NULL COMMENT 'Campo destinado a armazenar a chave estrangeira de itens na entidade associativa.',
  `item_quantity` TINYINT(2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar a quantidade de itens em cada evento.',
  `actual_value` DECIMAL(6,2) UNSIGNED NOT NULL COMMENT 'Campo destinado a armazenar o valor atual dos itens dentro do evento.',
  PRIMARY KEY (`events_id`, `items_id`)  COMMENT '',
  INDEX `fk_events_has_items_items1_idx` (`items_id` ASC)  COMMENT '',
  INDEX `fk_events_has_items_events1_idx` (`events_id` ASC)  COMMENT '',
  CONSTRAINT `fk_events_has_items_events1`
    FOREIGN KEY (`events_id`)
    REFERENCES `cb_db`.`events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_events_has_items_items1`
    FOREIGN KEY (`items_id`)
    REFERENCES `cb_db`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela destinada a armazenar os itens presentes em cada evento.';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
