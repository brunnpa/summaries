---------------------------------------------------------------------
-- L_Praktikum_02_A04.sql: n-te Fibonacci-Zahl berechnen
---------------------------------------------------------------------

USE DAB2Query
GO

-- Löschen, falls vorhanden
IF OBJECT_ID('dbo.Fibonacci','P') IS NOT NULL
  DROP PROCEDURE dbo.Fibonacci;
GO

-- Erstellen
CREATE PROCEDURE dbo.Fibonacci
  @n AS INTEGER
AS
BEGIN
  DECLARE @f1 INTEGER
  DECLARE @f2 INTEGER
  DECLARE @f  INTEGER
  DECLARE @nr INTEGER

  IF @n <= 2
  BEGIN
    PRINT 1
    RETURN
  END

  SET @f1 = 1
  SET @f2 = 1

  SET @nr = 0

  WHILE @nr < @n - 2
  BEGIN
    SET @f  = @f1 + @f2
    SET @f2 = @f1
    SET @f1 = @f

    SET @nr = @nr + 1
  END   

  PRINT @f
END
GO

-- Test 

EXECUTE dbo.Fibonacci 1
EXECUTE dbo.Fibonacci 2
EXECUTE dbo.Fibonacci 3
EXECUTE dbo.Fibonacci 4
EXECUTE dbo.Fibonacci 5
EXECUTE dbo.Fibonacci 6
EXECUTE dbo.Fibonacci 7
EXECUTE dbo.Fibonacci 8