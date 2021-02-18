---------------------------------------------------------------------
-- L_Praktikum_02_A07.sql: Fibonacci rekursiv
---------------------------------------------------------------------

USE DAB2Query
GO

-- Löschen, falls vorhanden
IF OBJECT_ID('dbo.FibonacciRec','FN') IS NOT NULL
  DROP FUNCTION dbo.FibonacciRec
GO

-- Erstellen
CREATE FUNCTION dbo.FibonacciRec(@n AS INTEGER)
RETURNS INTEGER 
AS BEGIN
  IF @n <= 2 RETURN 1

  RETURN dbo.FibonacciRec(@n - 1) + dbo.FibonacciRec(@n - 2)
END
GO

-- Ausführen
SELECT dbo.FibonacciRec(1)
SELECT dbo.FibonacciRec(2)
SELECT dbo.FibonacciRec(3)
SELECT dbo.FibonacciRec(4)
SELECT dbo.FibonacciRec(5)
SELECT dbo.FibonacciRec(6)
SELECT dbo.FibonacciRec(7)
SELECT dbo.FibonacciRec(8)

