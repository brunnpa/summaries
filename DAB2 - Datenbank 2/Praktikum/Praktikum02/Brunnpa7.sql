--- Exercise 1 --- 
SELECT * FROM Sales.Orders WHERE custid =37 AND shippeddate > '2014-03-31' AND shippeddate < '2014-06-30';

--- Exercise 2 --- 
DECLARE @custid int
SET @custid = 37
SELECT * FROM Sales.Orders Where custid = @custid AND shippeddate > '2014-03-31' AND shippeddate < '2014-06-30';

--- Exercise 3 --- 
CREATE PROCEDURE Sales.SalesFromSecondQuarter
	@custid int,
	@dateFrom date,
	@dateTo date
AS
	SELECT *
	FROM Sales.Orders
	WHERE custid = @custid and shippeddate > @dateFrom AND shippeddate < @dateTo;
GO

EXEC Sales.SalesFromSecondQuarter @custid = 37, @dateFrom = '2014-03-31', @dateTo = '2014-06-30';

--- Exercise 4 ---
CREATE PROCEDURE dbo.Fibonacci
	@position int
AS
BEGIN
	DECLARE @f1 int
	DECLARE @f2 int
	DECLARE @f int -- the final value
	DECLARE @nr int -- counter
	IF @position <= 2
	BEGIN
		SET @f = 1
		PRINT @f
		RETURN
	END

	SET @f1 = 1
	SET @f2 = 1
	SET @nr = 0

	WHILE @nr < @position -2
		BEGIN
			SET @f = @f1 + @f2
			SET @f2 = @f1
			SET @f1 = @f
			SET @nr = @nr + 1
		END
	PRINT @f
	END
GO

EXEC dbo.Fibonacci 10; --55

--- Exercise 5 --- 
CREATE FUNCTION Sales.Value (@unitprice int, @qty int)
RETURNS int

AS
BEGIN 
	RETURN @unitprice * @qty
END;
GO

SELECT orderid, unitprice, qty, Sales.Value(unitprice, qty) AS value
FROM Sales.OrderDetails
WHERE Sales.Value(unitprice, qty) > 10000;

--- Exercise 6 ---
CREATE FUNCTION Sales.QtyRange (@qtylow int, @qtyhigh int) RETURNS TABLE
AS
RETURN (
	SELECT *
	FROM Sales.OrderDetails
	WHERE Sales.OrderDetails.qty BETWEEN @qtylow AND @qtyhigh
	);
GO

SELECT * FROM Sales.QtyRange(100, 200);

--- Exercise 7 ---
CREATE FUNCTION dbo.FibonacciRec (@n int) RETURNS int
AS
BEGIN
	IF @n <= 0 RETURN 0
	IF @n = 1 RETURN 1
	RETURN dbo.FibonacciRec(@n-2) + dbo.FibonacciRec(@n-1)
END;
GO

SELECT dbo.FibonacciRec(10) AS value;