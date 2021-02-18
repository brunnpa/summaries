-- --------------------------------------------------
-- BEWERTETES PRAKTIKUM PASCAL BRUNNER / BRUNNPA7 
-- IT17TB_ZH 									
-- BEMERKUNG:
-- 		Aufgrund der eingefügten Daten zum Kontrollieren 
-- 		ob Aufgabe 3 und 4 funktionieren, erhalte ich in 
-- 		Aufgabe 2, nun keine Tupel mehr zurueck
-- 		Jedoch habe ich aus der Aufgabenstellung
-- 		nicht herauslesen könne, dass schlussendlich
-- 		fuer jede Abfrage auch ein entsprechendes Tupel
-- 		zurueckgeben werden muss.
-- --------------------------------------------------



-- Aufgabe 1) Erstellen Sie die Tabellen für das gesamte Datenmodell in SQL und fügen Sie mindestens 3
-- unterschiedliche Datensätze pro Tabelle ein. Definieren Sie Primary, Foreign und Unique Keys
-- entsprechend. Falls Sie für die untenstehenden Aufgaben noch weitere Datensätze benötigen, fügen
-- Sie diese entsprechend ein.

-- Datenbank erstellen
CREATE DATABASE
	brunnpa;
	


-- Tabellen erstellen
CREATE TABLE Sammelstelle (
	SNr integer(20) NOT NULL,
	SOrt VARCHAR(30),
	SLand VARCHAR(30),
    CONSTRAINT PK_Sammelstelle PRIMARY KEY (SNr)
);

CREATE TABLE KaffeeSorte (
	KNr integer(20) NOT NULL,
	KName VARCHAR(30),
    CONSTRAINT PK_KaffeeSorte PRIMARY KEY (KNr)
);	

CREATE TABLE Abgabe_moeglich (
	SNr integer(20) NOT NULL,
	KNr integer(20) NOT NULL,
    CONSTRAINT PK_Abgabe_moeglich PRIMARY KEY (SNr, KNr),
    CONSTRAINT FK_Sammelstelle FOREIGN KEY (SNr)
    REFERENCES Sammelstelle (SNr),
    CONSTRAINT FK_KaffeeSorte FOREIGN KEY (KNr)
    REFERENCES KaffeeSorte (KNr)
);

CREATE TABLE Fabrik (
	FNr integer(20) NOT NULL,
	FOrt VARCHAR (30),
	FLand VARCHAR (30),
    CONSTRAINT PK_Fabrik PRIMARY KEY (FNr)
);
	
CREATE TABLE Lieferung_moeglich (
	SNr integer(20) NOT NULL,
	KNr integer(20) NOT NULL,
	FNr integer(20) NOT NULL,
    CONSTRAINT PK_Lieferung_moeglich PRIMARY KEY (SNr, KNr, FNr),
    CONSTRAINT FK_SammelstelleLieferungmoeglich FOREIGN KEY (SNr)
    REFERENCES Sammelstelle (SNr),
    CONSTRAINT FK_KaffeeSorteLieferungmoeglich FOREIGN KEY (KNr)
    REFERENCES KaffeeSorte (KNr),
    CONSTRAINT FK_FabrikLieferungmoeglich FOREIGN KEY (FNr)
    REFERENCES Fabrik (FNr)
);

CREATE TABLE Abgabe ( 
	SNr integer(20) NOT NULL,
	KNr integer(20) NOT NULL,
	ANr integer(20) NOT NULL,
	ADatum date, 
	AAnzKg int,
	CONSTRAINT UC_Abagbe UNIQUE (SNr, KNr, ANr),
    CONSTRAINT FK_Abgabe_moeglich FOREIGN KEY (SNr, KNr)
    REFERENCES Abgabe_moeglich (SNr, KNr)
);

CREATE TABLE Lieferung (
	SNr integer(20) NOT NULL,
	FNr integer(20) NOT NULL,
	KNr integer(20) NOT NULL,
	LNr integer(20) NOT NULL,
	LDatum date, 
	LAnzKg integer,
    CONSTRAINT UC_Lieferung UNIQUE (SNr, KNr, FNr, LNr),
    CONSTRAINT FK_Lieferung_moeglich FOREIGN KEY (SNr, KNr, FNr) 
    REFERENCES Lieferung_moeglich (SNr, KNr, FNr)
);



-- Tabellen mit Datensaetzen fuellen
	-- Sammelstelle 
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (1, 'Zug', 'Schweiz');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (2, 'Zurich', 'Schweiz');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (3, 'London', 'Grossbritanien');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (4, 'Moskau', 'Russland');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (5, 'Helsinki', 'Finnland');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (6, 'Berlin', 'Deutschland');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (7, 'Oslo', 'Norwegen');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (8, 'Paris', 'Frankreich');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (9, 'Washington', 'USA');
INSERT INTO Sammelstelle(SNr, SOrt, SLand) values (10, 'Ottawa', 'Kanada');

	-- Fabrik 
INSERT INTO Fabrik(FNr, FOrt, FLand) values (1, 'Rio', 'Brasilien');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (2, 'Havanna', 'Kuba');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (3, 'Niger', 'Nigeria');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (4, 'Delhi', 'Indien');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (5, 'San Jose', 'Costa Rica');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (6, 'Dublin', 'Irland');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (7, 'St. Petersburg', 'Russland');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (8, 'Sidney', 'Australien');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (9, 'Paris', 'Frankreich');
INSERT INTO Fabrik(FNr, FOrt, FLand) values (10, 'Johannesburg', 'Suedafrika');

	-- KaffeeSorte
INSERT INTO KaffeeSorte(KNr, KName) values (1, 'Excelsa');
INSERT INTO KaffeeSorte(KNr, KName) values (2, 'Arabica');
INSERT INTO KaffeeSorte(KNr, KName) values (3, 'Robusta');
INSERT INTO KaffeeSorte(KNr, KName) values (4, 'Maragogype');
INSERT INTO KaffeeSorte(KNr, KName) values (5, 'Liberia');
INSERT INTO KaffeeSorte(KNr, KName) values (6, 'Kopi Luwak');

	-- Abgabe moeglich
INSERT INTO Abgabe_moeglich(SNr, KNr) values (1,1);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (1,2);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (1,3);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (1,4);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (1,5);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (2,2);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (5,3);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (7,4);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (9,5);
INSERT INTO Abgabe_moeglich(SNr, KNr) values (1,6);

	-- Lieferung moeglich
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,1);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,2,3);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(2,2,2);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(4,6,3);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(10,3,10);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(4,2,1);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(10,5,10);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(6,6,6);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,2);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,3);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,4);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,5);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,6);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,7);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,8);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,9);
INSERT INTO Lieferung_moeglich(SNr, KNr, FNr) values(1,1,10);

	-- Lieferung
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,1,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(2,2,2,2,'2017-10-10',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(6,6,6,3,'2016-08-08',300);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(10,10,5,4,'2015-08-08',500);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(4,1,2,5,'2016-08-08',200);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(10,10,3,6,'2016-08-08',300);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,3,2,7,'2010-01-01',50);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,2,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,3,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,4,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,5,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,6,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,7,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,8,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,9,1,1,'2017-01-01',100);
INSERT INTO Lieferung(SNr, FNr, KNr, LNr, LDatum, LAnzKg) values(1,10,1,1,'2017-01-01',100);


	-- Abgabe
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(1,1,1,'2017-01-01', 200);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(2,2,2,'2016-01-01', 200);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(5,3,3,'2015-01-01', 500);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(7,4,4,'2014-01-01', 2000);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(1,2,5,'2017-01-01', 200);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(1,3,6,'2017-01-01', 200);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(1,4,7,'2017-01-01', 200);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(1,5,8,'2017-01-01', 200);
INSERT INTO Abgabe(SNr, KNr, ANr, ADatum, AAnzKg) values(1,6,9,'2017-01-01', 200);


-- Aufgabe 2) Erstellen Sie eine Liste von Kaffeesorten (KNr, KName), die an eine Fabrik geliefert worden sind, die
-- aber noch nie an eine Sammelstelle abgegeben worden sind.
SELECT
	KNr, KName
FROM
	KaffeeSorte 
WHERE EXISTS (
	SELECT 1
    FROM lieferung
    WHERE Lieferung.KNr=Kaffeesorte.KNr
    )
    AND NOT EXISTS (
    SELECT 1
    FROM Abgabe
    WHERE Abgabe.Knr=Kaffeesorte.KNr);
	
-- Aufgabe 3) Erstellen Sie eine Liste von Kaffeesorten, die von allen Fabriken geliefert worden sind.
SELECT 
	KNr, KName
FROM 
	kaffeesorte
WHERE
	KNr IN (SELECT KNr
			FROM Lieferung
			GROUP BY KNr
			HAVING count(distinct FNr) = (SELECT COUNT(FNr)
										  FROM Fabrik)
										);
-- Musterloesung
SELECT
	k.KName, k.KNr
FROM
	Kaffeesorte k
WHERE NOT EXISTS (
		SELECT 1
        FROM Fabrik f
        WHERE NOT EXISTS(
				SELECT 1
                FROM Lieferung l
                WHERE l.fnr = f.fnr AND l.knr = k.knr))
                
	
-- Aufgabe 4) Erstellen Sie eine Liste von Sammelstellen (SNr, SLand) und geben Sie an, wie viele Abgaben pro
-- Sammelstelle gemacht worden sind. Es sollen nur diejenigen Sammelstellungen aufgelistet werden,
-- an die mehr als 5 Abgaben gemacht worden sind und von denen mehr als 3 Fabriklieferungen
-- ausgegangen sind.
SELECT 
	SNr, SLand, COUNT(ANr) AS AnzahlAbgaben
FROM 
	Abgabe 
NATURAL JOIN 
	Sammelstelle AS S
WHERE 
	S.SNr IN (SELECT SNr
				FROM lieferung
                group by SNr
                HAVING COUNT(*) > 3)
GROUP BY
	SNr
HAVING COUNT(AnzahlAbgaben) > 5;

-- Aufgabe 5) Erstellen Sie eine sortierte Liste von Kaffeesorten mit den meisten Lieferungen (und deren Anzahl an Lieferungen).	
SELECT
	KaffeeSorte.KName, COUNT(Lieferung_moeglich.KNr) AS AnzahlLieferungen
FROM
	KaffeeSorte
JOIN
	Lieferung_moeglich
ON
	KaffeeSorte.KNr = Lieferung_moeglich.KNr
GROUP BY
	KName
ORDER BY
	AnzahlLieferungen DESC;
    
-- Aufgabe 6) Formulieren Sie folgenden Ausdruck in SQL
SELECT
	KName, FOrt, FLand
FROM 
	Lieferung
NATURAL JOIN
	KaffeeSorte
NATURAL JOIN
	FABRIK
WHERE
	LDatum < '2013-12-07';

	