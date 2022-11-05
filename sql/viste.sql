CREATE OR REPLACE VIEW ContributiDaSaldare AS 
SELECT  id_socio,"Mensile" as tipo, id_attivita, quota_partecipazione as importo FROM
(
	SELECT id_attivita, id_socio  
	FROM PartecipazioneAttivita PA 
	LEFT JOIN ( SELECT * FROM Contributo C WHERE NOW() BETWEEN C.`data` AND C.scadenza ) C1 USING (id_socio, id_attivita)
	WHERE id_contributo IS NULL
) T
NATURAL JOIN Attivita a
UNION SELECT
	id_socio,
	"Annuale" as tipo,
	NULL as attivita,
	15 as importo
FROM Socio S WHERE NOT EXISTS(
	SELECT * FROM Contributo C2 
	WHERE 
		C2.tipo = "Annuale" AND
		C2.id_socio = S.id_socio AND
		NOW() BETWEEN C2.`data` AND C2.scadenza 
)
