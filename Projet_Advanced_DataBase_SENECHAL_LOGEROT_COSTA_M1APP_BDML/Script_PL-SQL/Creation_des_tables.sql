REM Creation des tables pour notre base de données
REM Utilisation du MCD et MLD pour la création de nos tables (Quelques modifications apportees)


-- Création de la table Theatre

CREATE TABLE Theatre -- Création d'une nouvelle table nommée 'Theatre'
(      
    ID_theatre          INT, -- Colonne pour l'identifiant du théâtre, de type entier
    nom_theatre         VARCHAR (50), -- Colonne pour le nom du théâtre, chaîne de caractères de longueur maximale 50
    capacite            NUMBER (7,2) NOT NULL,-- Colonne pour la capacité du théâtre, nombre avec 7 chiffres et 2 décimales, ne peut pas être nul
    frais_deplacement   NUMBER (7,2) NOT NULL,-- Colonne pour les frais de déplacement, nombre avec 7 chiffres et 2 décimales, ne peut pas être nul
    adresse             VARCHAR (50),-- Colonne pour l'adresse du théâtre, chaîne de caractères de longueur maximale 50
        
    CONSTRAINT pk_theatre PRIMARY KEY (ID_theatre)-- Contrainte : clé primaire sur la colonne ID_theatre
);



-- Création de la table Compagnie_Theatrale

CREATE TABLE Compagnie_Theatrale -- Création d'une nouvelle table nommée 'Compagnie_Theatrale'
(       
    ID_Compagnie_Theatrale   INT,-- Colonne pour l'identifiant de la compagnie théâtrale, de type entier
    ID_theatre               INT,-- Colonne pour l'identifiant du théâtre associé, de type entier
    nom_Compagnie_Theatrale  VARCHAR(50), -- Colonne pour le nom de la compagnie théâtrale, chaîne de caractères de longueur maximale 50
    budget                   NUMBER(8,2) NOT NULL,-- Colonne pour le budget de la compagnie, nombre avec 8 chiffres et 2 décimales, ne peut pas être nul
        
    CONSTRAINT pk_Compagnie_Theatrale PRIMARY KEY (ID_Compagnie_Theatrale),-- Contrainte : clé primaire sur la colonne ID_Compagnie_Theatrale
    CONSTRAINT fk_Compagnie_Theatrale FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre), -- Contrainte : clé étrangère pour ID_theatre référençant la table Theatre
    CONSTRAINT check_budget CHECK (budget >= 0)-- Contrainte : vérification pour s'assurer que le budget est supérieur ou égal à 0
);


-- Création de la table Spectacle

CREATE TABLE Spectacle -- Création d'une nouvelle table nommée 'Spectacle'
(        
    ID_Spectacle             INT,-- Colonne pour l'identifiant du spectacle, de type entier
    nom_Spectacle            VARCHAR(50),-- Colonne pour le nom du spectacle, chaîne de caractères de longueur maximale 50
    couts_production         NUMBER(8,2) NOT NULL, -- Colonne pour les coûts de production, nombre avec 8 chiffres et 2 décimales, ne peut pas être nul
        
    CONSTRAINT pk_Spectacle PRIMARY KEY (ID_Spectacle),-- Contrainte : clé primaire sur la colonne ID_Spectacle
    CONSTRAINT check_Spectacle_couts_production CHECK (couts_production >= 0)-- Contrainte : vérification pour s'assurer que les coûts de production sont supérieurs ou égaux à 0
);


-- Création de la table Représentation

CREATE TABLE Representation -- Création d'une nouvelle table nommée 'Representation'
(        
    ID_representation   INT, -- Colonne pour l'identifiant de la représentation, de type entier
    ID_Compagnie_Theatrale           INT, -- Colonne pour l'identifiant de la compagnie théâtrale, de type entier
    ID_Spectacle             INT, -- Colonne pour l'identifiant du spectacle, de type entier
    ID_theatre          INT, -- Colonne pour l'identifiant du théâtre, de type entier
    duree               INT, -- Colonne pour la durée de la représentation, en minutes, de type entier
    date_debut          DATE NOT NULL,-- Colonne pour la date de début de la représentation, ne peut pas être nulle
    salaires            NUMBER(8,2), -- Colonne pour les salaires associés, nombre avec 8 chiffres et 2 décimales
        
    CONSTRAINT pk_representation PRIMARY KEY (ID_representation),      -- Contrainte : clé primaire sur la colonne ID_representation
    CONSTRAINT fk_representation_Compagnie_Theatrale FOREIGN KEY (ID_Compagnie_Theatrale) REFERENCES Compagnie_Theatrale(ID_Compagnie_Theatrale), -- Contrainte : clé étrangère pour ID_Compagnie_Theatrale référençant la table Compagnie_Theatrale
    CONSTRAINT fk_representation_Spectacle FOREIGN KEY (ID_Spectacle) REFERENCES Spectacle(ID_Spectacle), -- Contrainte : clé étrangère pour ID_Spectacle référençant la table Spectacle
    CONSTRAINT fk_representation_theatre FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre) -- Contrainte : clé étrangère pour ID_theatre référençant la table Theatre
);



-- Création de la table Employé

CREATE TABLE Employe -- Création d'une nouvelle table nommée 'Employe'
(       
    ID_employe  INT, -- Colonne pour l'identifiant de l'employé, de type entier
    ID_Compagnie_Theatrale    INT,  -- Colonne pour l'identifiant de la compagnie théâtrale, de type entier
    nom         VARCHAR(50),        -- Colonne pour le nom de l'employé, chaîne de caractères de longueur maximale 50
    type_emploi VARCHAR(50),        -- Colonne pour le type d'emploi, chaîne de caractères de longueur maximale 50
    salaire     NUMBER(7,2) NOT NULL, -- Colonne pour le salaire de l'employé, nombre avec 7 chiffres et 2 décimales, ne peut pas être nul
      
    CONSTRAINT pk_employe PRIMARY KEY (ID_employe), -- Contrainte : clé primaire sur la colonne ID_employe
    CONSTRAINT fk_employe_Compagnie_Theatrale FOREIGN KEY (ID_Compagnie_Theatrale) REFERENCES Compagnie_Theatrale(ID_Compagnie_Theatrale), -- Contrainte : clé étrangère pour ID_Compagnie_Theatrale référençant la table Compagnie_Theatrale
    CONSTRAINT check_employe_type CHECK (type_emploi IN ('acteur','staff')), -- Contrainte : vérification pour s'assurer que le type d'emploi est soit 'acteur' soit 'staff'
    CONSTRAINT check_employe_salaire CHECK (salaire > 0)  -- Contrainte : vérification pour s'assurer que le salaire est supérieur à 0
);


-- Création de la table Spectateur

CREATE TABLE Spectateur -- Création d'une nouvelle table nommée 'Spectateur'
(        
    ID_spectateur   INT, -- Colonne pour l'identifiant du spectateur, de type entier
    email           VARCHAR(50), -- Colonne pour l'email du spectateur, chaîne de caractères de longueur maximale 50
    statut          VARCHAR(50) NOT NULL, -- Colonne pour le statut du spectateur, chaîne de caractères de longueur maximale 50, ne peut pas être nulle
      
    CONSTRAINT pk_spectateur PRIMARY KEY (ID_spectateur), -- Contrainte : clé primaire sur la colonne ID_spectateur
    CONSTRAINT ck_statut CHECK (statut IN ('normal','reduit')) -- Contrainte : vérification pour s'assurer que le statut est soit 'normal' soit 'reduit'
);


-- Création de la table Billet

CREATE TABLE Billet -- Création d'une nouvelle table nommée 'Billet'
(          
    ID_Billet        INT, -- Colonne pour l'identifiant du billet, de type entier
    ID_spectateur    INT, -- Colonne pour l'identifiant du spectateur, de type entier
    ID_theatre       INT, -- Colonne pour l'identifiant du théâtre, de type entier
    tarif_normal     NUMBER(5,2) NOT NULL,  -- Colonne pour le tarif normal, nombre avec 5 chiffres et 2 décimales, ne peut pas être nul
    tarif_reduit     NUMBER(5,2) NOT NULL,  -- Colonne pour le tarif réduit, nombre avec 5 chiffres et 2 décimales, ne peut pas être nul
    date_achat       DATE NOT NULL, -- Colonne pour la date d'achat du billet, ne peut pas être nulle
    date_accees      DATE NOT NULL, -- Colonne pour la date d'accès à l'événement, ne peut pas être nulle
     
    CONSTRAINT pk_Billet PRIMARY KEY (ID_Billet), -- Contrainte : clé primaire sur la colonne ID_Billet
    CONSTRAINT fk_Billet_theatre FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre), -- Contrainte : clé étrangère pour ID_theatre référençant la table Theatre
    CONSTRAINT fk_Billet_spectateur FOREIGN KEY (ID_spectateur) REFERENCES Spectateur(ID_spectateur), -- Contrainte : clé étrangère pour ID_spectateur référençant la table Spectateur
    CONSTRAINT check_Billet_tarif_normal CHECK (tarif_normal >= 0),-- Contrainte : vérification pour s'assurer que le tarif normal est supérieur ou égal à 0
    CONSTRAINT check_Billet_tarif_reduit CHECK (tarif_reduit >= 0 AND tarif_reduit < tarif_normal),  -- Contrainte : vérification pour s'assurer que le tarif réduit est supérieur ou égal à 0 et inférieur au tarif normal
    CONSTRAINT ck_date_achat_Billet CHECK (date_achat <= date_accees) -- Contrainte : vérification pour s'assurer que la date d'achat est antérieure ou égale à la date d'accès
);


-- Création de la table Subvention

CREATE TABLE Subvention -- Création d'une nouvelle table nommée 'Subvention'
(          
    ID_Subvention           INT, -- Colonne pour l'identifiant de la subvention, de type entier
    ID_Compagnie_Theatrale  INT, -- Colonne pour l'identifiant de la compagnie théâtrale bénéficiaire, de type entier
    nom_donateur            VARCHAR(50), -- Colonne pour le nom du donateur, chaîne de caractères de longueur maximale 50
    somme_donnee            NUMBER(7) NOT NULL,-- Colonne pour la somme donnée, nombre entier, ne peut pas être nul
    frequence               INT, -- Colonne pour la fréquence de la subvention, en nombre d'occurrences (par exemple, annuel, mensuel, etc.)
    date_debut              DATE NOT NULL, -- Colonne pour la date de début de la subvention, ne peut pas être nulle
    date_fin                DATE NOT NULL, -- Colonne pour la date de fin de la subvention, ne peut pas être nulle
        
    CONSTRAINT pk_Subvention PRIMARY KEY (ID_Subvention), -- Contrainte : clé primaire sur la colonne ID_Subvention
    CONSTRAINT fk_Subvention_Compagnie_Theatrale FOREIGN KEY (ID_Compagnie_Theatrale) REFERENCES Compagnie_Theatrale(ID_Compagnie_Theatrale) -- Contrainte : clé étrangère pour ID_Compagnie_Theatrale référençant la table Compagnie_Theatrale
);


-- Création de la table REMUNERER

CREATE TABLE REMUNERER -- Création d'une nouvelle table nommée 'REMUNERER'
(        
    ID_theatre              INT, -- Colonne pour l'identifiant du théâtre, de type entier
    ID_Compagnie_Theatrale  INT, -- Colonne pour l'identifiant de la compagnie théâtrale, de type entier
    total                   NUMBER(8,2) NOT NULL, -- Colonne pour le montant total de la rémunération, nombre avec 8 chiffres et 2 décimales, ne peut pas être nul
    date_paiement           DATE NOT NULL, -- Colonne pour la date de paiement, ne peut pas être nulle
       
    CONSTRAINT pk_remunerer  PRIMARY KEY (ID_theatre,ID_Compagnie_Theatrale),   -- Contrainte : clé primaire composée sur les colonnes ID_theatre et ID_Compagnie_Theatrale
    CONSTRAINT fk_remunerer_theatre FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre), -- Contrainte : clé étrangère pour ID_theatre référençant la table Theatre
    CONSTRAINT fk_remunerer_Compagnie_Theatrale FOREIGN KEY (ID_Compagnie_Theatrale) REFERENCES Compagnie_Theatrale(ID_Compagnie_Theatrale), -- Contrainte : clé étrangère pour ID_Compagnie_Theatrale référençant la table Compagnie_Theatrale
    CONSTRAINT check_remunerer_total CHECK (total >= 0)   -- Contrainte : vérification pour s'assurer que le montant total est supérieur ou égal à 0
);


-- Création de la table Date_Theatre

CREATE TABLE Date_Theatre -- Création d'une nouvelle table nommée 'Date_Theatre'
(          
    date_actuelle  DATE -- Colonne pour la date actuelle, de type DATE
);


-- Création de la table Temporaire

create table temp -- Création d'une nouvelle table temporaire nommée 'temp'
(              
    Salaires int,-- Colonne pour les salaires, de type entier
    ID_Compagnie_Theatrale int  -- Colonne pour l'identifiant de la compagnie théâtrale, de type entier
);

