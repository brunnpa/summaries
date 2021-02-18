---------------------------------------------------------------------
-- L_Praktikum_01_A05.sql: Füllen der Tabelle
---------------------------------------------------------------------

USE DAB2Query
GO

INSERT INTO Sales.Shippers(shipperid, companyname, phone)
  VALUES(1, N'Shipper GVSUA', N'(503) 555-0137');
INSERT INTO Sales.Shippers(shipperid, companyname, phone)
  VALUES(2, N'Shipper ETYNR', N'(425) 555-0136');
INSERT INTO Sales.Shippers(shipperid, companyname, phone)
  VALUES(3, N'Shipper ZHISN', N'(415) 555-0138');

SELECT * FROM Sales.Shippers;