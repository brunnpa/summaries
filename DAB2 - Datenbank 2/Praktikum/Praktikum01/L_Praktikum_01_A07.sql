---------------------------------------------------------------------
-- L_Praktikum_01_A07.sql: Constraint verletzen
---------------------------------------------------------------------

USE DAB2Query
GO

INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(999, N'Davis', N'Sara', N'CEO', N'Ms.', '20160929', '20120501', N'7890 - 20th Ave. E., Apt. 2A', N'Seattle', N'WA', N'10003', N'USA', N'(206) 555-0101', NULL);

