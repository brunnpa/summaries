-- 1) Wie hoch ist der durchschnittliche Lagerbestand aller Biere (der Wert soll den Namen Durchschnittslagerbestand erhalten)?
SELECT 
	AVG (AnLager) AS Durchschnittlicher_Lagerbestand
FROM 
	Sortiment;
    
-- 2) Welche Besucher (Name,Vorname, Strasse) wohnen an einer Strasse, deren Bezeichnung das Wort ‚bach‘ enthält? Untersuchen Sie auch die Resultate, 
-- die Sie mit ,Bach‘, ‚BACH‘ etc. erhalten. Sehen Sie hier allenfalls ein Problem?
SELECT 
	Name, Vorname, Strasse 
FROM
	Besucher
WHERE 
	Strasse LIKE '%bach%' ; 
    
-- 3) An welchen Strassen gibt es mindestens drei Restaurants (GROUP BY verwenden)?
SELECT 
	Strasse
FROM
	Restaurant
GROUP BY
	Strasse
HAVING 
	COUNT(Strasse) > 2;
    -- HAVING gibt es nur in Kombination GROUP BY

-- 4) Bilden Sie das Kreuzprodukt der Tabellen Restaurant und Besucher (mit und ohne CROSS JOIN). Wieviele Tupel enthält das Resultat? Warum? 
-- Wozu könnte eine solche Abfrage nützlich sein
-- Variante mit CROSS JOIN
SELECT
	*
FROM
	Restaurant
CROSS JOIN
	Besucher;
    
-- Variante ohne CROSS JOIN
SELECT
	*
FROM
	Restaurant, Besucher;

-- 5) Gesucht ist eine Liste von Besuchern mit Name, Vorname und der Anzahl Restaurantbesuche pro Woche (= Frequenz). 
-- Falls ein Besucher nie Gast ist, soll er auf der Liste mit einer Anzahl Besuche von 0 erscheinen. 
-- Verwenden Sie dazu einen OUTER JOIN. Optional: Lösung ohne JOIN.
SELECT
	b.name, b.vorname, SUM(IFNULL(g.frequenz,0))
FROM
	Besucher b 
LEFT OUTER JOIN
	Gast g
ON
	b.name = g.bname AND b.vorname = g.bvorname
GROUP BY
	b.vorname
ORDER BY
	SUM(g.frequenz);

-- MUSTERLOESUNG 5)
SELECT
	Name, Vorname, SUM(COALESCE(Frequenz,0)) AS AnzahlBesuche
FROM
	Besucher AS b
LEFT OUTER JOIN
	Gast AS g
ON
	b.name = g.bname AND b.vorname = g.bvorname
GROUP BY
	b.name, b.vorname
ORDER BY
	AnzahlBesuche DESC;
    
-- MUSTERLOESUNG 5) ohne OUTER JOIN
SELECT -- Gäste
	Bname, Bvorname, SUM(Frequenz) AS AnzahlBesuche
FROM
	Gast
GROUP BY
	Bname, Bvorname
    
UNION

SELECT -- Besucher, die keine Gäste sind
	Name, Vorname, 0 AS AnzahlBesuche
FROM 
	Besucher AS X
WHERE NOT EXISTS (
	SELECT 	1
    FROM	Gast AS y
    WHERE	y.Bname = x.Name AND y.Bvorname = x.Vorname
    )
ORDER BY
	AnzahlBesuche DESC;

-- 6) Gesucht ist eine Liste der Hersteller von Biersorten zusammen mit der Anzahl Biersorten, 
-- die sie produzieren und der Anzahl verschiedener dabei verwendeter Grundstoffe
SELECT
	Hersteller, COUNT(Name) AS AnzahlBiere, COUNT(DISTINCT Grundstoff) AS AnzahlGrundstoffe -- DISTINCT, da zwei Biere dieselben Grundstoffe haben können
FROM 
	Biersorte
GROUP BY    -- Wenn man Aggregation macht, muss mindestens ein Attribut des Selects in GROUP BY erwähnt werden
	Hersteller;

-- 7) Welche Biersorten sind von allen mit derselben Note bewertet worden (Hinweis: das bedeutet, dass kleinste Note = grösste Note)?
SELECT
	BSorte
FROM
	Lieblingsbier
GROUP BY -- In diesem Fall eine Art DISTINCT, da man nur ein Attribut hat
	BSorte
HAVING
	MAX(Bewertung) = MIN(Bewertung);

-- 8) Gesucht ist eine Liste von Restaurants mit ihrem Namen, ihrem Suppenpreis, sowie dem durchschnittlichen Suppenpreis aller Restaurants derselben Strasse.
SELECT
	Name, Suppenpreis, 0 AS AVGSuppenpreisStrasse
FROM
	Restaurant

UNION

SELECT
	Name, Suppenpreis, AVG(Suppenpreis) AS AVGSuppenpreisStrasse
FROM
	Restaurant
GROUP BY
Strasse;

-- 8) korrekte Loesung
SELECT
	x.Name, x.Suppenpreis, y.Durchschnittspreis
FROM
	Restaurant x
JOIN (
		SELECT
			Strasse, AVG(Suppenpreis) AS Durchschnittspreis
		FROM
			Restaurant
		GROUP BY
			Strasse) AS y
ON
	x.Strasse = y.Strasse;

-- 9) Gesucht ist eine Liste von Restaurants und Biersorten, von denen sie am meisten an Lager haben.
SELECT
	RName, BSorte
FROM
	Sortiment x
WHERE
	AnLager = (
		SELECT MAX(AnLager)
        FROM Sortiment y
        WHERE y.RName = x.RName
        GROUP BY RName);


