CREATE DATABASE `demo`;

USE `demo`;

CREATE TABLE `products` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `productCode` varchar(10) NOT NULL,
  `productName` varchar(45) NOT NULL,
  `productPrice` double NOT NULL DEFAULT '0',
  `productAmount` double NOT NULL DEFAULT '0',
  `productDescription` varchar(45) NOT NULL,
  `productStatus` int NOT NULL,
  PRIMARY KEY (`Id`)
);

INSERT INTO `demo`.`products` (`Id`, `productCode`, 
`productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES ('1', '2435', 'đường', '10000', '12000', 'an toàn', '1');

INSERT INTO `demo`.`products` (`Id`, `productCode`, 
`productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES ('2', '3821', 'sữa', '15000', '18000', 'sắp hết hạn', '2');

EXPLAIN SELECT * FROM products;

CREATE UNIQUE INDEX product_code
ON products (productCode);

CREATE UNIQUE INDEX name_and_price
ON products (productName,productPrice);

EXPLAIN SELECT * FROM products;

CREATE VIEW product_information
AS SELECT productCode, productName, productPrice, productAmount, productDescription, productStatus
FROM products;

SELECT * FROM product_information;

ALTER VIEW product_information
AS SELECT productCode, productName, productPrice, productAmount, productStatus
FROM products;

DROP VIEW product_information;

DELIMITER //
CREATE PROCEDURE findAllProduct()
BEGIN
  SELECT * FROM products;
END //

DELIMITER ;

CALL findAllProduct;

DELIMITER //
CREATE PROCEDURE addAProduct(IN Id INT, IN productCode VARCHAR(10), 
IN productName VARCHAR(45), IN productPrice DOUBLE, IN productAmount DOUBLE,
IN productDescription VARCHAR(45), IN productStatus INT)
BEGIN
  INSERT INTO products (Id, productCode, productName, productPrice, productAmount, productDescription, productStatus)
  VALUES (Id, productCode, productName, productPrice, productAmount, productDescription, productStatus);
END //

DELIMITER ;

CALL addAProduct('3', '4135', 'kẹo', '14000', '16000', 'an toàn', '1');

DELIMITER //
CREATE PROCEDURE editAProduct(IN Id INT, IN productCode VARCHAR(10), 
IN productName VARCHAR(45), IN productPrice DOUBLE, IN productAmount DOUBLE,
IN productDescription VARCHAR(45), IN productStatus INT)
BEGIN
  UPDATE products SET `productCode` = productCode, `productName` = productName, 
  `productPrice` = productPrice, `productAmount` = productAmount, 
  `productDescription` = productDescription, `productStatus` = productStatus
  WHERE products.Id = Id;
END //

DELIMITER ;

CALL editAProduct('3', '3135', 'kẹo', '15000', '18000', 'an toàn', '2');

DELIMITER //
CREATE PROCEDURE deleteAProduct(IN Id INT)
BEGIN
  DELETE FROM products 
  WHERE products.Id = Id;
END //

DELIMITER ;

CALL deleteAProduct('3');

SELECT * FROM products;