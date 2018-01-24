

CREATE TABLE Transcript(
	idT  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	idG  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idT) ,
	
	FOREIGN KEY (idG) REFERENCES Gene(idG),
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
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


CREATE TABLE Gene(
	idG          INTEGER AUTO_INCREMENT NOT NULL ,
	nom          TEXT NOT NULL ,
	tag_locus    TEXT NOT NULL ,
	start        INTEGER ,
	end          INTEGER ,
	ref_uniprot  TEXT ,
	PRIMARY KEY (idG)
);


CREATE TABLE Maladies(
	idM  INTEGER AUTO_INCREMENT NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idM)
);


CREATE TABLE Proteines(
	idP          INTEGER AUTO_INCREMENT NOT NULL ,
	nom          TEXT NOT NULL ,
	poids        REAL ,
	longueur     INTEGER ,
	ref_uniprot  TEXT ,
	idT          INTEGER NOT NULL ,
	PRIMARY KEY (idP) ,
	
	FOREIGN KEY (idT) REFERENCES Transcript(idT)
);


CREATE TABLE Methodes_detection(
	idMD    INTEGER AUTO_INCREMENT NOT NULL ,
	label   TEXT NOT NULL ,
	idMD_1  INTEGER NOT NULL ,
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


CREATE TABLE Articles(
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


CREATE TABLE Sequences(
	idS  INTEGER AUTO_INCREMENT NOT NULL ,
	seq  TEXT NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


CREATE TABLE Interactions(
	idI            INTEGER AUTO_INCREMENT NOT NULL ,
	ref_PSIMI      TEXT NOT NULL ,
	idP            INTEGER NOT NULL ,
	idP_Proteines  INTEGER NOT NULL ,
	idTI           INTEGER ,
	PRIMARY KEY (idI) ,
	
	FOREIGN KEY (idP) REFERENCES Proteines(idP),
	FOREIGN KEY (idP_Proteines) REFERENCES Proteines(idP),
	FOREIGN KEY (idTI) REFERENCES Type_interaction(idTI)
);


CREATE TABLE seq_primaire(
	idS  INTEGER NOT NULL ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idS) REFERENCES Sequences(idS)
);


CREATE TABLE seq_alt(
	idS  INTEGER NOT NULL ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idS) REFERENCES Sequences(idS)
);


CREATE TABLE Modif_posttrad(
	idM  INTEGER AUTO_INCREMENT NOT NULL ,
	PRIMARY KEY (idM)
);


CREATE TABLE Type_interaction(
	idTI  INTEGER AUTO_INCREMENT NOT NULL ,
	PRIMARY KEY (idTI)
);


CREATE TABLE Observation(
	idL  INTEGER NOT NULL ,
	idC  INTEGER NOT NULL ,
	idG  INTEGER NOT NULL ,
	PRIMARY KEY (idL,idC,idG) ,
	
	FOREIGN KEY (idL) REFERENCES Laboratoire(idL),
	FOREIGN KEY (idC) REFERENCES Conditions(idC),
	FOREIGN KEY (idG) REFERENCES Gene(idG)
);


CREATE TABLE implication(
	idM  INTEGER NOT NULL ,
	idS  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idM,idS,idP) ,
	
	FOREIGN KEY (idM) REFERENCES Maladies(idM),
	FOREIGN KEY (idS) REFERENCES Sequences(idS),
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


CREATE TABLE detection(
	idMD  INTEGER NOT NULL ,
	idI   INTEGER NOT NULL ,
	PRIMARY KEY (idMD,idI) ,
	
	FOREIGN KEY (idMD) REFERENCES Methodes_detection(idMD),
	FOREIGN KEY (idI) REFERENCES Interactions(idI)
);


CREATE TABLE signature(
	ordre  INTEGER NOT NULL ,
	idC    INTEGER NOT NULL ,
	idA    INTEGER NOT NULL ,
	PRIMARY KEY (idC,idA) ,
	
	FOREIGN KEY (idC) REFERENCES Chercheuse(idC),
	FOREIGN KEY (idA) REFERENCES Articles(idA)
);


CREATE TABLE citation(
	idA  INTEGER NOT NULL ,
	idM  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idA,idM,idP) ,
	
	FOREIGN KEY (idA) REFERENCES Articles(idA),
	FOREIGN KEY (idM) REFERENCES Maladies(idM),
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


CREATE TABLE Travaille(
	idC  INTEGER NOT NULL ,
	idL  INTEGER NOT NULL ,
	PRIMARY KEY (idC,idL) ,
	
	FOREIGN KEY (idC) REFERENCES Chercheuse(idC),
	FOREIGN KEY (idL) REFERENCES Laboratoire(idL)
);


CREATE TABLE modification(
	idS            INTEGER NOT NULL ,
	idS_Sequences  INTEGER NOT NULL ,
	idM            INTEGER NOT NULL ,
	PRIMARY KEY (idS,idS_Sequences,idM) ,
	
	FOREIGN KEY (idS) REFERENCES Sequences(idS),
	FOREIGN KEY (idS_Sequences) REFERENCES Sequences(idS),
	FOREIGN KEY (idM) REFERENCES Modif_posttrad(idM)
);


