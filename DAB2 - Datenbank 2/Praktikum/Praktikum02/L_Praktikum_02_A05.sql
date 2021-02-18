---------------------------------------------------------------------
-- L_Praktikum_02_A05.sql: Funktion zur Berechnung von Preis*Quantität
---------------------------------------------------------------------

USE DAB2Query
GO

-- Löschen, falls vorhanden
IF OBJECT_ID('Sales.Value','FN') IS NOT NULL
  DROP FUNCTION Sales.Value;
GO

-- Erstellen
CREATE FUNCTION Sales.Value(@price AS MONEY,@qty AS INTEGER)
RETURNS MONEY
AS BEGIN
  RETURN @price * @qty
END;
GO

-- Ausführen
SELECT 
  orderid, unitprice, qty, Sales.Value(unitprice, qty) AS value
FROM 
  Sales.OrderDetails
WHERE 
  Sales.Value(unitprice, qty) > 10000;