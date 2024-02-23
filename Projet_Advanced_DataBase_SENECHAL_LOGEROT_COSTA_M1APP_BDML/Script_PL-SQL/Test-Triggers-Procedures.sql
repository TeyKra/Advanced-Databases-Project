REM   Script: Test-Triggers-Procédures.sql
REM   Script employé pour tester les déclencheurs et procédures créés.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Vérification du déclencheur associé aux Spectacles et Compagnie_Théâtrale
--Vérification: il est impossible d'ajouter un spectacle attribué à plusieurs compagnies théâtrales.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) VALUES (0011, 1, '2021-04-18', 0004, 0001, 0007);

-- Vérification du déclencheur 'Rémunération'
-- Vérification : une représentation ne peut être ajoutée que si les billets sont préalablement créés, assurant ainsi le calcul de la rémunération de la Compagnie_Théâtrale.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) VALUES (0011, 1, '2021-04-18', 0001, 0001, 0007);

-- Vérification du déclencheur 'Superposition des Théâtres'
-- Ce déclencheur garantit qu'un seul spectacle est organisé par soir dans chaque théâtre.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) VALUES (0051, 1, '2021-02-22', 0002, 0002, 0002);


-- Vérification du déclencheur 'Superposition des Compagnie_Théâtrale'
-- Ce déclencheur vérifie qu'une Compagnie_Théâtrale ne présente qu'un seul spectacle par soirée.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) VALUES (0051, 1, '2021-01-01', 0001, 0001, 0001);


-- Vérification du déclencheur 'Salaires et Représentation'
-- Confirmation du bon fonctionnement du déclencheur 'Salaires_Spectacle'.
SELECT salaires FROM Representation;


-- Vérification de la procédure 'Villes par Compagnie_Théâtrale'
-- Cette procédure stockée récupère les villes dans lesquelles une Compagnie_Théâtrale s'est produite durant une période spécifique.
EXECUTE ville_Compagnie_Theatrale(0001, '2021-01-01', '2021-02-01')


EXECUTE ville_Compagnie_Theatrale(0001, '2021-01-01', '2021-03-01')


-- Vérification de la procédure 'Prix selon le jour'
-- Évaluation de la procédure pour déterminer le prix quotidien du billet.
EXECUTE price_day('2021-02-22')


-- Vérification de la procédure de distribution des prix
-- Cette procédure renvoie la répartition des prix en fonction des deux types de tarifs.
EXECUTE price_Spectacle(0001)



-- Prévisualisation avant l'ajout
-- Nous examinons les données avant de les insérer dans la table des dates.
SELECT * FROM Compagnie_Theatrale;

SELECT * FROM Theatre;

SELECT * FROM Representation;

SELECT * FROM REMUNERER;

insert into date_theatre values ('2021-01-08');

update date_theatre set date_actuelle = '2021-01-07' where date_actuelle = '2021-01-08';

-- Observation après l'ajout
-- Nous constatons que les données ont été modifiées, ce qui indique que les déclencheurs fonctionnent correctement.
SELECT * FROM Compagnie_Theatrale;

SELECT * FROM Theatre;

SELECT * FROM Representation;

SELECT * FROM REMUNERER;

