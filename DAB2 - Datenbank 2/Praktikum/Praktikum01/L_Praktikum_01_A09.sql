---------------------------------------------------------------------
-- L_Praktikum_01_A09.sql: Queries
---------------------------------------------------------------------

USE DAB2Query
GO

-- Aufgabe 9a

SELECT 
  SUM(Freight) AS Frachtkosten
FROM 
  Sales.Orders 
JOIN 
  Sales.Customers
ON 
  Sales.Orders.custid = Sales.Customers.custid
WHERE 
  Sales.Customers.country = 'Germany';

-- Aufgabe 9b

SELECT DISTINCT
  Sales.Shippers.phone
FROM
  Sales.Shippers
JOIN
  Sales.Orders
ON
  Sales.Shippers.shipperid = Sales.Orders.shipperid
JOIN
  Sales.Customers
ON 
  Sales.Orders.custid = Sales.Customers.custid
WHERE
  Sales.Customers.country = 'Mexico' AND 
  Sales.Customers.postalcode = '10077' AND
  YEAR(Sales.Orders.orderdate) = 2014;

