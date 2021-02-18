---------------------------------------------------------------------
-- S_Praktikum_02.sql: Erstellen der Übungsdatenbank DAB2Perf
--
-- Basiert auf der Datenbank PerformanceV3 aus dem Buch: T-SQL Querying
-- © Itzik Ben-Gan
--
-- Modifikationen für den DAB2-Unterricht: © Dr. Daniel Aebi 
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Datenbank erzeugen
---------------------------------------------------------------------

USE master;

-- Falls vorhanden: DB löschen
IF DB_ID(N'DAB2Perf') IS NOT NULL DROP DATABASE DAB2Perf;

-- Falls noch aktive Verbindungen vorhanden: Abbruch
IF @@ERROR = 3702 
  RAISERROR(N'Datenbank DAB2Perf kann nicht gelöscht werden da es noch aktive Verbindungen gibt.', 127, 127) WITH NOWAIT, LOG;

-- Datenbank erzeugen mit Standardoptionen
CREATE DATABASE DAB2Perf;
GO

USE DAB2Perf;
GO

---------------------------------------------------------------------
-- Funktion definieren, die eine Sequenz erzeugt
---------------------------------------------------------------------

IF OBJECT_ID(N'dbo.GetNums', N'IF') IS NOT NULL 
  DROP FUNCTION dbo.GetNums;
GO

CREATE FUNCTION dbo.GetNums(@low AS BIGINT, @high AS BIGINT) RETURNS TABLE
AS
RETURN
  WITH
    L0   AS (SELECT c FROM (VALUES(1),(1)) AS D(c)),
    L1   AS (SELECT 1 AS c FROM L0 AS A CROSS JOIN L0 AS B),
    L2   AS (SELECT 1 AS c FROM L1 AS A CROSS JOIN L1 AS B),
    L3   AS (SELECT 1 AS c FROM L2 AS A CROSS JOIN L2 AS B),
    L4   AS (SELECT 1 AS c FROM L3 AS A CROSS JOIN L3 AS B),
    L5   AS (SELECT 1 AS c FROM L4 AS A CROSS JOIN L4 AS B),
    Nums AS (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rownum
            FROM L5)
  SELECT TOP(@high - @low + 1) @low + rownum - 1 AS n
  FROM Nums
  ORDER BY rownum;
GO

---------------------------------------------------------------------
-- Grössenordnungen für Testdaten festlegen
---------------------------------------------------------------------

DECLARE
  @numorders   AS INT      =   1000000,
  @numcusts    AS INT      =     20000,
  @numemps     AS INT      =       500,
  @numshippers AS INT      =         5,
  @numyears    AS INT      =         4,
  @startdate   AS DATE     = '20130101';

---------------------------------------------------------------------
-- Tabellen erzeugen und füllen
---------------------------------------------------------------------

-- Customers
CREATE TABLE dbo.Customers
(
  custid   CHAR(11)     NOT NULL,
  custname NVARCHAR(50) NOT NULL
);

INSERT INTO dbo.Customers(custid, custname)
  SELECT
    'C' + RIGHT('000000000' + CAST(n AS VARCHAR(10)), 10) AS custid,
    N'Cust_' + CAST(n AS VARCHAR(10)) AS custname
  FROM dbo.GetNums(1, @numcusts);

ALTER TABLE dbo.Customers ADD
  CONSTRAINT PK_Customers PRIMARY KEY(custid);

-- Employees 
CREATE TABLE dbo.Employees
(
  empid     INT          NOT NULL,
  firstname NVARCHAR(25) NOT NULL,
  lastname  NVARCHAR(25) NOT NULL
);

INSERT INTO dbo.Employees(empid, firstname, lastname)
  SELECT n AS empid,
    N'Fname_' + CAST(n AS NVARCHAR(10)) AS firstname,
    N'Lname_' + CAST(n AS NVARCHAR(10)) AS lastname
  FROM dbo.GetNums(1, @numemps);

ALTER TABLE dbo.Employees ADD
  CONSTRAINT PK_Employees PRIMARY KEY(empid);

-- Shippers
CREATE TABLE dbo.Shippers
(
  shipperid   VARCHAR(5)   NOT NULL,
  shippername NVARCHAR(50) NOT NULL
);

INSERT INTO dbo.Shippers(shipperid, shippername)
  SELECT shipperid, N'Shipper_' + shipperid AS shippername
  FROM (SELECT CHAR(ASCII('A') - 2 + 2 * n) AS shipperid
        FROM dbo.GetNums(1, @numshippers)) AS D;

ALTER TABLE dbo.Shippers ADD
  CONSTRAINT PK_Shippers PRIMARY KEY(shipperid);

-- Orders
CREATE TABLE dbo.Orders
(
  orderid   INT        NOT NULL,
  custid    CHAR(11)   NOT NULL,
  empid     INT        NOT NULL,
  shipperid VARCHAR(5) NOT NULL,
  orderdate DATE       NOT NULL,
  filler    CHAR(160)  NOT NULL DEFAULT('a')
);

INSERT INTO dbo.Orders(orderid, custid, empid, shipperid, orderdate)
  SELECT n AS orderid,
    'C' + RIGHT('000000000'
            + CAST(
                1 + ABS(CHECKSUM(NEWID())) % @numcusts
                AS VARCHAR(10)), 10) AS custid,
    1 + ABS(CHECKSUM(NEWID())) % @numemps AS empid,
    CHAR(ASCII('A') - 2
           + 2 * (1 + ABS(CHECKSUM(NEWID())) % @numshippers)) AS shipperid,
      DATEADD(day, n / (@numorders / (@numyears * 365.25))
                   -- late arrival with earlier date
	                 - CASE WHEN n % 10 = 0
                       THEN 1 + ABS(CHECKSUM(NEWID())) % 30
                       ELSE 0 
                     END, @startdate)
         AS orderdate
  FROM dbo.GetNums(1, @numorders)
  ORDER BY CHECKSUM(NEWID())
OPTION(MAXDOP 1);

CREATE CLUSTERED INDEX idx_cl_od ON dbo.Orders(orderdate);

CREATE NONCLUSTERED INDEX idx_nc_sid_od_cid
  ON dbo.Orders(shipperid, orderdate, custid);

CREATE UNIQUE INDEX idx_unc_od_oid_i_cid_eid
  ON dbo.Orders(orderdate, orderid)
  INCLUDE(custid, empid);

ALTER TABLE dbo.Orders ADD
  CONSTRAINT PK_Orders PRIMARY KEY NONCLUSTERED(orderid),
  CONSTRAINT FK_Orders_Customers
    FOREIGN KEY(custid)    REFERENCES dbo.Customers(custid),
  CONSTRAINT FK_Orders_Employees
    FOREIGN KEY(empid)     REFERENCES dbo.Employees(empid),
  CONSTRAINT FK_Orders_Shippers
    FOREIGN KEY(shipperid) REFERENCES dbo.Shippers(shipperid);
GO

