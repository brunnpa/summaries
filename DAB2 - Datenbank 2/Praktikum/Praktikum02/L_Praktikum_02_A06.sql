---------------------------------------------------------------------
-- L_Praktikum_02_A06.sql: Funktion zur Filterung von Tupeln
---------------------------------------------------------------------

USE DAB2Query
GO

-- Löschen, falls vorhanden
IF OBJECT_ID('Sales.QtyRange','IF') IS NOT NULL
  DROP FUNCTION Sales.QtyRange;
GO

-- Erstellen
CREATE FUNCTION Sales.QtyRange(@qtylow AS INTEGER, @qtyhigh AS INTEGER)
RETURNS TABLE AS RETURN
(
  SELECT 
    *
  FROM 
    Sales.OrderDetails
  WHERE 
    qty BETWEEN @qtylow AND @qtyhigh
);
GO

-- Ausführen
SELECT 
  * 
FROM 
  Sales.QtyRange(100,200)