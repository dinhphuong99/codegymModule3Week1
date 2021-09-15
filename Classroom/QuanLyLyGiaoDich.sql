CREATE DATABASE `quan_ly_giao_dich_ngan_hang`;
USE `quan_ly_giao_dich_ngan_hang`;

CREATE TABLE `customers`(
id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(45),
date_of_birth DATE NOT NULL,
email VARCHAR(45),
blank FLOAT CHECK (blank >= 0)
);

CREATE TABLE `transaction`(
id INT AUTO_INCREMENT PRIMARY KEY,
amount DOUBLE NOT NULL,
customer_id INT NOT NULL,
create_date DATETIME,
method VARCHAR(50),
FOREIGN KEY (customer_id) REFERENCES customers(id)
);

SELECT * FROM quan_ly_giao_dich_ngan_hang.transaction;

INSERT INTO transaction VALUE(null,10000,2, SYSDATE(),0);
UPDATE customers SET blank = blank + 10000 WHERE id =2;

select * FROM customers;