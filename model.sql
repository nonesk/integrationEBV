#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Transcript
#------------------------------------------------------------

CREATE TABLE Transcript(
        idT int (11) Auto_increment  NOT NULL ,
        nom Varchar (25) NOT NULL ,
        idG Int NOT NULL ,
        idP Int NOT NULL ,
        PRIMARY KEY (idT ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Laboratoire
#------------------------------------------------------------

CREATE TABLE Laboratoire(
        idL      int (11) Auto_increment  NOT NULL ,
        nom      Varchar (25) NOT NULL ,
        acronyme Varchar (10) ,
        PRIMARY KEY (idL ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Conditions
#------------------------------------------------------------

CREATE TABLE Conditions(
        idC int (11) Auto_increment  NOT NULL ,
        PRIMARY KEY (idC )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Gène
#------------------------------------------------------------

CREATE TABLE Gene(
        idG         int (11) Auto_increment  NOT NULL ,
        nom         Varchar (25) NOT NULL ,
        tag_locus   Varchar (25) NOT NULL ,
        start       Int ,
        end         Int ,
        ref_uniprot Varchar (25) ,
        PRIMARY KEY (idG ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Maladies
#------------------------------------------------------------

CREATE TABLE Maladies(
        idM int (11) Auto_increment  NOT NULL ,
        nom Varchar (25) NOT NULL ,
        PRIMARY KEY (idM ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Protéines
#------------------------------------------------------------

CREATE TABLE Proteines(
        idP         int (11) Auto_increment  NOT NULL ,
        nom         Varchar (25) NOT NULL ,
        poids       Float ,
        longueur    Int ,
        ref_uniprot Varchar (25) ,
        idT         Int NOT NULL ,
        PRIMARY KEY (idP ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Methodes_detection
#------------------------------------------------------------

CREATE TABLE Methodes_detection(
        idMD   int (11) Auto_increment  NOT NULL ,
        label  Varchar (25) NOT NULL ,
        idMD_1 Int NOT NULL ,
        PRIMARY KEY (idMD )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Chercheuse
#------------------------------------------------------------

CREATE TABLE Chercheuse(
        idC int (11) Auto_increment  NOT NULL ,
        nom Varchar (25) NOT NULL ,
        idP Int NOT NULL ,
        PRIMARY KEY (idC )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Pays
#------------------------------------------------------------

CREATE TABLE Pays(
        idP int (11) Auto_increment  NOT NULL ,
        nom Varchar (25) NOT NULL ,
        PRIMARY KEY (idP ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Articles
#------------------------------------------------------------

CREATE TABLE Articles(
        idA        int (11) Auto_increment  NOT NULL ,
        titre      Varchar (100) NOT NULL ,
        ref_pubmed Varchar (50) ,
        annee      Year NOT NULL ,
        idJ        Int NOT NULL ,
        PRIMARY KEY (idA ) ,
        UNIQUE (ref_pubmed )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Journaux
#------------------------------------------------------------

CREATE TABLE Journaux(
        idJ int (11) Auto_increment  NOT NULL ,
        nom Varchar (50) NOT NULL ,
        PRIMARY KEY (idJ ) ,
        UNIQUE (nom )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Sequences
#------------------------------------------------------------

CREATE TABLE Sequences(
        idS int (11) Auto_increment  NOT NULL ,
        seq Varchar (800) NOT NULL ,
        idP Int NOT NULL ,
        PRIMARY KEY (idS ) ,
        UNIQUE (seq )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Interactions
#------------------------------------------------------------

CREATE TABLE Interactions(
        idI           int (11) Auto_increment  NOT NULL ,
        ref_PSIMI     Varchar (25) NOT NULL ,
        idP           Int NOT NULL ,
        idP_Proteines Int NOT NULL ,
        idTI          Int ,
        PRIMARY KEY (idI )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: seq_primaire
#------------------------------------------------------------

CREATE TABLE seq_primaire(
        idS Int NOT NULL ,
        PRIMARY KEY (idS )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: seq_alt
#------------------------------------------------------------

CREATE TABLE seq_alt(
        idS Int NOT NULL ,
        PRIMARY KEY (idS )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Modif_posttrad
#------------------------------------------------------------

CREATE TABLE Modif_posttrad(
        idM int (11) Auto_increment  NOT NULL ,
        PRIMARY KEY (idM )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Type_interaction
#------------------------------------------------------------

CREATE TABLE Type_interaction(
        idTI int (11) Auto_increment  NOT NULL ,
        PRIMARY KEY (idTI )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Observation
#------------------------------------------------------------

CREATE TABLE Observation(
        idL Int NOT NULL ,
        idC Int NOT NULL ,
        idG Int NOT NULL ,
        PRIMARY KEY (idL ,idC ,idG )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: implication
#------------------------------------------------------------

CREATE TABLE implication(
        idM Int NOT NULL ,
        idS Int NOT NULL ,
        idP Int NOT NULL ,
        PRIMARY KEY (idM ,idS ,idP )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: detection
#------------------------------------------------------------

CREATE TABLE detection(
        idMD Int NOT NULL ,
        idI  Int NOT NULL ,
        PRIMARY KEY (idMD ,idI )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: signature
#------------------------------------------------------------

CREATE TABLE signature(
        ordre Int NOT NULL ,
        idC   Int NOT NULL ,
        idA   Int NOT NULL ,
        PRIMARY KEY (idC ,idA )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: citation
#------------------------------------------------------------

CREATE TABLE citation(
        idA Int NOT NULL ,
        idM Int NOT NULL ,
        idP Int NOT NULL ,
        PRIMARY KEY (idA ,idM ,idP )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Travaille
#------------------------------------------------------------

CREATE TABLE Travaille(
        idC Int NOT NULL ,
        idL Int NOT NULL ,
        PRIMARY KEY (idC ,idL )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: modification
#------------------------------------------------------------

CREATE TABLE modification(
        idS           Int NOT NULL ,
        idS_Sequences Int NOT NULL ,
        idM           Int NOT NULL ,
        PRIMARY KEY (idS ,idS_Sequences ,idM )
)ENGINE=InnoDB;

ALTER TABLE Transcript ADD CONSTRAINT FK_Transcript_idG FOREIGN KEY (idG) REFERENCES Gene(idG);
ALTER TABLE Transcript ADD CONSTRAINT FK_Transcript_idP FOREIGN KEY (idP) REFERENCES Proteines(idP);
ALTER TABLE Proteines ADD CONSTRAINT FK_Proteines_idT FOREIGN KEY (idT) REFERENCES Transcript(idT);
ALTER TABLE Methodes_detection ADD CONSTRAINT FK_Methodes_detection_idMD_1 FOREIGN KEY (idMD_1) REFERENCES Methodes_detection(idMD);
ALTER TABLE Chercheuse ADD CONSTRAINT FK_Chercheuse_idP FOREIGN KEY (idP) REFERENCES Pays(idP);
ALTER TABLE Articles ADD CONSTRAINT FK_Articles_idJ FOREIGN KEY (idJ) REFERENCES Journaux(idJ);
ALTER TABLE Sequences ADD CONSTRAINT FK_Sequences_idP FOREIGN KEY (idP) REFERENCES Proteines(idP);
ALTER TABLE Interactions ADD CONSTRAINT FK_Interactions_idP FOREIGN KEY (idP) REFERENCES Proteines(idP);
ALTER TABLE Interactions ADD CONSTRAINT FK_Interactions_idP_Proteines FOREIGN KEY (idP_Proteines) REFERENCES Proteines(idP);
ALTER TABLE Interactions ADD CONSTRAINT FK_Interactions_idTI FOREIGN KEY (idTI) REFERENCES Type_interaction(idTI);
ALTER TABLE seq_primaire ADD CONSTRAINT FK_seq_primaire_idS FOREIGN KEY (idS) REFERENCES Sequences(idS);
ALTER TABLE seq_alt ADD CONSTRAINT FK_seq_alt_idS FOREIGN KEY (idS) REFERENCES Sequences(idS);
ALTER TABLE Observation ADD CONSTRAINT FK_Observation_idL FOREIGN KEY (idL) REFERENCES Laboratoire(idL);
ALTER TABLE Observation ADD CONSTRAINT FK_Observation_idC FOREIGN KEY (idC) REFERENCES Conditions(idC);
ALTER TABLE Observation ADD CONSTRAINT FK_Observation_idG FOREIGN KEY (idG) REFERENCES Gene(idG);
ALTER TABLE implication ADD CONSTRAINT FK_implication_idM FOREIGN KEY (idM) REFERENCES Maladies(idM);
ALTER TABLE implication ADD CONSTRAINT FK_implication_idS FOREIGN KEY (idS) REFERENCES Sequences(idS);
ALTER TABLE implication ADD CONSTRAINT FK_implication_idP FOREIGN KEY (idP) REFERENCES Proteines(idP);
ALTER TABLE detection ADD CONSTRAINT FK_detection_idMD FOREIGN KEY (idMD) REFERENCES Methodes_detection(idMD);
ALTER TABLE detection ADD CONSTRAINT FK_detection_idI FOREIGN KEY (idI) REFERENCES Interactions(idI);
ALTER TABLE signature ADD CONSTRAINT FK_signature_idC FOREIGN KEY (idC) REFERENCES Chercheuse(idC);
ALTER TABLE signature ADD CONSTRAINT FK_signature_idA FOREIGN KEY (idA) REFERENCES Articles(idA);
ALTER TABLE citation ADD CONSTRAINT FK_citation_idA FOREIGN KEY (idA) REFERENCES Articles(idA);
ALTER TABLE citation ADD CONSTRAINT FK_citation_idM FOREIGN KEY (idM) REFERENCES Maladies(idM);
ALTER TABLE citation ADD CONSTRAINT FK_citation_idP FOREIGN KEY (idP) REFERENCES Proteines(idP);
ALTER TABLE Travaille ADD CONSTRAINT FK_Travaille_idC FOREIGN KEY (idC) REFERENCES Chercheuse(idC);
ALTER TABLE Travaille ADD CONSTRAINT FK_Travaille_idL FOREIGN KEY (idL) REFERENCES Laboratoire(idL);
ALTER TABLE modification ADD CONSTRAINT FK_modification_idS FOREIGN KEY (idS) REFERENCES Sequences(idS);
ALTER TABLE modification ADD CONSTRAINT FK_modification_idS_Sequences FOREIGN KEY (idS_Sequences) REFERENCES Sequences(idS);
ALTER TABLE modification ADD CONSTRAINT FK_modification_idM FOREIGN KEY (idM) REFERENCES Modif_posttrad(idM);
