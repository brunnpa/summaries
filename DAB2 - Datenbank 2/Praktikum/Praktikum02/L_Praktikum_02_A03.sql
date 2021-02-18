---------------------------------------------------------------------
-- L_Praktikum_02_A03.sql: Abfrage als gespeicherte Prozedur
---------------------------------------------------------------------

USE DAB2Query
GO

-- Löschen, falls vorhanden
IF OBJECT_ID('Sales.GetOrders','P') IS NOT NULL
  DROP PROCEDURE Sales.GetOrders;
GO

-- Erstellen
CREATE PROCEDURE Sales.GetOrders
  @custid AS INTEGER,
  @orderdatefrom AS DATE = '1900-01-01', -- Defaultwert, wenn kein Parameterwert geliefert wird
  @orderdateto AS DATE   = '9999-12-31'  -- Defaultwert, wenn kein Parameterwert geliefert wird
AS
BEGIN
  SET NOCOUNT ON; -- Unterdrücken der Angabe der betroffenen Zeilen

  SELECT 
    *
  FROM 
    Sales.Orders
  WHERE 
    custid = @custid
    AND orderdate >= @orderdatefrom
    AND orderdate < @orderdateto;

  RETURN;
END
GO

-- Test 

EXECUTE Sales.GetOrders 37, '2014-04-01', '2014-07-01'

EXECUTE Sales.GetOrders 37

EXECUTE Sales.GetOrders
