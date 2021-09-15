CREATE DATABASE `packing_manager`;

USE `packing_manager`;

CREATE TABLE IF NOT EXISTS `packing_manager`.`fare_type` (
  `id` INT NOT NULL,
  `type` ENUM('SINGLE_PASS_FARE', 'MONTH_FARE') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type` (`type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`fare` (
  `id` INT NOT NULL,
  `price` DOUBLE NOT NULL DEFAULT '0',
  `fare_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fare_fare_type1_idx` (`fare_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_fare_fare_type1`
    FOREIGN KEY (`fare_type_id`)
    REFERENCES `packing_manager`.`fare_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`position` (
  `id` INT NOT NULL,
  `type` ENUM('ADMIN', 'CAR_KEEPER', 'VALET') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type` (`type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`staff` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(13) NULL DEFAULT NULL,
  `user_name` VARCHAR(20) NULL DEFAULT NULL,
  `password` VARCHAR(20) NULL DEFAULT NULL,
  `salary` DOUBLE NOT NULL DEFAULT '0',
  `position_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_staff_position_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_position`
    FOREIGN KEY (`position_id`)
    REFERENCES `packing_manager`.`position` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`ticket_status` (
  `id` INT NOT NULL,
  `type` ENUM('AVAILABLE', 'UNAVAILABLE') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type` (`type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`ticket_type` (
  `id` INT NOT NULL,
  `type` ENUM('SINGLE_PASS', 'MONTHLY') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type` (`type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`customer` (
  `id` VARCHAR(9) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`ticket` (
  `id` INT NOT NULL,
  `start_date` DATETIME NULL DEFAULT NULL,
  `end_date` DATETIME NULL DEFAULT NULL,
  `price` DOUBLE NOT NULL DEFAULT '0',
  `ticket_status_id` INT NOT NULL,
  `ticket_type_id` INT NOT NULL,
  `customer_id` VARCHAR(9) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_ticket_status1_idx` (`ticket_status_id` ASC) VISIBLE,
  INDEX `fk_ticket_ticket_type1_idx` (`ticket_type_id` ASC) VISIBLE,
  INDEX `fk_ticket_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_ticket_status1`
    FOREIGN KEY (`ticket_status_id`)
    REFERENCES `packing_manager`.`ticket_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_ticket_type1`
    FOREIGN KEY (`ticket_type_id`)
    REFERENCES `packing_manager`.`ticket_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `packing_manager`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`trouble` (
  `id` INT NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `date` DATETIME NULL DEFAULT NULL,
  `into_money` DOUBLE NOT NULL DEFAULT '0',
  `solutions` VARCHAR(45) NULL DEFAULT NULL,
  `ticket_id` INT NOT NULL,
  `customer_id` VARCHAR(9) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trouble_ticket1_idx` (`ticket_id` ASC) VISIBLE,
  INDEX `fk_trouble_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_trouble_ticket1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `packing_manager`.`ticket` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trouble_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `packing_manager`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `packing_manager`.`gross_profit` (
  `id` INT NOT NULL,
  `ticket_id` INT NOT NULL,
  `type_ticket_id` INT NOT NULL,
  `status_id` INT NULL DEFAULT NULL,
  `start_date` DATETIME NULL DEFAULT NULL,
  `end_date` DATETIME NULL DEFAULT NULL,
  `customer_id` VARCHAR(45) NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;