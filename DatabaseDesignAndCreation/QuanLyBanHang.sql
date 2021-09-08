CREATE DATABASE `sale_manager`;
USE `sale_manager`;

CREATE TABLE `customer`(
`cID` INT NOT NULL,
`cName` NVARCHAR(45),
`cAge` INT,
PRIMARY KEY (`cID`)
);

CREATE TABLE `order`(
`oID` INT NOT NULL,
`cID` INT NOT NULL,
`oDate` DATE,
`oTotalPrice` DECIMAL(10,2),
PRIMARY KEY (`oID`),
FOREIGN KEY (`cID`) REFERENCES `customer` (`cID`)
);

CREATE TABLE `product`(
`pID` INT NOT NULL,
`pName` NVARCHAR(45),
`pPrice` NVARCHAR(45),
PRIMARY KEY (`pID`)
);

CREATE TABLE `order_detail`(
`oID` INT NOT NULL,
`pID` INT NOT NULL,
`odQTY` INT,
PRIMARY KEY(`oID`,`pID`),
FOREIGN KEY (`oID`) REFERENCES `order` (`oID`),
FOREIGN KEY (`pID`) REFERENCES `product` (`pID`)
);