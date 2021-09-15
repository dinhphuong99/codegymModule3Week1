USE `banking_transaction_management`;

DELIMITER $$
#DROP PROCEDURE IF EXISTS `pr_deprosit`;
CREATE PROCEDURE pr_deprosit(IN id INT, IN money DOUBLE)
BEGIN 
	DECLARE balance1 DOUBLE ;
	SET balance1 = (SELECT c.balance FROM customers AS c WHERE c.id = id);

	IF (money > 0) THEN  
	SET balance1 = balance1 + money ; 

	UPDATE customers
	SET balance = balance1 WHERE customers.id = id;

	INSERT INTO withdraws(customer_id , amount, create_date)
	VALUES(id, money, sysdate());
	END IF;
END;

DELIMITER $$
#DROP PROCEDURE IF EXISTS `pr_deprosit`;
CREATE PROCEDURE pr_withdraws(IN id INT, IN money DOUBLE)
BEGIN 
	DECLARE balance1 DOUBLE ;
	SET balance1 = (SELECT c.balance FROM customers c WHERE c.id = id);

	IF (balance1 >= money AND balance1 > 0) THEN  
	SET balance1 = balance1 - money; 

	UPDATE customers
	SET balance = balance1 WHERE customers.id = id;

	INSERT INTO withdraws(customer_id , amount, create_date)
	VALUES(id,money,sysdate());
	END IF;
END;

DELIMITER $$
#DROP PROCEDURE IF EXISTS `pr_transfers`;
CREATE PROCEDURE pr_transfers(IN sender_id  INT, IN receiver_id  INT, IN money DOUBLE)
BEGIN 
	DECLARE deposits_balance DOUBLE;
	DECLARE withdraws_balance DOUBLE;
	SET deposits_balance = ( SELECT c.balance FROM customers c WHERE c.id = receiver_id);
	SET withdraws_balance = (SELECT c.balance FROM customers c where c.id = sender_id);

	IF (withdraws_balance >= (money + money*10/100) AND receiver_id != sender_id) THEN
	SET withdraws_balance = withdraws_balance - (money + money*10/100);
    SET deposits_balance = deposits_balance + money;
	
	UPDATE customers
	SET balance = deposits_balance WHERE customers.id = receiver_id;
	UPDATE customers
	SET balance = withdraws_balance WHERE customers.id = sender_id;

	INSERT INTO transfers(sender_id, receiver_id, amount, fee, created_date)
    VALUES(sender_id, receiver_id, money, money*10/100, sysdate());

	END IF;
END;

/*INSERT INTO `banking_transaction_management`.`customers` (`id`, `full_name`, `dob`, `email`, `balance`) VALUES ('1', 'kh_1', '2000-12-13', 'kh_1@gmail.com', '10000');
INSERT INTO `banking_transaction_management`.`customers` (`id`, `full_name`, `dob`, `email`, `balance`) VALUES ('2', 'kh_2', '1999-12-23', 'kh_2@gmail.com', '20000');*/

CALL pr_deprosit (1, 1000);
CALL pr_withdraws(1, 2000);
CALL pr_transfers(1, 2, 2000);

 CREATE VIEW historyTransaction AS
 SELECT sender_id,
 (SELECT full_name FROM customers WHERE id = sender_id) AS senderName, 
 receiver_id, 
 (SELECT full_name FROM customers WHERE id = receiver_id) AS receiverName, 
 amount, fee
    FROM transfers;