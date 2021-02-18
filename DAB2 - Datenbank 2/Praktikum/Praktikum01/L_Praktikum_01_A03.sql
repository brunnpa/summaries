---------------------------------------------------------------------
-- L_Praktikum_01_A03.sql: Erstellen der Tabelle Sales.Shippers
---------------------------------------------------------------------

USE DAB2Query
GO

CREATE TABLE Sales.Shippers
(
  shipperid   INT          NOT NULL,
  companyname NVARCHAR(40) NOT NULL,
  phone       NVARCHAR(24) NOT NULL,
  CONSTRAINT PK_Shippers PRIMARY KEY(shipperid)
);
