---------------------------------------------------------------------
-- L_Praktikum_02_A02.sql: Abfrage mit Variablen
---------------------------------------------------------------------

USE DAB2Query
GO

DECLARE @custid        AS INTEGER
DECLARE @orderdatefrom AS DATE
DECLARE @orderdateto   AS DATE

SET @custid        = 37;
SET @orderdatefrom = '2014-04-01';
SET @orderdateto   = '2014-06-30';

SELECT 
  *
FROM 
  Sales.Orders
WHERE 
  custid = @custid
  AND orderdate >= @orderdatefrom
  AND orderdate <= @orderdateto;
GO