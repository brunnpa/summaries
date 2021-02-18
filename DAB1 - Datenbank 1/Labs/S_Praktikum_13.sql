-- ----------------------------------------------------------------------
-- DAB1 Praktikum_13: L_T_P_LTP-Datenbank erzeugen und füllen
-- ----------------------------------------------------------------------

DROP DATABASE IF EXISTS DAB1_Praktikum_13; 
CREATE DATABASE DAB1_Praktikum_13;         
USE DAB1_Praktikum_13;                    

/*

In zweitem Abfragefenster bereithalten:

SELECT * FROM L;
SELECT * FROM T;
SELECT * FROM P;
SELECT * FROM LTP;

*/

-- ----------------------------------------------------------------------
-- Tabellen
-- ----------------------------------------------------------------------

-- Lieferanten
CREATE TABLE L ( 
  LNr     VARCHAR(5)  PRIMARY KEY,
  LName   VARCHAR(10) NOT NULL UNIQUE,
  Status  INT         NOT NULL,
  Stadt   VARCHAR(20) NOT NULL
);

-- Teile
CREATE TABLE T ( 
  TNr     VARCHAR(5)  PRIMARY KEY,
  TName   VARCHAR(10) NOT NULL UNIQUE,
  Farbe   VARCHAR(10) NOT NULL,
  Gewicht FLOAT       NOT NULL,
  Stadt   VARCHAR(20) NOT NULL
);

-- Projekte
CREATE TABLE P ( 
  PNr     VARCHAR(5)  PRIMARY KEY,
  PName   VARCHAR(10) NOT NULL UNIQUE,
  Stadt   VARCHAR(20) NOT NULL
);

-- Zusammenhang: Welcher Lieferant liefert welche Teile für welche Projekte in welcher Menge
CREATE TABLE LTP ( 
  LNr     VARCHAR(5)  NOT NULL,
  TNr     VARCHAR(5)  NOT NULL,
  PNr     VARCHAR(5)  NOT NULL,
  Menge   FLOAT           NULL,

  PRIMARY KEY (LNR, TNR, PNR),
  FOREIGN KEY (LNr) REFERENCES L(LNr),
  FOREIGN KEY (TNr) REFERENCES T(TNr),
  FOREIGN KEY (PNr) REFERENCES P(PNr)
);

-- ----------------------------------------------------------------------
-- Daten 
-- ----------------------------------------------------------------------

-- L
INSERT INTO L VALUES('L1','Sulzer',  3,'Winterthur');
INSERT INTO L VALUES('L2','Novartis',2,'Basel');
INSERT INTO L VALUES('L3','Aventis', 4,'Basel');
INSERT INTO L VALUES('L4','Atraxis', 1,'Bern');
INSERT INTO L VALUES('L5','Unaxis',  5,'Zürich');
INSERT INTO L VALUES('L6','Comandis',6,'Zug');

-- T
INSERT INTO T VALUES('T1','TA','Blau',1.5,'Basel');
INSERT INTO T VALUES('T2','TB','Rot', 2.5,'Winterthur');
INSERT INTO T VALUES('T3','TC','Rot', 3.5,'Basel');
INSERT INTO T VALUES('T4','TD','Blau',4.5,'Bern');

-- P
INSERT INTO P VALUES('P1','PA','Winterthur');
INSERT INTO P VALUES('P2','PB','Basel');
INSERT INTO P VALUES('P3','PC','Bern');
INSERT INTO P VALUES('P4','PD','Schindellegi');

-- LTP
INSERT INTO LTP VALUES('L1','T1','P1',300);
INSERT INTO LTP VALUES('L1','T1','P2',800);
INSERT INTO LTP VALUES('L1','T1','P3',299);
INSERT INTO LTP VALUES('L2','T1','P1',750);
INSERT INTO LTP VALUES('L2','T2','P1',400);
INSERT INTO LTP VALUES('L2','T2','P2',300);
INSERT INTO LTP VALUES('L2','T2','P3',300);
INSERT INTO LTP VALUES('L3','T4','P2',700);



