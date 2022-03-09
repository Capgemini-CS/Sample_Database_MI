//----------------------------Create transaction----------------------------
//-------The transaction will add new information about an order to me and will delete a payment-------

START TRANSACTION;
	INSERT INTO orderdetails (`orderNumber`,`productCode`,`quantityOrdered`,`priceEach`,`orderLineNumber`) VALUES (10162,'S10_4757',21,'80.14',2);
	DELETE FROM payments WHERE customerNumber = 415;
COMMIT;