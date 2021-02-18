
-- 1.) Finden Sie alle verschiedenen Teilefarben/Teilestädte-Kombinationen. 
-- (Mit “alle“ ist gemeint “alle, die zur Zeit in der DB gespeichert sind“, und nicht alle überhaupt möglichen.)
SELECT distinct
	Farbe, Stadt
FROM
	t;
    
-- 2.) Finden Sie alle Lieferantennummern/Teilenummern/Projektnummern-Kombinationen, 
-- bei denen Lieferant, Teil und Projekt alle aus derselben Stadt kommen.    
SELECT
	l.LNr, t.TNr, p.PNr
FROM
	t
Join
	l
ON
	t.stadt = l.stadt
Join
	p
ON
	l.stadt = p.stadt;
    
-- 3.) Finden Sie die Teilenummern von allen Teilen, welche von einem Lieferanten aus 
-- Winterthur für ein Projekt in Winterthur geliefert werden.
SELECT DISTINCT
	TNR
FROM
	LTP
JOIN
	P
ON
	LTP.PNR = p.pnr
JOIN
	L
ON
	LTP.Lnr = l.lnr
WHERE
	L.Stadt = 'Winterthur' AND P.Stadt = 'Winterthur';

-- 4. Definieren Sie eine Sicht mit Namen BStadtTeile, die alle Angaben über alle Teile liefert die aus einer 
-- Stadt stammen deren Namen mit ‚B‘ beginnt. Fragen Sie die Sicht ab nach blauen Teilen (nur die Attribute TName und Gewicht).

CREATE VIEW 
	BStadtTeile AS
SELECT
	*
FROM
	T
WHERE
	Stadt LIKE 'B%';


-- 5. Finden Sie die Lieferantennummern aller Lieferanten, die ein Teil liefern das aus einer Stadt
-- stammt, deren Namen mit ‚B‘ beginnt (verwenden Sie obige Sicht).

SELECT DISTINCT Lnr
FROM BStadtTeile;

-- 6. Finden Sie die Projektnummern aller Projekte, die mit dem Teil mit der Nummer T1 
-- beliefert werden in einer durchschnittlichen Menge, welche grösser ist als die grösste Menge 
-- eines Teiles, das an das Projekt mit der Nummer P1 geliefert wird.
SELECT
	PNr -- , AVG(Menge)
FROM
	LTP
WHERE
	ltp.TNR = 'T1'
GROUP BY
	PNr
HAVING AVG(Menge) > (
					SELECT
						MAX(Menge)
					FROM
						LTP
					Where
						PNr = 'P1');


-- 7. Finden Sie die Teilenummern aller Teile, welche an alle Projekte in Winterthur geliefert 
-- werden.

-- 8. Finden Sie die Lieferantennummern aller Lieferanten mit Status kleiner als der Status von Sulzer.
-- 9. Finden Sie alle Paare von verschiedenen Teilenummern, bei denen es einen Lieferanten gibt, welcher beide Teile liefert.
-- 10. Finden Sie die Anzahl Projekte, zu denen der Lieferant mit dem Namen “Sulzer“ beiträgt.



