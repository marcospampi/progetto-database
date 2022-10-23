# Analisi requisiti
Si vuole sviluppare una base dati per un software gestionale di una palestra,
devono essere gestiti i *soci*, i *contributi* dei soci, le *attività*, e inoltre
deve essere possibile gestire le *schede degli esercizi*.  

## Descrizione generale

Un **socio** è descritto da ( nome, cognome, codice fiscale, data di nascita, residenza, contatto telefonico ),
inoltre devono essere conservati i documenti digitalizzati, quali ( modulo di iscrizione, certificato medico ) del socio
all'interno del database con la relativa data di immissione.

Le **attività** sono offerte dal club ai soci, ogni attività deve essere descritta da un nome e un costo di partecipazione.
Una **attività** *può disporre* di un **calendario** settimanale.

Ogni **socio** può *partecipare* a più attività, la partecipazione ad una attività può includere la partecipazione ad una seconda 
attività ( chi partecipa a KB partecipa a SP )

Ogni **socio** versa mensilmente *il contributo di partecipazione alle sue attività*, e le *registrazioni del versamento* possiedono un riferimento all'attività,
il valore del contributo ( modificabile dall'operatore ), la data di pagamento e la data di scadenza.

Ogni **socio** deve versare un *contributo annuale* di iscrizione e/o rinnovo, anch'esso deve essere descritto da un valore monetario, data di pagamento e data prossimo pagamento.

Ogni **contributo** versato deve essere registrato, ragguppando i versamenti in una **ricevuta**, cui progressivo è annuale.

Devono essere registrati gli **ingressi** dei soci, con eventuale orario di uscita ( eventualmente considerare una permanenza di due ore ),
un socio non può registrare ingresso se ha l'iscrizione scaduta o non ha versato i contributi mensile.

E' necessario mantenere un **catalogo di esercizi** per la attività *"Sala pesi"*, ogni esercizio è descritto da un *titolo*, una *nota* e una serie di link vari ( youtube, documenti pdf ) dove viene spiegato come effettuare l'esercizio.


Una **scheda di esercizi** è composto da una sequenza di **esercizi** ordinata, con numero di serie, ripetizioni ed eventuale periodo di riposo in secondi, cui viene considerato di default 120 secondi, una scheda deve avere un nome e una data di immissione.

Ogni partecipante all'attività "sala pesi" può essere assegnato ad una **categoria pesi**, e tale categoria è in relazione con le varie schede di esercizi, inoltre deve essere possibile assegnare schede singole a singoli soci, una categoria può essere descritta da un semplice nome.

## Glossario dei termini
| TERMINE            	| DESCRIZIONE                                                      	| SINONIMI            	| ATTRIBUTI                                                                      	| LEGAMI                      	|
|--------------------	|------------------------------------------------------------------	|---------------------	|--------------------------------------------------------------------------------	|-----------------------------	|
| Socio              	| Persona che partecipà alle attività del club.                    	|                     	| Nome, cognome, codice fiscale, data di nascita, residenza, contatto telefonico 	| Attività                    	|
| Attività           	| Servizio offerto dal club.                                       	| Corso               	| Nome, costo di partecipazione                                                  	| Socio, Calendario           	|
| Calendario         	| Giorni e orari di una attività                                   	|                     	| Implicitamente: giorno settimanale e ore.                                      	|                             	|
| Contributo         	| Spese di partecipazione.                                         	|                     	| Valore, attività, data pagamento, data prossimo pagamento                      	| Socio                       	|
| Contributo mensile 	| Versamento della quota di partecipazione mensile delle attività. 	| Mensile             	| “                                                                              	| Socio, Attività, Contributo 	|
| Contributo annuale 	| Versamento della quota annuale del socio.                        	| Iscrizione, rinnovo 	| “                                                                              	| Socio, Contributo           	|
| Ricevuta           	| Ricevuta pagamento delle quote del club.                         	|                     	| Anno, Documento, Data, Valore                                                          	| Socio, Contributi           	|
| Ingresso           	| Socio che partecipa alle attività.                               	|                     	| Data, ora entrata, ora uscita.                                                 	| Socio                       	|
| Esercizio          	| Modello di esercizio della sala pesi.                            	|                     	| Titolo, nota, link+                                                            	|                             	|
| Scheda esercizi    	| Sequenza di esercizi.                                            	| Scheda              	| Nome, data immissione                                                          	| Esercizi                    	|
| Categoria pesi     	| Gruppo di persone che condividono una scheda                     	|                     	| Nome                                                                           	| Socio, Scheda               	|

## Operazioni comuni
1. Registrazione nuovo socio.
2. Associare un socio a una attività.
3. Creare una scheda di esercizi.
4. Registrare il pagamento di un contributo.
5. Verificare la regolarità delle quote di un socio.
6. Stampare le ricevute effettuate dentro un range di date.
7. Confrontare gli ingressi di due differenti settimana per giorno e ora.
8. Stampare una scheda esercizi.