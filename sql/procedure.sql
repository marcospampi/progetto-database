DELIMITER $$
CREATE OR REPLACE PROCEDURE creaRicevuta(IN id_socio INT, OUT a SMALLINT, OUT p INT, OUT ir INT)
BEGIN
	
	INSERT INTO Ricevuta SET
		anno = YEAR(CURDATE()),
		progressivo = (
			SELECT COALESCE( MAX(progressivo), 0 ) + 1 
			FROM Ricevuta R WHERE R.anno = YEAR(CURDATE())
		),
		`data` = NOW(),
		id_socio = id_socio;
	SELECT id_ricevuta, anno, progressivo INTO ir, a, p FROM Ricevuta WHERE id_ricevuta = LAST_INSERT_ID() ; 
END $$

CREATE OR REPLACE PROCEDURE computaReportAffluenza(IN settimana_ DATE)
BEGIN 
	DECLARE settimana DATETIME;
	
	CREATE OR REPLACE TEMPORARY TABLE RisultatoReportAffluenza_tmp(
		data_estesa DATETIME,
		giorno VARCHAR(16) DEFAULT DAYNAME(data_estesa),
		ora TIME DEFAULT TIME(data_estesa),
		affluenza INT DEFAULT 0
	);
	# nel caso non sia stato fornito un lunedì, in questo modo si rimedia all'errore
	SET settimana = settimana_ - INTERVAL WEEKDAY(settimana_) DAY;
	
	# riempio le tabella temporanea
	BEGIN
		DECLARE wday INT DEFAULT 0;
		WHILE wday < 5 DO
			BEGIN
				DECLARE hday INT DEFAULT 9;
				WHILE hday < 20 DO
					INSERT INTO RisultatoReportAffluenza_tmp SET
						data_estesa = settimana + INTERVAL wday DAY + INTERVAL hday HOUR,
						affluenza = (SELECT COUNT(*) FROM Ingresso i WHERE i.`data` BETWEEN data_estesa AND data_estesa + INTERVAL 1 HOUR );
					SET hday = hday + 1;
				END WHILE;
			END;
			SET wday = wday + 1;
		END WHILE;
	END;
	
END $$
DELIMITER ;


