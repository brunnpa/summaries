---------------------------------------------------------------------
-- L_Praktikum_01_A10.sql: Reihenfolge der Abarbeitung
---------------------------------------------------------------------

USE DAB2Query
GO

SELECT
  custid AS CustomerID, YEAR(orderdate) AS OrderYear
FROM
  Sales.Orders
WHERE
  OrderYear = 2014;

-- Korrekt:
SELECT
  custid AS CustomerID, YEAR(orderdate) AS OrderYear
FROM
  Sales.Orders
WHERE
  YEAR(orderdate) = 2014;