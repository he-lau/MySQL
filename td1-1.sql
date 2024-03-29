DROP DATABASE IF EXISTS universite;
CREATE DATABASE  universite;
USE universite;

CREATE TABLE ETUDIANT(
						NumEtudiant INT NOT NULL PRIMARY KEY,
					  NomE CHAR(20),
					  Adresse CHAR(50),
					  Date_Naissance DATE
					  );

CREATE TABLE RESPONSABLE(
						NumResponsable INT NOT NULL PRIMARY KEY,
						NomR CHAR(20),
						Departement CHAR(20)
						);

CREATE TABLE UNITE_VALEUR(
						Uv CHAR(20) NOT NULL Primary Key,
						Nb_Heures INT,
						NumResponsable INT REFERENCES RESPONSABLE(NumResponsable)
						);

CREATE TABLE INSCRIPTION(
						 NumEtudiant INT NOT NULL REFERENCES ETUDIANT(NumEtudiant),
						 Uv CHAR(20) NOT NULL REFERENCES UNITE_VALEUR(Uv),
						 Date_Inscription DATE,
						 PRIMARY KEY(NumEtudiant,Uv)
					   );

CREATE TABLE RESULTAT (
						 NumEtudiant INT NOT NULL REFERENCES ETUDIANT(NumEtudiant),
						 Uv CHAR(20) NOT NULL REFERENCES INSCRIPTION(Uv),
					   Code_Controle INT NOT NULL,
						 Note INT,
					   PRIMARY KEY(NumEtudiant,Uv,Code_Controle)
					   );


INSERT INTO ETUDIANT VALUES(1,'Alice','XX Rue XXXX','2000-01-01');
INSERT INTO ETUDIANT VALUES(2,'Bob','XX Rue XXXX','2000-01-02');
INSERT INTO ETUDIANT VALUES(3,'Tom','XX Rue XXXX','2000-01-03');
INSERT INTO ETUDIANT VALUES(4,'George','XX Rue XXXX','2000-01-04');

INSERT INTO RESPONSABLE VALUES(1,'Alice','Informatique');
INSERT INTO RESPONSABLE VALUES(2,'Bob','Informatique');
INSERT INTO RESPONSABLE VALUES(3,'Tom','Informatique');
INSERT INTO RESPONSABLE VALUES(4,'George','Informatique');

INSERT INTO UNITE_VALEUR VALUES('BD',10,1);
INSERT INTO UNITE_VALEUR VALUES('IA',20,2);
INSERT INTO UNITE_VALEUR VALUES('C',30,3);
INSERT INTO UNITE_VALEUR VALUES('JAVA',40,4);

INSERT INTO INSCRIPTION VALUES(1,'BD','2022-01-01');
INSERT INTO INSCRIPTION VALUES(1,'IA','2022-01-02');
INSERT INTO INSCRIPTION VALUES(2,'IA','2022-01-02');
INSERT INTO INSCRIPTION VALUES(3,'BD','2022-01-01');
INSERT INTO INSCRIPTION VALUES(4,'JAVA','2022-01-02');

INSERT INTO RESULTAT VALUES(1,'BD',1,20);
INSERT INTO RESULTAT VALUES(1,'IA',1,12);
INSERT INTO RESULTAT VALUES(2,'IA',2,20);
INSERT INTO RESULTAT VALUES(3,'BD',3,20);
INSERT INTO RESULTAT VALUES(4,'JAVA',4,20);


SELECT NumEtudiant,NomE
FROM ETUDIANT
NATURAL JOIN INSCRIPTION
WHERE(Uv='BD');

SELECT NomE
FROM ETUDIANT
NATURAL JOIN INSCRIPTION
NATURAL JOIN UNITE_VALEUR
NATURAL JOIN RESPONSABLE
WHERE (Departement = 'Informatique');

SELECT NomE
FROM ETUDIANT
JOIN RESULTAT
ON ETUDIANT.NumEtudiant = RESULTAT.NumEtudiant
WHERE (Uv='IA' AND Note>=12);
