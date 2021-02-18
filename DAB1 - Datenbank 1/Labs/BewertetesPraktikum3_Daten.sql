-----------------------
-- Aufgabe 1 (2 Punkte)
-----------------------
DROP DATABASE IF EXISTS BP3;
CREATE DATABASE BP3;
USE BP3;

-- -----------------------------------------------
-- Erstelle unabhaengige Tabellen (Entitaetstypen)
-- -----------------------------------------------

CREATE TABLE Sammelstelle (
	SOrt varchar(100) NOT NULL,
	SLand varchar(100) NOT NULL,
	SNr varchar(50) NOT NULL,
	
	CONSTRAINT PK_Sammelstelle PRIMARY KEY (SNr)
);

CREATE TABLE KaffeeSorte (
	KName varchar(100) NOT NULL,
	KNr varchar(50) NOT NULL,
	
	CONSTRAINT PK_KaffeeSorte PRIMARY KEY (KNr)
);

CREATE TABLE Fabrik (
	FOrt varchar(100) NOT NULL,
	FLand varchar(100) NOT NULL,
	FNr varchar(50) NOT NULL,
	
	CONSTRAINT PK_Fabrik PRIMARY KEY (FNr)
);

-- -----------------------------------------------
-- Erstelle Beziehungstypen
-- -----------------------------------------------

CREATE TABLE AbgabeMoeglich (
	SNr varchar(50) NOT NULL,
	KNr varchar(50) NOT NULL,
	
	CONSTRAINT PK_AbgabeMoeglich PRIMARY KEY (SNr, KNr),
	CONSTRAINT FK_AbM_Sammelstelle FOREIGN KEY (SNr) REFERENCES Sammelstelle(SNr),
	CONSTRAINT FK_AbM_KaffeeSorte FOREIGN KEY (KNr) REFERENCES KaffeeSorte(KNr)
);

CREATE TABLE LieferungMoeglich (
	SNr varchar(50) NOT NULL,
	KNr varchar(50) NOT NULL,
	FNr varchar(50) NOT NULL,
	
	CONSTRAINT PK_LieferungMoeglich PRIMARY KEY (SNr, KNr, FNr),
	CONSTRAINT FK_LfM_Sammelstelle FOREIGN KEY (SNr) REFERENCES Sammelstelle(SNr),
	CONSTRAINT FK_LfM_KaffeeSorte FOREIGN KEY (KNr) REFERENCES KaffeeSorte(KNr),
	CONSTRAINT FK_LfM_Fabrik FOREIGN KEY (FNr) REFERENCES Fabrik(FNr)
);

CREATE TABLE Abgabe (
	SNr varchar(50) NOT NULL,
	KNr varchar(50) NOT NULL,
	ANr varchar(50) NOT NULL,
	AAnzKg decimal (10,3) NOT NULL,
	ADatum date NOT NULL,
	
	CONSTRAINT UK_Abgabe UNIQUE (SNr, KNr, ANr),
	CONSTRAINT FK_AbgabeMoeglich FOREIGN KEY (SNr, KNr) REFERENCES AbgabeMoeglich (SNr, KNr)
);

CREATE TABLE Lieferung (
	SNr varchar(50) NOT NULL,
	KNr varchar(50) NOT NULL,
	FNr varchar(50) NOT NULL,
	LNr varchar(50) NOT NULL,
	LAnzKg decimal (10,3) NOT NULL,
	LDatum date NOT NULL,
	
	CONSTRAINT UK_Lieferung UNIQUE (SNr, KNr, FNr, LNr),
	CONSTRAINT FK_LieferungMoeglich FOREIGN KEY (SNr, KNr, FNr) REFERENCES LieferungMoeglich (SNr, KNr, FNr)
);

-- -----------------------------
-- Lade Daten
-- -----------------------------

-- Sammelstelle
INSERT INTO Sammelstelle (SOrt, SLand, SNr) VALUES ('Bern', 'Schweiz', '001');
INSERT INTO Sammelstelle (SOrt, SLand, SNr) VALUES ('Berlin', 'Deutschland', '002');
INSERT INTO Sammelstelle (SOrt, SLand, SNr) VALUES ('Palermo', 'Italien', '003');
INSERT INTO Sammelstelle (SOrt, SLand, SNr) VALUES ('Rio', 'Brasilien', '004');

-- KaffeeSorte
INSERT INTO KaffeeSorte (KName, KNr) VALUES ('Arabica', '001');
INSERT INTO KaffeeSorte (KName, KNr) VALUES ('Robusta', '002');
INSERT INTO KaffeeSorte (KName, KNr) VALUES ('Excelsa', '003');
INSERT INTO KaffeeSorte (KName, KNr) VALUES ('Kopi Luwak', '004');
INSERT INTO KaffeeSorte (KName, KNr) VALUES ('Liberia', '005');

-- Fabrik
INSERT INTO Fabrik (FOrt, FLand, FNr) VALUES ('Thun', 'Schweiz', '001');
INSERT INTO Fabrik (FOrt, FLand, FNr) VALUES ('Bremen', 'Deutschland', '002');
INSERT INTO Fabrik (FOrt, FLand, FNr) VALUES ('Cagliari', 'Italien', '003');

-- AbgabeMoeglich
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('001', '001');
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('002', '001');
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('002', '003');
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('003', '002');
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('004', '001');
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('004', '003');
INSERT INTO AbgabeMoeglich (SNr, KNr) VALUES ('004', '004');

-- LieferungMoeglich
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('001', '001', '002');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('002', '001', '001');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('002', '003', '003');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('003', '002', '001');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('001', '001', '001');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('002', '001', '002');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('003', '001', '003');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('004', '001', '001');
INSERT INTO LieferungMoeglich (SNr, KNr, FNr) VALUES ('001', '005', '001');

-- Abgabe
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('001', '001', '001', 1200.5, STR_TO_DATE('2013-11-05', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('002', '001', '002', 1456.37, STR_TO_DATE('2013-11-06', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('002', '003', '003', 845.95, STR_TO_DATE('2013-11-05', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('003', '002', '004', 312.0, STR_TO_DATE('2013-11-07', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('004', '001', '005', 124.5, STR_TO_DATE('2013-11-07', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('004', '003', '006', 945.78, STR_TO_DATE('2013-11-06', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('004', '003', '007', 123.0, STR_TO_DATE('2013-11-03', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('004', '004', '008', 236.0, STR_TO_DATE('2013-12-05', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('004', '004', '009', 236.0, STR_TO_DATE('2013-12-01', '%Y-%m-%d'));
INSERT INTO Abgabe (SNr, KNr, ANr, AAnzKg, ADatum) VALUES ('004', '003', '010', 236.0, STR_TO_DATE('2013-12-01', '%Y-%m-%d'));

-- Lieferung
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('001', '001', '002', '001', 679.15, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('002', '001', '001', '002', 1023.367, STR_TO_DATE('2013-12-03', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('002', '003', '003', '003', 568.54, STR_TO_DATE('2013-12-03', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('003', '002', '001', '004', 43.0, STR_TO_DATE('2013-12-05', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('001', '001', '001', '005', 543.0, STR_TO_DATE('2013-12-05', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('002', '001', '002', '006', 343.0, STR_TO_DATE('2013-12-06', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('002', '001', '002', '007', 1233.0, STR_TO_DATE('2013-12-06', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('003', '001', '003', '008', 143.0, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('003', '001', '003', '009', 67.0, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('004', '001', '001', '010', 21.5, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('004', '001', '001', '011', 2345.56, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('004', '001', '001', '012', 125.54, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('004', '001', '001', '013', 2125, STR_TO_DATE('2013-12-07', '%Y-%m-%d'));
INSERT INTO Lieferung (SNr, KNr, FNr, LNr, LAnzKg, LDatum) VALUES ('001', '005', '001', '014', 125, STR_TO_DATE('2013-12-08', '%Y-%m-%d'));
