CREATE OR REPLACE TRIGGER AggiornaRicevutaInserimentoContributo AFTER INSERT ON Contributo
FOR EACH ROW
	UPDATE Ricevuta R SET R.importo = R.importo + NEW.importo WHERE R.id_ricevuta = NEW.id_ricevuta;

CREATE OR REPLACE TRIGGER AggiornaRicevutaAggiornamentoContributo AFTER UPDATE ON Contributo
FOR EACH ROW
	UPDATE Ricevuta R SET R.importo = R.importo - OLD.importo + NEW.importo WHERE R.id_ricevuta = NEW.id_ricevuta;

CREATE OR REPLACE TRIGGER AggiornaRicevutaEliminazioneContributo AFTER DELETE ON Contributo
FOR EACH ROW
	UPDATE Ricevuta R SET R.importo = R.importo - OLD.importo WHERE R.id_ricevuta = OLD.id_ricevuta;
	
DELIMITER $$
CREATE OR REPLACE TRIGGER PrevieniIngressoSocioIrregolare BEFORE INSERT ON Ingresso
FOR EACH ROW
BEGIN 
	IF NOT socioInRegola(NEW.id_socio) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=30001, MESSAGE_TEXT="Il socio non è in regola.";
	END IF;
END $$
DELIMITER $$