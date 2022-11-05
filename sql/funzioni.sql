DELIMITER $$

CREATE OR REPLACE FUNCTION socioInRegola(id_socio INT) RETURNS BOOL DETERMINISTIC
BEGIN 
	DECLARE mensile BOOL DEFAULT FALSE;
	DECLARE annuale BOOL DEFAULT FALSE;
	
	SELECT NOT EXISTS(
		SELECT * FROM (
			SELECT *
			FROM PartecipazioneAttivita PA
			LEFT JOIN Contributo C USING (id_socio, id_attivita)
			WHERE 
				PA.id_socio = id_socio AND
				NOW() BETWEEN C.`data` AND C.scadenza 
		) T
		WHERE T.id_contributo IS NULL
	) INTO mensile;

	SELECT EXISTS (
		SELECT *
		FROM Contributo C WHERE 
			C.id_socio = id_socio AND
			C.tipo = "Annuale" AND 
			NOW() BETWEEN C.`data` AND C.scadenza
	) INTO annuale;
		
	
	RETURN mensile AND annuale;
END $$

DELIMITER ;