CREATE DATABASE `banking_transaction_management`;
USE `banking_transaction_management`;

CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(45) NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `balance` double DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `customer_chk_1` CHECK ((`balance` >= 0))
);

CREATE TABLE `deposits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_date` datetime DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `deposits_chk_1` CHECK ((`amount` > 0))
);

CREATE TABLE IF NOT EXISTS `banking_transaction_management`.`transfers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_date` DATETIME NOT NULL,
  `amount` DOUBLE NOT NULL DEFAULT '0',
  `fee` DOUBLE NOT NULL,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`sender_id`)
    REFERENCES `banking_transaction_management`.`customers` (`id`),
    FOREIGN KEY (`receiver_id`)
    REFERENCES `banking_transaction_management`.`customers` (`id`));

CREATE TABLE `withdraws` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL DEFAULT '0' CHECK(`amount` > 0),
  `create_date` datetime DEFAULT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_withdraws_customer1_idx` (`customer_id`),
  CONSTRAINT `fk_withdraws_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
);