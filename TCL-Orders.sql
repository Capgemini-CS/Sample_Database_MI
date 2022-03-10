//----------------------------Create transaction----------------------------
//-------The transaction will add new information about an order to me and will delete a payment-------

START TRANSACTION;
	INSERT INTO orderdetails (`orderNumber`,`productCode`,`quantityOrdered`,`priceEach`,`orderLineNumber`) VALUES (10162,'S10_4757',21,'80.14',2);
	DELETE FROM payments WHERE customerNumber = 415;
COMMIT;


//---------------- Transaction that updates the missing comments with a message and displays the new table -------------
START TRANSACTION;
  UPDATE orders SET comments = 'There are no comments' WHERE comments is NULL;
  UPDATE customers SET customers.addressLine2 = 'There is no other address' 	where addressLine2 is NULL;
  SELECT orderNumber, comments FROM orders;
  SELECT customerNumber, addressLine2 FROM customers;
COMMIT;
