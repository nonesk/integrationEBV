

CREATE TABLE TRANSCRIPTS(
	idT  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	idG  INTEGER NOT NULL ,
	idP  INTEGER ,
	PRIMARY KEY (idT) ,
	
	FOREIGN KEY (idG) REFERENCES GENES(idG),
	FOREIGN KEY (idP) REFERENCES PROTEINS(idP)
);


CREATE TABLE Laboratoire(
	idL       INTEGER AUTO_INCREMENT NOT NULL ,
	nom       TEXT NOT NULL ,
	acronyme  TEXT ,
	PRIMARY KEY (idL)
);


CREATE TABLE Conditions(
	idC  INTEGER AUTO_INCREMENT NOT NULL ,
	PRIMARY KEY (idC)
);


CREATE TABLE GENES(
	idG         INTEGER AUTO_INCREMENT NOT NULL ,
	nom         TEXT NOT NULL ,
	locus_tag   TEXT ,
	start       TEXT ,
	end         TEXT ,
	uniprot_id  TEXT ,
	PRIMARY KEY (idG)
);


CREATE TABLE Maladies(
	idM  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idM)
);


CREATE TABLE PROTEINS(
	idP                 INTEGER NOT NULL ,
	nom                 TEXT NOT NULL ,
	fullName            TEXT ,
	poids               REAL ,
	longueur            INTEGER ,
	UniProtKBSwissProt  TEXT ,
	UniProtKBTrEMBL     TEXT ,
	GOA                 TEXT ,
	InterPro            TEXT ,
	RefSeq_id           TEXT ,
	idT INTEGER ,
	PRIMARY KEY (idP) ,
	
	FOREIGN KEY (idT) REFERENCES TRANSCRIPTS(idT)
);


CREATE TABLE Methodes_detection(
	idMD    INTEGER NOT NULL ,
	psimi   TEXT NOT NULL ,
	label   TEXT NOT NULL ,
	idMD_1  INTEGER ,
	PRIMARY KEY (idMD) ,
	
	FOREIGN KEY (idMD_1) REFERENCES Methodes_detection(idMD)
);


CREATE TABLE Chercheuse(
	idC  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idC) ,
	
	FOREIGN KEY (idP) REFERENCES Pays(idP)
);


CREATE TABLE Pays(
	idP  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idP)
);


CREATE TABLE PUBLICATIONS(
	idA         INTEGER AUTO_INCREMENT NOT NULL ,
	titre       TEXT NOT NULL ,
	ref_pubmed  TEXT NOT NULL ,
	annee       NUMERIC NOT NULL ,
	idJ         INTEGER NOT NULL ,
	PRIMARY KEY (idA) ,
	
	FOREIGN KEY (idJ) REFERENCES Journaux(idJ)
);


CREATE TABLE Journaux(
	idJ  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idJ)
);


CREATE TABLE SEQUENCES(
	idS  INTEGER NOT NULL ,
	seq  TEXT NOT NULL ,
	idP  INTEGER ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idP) REFERENCES PROTEINS(idP)
);


CREATE TABLE INTERACTIONS(
	idI           INTEGER NOT NULL ,
	idP           INTEGER ,
	idP_PROTEINS  INTEGER ,
	idTI          INTEGER ,
	PRIMARY KEY (idI) ,
	
	FOREIGN KEY (idP) REFERENCES PROTEINS(idP),
	FOREIGN KEY (idP_PROTEINS) REFERENCES PROTEINS(idP),
	FOREIGN KEY (idTI) REFERENCES INTERACTION_TYPE(idTI)
);


CREATE TABLE INTERACTION_TYPE(
	idTI   INTEGER NOT NULL ,
	psimi  TEXT NOT NULL ,
	label  TEXT NOT NULL ,
	PRIMARY KEY (idTI)
);


CREATE TABLE UNIPROT_ACC(
	accession  TEXT NOT NULL ,
	idP        INTEGER ,
	PRIMARY KEY (accession) ,
	
	FOREIGN KEY (idP) REFERENCES PROTEINS(idP)
);


CREATE TABLE Observation(
	idL  INTEGER NOT NULL ,
	idC  INTEGER NOT NULL ,
	idG  INTEGER NOT NULL ,
	PRIMARY KEY (idL,idC,idG) ,
	
	FOREIGN KEY (idL) REFERENCES Laboratoire(idL),
	FOREIGN KEY (idC) REFERENCES Conditions(idC),
	FOREIGN KEY (idG) REFERENCES GENES(idG)
);


CREATE TABLE implication(
	idM  INTEGER NOT NULL ,
	idS  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idM,idS,idP) ,
	
	FOREIGN KEY (idM) REFERENCES Maladies(idM),
	FOREIGN KEY (idS) REFERENCES SEQUENCES(idS),
	FOREIGN KEY (idP) REFERENCES PROTEINS(idP)
);


CREATE TABLE detection(
	idMD  INTEGER NOT NULL ,
	idI   INTEGER NOT NULL ,
	PRIMARY KEY (idMD,idI) ,
	
	FOREIGN KEY (idMD) REFERENCES Methodes_detection(idMD),
	FOREIGN KEY (idI) REFERENCES INTERACTIONS(idI)
);


CREATE TABLE signature(
	ordre  INTEGER NOT NULL ,
	idC    INTEGER NOT NULL ,
	idA    INTEGER NOT NULL ,
	PRIMARY KEY (idC,idA) ,
	
	FOREIGN KEY (idC) REFERENCES Chercheuse(idC),
	FOREIGN KEY (idA) REFERENCES PUBLICATIONS(idA)
);


CREATE TABLE CITATION_PROTEIN(
	idA  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idA,idP) ,
	
	FOREIGN KEY (idA) REFERENCES PUBLICATIONS(idA),
	FOREIGN KEY (idP) REFERENCES PROTEINS(idP)
);


CREATE TABLE Travaille(
	idC  INTEGER NOT NULL ,
	idL  INTEGER NOT NULL ,
	PRIMARY KEY (idC,idL) ,
	
	FOREIGN KEY (idC) REFERENCES Chercheuse(idC),
	FOREIGN KEY (idL) REFERENCES Laboratoire(idL)
);


CREATE TABLE CITATION_MALADIE(
	idM  INTEGER NOT NULL ,
	idA  INTEGER NOT NULL ,
	PRIMARY KEY (idM,idA) ,
	
	FOREIGN KEY (idM) REFERENCES Maladies(idM),
	FOREIGN KEY (idA) REFERENCES PUBLICATIONS(idA)
);


CREATE TABLE CITATION_GENE(
	idA  INTEGER NOT NULL ,
	idG  INTEGER NOT NULL ,
	PRIMARY KEY (idA,idG) ,
	
	FOREIGN KEY (idA) REFERENCES PUBLICATIONS(idA),
	FOREIGN KEY (idG) REFERENCES GENES(idG)
);


