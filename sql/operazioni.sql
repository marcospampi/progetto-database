/* * Operazione 1: Inserimento di un nuovo socio. 
 * */
INSERT INTO Socio (codice_fiscale, nome, cognome, data_nascita, telefono, residenza, id_pesi)
	VALUES ("MRSQUIRREL123456", "Conker", "The Squirrel", "1997-07-01", "+39 123 456 7890", "Via degli Scoiattoli 4, Milano", 1 /*Ragazzi*/);

# Stampa il nuovo socio
SET @id_socio = LAST_INSERT_ID(); 
SELECT * FROM Socio WHERE id_socio = @id_socio; 

# Successivamente verrà trattata l'operazione di creazione ricevuta, dunque aggiungiamo delle attività cui il nuovo socio partecipa ( Sala pesi e Zumba )
INSERT INTO PartecipazioneAttivita (id_socio, id_attivita) VALUES (@id_socio, 1), (@id_socio, 3);

-- --------------------------------------------------------------------------------

/* * Operazione 2: Creazione di una scheda esercizi */
INSERT INTO Scheda (id_pesi, nome) VALUES (1 /*Ragazzi*/, "Scheda Novembre");

/* Si seleziona l'id della scheda */
SET @id_scheda = LAST_INSERT_ID();

/* Si riempie la scheda con due esercizi per fascia 
 * 	Ovviamente la composizione andrebbe fatta interattivamente usando un client.
 */
INSERT INTO EsercizioScheda (id_scheda, id_esercizio, ordine, serie, ripetizioni) VALUES
	/*			   E  O  S   R */			 	
	( @id_scheda,  1, 1, 5,  8 ), /* Bilanciere panca piana */
	( @id_scheda,  2, 1, 4, 10 ), /* Spinte manubri su inclinata */
	( @id_scheda,  7, 2, 5,  8 ), /* Curl bilanciere curvo presa larga */
	( @id_scheda,  8, 2, 4, 10 ), /* Curl manubri panca inclinata */
	( @id_scheda, 10, 3, 5,  8 ), /* Squat */
	( @id_scheda, 11, 3, 4, 10 ), /* Leg-Extension */
	( @id_scheda, 16, 4, 5,  8 ), /* Lat-Machine */
	( @id_scheda, 17, 4, 6, 10 ), /* Pulley */
	( @id_scheda, 20, 5, 5,  8 ), /* Spinte manubri da seduto  */
	( @id_scheda, 25, 5, 3, 15 ), /* Alzate laterali busto a flesso */
    ( @id_scheda, 27, 6, 5,  8 ), /* Spinte in basso al cavo */
	( @id_scheda, 28, 6, 5,  8 ); /* Spinte indietro con manubri petto sulla panca */

-- --------------------------------------------------------------------------------

/* * Operazione 3: Registrare il pagamento di un contributo.
 *  è stata creata una vista ad-hoc per questa operazione, _ContributiDaSaldare_, che mostra i contributi da saldare dei soci,
 * 	dunque andremo a stampare a schermo i contributi da saldare del socio, successivamente creeremo la inseriamo i record dei contributi
 * */
SELECT * FROM ContributiDaSaldare WHERE id_socio = @id_socio;

# si crea una istanza di ricevuta:
CALL creaRicevuta(/*in*/ @id_socio, /*out*/ @anno_ricevuta, /*out*/ @progressivo_ricevuta, /*out*/ @id_ricevuta);

# si registrano i contributi saldati
INSERT INTO Contributo (id_socio, id_ricevuta, id_attivita, tipo, importo ) 
	SELECT id_socio, @id_ricevuta, id_attivita, tipo, importo
	FROM ContributiDaSaldare WHERE id_socio = @id_socio;

-- --------------------------------------------------------------------------------

/* * Operazione 4: Verificare se il socio abbia versato le quote di partecipazione.
 *  Al riguardo, è possibile eseguire le operazioni in due modi:
 * 		1. Controllando che la query ContributiDaSaldare dove id_socio = @id_socio resituisca nessun risultato.
 * 		2. Usando la funzione socioInRegola(@id_socio), creata per lo scopo.
 * */

# Opzione 1:
SELECT NOT EXISTS( SELECT * FROM ContributiDaSaldare WHERE id_socio = @id_socio);
# Opzione 2:
SELECT socioInRegola(@id_socio);

-- --------------------------------------------------------------------------------

/* * Operazione 5: Eseguire l'export delle ricevute effettuate entro un range di date.
 * Questa operazione verrà trattata con un pò di più creatività rispetto alle altre,
 * innanzi tutto bisogna considerare il motivo di questa operazione:
 * 		Fornire le ricevute al ragioniere cosicché possa svolgere il suo lavoro contabile.
 * Spesso i software dedicati alla ragioneria supportano una grande varietà di formati di input
 * per importare i documenti, si sfrutterà questa occasione per usare le funzionalità NoSQL di MariaDB,
 * appunto le funzioni relative all'elaborazione di documenti JSON.
 * 
 * Inoltre di recente anche SQLite ha aggiunto tali funzionalità, rendendo dunque queste operazioni
 * possibili anche del DBMS embedded più diffuso al mondo.
 * 
 * */

SELECT
	R.anno 			AS `anno_ricevuta`, 
	R.progressivo 	AS `numero_ricevuta`,
	R.`data` 		AS `data_ricevuta`,
	R.importo 		AS `importo`,
	R.nota 			AS `nota`,
	JSON_OBJECT(
		"codice_fiscale", 	S.codice_fiscale,
		"nome", 			S.nome,
		"cognome",			S.cognome
	)				AS `intestatario`,
	JSON_ARRAYAGG(
		JSON_OBJECT(
			"descrizione",	CONCAT("Pagamento quota ", LOWER(C.tipo) ),
			"data",			C.`data`,
			"nota",			C.nota,
			"importo",		C.importo
		)
	) 				AS `righe`
		
		
FROM Ricevuta R
JOIN Socio S USING (id_socio)
JOIN Contributo C USING (id_ricevuta)
GROUP BY R.id_ricevuta, S.id_socio;


-- --------------------------------------------------------------------------------

/* * Operazione 6: Registrare un ingresso.
 * 	E' stato creato appositamente il trigger _PrevieniIngressoSocioIrregolare_ che genera uno stato di errore
 *  nel caso il socio sia irregolare, dunque questa operazione può fallire.
 * */

INSERT INTO Ingresso (id_socio) VALUES (@id_socio);

-- --------------------------------------------------------------------------------

/* * Operazione 7: Stampare un report sull'affluenza settimanale.
 * Per la computazione del report affluenza è stato scelto di usare una procedura che restituisca il risultato
 * su di una tabella temporanea, la procedura prende come input una data, dalla quale partirà dal primo giorno di quella settimana
 * e andrà a riempire la tabella temporanea RisultatoReportAffluenza_tmp.
 * */
CALL computaReportAffluenza("2022-11-07");
SELECT * from RisultatoReportAffluenza_tmp;


