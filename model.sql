#------------------------------------------------------------
#        Script SQLite  
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Transcript
#------------------------------------------------------------
CREATE TABLE Transcript(
	idT  INTEGER autoincrement NOT NULL ,
	nom  TEXT NOT NULL ,
	idG  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idT) ,
	
	FOREIGN KEY (idG) REFERENCES Gene(idG),
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


#------------------------------------------------------------
# Table: Laboratoire
#------------------------------------------------------------
CREATE TABLE Laboratoire(
	idL       INTEGER autoincrement NOT NULL ,
	nom       TEXT NOT NULL ,
	acronyme  TEXT ,
	PRIMARY KEY (idL)
);


#------------------------------------------------------------
# Table: Conditions
#------------------------------------------------------------
CREATE TABLE Conditions(
	idC  INTEGER autoincrement NOT NULL ,
	PRIMARY KEY (idC)
);


#------------------------------------------------------------
# Table: Gène
#------------------------------------------------------------
CREATE TABLE Gene(
	idG          INTEGER autoincrement NOT NULL ,
	nom          TEXT NOT NULL ,
	tag_locus    TEXT NOT NULL ,
	start        INTEGER ,
	end          INTEGER ,
	ref_uniprot  TEXT ,
	PRIMARY KEY (idG)
);


#------------------------------------------------------------
# Table: Maladies
#------------------------------------------------------------
CREATE TABLE Maladies(
	idM  INTEGER autoincrement NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idM)
);


#------------------------------------------------------------
# Table: Protéines
#------------------------------------------------------------
CREATE TABLE Proteines(
	idP          INTEGER autoincrement NOT NULL ,
	nom          TEXT NOT NULL ,
	poids        REAL ,
	longueur     INTEGER ,
	ref_uniprot  TEXT ,
	idT          INTEGER NOT NULL ,
	PRIMARY KEY (idP) ,
	
	FOREIGN KEY (idT) REFERENCES Transcript(idT)
);


#------------------------------------------------------------
# Table: Methodes_detection
#------------------------------------------------------------
CREATE TABLE Methodes_detection(
	idMD    INTEGER autoincrement NOT NULL ,
	label   TEXT NOT NULL ,
	idMD_1  INTEGER NOT NULL ,
	PRIMARY KEY (idMD) ,
	
	FOREIGN KEY (idMD_1) REFERENCES Methodes_detection(idMD)
);


#------------------------------------------------------------
# Table: Chercheuse
#------------------------------------------------------------
CREATE TABLE Chercheuse(
	idC  INTEGER autoincrement NOT NULL ,
	nom  TEXT NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idC) ,
	
	FOREIGN KEY (idP) REFERENCES Pays(idP)
);


#------------------------------------------------------------
# Table: Pays
#------------------------------------------------------------
CREATE TABLE Pays(
	idP  INTEGER autoincrement NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idP)
);


#------------------------------------------------------------
# Table: Articles
#------------------------------------------------------------
CREATE TABLE Articles(
	idA         INTEGER autoincrement NOT NULL ,
	titre       TEXT NOT NULL ,
	ref_pubmed  TEXT NOT NULL ,
	annee       NUMERIC NOT NULL ,
	idJ         INTEGER NOT NULL ,
	PRIMARY KEY (idA) ,
	
	FOREIGN KEY (idJ) REFERENCES Journaux(idJ)
);


#------------------------------------------------------------
# Table: Journaux
#------------------------------------------------------------
CREATE TABLE Journaux(
	idJ  INTEGER autoincrement NOT NULL ,
	nom  TEXT NOT NULL ,
	PRIMARY KEY (idJ)
);


#------------------------------------------------------------
# Table: Sequences
#------------------------------------------------------------
CREATE TABLE Sequences(
	idS  INTEGER autoincrement NOT NULL ,
	seq  TEXT NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


#------------------------------------------------------------
# Table: Interactions
#------------------------------------------------------------
CREATE TABLE Interactions(
	idI            INTEGER autoincrement NOT NULL ,
	ref_PSIMI      TEXT NOT NULL ,
	idP            INTEGER NOT NULL ,
	idP_Proteines  INTEGER NOT NULL ,
	idTI           INTEGER ,
	PRIMARY KEY (idI) ,
	
	FOREIGN KEY (idP) REFERENCES Proteines(idP),
	FOREIGN KEY (idP_Proteines) REFERENCES Proteines(idP),
	FOREIGN KEY (idTI) REFERENCES Type_interaction(idTI)
);


#------------------------------------------------------------
# Table: seq_primaire
#------------------------------------------------------------
CREATE TABLE seq_primaire(
	idS  INTEGER NOT NULL ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idS) REFERENCES Sequences(idS)
);


#------------------------------------------------------------
# Table: seq_alt
#------------------------------------------------------------
CREATE TABLE seq_alt(
	idS  INTEGER NOT NULL ,
	PRIMARY KEY (idS) ,
	
	FOREIGN KEY (idS) REFERENCES Sequences(idS)
);


#------------------------------------------------------------
# Table: Modif_posttrad
#------------------------------------------------------------
CREATE TABLE Modif_posttrad(
	idM  INTEGER autoincrement NOT NULL ,
	PRIMARY KEY (idM)
);


#------------------------------------------------------------
# Table: Type_interaction
#------------------------------------------------------------
CREATE TABLE Type_interaction(
	idTI  INTEGER autoincrement NOT NULL ,
	PRIMARY KEY (idTI)
);


#------------------------------------------------------------
# Table: Observation
#------------------------------------------------------------
CREATE TABLE Observation(
	idL  INTEGER NOT NULL ,
	idC  INTEGER NOT NULL ,
	idG  INTEGER NOT NULL ,
	PRIMARY KEY (idL,idC,idG) ,
	
	FOREIGN KEY (idL) REFERENCES Laboratoire(idL),
	FOREIGN KEY (idC) REFERENCES Conditions(idC),
	FOREIGN KEY (idG) REFERENCES Gene(idG)
);


#------------------------------------------------------------
# Table: implication
#------------------------------------------------------------
CREATE TABLE implication(
	idM  INTEGER NOT NULL ,
	idS  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idM,idS,idP) ,
	
	FOREIGN KEY (idM) REFERENCES Maladies(idM),
	FOREIGN KEY (idS) REFERENCES Sequences(idS),
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


#------------------------------------------------------------
# Table: detection
#------------------------------------------------------------
CREATE TABLE detection(
	idMD  INTEGER NOT NULL ,
	idI   INTEGER NOT NULL ,
	PRIMARY KEY (idMD,idI) ,
	
	FOREIGN KEY (idMD) REFERENCES Methodes_detection(idMD),
	FOREIGN KEY (idI) REFERENCES Interactions(idI)
);


#------------------------------------------------------------
# Table: signature
#------------------------------------------------------------
CREATE TABLE signature(
	ordre  INTEGER NOT NULL ,
	idC    INTEGER NOT NULL ,
	idA    INTEGER NOT NULL ,
	PRIMARY KEY (idC,idA) ,
	
	FOREIGN KEY (idC) REFERENCES Chercheuse(idC),
	FOREIGN KEY (idA) REFERENCES Articles(idA)
);


#------------------------------------------------------------
# Table: citation
#------------------------------------------------------------
CREATE TABLE citation(
	idA  INTEGER NOT NULL ,
	idM  INTEGER NOT NULL ,
	idP  INTEGER NOT NULL ,
	PRIMARY KEY (idA,idM,idP) ,
	
	FOREIGN KEY (idA) REFERENCES Articles(idA),
	FOREIGN KEY (idM) REFERENCES Maladies(idM),
	FOREIGN KEY (idP) REFERENCES Proteines(idP)
);


#------------------------------------------------------------
# Table: Travaille
#------------------------------------------------------------
CREATE TABLE Travaille(
	idC  INTEGER NOT NULL ,
	idL  INTEGER NOT NULL ,
	PRIMARY KEY (idC,idL) ,
	
	FOREIGN KEY (idC) REFERENCES Chercheuse(idC),
	FOREIGN KEY (idL) REFERENCES Laboratoire(idL)
);


#------------------------------------------------------------
# Table: modification
#------------------------------------------------------------
CREATE TABLE modification(
	idS            INTEGER NOT NULL ,
	idS_Sequences  INTEGER NOT NULL ,
	idM            INTEGER NOT NULL ,
	PRIMARY KEY (idS,idS_Sequences,idM) ,
	
	FOREIGN KEY (idS) REFERENCES Sequences(idS),
	FOREIGN KEY (idS_Sequences) REFERENCES Sequences(idS),
	FOREIGN KEY (idM) REFERENCES Modif_posttrad(idM)
);


