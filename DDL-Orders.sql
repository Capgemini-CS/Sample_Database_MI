//----------------------------Create Table  customers----------------------------


CREATE TABLE `customers` (
  `customerNumber` int(11) NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int(11) DEFAULT NULL,
  `creditLimit` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`),
  KEY `salesRepEmployeeNumber` (`salesRepEmployeeNumber`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`salesRepEmployeeNumber`) REFERENCES `employees` (`employeeNumber`)
);


//----------------------------Create Table  offices----------------------------


CREATE TABLE `offices` (
`officeCode` varchar(10) NOT NULL,
`city` varchar(50) NOT NULL,
`phone` varchar(50) NOT NULL,
`addressLine1` varchar(50) NOT NULL,
`addressLine2` varchar(50) DEFAULT NULL,
`state` varchar(50) DEFAULT NULL,
`country` varchar(50) NOT NULL,
`postalCode` varchar(15) NOT NULL,
`territory` varchar(10) NOT NULL,
PRIMARY KEY (`officeCode`)
);


//----------------------------Create Table  employees----------------------------


CREATE TABLE `employees` (
`employeeNumber` int(11) NOT NULL,
`lastName` varchar(50) NOT NULL,
`firstName` varchar(50) NOT NULL,
`extension` varchar(10) NOT NULL,
`email` varchar(100) NOT NULL,
`officeCode` varchar(10) NOT NULL,
`reportsTo` int(11) DEFAULT NULL,
`jobTitle` varchar(50) NOT NULL,
PRIMARY KEY (`employeeNumber`),
KEY `reportsTo` (`reportsTo`),
KEY `officeCode` (`officeCode`),
CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`reportsTo`) REFERENCES `employees` (`employeeNumber`),
CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`officeCode`) REFERENCES `offices` (`officeCode`)
);


//----------------------------Create Table  orderdetails----------------------------


CREATE TABLE `orderdetails` (
  `orderNumber` int(11) NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityOrdered` int(11) NOT NULL,
  `priceEach` decimal(10,2) NOT NULL,
  `orderLineNumber` smallint(6) NOT NULL,
  PRIMARY KEY (`orderNumber`,`productCode`),
  KEY `productCode` (`productCode`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
);


//----------------------------Create Table  payments----------------------------


CREATE TABLE `payments` (
`customerNumber` int(11) NOT NULL,
`checkNumber` varchar(50) NOT NULL,
`paymentDate` date NOT NULL,
`amount` decimal(10,2) NOT NULL,
PRIMARY KEY (`customerNumber`,`checkNumber`),
CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
);


//----------------------------Create Table  orders----------------------------


CREATE TABLE `orders` (
`orderNumber` int(11) NOT NULL,
`orderDate` date NOT NULL,
`requiredDate` date NOT NULL,
`shippedDate` date DEFAULT NULL,
`status` varchar(15) NOT NULL,
`comments` text,
`customerNumber` int(11) NOT NULL,
PRIMARY KEY (`orderNumber`),
KEY `customerNumber` (`customerNumber`),
CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
);


//----------------------------Create Table  productlines----------------------------


CREATE TABLE `productlines` (
  `productLine` varchar(50) NOT NULL,
  `textDescription` varchar(4000) DEFAULT NULL,
  `htmlDescription` mediumtext,
  `image` mediumblob,
  PRIMARY KEY (`productLine`)
);


//----------------------------Create Table  products----------------------------


CREATE TABLE `products` (
`productCode` varchar(15) NOT NULL,
`productName` varchar(70) NOT NULL,
`productLine` varchar(50) NOT NULL,
`productScale` varchar(10) NOT NULL,
`productVendor` varchar(50) NOT NULL,
`productDescription` text NOT NULL,
`quantityInStock` int(6) NOT NULL,
`buyPrice` decimal(10,2) NOT NULL,
`MSRP` decimal(10,2) NOT NULL,
PRIMARY KEY (`productCode`),
KEY `productLine` (`productLine`),
CONSTRAINT `products_ibfk_1` FOREIGN KEY (`productLine`) REFERENCES `productlines` (`productLine`)
);



//----------------------------Create View Table  ViewProductOrdered----------------------------
//-------I created a view in which I selected the order, with the products in it and the delivery date-------
CREATE VIEW viewProductOrdered AS (SELECT od.orderNumber as ORDER_NUMBER, od.quantityOrdered as QUANTITY_ORDERED,
p.quantityInStock as QUANTITY_IN_STOCK, p.productName as PRODUCT_NAME ,
o.requiredDate as REQUIRED_DATE, o.shippedDate as SHIPPED_DATE
FROM orderdetails od
INNER JOIN products p ON od.productCode = p.productCode
INNER JOIN orders o ON o.orderNumber = od.orderNumber);


//------- View with order and products-------
CREATE VIEW orderedProducts AS (SELECT o.orderNumber,
  od.quantityOrdered, od.priceEach,
  (od.quantityOrdered * od.priceEach) as ORDER_vALUE
FROM orders o
  INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
  INNER JOIN products p ON p.productCode = od.productCode
ORDER BY 1);
