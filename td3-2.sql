DROP DATABASE IF EXISTS livraison_journal;
CREATE DATABASE  livraison_journal;
USE livraison_journal;

CREATE TABLE JOURNAL(
  CODE_J INT NOT NULL PRIMARY KEY,
  TITRE CHAR(20) NOT NULL,
  PRIX FLOAT NOT NULL,
  TYPE CHAR(20),
  PERIODE CHAR(20) NOT NULL,
  ADR_J CHAR(20) NOT NULL
);

CREATE TABLE DEPOT(
  N_DEP INT NOT NULL PRIMARY KEY,
  NOM_DEP CHAR(30) NOT NULL,
  ADR CHAR(30) NOT NULL
);

CREATE TABLE LIVRAISON(
  N_DEP INT NOT NULL REFERENCES DEPOT(N_DEP) ,
  CODE_J INT NOT NULL REFERENCES JOURNAL(CODE_J),
  DATE_L DATE NOT NULL,
  QTE_L INT NOT NULL,
  QTE_R INT NOT NULL
);

INSERT INTO JOURNAL VALUES(110,"LE MONDE",4.5,"INFO","QUOTIDIEN","PARIS");
INSERT INTO JOURNAL VALUES(115,"LIBERATION",4.5,"INFO","QUOTIDIEN","PARIS");
INSERT INTO JOURNAL VALUES(120,"LA RECHERCHE",32,"SCIENCE","MENSUEL","PARIS");
INSERT INTO JOURNAL(CODE_J,TITRE,PRIX,PERIODE,ADR_J) VALUES(153,"LE CANARD",20,"HEBDO","MONTROUGE");
INSERT INTO JOURNAL VALUES(156,"SCIENCE ET VIE",20,"SCIENCE","MENSUEL","PARIS");
INSERT INTO JOURNAL VALUES(160,"ELLE",15,"FEMININ","HEBDO","MONTROUGE");

INSERT INTO DEPOT VALUES(310,"CAFE DE LA GARE","BURES");
INSERT INTO DEPOT VALUES(311,"CAFE DE PARIS","ARCEUIL");
INSERT INTO DEPOT VALUES(324,"PRESS_CITY","PARIS");
INSERT INTO DEPOT VALUES(325,"CAFE DU COMMERCE","ORSAY");
INSERT INTO DEPOT VALUES(328,"LE MOZARD","PARIS");
INSERT INTO DEPOT VALUES(345,"CAFE LE FONTENAY","BURES");
INSERT INTO DEPOT VALUES(357,"CAFE DE LA GARE","PARIS");
INSERT INTO DEPOT VALUES(381,"L'AVENTURE","BREUILLET");

INSERT INTO LIVRAISON VALUES(328,110,"1992-05-04",20,0);
INSERT INTO LIVRAISON VALUES(328,115,"1992-05-05",10,1);
INSERT INTO LIVRAISON VALUES(328,110,"1992-05-04",48,1);
INSERT INTO LIVRAISON VALUES(328,115,"1992-05-03",40,2);
INSERT INTO LIVRAISON VALUES(328,110,"1992-04-23",20,0);
INSERT INTO LIVRAISON VALUES(328,115,"1992-04-24",20,0);
INSERT INTO LIVRAISON VALUES(328,120,"1992-04-25",25,0);


SELECT TITRE, PRIX, TYPE, PERIODE
FROM JOURNAL;

SELECT TITRE
FROM JOURNAL
ORDER BY TITRE;

SELECT CODE_J
FROM JOURNAL
WHERE(PERIODE="MENSUEL");

SELECT *
FROM JOURNAL
ORDER BY TYPE ASC,PRIX ASC;

SELECT MIN(PRIX),AVG(PRIX),MAX(PRIX)
FROM JOURNAL;

SELECT CODE_J
FROM JOURNAL
WHERE TYPE IS NULL;

SELECT TYPE,MIN(PRIX),AVG(PRIX),MAX(PRIX)
FROM JOURNAL
GROUP BY TYPE;

SELECT N_DEP
FROM LIVRAISON
GROUP BY N_DEP
HAVING AVG(QTE_L) > 15;

/* SELECT DISTINCT : evite doublons*/
/*Comparaison avec MIN/MAX/AVG/SUM : SELECT ! ou utiliser HAVING*/
SELECT DISTINCT CODE_J, TITRE
FROM JOURNAL
WHERE PRIX > (SELECT 2*MIN(PRIX) FROM JOURNAL);

SELECT N_DEP
FROM LIVRAISON
GROUP BY N_DEP
HAVING COUNT(DISTINCT CODE_J) > 1;

SELECT DISTINCT CODE_J
FROM JOURNAL
WHERE CODE_J NOT IN (SELECT CODE_J FROM LIVRAISON WHERE N_DEP =007);

SELECT CODE_J
FROM LIVRAISON
WHERE N_DEP =007;
