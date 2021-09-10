USE `sale_manager`;

INSERT INTO customer (cID, cName , cAge) VALUES (1,'Minh Quan',10);
INSERT INTO customer (cID, cName , cAge) VALUES (2,'Ngoc Oanh',20);
INSERT INTO customer (cID, cName , cAge) VALUES (3,'Hong Ha',50);

INSERT INTO `order` (oID, cID , oDate, oTotalPrice) VALUES (1,1,'2006-03-21', Null);
INSERT INTO `order` (oID, cID , oDate, oTotalPrice) VALUES (2,2,'2006-03-23', Null);
INSERT INTO `order` (oID, cID , oDate, oTotalPrice) VALUES (3,1,'2006-03-16', Null);

UPDATE `order` SET oDate = '2006-03-21' WHERE oID = 1;
UPDATE `order` SET oDate = '2006-03-23' WHERE oID = 2;
UPDATE `order` SET oDate = '2006-03-16' WHERE oID = 3;

INSERT INTO `product` (pID, pName, pPrice) VALUES (1,'May Giat',3);
INSERT INTO `product` (pID, pName, pPrice) VALUES (2,'Tu Lanh',5);
INSERT INTO `product` (pID, pName, pPrice) VALUES (3,'Dieu Hoa',7);
INSERT INTO `product` (pID, pName, pPrice) VALUES (4,'Quat',1);
INSERT INTO `product` (pID, pName, pPrice) VALUES (5,'Bep Dien',2);

INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (1, 1, 3);
INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (1, 3, 7);
INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (1, 4, 2);
INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (2, 1, 1);
INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (3, 1, 8);
INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (2, 5, 4);
INSERT INTO `order_detail` (oID, pID, odQTY) VALUES (2, 3, 3);

SELECT oID, cID , oTotalPrice FROM `order`;

SELECT * FROM `customer` WHERE EXISTS (SELECT cID FROM `order` WHERE cID = `customer`.cID);

SELECT * FROM `product` WHERE EXISTS (SELECT pID FROM `order_detail` WHERE pID = `product`.pID);

SELECT * FROM `customer` WHERE NOT EXISTS (SELECT cID FROM `order` WHERE cID = `customer`.cID);

UPDATE `order` SET `order`.oTotalPrice = `order_detail`.odQTY*`product`.pPrice 
	WHERE `order_detail`.pID = `product`.pID AND `order_detail`.oID = `order`.oID;



SELECT  od.oID, od.oDate , oddt.odQTY*pr.pPrice AS Total FROM `order` AS od
INNER JOIN `order_detail`AS oddt 
ON od.oID = oddt.oID 
INNER JOIN `product` AS pr
ON pr.pID = oddt.pID 
    
    
    
    