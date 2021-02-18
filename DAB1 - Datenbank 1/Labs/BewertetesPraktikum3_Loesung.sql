----------
-- A2 (1P)
----------
SELECT DISTINCT k.KNr, k.KName
FROM KaffeeSorte k, Lieferung l 
WHERE 
  k.KNr = l.KNr and
  k.KNr NOT IN (
  SELECT a.KNr FROM Abgabe a 
  where a.KNr = k.KNr
  )

----------  
-- A3 (1P)
----------
select distinct k.knr, k.kname
from kaffeesorte k
where not exists (
  select 1 from fabrik f
  where not exists (
      select 1 from lieferung l
      where
        l.knr = k.knr and
        l.fnr = f.fnr
    )
)

----------
-- A4 (1P)
----------
SELECT DISTINCT s.SNr, s.SLand, COUNT(a.SNr)
FROM Sammelstelle s INNER JOIN Abgabe a 
ON s.SNr = a.SNr
WHERE s.SNr in (
	SELECT SNr
	FROM Lieferung
	GROUP BY SNr
	HAVING COUNT(SNr) > 3)
GROUP BY s.SNr, s.SLand
HAVING COUNT(a.SNr) > 5

----------
-- A5 (1P)
----------
select k.KName, count(l.KNr) anzL
from KaffeeSorte k
join Lieferung l on l.KNr = k.KNr
group by k.KNr
order by anzL desc

----------
-- A6 (1P)
----------
select distinct KName, FOrt, FLand
from Lieferung l
join KaffeeSorte k on k.KNr = l.KNr
join Fabrik f on f.FNr = l.FNr
where LDatum < '2013-12-07'
