REM   Script: Insertions.sql
REM   Ajout de données aux diverses tables de la base de données.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';



--Insertion Theatre 

-- Theatre 1
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0001, 'Éclipse Lyonnaise', 55, '10 Allée des Tilleuls, Lyon', 355);

-- Theatre 2
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0002, 'Arlequin du Mans', 360, '8 Rue du Pré, Le Mans', 330);

-- Theatre 3
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0003, 'Aurore de Beauvais', 2450, '16 Avenue Gambetta, Beauvais', 395);

-- Theatre 4
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0004, 'Le Palais Parisien', 1625, '55 Boulevard Haussmann, Paris', 605);

-- Theatre 5
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0005, 'Oasis Montpelliérain', 610, '3 Rue de la Loge, Montpellier', 355);

-- Theatre 6
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0006, 'Le Dijonnais Royal', 565, '7 Avenue Foch, Dijon', 275);

-- Theatre 7
INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, frais_deplacement) 
VALUES (0007, 'La Comédie de Poitiers', 1175, '22 Boulevard Anatole France, Poitier', 175);



--Insertion Compagnie_Theatrale 

-- Compagnie 1
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0001, 'Éclat de Limoges', 30500, 0003);

-- Compagnie 2
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0002, 'Les Maîtres du Fou Rire', 65500, 0001);

-- Compagnie 3
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0003, 'Les Visionnaires de Infini', 102000, 0004);

-- Compagnie 4
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0004, 'Les Bateleurs du Sourire', 25500, 0007);

-- Compagnie 5
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0005, 'Les Lumières Mystiques', 46000, 0006);

-- Compagnie 6
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0006, 'Scène et Passion', 62500, 0002);

-- Compagnie 7
INSERT INTO Compagnie_Theatrale (ID_Compagnie_Theatrale, nom_Compagnie_Theatrale, budget, ID_theatre) 
VALUES (0007, 'Les Satires Bucoliques', 61500, 0002);


-- Insertion Employe 

-- Employe 1
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0001, 'Mario', 'staff', 62, 0001);

-- Employe 2
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0002, 'Jone', 'acteur', 122, 0001);

-- Employe 3
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0003, 'Maxime', 'staff', 112, 0001);

-- Employe 4
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0004, 'Romeo', 'staff', 111, 0001);

-- Employe 5
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0005, 'Juliette', 'staff', 72, 0001);

-- Employe 6
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0006, 'Jules', 'acteur', 80, 0002);

-- Employe 7
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0007, 'Morgan', 'staff', 70, 0002);

-- Employe 8
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0008, 'Thomas', 'acteur', 148, 0002);

-- Employe 9
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0009, 'Edwin', 'acteur', 111, 0002);

-- Employe 10
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0010, 'Loan', 'acteur', 120, 0002);

-- Employe 11
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0011, 'Mike', 'staff', 57, 0003);

-- Employe 12
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0012, 'Gaston', 'acteur', 59, 0003);

-- Employe 13
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0013, 'Henry', 'acteur', 76, 0003);

-- Employe 14
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0014, 'Marie', 'staff', 89, 0003);

-- Employe 15
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0015, 'Chloe', 'staff', 67, 0004);

-- Employe 16
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0016, 'Steve', 'staff', 62, 0004);

-- Employe 17
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0017, 'Esteban', 'acteur', 66, 0004);

-- Employe 18
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0018, 'Violette', 'staff', 112, 0004);

-- Employe 19
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0019, 'Alexandre', 'staff', 12, 0005);

-- Employe 20
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0020, 'Zoe', 'acteur', 10, 0005);

-- Employe 21
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0021, 'Axel', 'staff', 8, 0005);

-- Employe 22
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0022, 'Jerome', 'acteur', 78, 0005);

-- Employe 23
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0023, 'Ryan', 'acteur', 78, 0005);

-- Employe 24
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0024, 'Eloïse', 'acteur', 76, 0005);

-- Employe 25
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0025, 'Luc', 'staff', 80, 0005);

-- Employe 26
INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_Compagnie_Theatrale) VALUES (0026, 'Eric', 'staff', 2, 0006);


-- Insertion Spectacle 


-- Spectacle 1
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0001, 'Odyssée Lyrique', 505);

-- Spectacle 2
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0002, 'Les Ombres de la Scène', 555);

-- Spectacle 3
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0003, 'Les Masques de la Passion', 765);

-- Spectacle 4
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0004, 'Épopée de Bergerac', 450);

-- Spectacle 5
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0005, 'Aventurier Séducteur', 280);

-- Spectacle 6
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0006, 'Échiquier de la Vie', 445);

-- Spectacle 7
INSERT INTO Spectacle (ID_Spectacle, nom_Spectacle, couts_production) VALUES (0007, 'Les Voix Silencieuses', 625);



-- Insertion Subvention 

-- Subvention 1
INSERT INTO Subvention (ID_Subvention, nom_donateur, somme_donnee, frequence, date_debut, date_fin, ID_Compagnie_Theatrale) 
VALUES (0001, 'Fondation Art et Culture', 50500, null, '2021-01-01', '2021-01-01', 0001);

-- Subvention 2
INSERT INTO Subvention (ID_Subvention, nom_donateur, somme_donnee, frequence, date_debut, date_fin, ID_Compagnie_Theatrale) 
VALUES (0002, 'Conseil Municipal du Mans', 10500, 2, '2021-01-01', '2021-12-01', 0006);

-- Subvention 3
INSERT INTO Subvention (ID_Subvention, nom_donateur, somme_donnee, frequence, date_debut, date_fin, ID_Compagnie_Theatrale) 
VALUES (0003, 'Direction Régionale des Affaires Culturelles', 101000, 12, '2021-01-01', '2024-01-01', 0002);



-- Insertion Spectateur 

-- Spectateur 1
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0001, 'jean.leroux@hotmail.fr', 'normal');

-- Spectateur 2
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0002, 'marie.laurent@hotmail.fr', 'reduit');

-- Spectateur 3
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0003, 'paul.dupond@yahoo.fr', 'normal');

-- Spectateur 4
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0004, 'sophie.lefebvre@gmail.com', 'normal');

-- Spectateur 5
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0005, 'lucie.moreau@outlook.com', 'normal');

-- Spectateur 6
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0006, 'emile.fournier@live.fr', 'normal');

-- Spectateur 7
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0007, 'clara.rousseau@orange.fr', 'reduit');

-- Spectateur 8
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0008, 'henri.lemoine@icloud.com', 'reduit');

-- Spectateur 9
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0009, 'olivier.mercier@efrei.net', 'reduit');

-- Spectateur 10
INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0010, 'lea.girard@wanadoo.com', 'normal');



-- Insertion Billet 

-- Billet 1
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0001, 10.50, 8, '2020-12-18', '2021-01-01', 0001, 0001);

-- Billet 2
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0002, 10.50, 8, '2020-12-12', '2021-01-01', 0002, 0001);

-- Billet 3
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0003, 10.50, 8, '2020-12-25', '2021-01-01', 0003, 0001);

-- Billet 4
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0004, 10.50, 8, '2020-12-10', '2021-01-01', 0004, 0001);

-- Billet 5
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0005, 10.50, 8, '2020-12-19', '2021-01-01', 0005, 0001);

-- Billet 6
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0006, 10.50, 8, '2020-12-22', '2021-01-02', 0006, 0001);

-- Billet 7
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0007, 10.50, 8, '2020-12-23', '2021-01-02', 0007, 0001);

-- Billet 8
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0008, 10.50, 8, '2020-12-20', '2021-01-02', 0008, 0001);

-- Billet 9
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0009, 10.50, 8, '2020-12-29', '2021-01-03', 0009, 0001);

-- Billet 10
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0010, 10.50, 8, '2020-12-22', '2021-01-03', 0010, 0001);

-- Billet 11
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0011, 12.50, 9, '2020-12-22', '2021-01-07', 0001, 0002);

-- Billet 12
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0012, 12.50, 9, '2020-12-21', '2021-01-07', 0002, 0002);

-- Billet 13
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0013, 12.50, 9, '2020-12-15', '2021-01-07', 0003, 0002);

-- Billet 14
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0014, 12.50, 9, '2020-12-19', '2021-01-07', 0004, 0002);


-- Billet 15
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0015, 12.50, 9, '2020-12-18', '2021-01-08', 0005, 0002);

-- Billet 16
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0016, 12.50, 9, '2020-12-19', '2021-01-08', 0006, 0002);

-- Billet 17
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0017, 12.50, 9, '2020-12-11', '2021-01-08', 0007, 0002);

-- Billet 18
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0018, 9.50, 7.50, '2021-01-19', '2021-02-13', 0008, 0007);

-- Billet 19
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0019, 9.50, 7.50, '2021-01-19', '2021-02-13', 0009, 0007);

-- Billet 20
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0020, 9.50, 7.50, '2021-01-19', '2021-02-13', 0001, 0007);

-- Billet 21
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0021, 9.50, 7.50, '2021-01-19', '2021-02-13', 0002, 0007);

-- Billet 22
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0022, 9.50, 7.50, '2021-01-19', '2021-02-13', 0003, 0007);

-- Billet 23
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0023, 9.50, 7.50, '2021-01-18', '2021-02-13', 0004, 0007);

-- Billet 24
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0024, 9.50, 7.50, '2021-01-10', '2021-02-13', 0005, 0007);

-- Billet 25
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0025, 7.50, 6.49, '2021-01-19', '2021-02-09', 0006, 0002);

-- Billet 26
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0026, 7.50, 6.49, '2021-01-19', '2021-02-09', 0007, 0002);

-- Billet 27
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0027, 7.50, 6.49, '2021-01-19', '2021-02-09', 0010, 0002);

-- Billet 28
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0028, 7.50, 6.49, '2021-01-15', '2021-02-10', 0001, 0002);

-- Billet 29
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0029, 7.50, 6.49, '2021-01-09', '2021-02-10', 0002, 0002);

-- Billet 30
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0030, 7.50, 6.49, '2021-02-04', '2021-02-10', 0003, 0002);

-- Billet 31
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0031, 7.50, 6.49, '2021-01-19', '2021-02-10', 0004, 0002);

-- Billet 32
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0032, 7.50, 6.49, '2021-01-19', '2021-02-10', 0005, 0002);

-- Billet 33
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0033, 8.50, 6.49, '2021-01-19', '2021-02-22', 0001, 0002);

-- Billet 34
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0034, 8.50, 6.49, '2021-01-11', '2021-02-22', 0002, 0002);

-- Billet 35
INSERT INTO Billet (ID_Billet, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) 
VALUES (0035, 8.50, 6.49, '2021-01-12', '2021-02-22', 0003, 0002);


-- Insertion Representation 

-- Representation 1
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) 
VALUES (0001, 3.5, '2021-01-01', 0001, 0001, 0001);

-- Representation 2
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) 
VALUES (0002, 2.5, '2021-01-07', 0002, 0002, 0002);

-- Representation 4
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) 
VALUES (0004, 1.5, '2021-02-13', 0004, 0004, 0007);

-- Representation 6
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) 
VALUES (0006, 2.5, '2021-02-09', 0006, 0006, 0002);

-- Representation 7
INSERT INTO Representation (ID_representation, duree, date_debut, ID_Compagnie_Theatrale, ID_Spectacle, ID_theatre) 
VALUES (0007, 1.5, '2021-02-22', 0001, 0001, 0002);


SELECT * FROM Theatre;

-- Vérification de la table Représentation
SELECT * FROM Representation;

SELECT * FROM Spectacle;

SELECT * FROM Compagnie_Theatrale;

SELECT * FROM Billet;

SELECT * FROM REMUNERER;
