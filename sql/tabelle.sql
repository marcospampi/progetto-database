SET FOREIGN_KEY_CHECKS=0;

CREATE OR REPLACE TABLE Esercizio(
	id_esercizio INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(128) NOT NULL,
	fascia ENUM("Petto", "Bicipiti", "Dorso", "Gambe", "Spalle", "Tricipiti"),
	nota TEXT
);

CREATE OR REPLACE TABLE LinkEsercizio(
	id_esercizio INT,
	link VARCHAR(255),
	PRIMARY KEY(id_esercizio, link),
	FOREIGN KEY (id_esercizio) REFERENCES Esercizio (id_esercizio) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE CategoriaPesi (
	id_pesi INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(32) NOT NULL
);

CREATE OR REPLACE TABLE Scheda (
	id_scheda INT PRIMARY KEY AUTO_INCREMENT,
	id_pesi INT NOT NULL,
	nome VARCHAR(32) NOT NULL,
	data_immissione DATE DEFAULT CURDATE(),
	FOREIGN KEY (id_pesi) REFERENCES CategoriaPesi(id_pesi) ON DELETE CASCADE
);
CREATE OR REPLACE TABLE EsercizioScheda (
	id_scheda INT NOT NULL,
	id_esercizio INT NOT NULL,
	ordine SMALLINT NOT NULL,
	serie TINYINT NOT NULL,
	ripetizioni TINYINT NOT NULL,
	recupero TINYINT DEFAULT 120,
	FOREIGN KEY (id_scheda) REFERENCES Scheda(id_scheda) ON DELETE CASCADE,
	FOREIGN KEY (id_esercizio) REFERENCES Esercizio(id_esercizio) ON DELETE CASCADE

);

CREATE OR REPLACE TABLE Socio (
	id_socio INT PRIMARY KEY AUTO_INCREMENT,
	codice_fiscale CHAR(16) UNIQUE KEY,
	nome VARCHAR(32) NOT NULL,
	cognome VARCHAR(32) NOT NULL,
	data_nascita DATE,
	telefono VARCHAR(16),
	residenza VARCHAR(255),
	id_pesi INT,
	FOREIGN KEY (id_pesi) REFERENCES CategoriaPesi (id_pesi) ON DELETE SET NULL
);

CREATE OR REPLACE TABLE Attivita(
	id_attivita INT PRIMARY KEY AUTO_INCREMENT,
	titolo VARCHAR(32) NOT NULL,
	quota_partecipazione DECIMAL(6,2) DEFAULT 0
);
CREATE OR REPLACE TABLE PartecipazioneAttivita(
	id_attivita INT,
	id_socio INT,
	PRIMARY KEY (id_attivita, id_socio),
	FOREIGN KEY (id_socio) REFERENCES Socio(id_socio) ON DELETE CASCADE,
	FOREIGN KEY (id_attivita) REFERENCES Attivita(id_attivita) ON DELETE CASCADE
);
CREATE OR REPLACE TABLE Ingresso (
	`data` DATETIME DEFAULT NOW(),
	id_socio INT,
	tempo_trascorso SMALLINT DEFAULT 60,
	PRIMARY KEY(`data`, id_socio),
	FOREIGN KEY (id_socio) REFERENCES Socio(id_socio) ON DELETE CASCADE
);
CREATE OR REPLACE TABLE Calendario (
	ora TINYINT CHECK (ora BETWEEN 9 AND 20),
	giorno ENUM("Lunedi","Martedi","Mercoledi","Giovedi","Venerdi"),
	id_attivita INT,
	PRIMARY KEY( ora, giorno, id_attivita),
	FOREIGN KEY (id_attivita) REFERENCES Attivita(id_attivita)
);

CREATE OR REPLACE TABLE Ricevuta (
	id_ricevuta INT PRIMARY KEY AUTO_INCREMENT,
	anno SMALLINT,
	progressivo INT,
	id_socio INT,
	nota TEXT,
	importo DECIMAL(6,2) DEFAULT 0,
	`data` DATETIME,
	UNIQUE KEY (anno, progressivo),
	FOREIGN KEY (id_socio) REFERENCES Socio(id_socio) ON DELETE RESTRICT
);

CREATE OR REPLACE TABLE Contributo (
	id_contributo INT PRIMARY KEY AUTO_INCREMENT,
	id_socio INT NOT NULL,
	id_ricevuta INT NOT NULL,
	id_attivita INT,
	tipo ENUM("Mensile", "Annuale") NOT NULL,
	nota TEXT,
	importo DECIMAL(6,2) DEFAULT 0,
	`data` DATETIME DEFAULT NOW(),
	scadenza DATE DEFAULT (
		IF(	tipo = "Mensile", 
		/*THEN*/	DATE_ADD(COALESCE(`data`,NOW()), INTERVAL 1 MONTH ), 
		/*ELSE*/	DATE_ADD(COALESCE(`data`,NOW()), INTERVAL 1 YEAR )
		)
	),
	FOREIGN KEY (id_socio) REFERENCES Socio(id_socio) ON DELETE RESTRICT,
	FOREIGN KEY (id_attivita) REFERENCES Attivita(id_attivita) ON DELETE SET NULL,
	FOREIGN KEY (id_ricevuta) REFERENCES Ricevuta(id_ricevuta) ON DELETE CASCADE,
	INDEX(id_socio, `data`, scadenza, tipo)
);

SET FOREIGN_KEY_CHECKS=1;

