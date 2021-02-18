---------------------------------------------------------------------
-- L_Praktikum_02_A01.sql: Abfrage mit Literalen
---------------------------------------------------------------------

USE DAB2Query
GO

SELECT 
  *
FROM 
  Sales.Orders
WHERE 
  custid = 37
  AND orderdate >= '2014-04-01'
  AND orderdate <= '2014-06-30';
GO
