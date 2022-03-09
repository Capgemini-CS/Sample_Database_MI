//---------------------------------------- SELECT FOR EACH TABLE ----------------------------------------


select * from customers;
select * from offices;
select * from employees;
select * from orderdetails;
select * from orders;
select * from payments;
select * from products;
select * from productlines;


//-----------------------Show how many products are in the products table----------------------------------


SELECT COUNT(productCode) as NumberfOfProducts FROM PRODUCTS;


//------------------------------ Select the highest purchase price ----------------------------------------


SELECT MAX(buyprice) as HighestPrices FROM PRODUCTS;


//----------------------------Show what order each customer has-----------------------------


SELECT o.orderNumber as Orders_number, c.customerNumber as Customer_number
FROM orders o
LEFT JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY o.orderDate asc;


//----------------------------------- Show how many employees are in the first office -----------------------------------


SELECT o.officeCode as Office_Code , o.addressLine1 as Address_Office, COUNT(e.employeeNumber) as Number_Of_Employee
FROM employees e
right JOIN offices o ON e.officeCode = o.officeCode
ORDER BY o.addressLine1 ASC;


//---------------------------------------- Shows the value of each order ----------------------------------------


SELECT (o.priceEach * o.quantityOrdered) as Value_Of_Order, o.orderNumber as Order_Number, orders.orderDate as ORDER_DATE
FROM orders orders
RIGHT JOIN orderdetails o ON o.orderNumber = orders.orderNumber
ORDER BY orders.orderDate ASC;


//------------------- Shows the number of products and the average sales with the average quantity. ------------------


SELECT Count(productName) as NUMBER_OF_PRODUCTS, AVG(buyPrice) as AVERAGE_PRICE, AVG(quantityInStock) as AVERAGE_QUANTITY
FROM products;
//---------------------------------------- Show which payments start with H ----------------------------------------


SELECT * FROM payments
WHERE checkNumber LIKE 'H%';


//------------------------------ Shows which customers have in their name at the end -ing ----------------------------


SELECT * FROM customers
WHERE contactLastName LIKE '_ing';


//----------------- Shows which customers are from France and have a credit limit of over 50,000 ------------------------


SELECT * FROM customers
WHERE country = 'France' AND creditLimit >50000.00
ORDER BY creditLimit DESC;


//--------- It shows the order number, the quantity in stock and the ordered one, the product number and the delivery date. ----------------


SELECT od.orderNumber as ORDER_NUMBER, od.quantityOrdered as QUANTITY_ORDERED,
p.quantityInStock as QUANTITY_IN_STOCK, p.productName as PRODUCT_NAME ,
o.requiredDate as REQUIRED_DATE, o.shippedDate as SHIPPED_DATE
FROM orderdetails od
INNER JOIN products p ON od.productCode = p.productCode
INNER JOIN orders o ON o.orderNumber = od.orderNumber;


//------------------------------- Select from ViewTable when the quantity in stock is 7933 -------------------------------


select * from viewProductOrdered WHERE QUANTITY_IN_STOCK = 7933;


//---------------------- Shows the status of each order depending on whether it was shipped or not. -----------------------


SELECT orderNumber as ORDER_NUMBER , orderDate as ORDER_DATE , requiredDate as REQUIRED_DATE , shippedDate as SHIPPED_DATE,
CASE
WHEN shippedDate < requiredDate THEN 'Your order has been delivered.'
WHEN shippedDate > requiredDate THEN 'Your order has not arrived yet.'
ELSE 'Your order has not yet been registered.'
END OrderStatus
FROM orders;