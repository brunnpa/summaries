-- Aufgabe 1  Geben Sie die Namen und Vornamen aller Besucher an, die an der Dorfstrasse wohnen.
select 
	name, vorname 
FROM 
	Besucher 
WHERE 
	strasse = 'Dorfstrasse';

-- Aufgabe 2  Geben Sie die Namen aller Personen an, deren Lieblingsbier Malzdrink ist und die dieses besser als mit 3 bewerten
select 
	bname 
FROM 
	lieblingsbier 
WHERE 
	bewertung > 3 AND bsorte = 'Malzdrink';

-- Aufgabe 3  Sortieren Sie das Ergebnis aus Aufgabe 1) absteigend nach Name und Vorname
select 
	name, vorname 
FROM 
	Besucher 
WHERE 
	strasse = 'Dorfstrasse'
ORDER by 
	Name DESC, vorname DESC;

-- Aufgabe 4  Geben Sie den Suppenpreis und den Restaurantnamen aller Restaurants an, die Biere mit dem Grundstoff ‚Hopfen‘ anbieten
SELECT 
	restaurant.Suppenpreis, restaurant.name
FROM 
	Restaurant as r, 
    sortiment as s, 
    biersorte as b
Where 
	r.name = s.rname and s.bsorte = b.Name and Grundstoff = 'hopfen';

-- Aufgabe 4 Klassenloesung
Select DISTINCT
	restaurant.name, suppenpreis
from
	restaurant
JOIN
	Sortiment
ON
	Restaurant.Name = Sortiment.RName
JOIN
	Biersorte
ON
	Sortiment.BSorte = Biersorte.Name
WHERE
	Grundstoff = 'Hopfen';

-- Aufgabe 4 Klassenloesung (kurze Version)
Select DISTINCT
	r.name, r.suppenpreis
from
	restaurant AS r
JOIN
	Sortiment AS s
ON
	r.Name = s.RName
JOIN
	Biersorte AS b
ON
	s.BSorte = b.Name
WHERE
	Grundstoff = 'Hopfen';

-- Aufgabe 4 Klassenloesung (Join-Kriterium und Select-Kriterium kombiniert)
Select DISTINCT
	restaurant.name, suppenpreis
FROM
	Restaurant AS r,
    Sortiment AS s,
    Biersorte AS b
WHERE
	r.name = s.RName AND s.BSorte = b.Name AND Grundstoff = 'Hopfen';

    
-- Aufgabe 5  Geben Sie Namen und Geburtstag aller Gäste an, die ein Restaurant mit Eröffnungsdatum vor dem Jahr 2010 besuchen
SELECT DISTINCT
	b.Name, b.Gebtag
FROM 
	Besucher AS b
JOIN
    Gast AS g
ON
	b.name = g.bname AND b.vorname = g.bvorname
JOIN
    Restaurant AS r
ON
	g.rname = r.name
WHERE
	r.Eroeffnungsdatum < '2010-01-01';


-- Aufgabe 6
-- Prosa-Loesung: Es werden alle Besucher angezeigt welche entweder nicht ins Restaurant gehen oder kein Lieblingsbier haben
SELECT DISTINCT 
	b1.Name, b1.Vorname
FROM
	Besucher AS b1;
    
-- Aufgabe 7 -- Gesucht sind Name, Vorname und Strasse der Besucher, die kein Restaurant an ihrer Wohnstrasse besuchen


-- Aufgabe 8  Gesucht sind Namen und Vornamen von Besuchern, die das Glück haben, dass es ein Restaurant gibt, welches eines ihrer Lieblingsbiere im Sortiment hat
SELECT DISTINCT
	Besucher.Name, Besucher.Vorname
FROM
	Besucher
JOIN
	Lieblingsbier
ON
	Besucher.Name = Lieblingsbier.Bname
JOIN
	Biersorte
ON
	Lieblingsbier.Bsorte = Biersorte.Name
JOIN
	Sortiment
ON
	Biersorte.Name = Sortiment.Bsorte;

-- Aufgabe 8 (Klassenloesung) - effizienterer und schnellerer Weg
SELECT DISTINCT
Bname, Bvorname
FROM
Lieblingsbier
NATURAL JOIN
Sortiment;

-- Aufgabe 9  Gesucht sind die Lieblingsbiersorten derjenigen Gäste des Restaurant ‚Löwen‘, deren Vorname mit ‚P‘ beginnt. (Algebraischer Ausdruck und SQL)
-- LIKE = entspricht // P% = beginnt mit P
SELECT DISTINCT
	lieblingsbier.Bsorte
FROM
	Lieblingsbier
NATURAL JOIN
	Gast
WHERE
	Gast.Rname ='löwen' AND Gast.Bvorname LIKE 'P%';
    
-- Aufgabe 9 (Klassenloesung)
SELECT DISTINCT
	lieblingsbier.Bsorte
FROM
	Gast
NATURAL JOIN
	Lieblingsbier
WHERE
	Gast.Rname ='löwen' AND Bvorname LIKE 'P%';
    
-- Aufgabe 10  An welchen Strassen gibt es mindestens drei Restaurants? (ohne Gruppierung zu lösen)
SELECT COUNT
	(Resturant.Strasse)
FROM
	Restaurant
HAVING COUNT > 2;

SELECT bname, Bvorname, CASE 
	WHEN SUM(Frequenz) > 10 THEN 'ist ein Säufer'
    ELSE 'trinkt nicht so viel' END
FROM
	gast
Group by bname, bvorname;

    
    
    
