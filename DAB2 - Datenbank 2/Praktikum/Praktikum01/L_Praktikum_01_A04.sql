---------------------------------------------------------------------
-- L_Praktikum_01_A04.sql: Erstellen des Fremdschlüssels
---------------------------------------------------------------------

USE DAB2Query
GO

ALTER TABLE Sales.Orders ADD CONSTRAINT FK_Orders_Shippers 
FOREIGN KEY(shipperid) REFERENCES Sales.Shippers(shipperid);
