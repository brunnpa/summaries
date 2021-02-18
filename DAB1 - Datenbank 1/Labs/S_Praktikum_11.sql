-- ----------------------------------------------------------------------
-- Praktikum_11: Bier-Datenbank erzeugen und füllen
-- ----------------------------------------------------------------------

DROP DATABASE IF EXISTS DAB1_Praktikum_11; 
CREATE DATABASE DAB1_Praktikum_11;         
USE DAB1_Praktikum_11;                     

/*

In zweitem Abfragefenster bereithalten:

SELECT * FROM Restaurant;
SELECT * FROM Besucher;
SELECT * FROM Biersorte;

SELECT * FROM Gast;
SELECT * FROM Lieblingsbier;
SELECT * FROM Sortiment;

*/

-- ----------------------------------------------------------------------
-- Unabhängige Entitätstypen
-- ----------------------------------------------------------------------

CREATE TABLE Besucher (
  Name    varchar(100) NOT NULL,
  Vorname varchar(100) NOT NULL,
  Strasse varchar(100) NOT NULL,
  Gebtag  date         NOT NULL,

  CONSTRAINT PK_Besucher PRIMARY KEY (Name, Vorname)
);

CREATE TABLE Restaurant (
  Name             varchar(100)  NOT NULL,
  Strasse          varchar(100)  NOT NULL,
  Wirtsname        varchar(100)  NOT NULL,
  Suppenpreis      decimal(10,5) NOT NULL,
  Eroeffnungsdatum date          NOT NULL,
  Wirtesonntag     varchar(15)   NOT NULL, -- 'Montag' .. 'Sonntag'

  CONSTRAINT PK_Restaurant PRIMARY KEY (Name)
);

CREATE TABLE Biersorte (
  Name       varchar(100) NOT NULL,
  Grundstoff varchar(100) NOT NULL,
  Hersteller varchar(100) NOT NULL,

  CONSTRAINT PK_Biersorte PRIMARY KEY (Name)
);

-- ----------------------------------------------------------------------
-- Beziehungstypen
-- ----------------------------------------------------------------------

CREATE TABLE Gast (
  Bname    varchar(100) NOT NULL,
  Bvorname varchar(100) NOT NULL,
  Rname    varchar(100) NOT NULL,
  Frequenz integer      NOT NULL, -- Restaurantbesuche pro Woche

  CONSTRAINT UK_Gast UNIQUE (Bname, Bvorname, Rname)
);

CREATE TABLE Lieblingsbier (
  Bname         varchar(100) NOT NULL,
  Bvorname      varchar(100) NOT NULL,
  Bsorte        varchar(100) NOT NULL,
  Bewertung     integer NULL,
  LiterproWoche decimal(5,2) NULL,


  CONSTRAINT PK_Lieblingsbier PRIMARY KEY (Bname, Bvorname, Bsorte),
  CONSTRAINT FK_Besucher      FOREIGN KEY (Bname, Bvorname) REFERENCES Besucher(Name, Vorname),
  CONSTRAINT FK_Biersorte_LB  FOREIGN KEY (Bsorte) REFERENCES Biersorte(Name)
);

CREATE TABLE Sortiment (
  Rname         varchar(100) NOT NULL,
  Bsorte        varchar(100) NOT NULL,
  AnLager       integer      NOT NULL,

  CONSTRAINT UK_Sortiment   UNIQUE (Rname, Bsorte),
  CONSTRAINT FK_Restaurant  FOREIGN KEY (Rname) REFERENCES Restaurant(Name),
  CONSTRAINT FK_Biersorte_S FOREIGN KEY (Bsorte) REFERENCES Biersorte(Name)
);

-- ----------------------------------------------------------------------
-- Daten Entitätstypen
-- ----------------------------------------------------------------------

-- Besucher
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Müller','Heinrich','Kirchweg','1965-03-01');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Meier','Hans','Dorfstrasse','1924-03-25');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Meier','Anna','Bachweg','1950-05-05');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Schmid','Joseph','Bachweg','1960-10-03');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Meier','Hanspeter','Dorfstrasse','1955-03-25');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Meier','Hansruedi','Dorfstrasse','1978-03-25');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Peters','Peter','Langstrasse','1980-02-01');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Anderegg','Ursula','Feldweg','1995-09-25');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Zarro','Darween','Klasbach','1965-12-20');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Mastroyanni','Pepe','Oberdorf','1960-02-29');
INSERT INTO Besucher (Name, Vorname, Strasse, Gebtag) VALUES ('Bucher','Rolf','Oberdorf','1960-02-29');

-- Restaurant
INSERT INTO Restaurant (Name, Strasse, Wirtsname, Suppenpreis, Eroeffnungsdatum, Wirtesonntag) VALUES ('Ochsen','Kirchplatz','Frehner',1.20,'1946-01-01','Montag');
INSERT INTO Restaurant (Name, Strasse, Wirtsname, Suppenpreis, Eroeffnungsdatum, Wirtesonntag) VALUES ('Löwen','Dorfstrasse','Sonderegger',4.30,'2013-07-01','Dienstag');
INSERT INTO Restaurant (Name, Strasse, Wirtsname, Suppenpreis, Eroeffnungsdatum, Wirtesonntag) VALUES ('Rössli','Bachmatt','Auer',2.20,'2000-04-01','Donnerstag');
INSERT INTO Restaurant (Name, Strasse, Wirtsname, Suppenpreis, Eroeffnungsdatum, Wirtesonntag) VALUES ('Bären','Feldweg','Jäger',4.90,'2011-10-01','Sonntag');
INSERT INTO Restaurant (Name, Strasse, Wirtsname, Suppenpreis, Eroeffnungsdatum, Wirtesonntag) VALUES ('Sternen','Feldweg','Jäger',3.60,'2011-10-01','Sonntag');
INSERT INTO Restaurant (Name, Strasse, Wirtsname, Suppenpreis, Eroeffnungsdatum, Wirtesonntag) VALUES ('Krone','Feldweg','Jäger',5.60,'2011-10-01','Sonntag');

-- Biersorte
INSERT INTO Biersorte (Name, Grundstoff, Hersteller) VALUES ('Hopfdrink', 'Hopfen', 'Hopfbräu');
INSERT INTO Biersorte (Name, Grundstoff, Hersteller) VALUES ('Malzdrink', 'Malz', 'Malzerei');
INSERT INTO Biersorte (Name, Grundstoff, Hersteller) VALUES ('Potatsaft', 'Kartoffel', 'Hopfbräu');
INSERT INTO Biersorte (Name, Grundstoff, Hersteller) VALUES ('Euelbräu','Mais','Euelbräu');
INSERT INTO Biersorte (Name, Grundstoff, Hersteller) VALUES ('Chopfab', 'Hopfen', 'Hopfbräu');

-- ----------------------------------------------------------------------
-- Daten Beziehungstypen
-- ----------------------------------------------------------------------

-- Gast
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Müller','Heinrich','Ochsen',6);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Müller','Heinrich','Löwen',1);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Müller','Heinrich','Bären',0);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Müller','Heinrich','Rössli',0);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hans','Bären',5);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hans','Löwen',4);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Anna','Ochsen',1);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Anna','Löwen',6);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hanspeter','Löwen',0);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hanspeter','Ochsen',2);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hanspeter','Rössli',3);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hanspeter','Bären',0);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hansruedi','Löwen',2);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hansruedi','Ochsen',3);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hansruedi','Rössli',4);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Meier','Hansruedi','Bären',2);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Peters','Peter','Löwen',2);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Anderegg','Ursula','Bären',1);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Zarro','Darween','Löwen',8);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Mastroyanni','Pepe','Rössli',3);
INSERT INTO Gast (Bname, Bvorname, Rname, Frequenz) VALUES ('Mastroyanni','Pepe','Ochsen',1);

-- Lieblingsbier
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Müller','Heinrich','Hopfdrink',10,7.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hans','Hopfdrink',4,2.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hans','Malzdrink',3,1.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hans','Potatsaft',2,0.5);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Anna','Hopfdrink',8,3.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Anna','Euelbräu',2,1.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hanspeter','Hopfdrink',9,8.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hanspeter','Malzdrink',9,7.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hanspeter','Potatsaft',2,0.5);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hansruedi','Hopfdrink',3,2.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hansruedi','Malzdrink',3,7.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Meier','Hansruedi','Potatsaft',2,0.9);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Peters','Peter','Hopfdrink',7,1.9);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Zarro','Darween','Potatsaft',2,6.9);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Mastroyanni','Pepe','Hopfdrink',6,3.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Mastroyanni','Pepe','Malzdrink',3,4.0);
INSERT INTO Lieblingsbier (Bname, Bvorname, Bsorte, Bewertung, LiterProWoche) VALUES ('Bucher','Rolf','Euelbräu',3,4.0);

-- Sortiment
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Löwen','Hopfdrink',570);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Löwen','Malzdrink',260);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Löwen','Potatsaft',120);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Ochsen','Hopfdrink',70);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Ochsen','Malzdrink',1250);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Ochsen','Potatsaft',20);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Bären','Hopfdrink',140);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Bären','Malzdrink',190);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Bären','Potatsaft',20);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Rössli','Potatsaft',2160);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Rössli','Euelbräu',2160);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Sternen','Potatsaft',2160);
INSERT INTO Sortiment (Rname, Bsorte, AnLager) VALUES ('Krone','Potatsaft',2160);
