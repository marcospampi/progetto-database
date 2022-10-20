# Analisi requisiti
Si vuole sviluppare una base dati per un software gestionale di una palestra,
devono essere gestite i *soci*, i *contributi* dei soci, le *attività*, e inoltre
deve essere possibile gestire le *schede degli esercizi*.  

Un **socio** è descritto da ( nome, cognome, codice fiscale, data di nascita, residenza, contatto telefonico, email ),
inoltre devono essere conservati i documenti digitalizzati, quali ( modulo di iscrizione, certificato medico ) del socio
all'interno del database con la relativa data di immissione.

Le **attività** sono offerte dal club ai soci, ogni attività deve essere descritta da un nome, una fascia di età, un costo di partecipazione.
Ogni **attività** *dispone* di un **calendario** settimanale.

Ogni **socio** può *partecipare* a più attività, la partecipazione ad una attività può includere la partecipazione ad una seconda 
attività ( chi partecipa a KB partecipa a SP )

Ogni **socio** ha una serie di *contributi da versare mensilmente* per le sue partecipazioni, i contributi vanno versati mensilmente, e le registrazioni vanno descritte da un riferimento all'attività,
il valore del contributo ( modificabile dall'operatore ), la data di pagamento e la data di scadenza.

Ogni **socio** ha anche il *contributo annuale* di iscrizione, anch'esso deve essere descritto da un valore monetario, data di pagamento e data scadenza.

Vanno registrati gli **ingressi** dei soci, con eventuale orario di uscita ( eventualmente considerare una permanenza di due ore ),
un socio non può registrare ingresso se ha l'iscrizione scaduta o non ha versato il contributo mensile.

E' necessario mantenere un catalogo di esercizi per la attività 'sala pesi', ogni esercizio è descritto da un titolo, una nota e una serie di link vari ( youtube, documenti pdf ) dove viene spiegato come effettuare l'esercizio.

Una scheda di esercizi è composto da una sequenza di esercizi, con numero di serie, ripetizioni ed eventuale periodo di riposo, cui viene considerato di default 90 secondi, è descritta da una data di inizio e data di fine.

Ogni partecipante all'attività "sala pesi" può essere assegnato ad una categoria, e tale categoria è in relazione con le varie schede di esercizi, inoltre deve essere possibile assegnare schede singole a singoli soci.
