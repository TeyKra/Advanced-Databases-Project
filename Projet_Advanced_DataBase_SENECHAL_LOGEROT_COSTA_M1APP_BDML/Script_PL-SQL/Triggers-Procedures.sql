REM   Script: Triggers-Procédures.sql
REM   Mise en place des fonctionnalités pour la gestion de la base de données en utilisant divers déclencheurs, fonctions et procédures stockées.

-- Trigger Représentation et Salaire
-- Ce trigger a pour but de calculer automatiquement la somme totale des salaires des employés
-- d'une compagnie théâtrale spécifique à chaque fois qu'une nouvelle représentation est enregistrée.
-- Il met à jour la colonne 'salaires' dans la table 'Representation' avec cette somme totale.

CREATE OR REPLACE TRIGGER Salaires_Representation  -- Création ou remplacement d'un trigger nommé 'Salaires_Representation'
BEFORE INSERT ON Representation FOR EACH ROW      -- Ce trigger est déclenché avant chaque insertion dans la table 'Representation'
DECLARE    
    somme_salaire Employe.salaire%type;           -- Déclaration d'une variable 'somme_salaire' du même type que la colonne 'salaire' dans la table 'Employe'
BEGIN      
    -- Sélection et sommation des salaires des employés de la compagnie théâtrale concernée par la nouvelle représentation
    SELECT SUM(salaire) INTO somme_salaire FROM Employe WHERE ID_Compagnie_Theatrale = :NEW.ID_Compagnie_Theatrale;      
    -- Affectation de la somme totale des salaires à la colonne 'salaires' dans la nouvelle ligne de la table 'Representation'
    :NEW.salaires := somme_salaire;      
EXCEPTION      
    -- Gestion de l'exception en cas d'absence de données (aucun employé trouvé)
    WHEN NO_DATA_FOUND     
    THEN somme_salaire := 0;      -- Affectation de 0 à 'somme_salaire' si aucun salaire n'est trouvé
END;  
/


-- Trigger pour la Rémunération
-- Ce trigger est conçu pour calculer et enregistrer automatiquement la rémunération d'une compagnie théâtrale
-- après l'insertion d'une nouvelle représentation. Il calcule cette rémunération basée sur le tarif normal des billets,
-- la capacité du théâtre, et une certaine proportion de ces revenus.

CREATE OR REPLACE TRIGGER Remuneration        -- Création ou remplacement d'un trigger nommé 'Remuneration'
After INSERT ON Representation FOR EACH ROW   -- Ce trigger est déclenché après chaque insertion dans la table 'Representation'
DECLARE        
    prix Billet.tarif_normal%type;            -- Déclaration d'une variable 'prix' du même type que la colonne 'tarif_normal' dans la table 'Billet'
    taille Theatre.capacite%type;             -- Déclaration d'une variable 'taille' du même type que la colonne 'capacite' dans la table 'Theatre'
    prix_tot int;                             -- Déclaration d'une variable 'prix_tot' pour le total de la rémunération
BEGIN          
    -- Sélection du tarif normal des billets pour le théâtre et la période de la représentation
    SELECT DISTINCT tarif_normal INTO prix FROM Billet WHERE ID_theatre = :NEW.ID_theatre AND date_accees >= :New.date_debut AND date_accees <= (:New.date_debut + :New.duree);    
    -- Sélection de la capacité du théâtre où se déroule la représentation
    SELECT capacite INTO taille FROM Theatre WHERE ID_theatre = :NEW.ID_theatre;    
    -- Calcul de la rémunération totale (50% du produit du tarif normal par la capacité du théâtre)
    prix_tot := prix * 0.5 * taille;    
    -- Insertion de la rémunération calculée dans la table 'Remunerer'
    INSERT INTO Remunerer VALUES (:New.ID_theatre, :New.ID_Compagnie_Theatrale, prix_tot, :New.date_debut);  
EXCEPTION  
    -- Gestion de l'exception en cas d'absence de données (pas de billets trouvés)
    WHEN NO_DATA_FOUND  
    THEN raise_application_error(-20002, 'Avant ajouter une représentation, veuillez entrer des billets !');  
END;
/


-- Trigger Spectacle et Compagnie_Theatrale
-- Ce trigger est conçu pour assurer qu'un spectacle est associé à une seule compagnie théâtrale.
-- Il empêche l'insertion d'une nouvelle représentation si le spectacle spécifié est déjà associé à une autre compagnie théâtrale.

CREATE OR REPLACE TRIGGER Spectacle_Compagnie_Theatrale         -- Création ou remplacement d'un trigger nommé 'Spectacle_Compagnie_Theatrale'
BEFORE INSERT ON Representation FOR EACH ROW                    -- Ce trigger est déclenché avant chaque insertion dans la table 'Representation'
DECLARE          
    Compagnie_Theatrale Representation.ID_Compagnie_Theatrale%type; -- Déclaration d'une variable 'Compagnie_Theatrale' du même type que la colonne 'ID_Compagnie_Theatrale' dans la table 'Representation'
    Compagnie_Theatrale_exception EXCEPTION;                     -- Déclaration d'une exception personnalisée 'Compagnie_Theatrale_exception'

BEGIN            
    -- Vérification s'il existe déjà une représentation avec un spectacle identique mais associée à une autre compagnie théâtrale
    SELECT DISTINCT ID_Compagnie_Theatrale INTO Compagnie_Theatrale FROM Representation WHERE ID_Compagnie_Theatrale != :NEW.ID_Compagnie_Theatrale AND ID_Spectacle = :NEW.ID_Spectacle;     
         
    -- Si une telle compagnie théâtrale existe, déclencher l'exception personnalisée
    IF (Compagnie_Theatrale IS NOT NULL) THEN         
        RAISE Compagnie_Theatrale_exception;         
    END IF;         
EXCEPTION         
    -- Gestion de l'exception personnalisée avec un message d'erreur spécifique
    WHEN Compagnie_Theatrale_exception THEN 
        raise_application_error(-20002, 'Les spectacles sont associés à une seule compagnie théâtrale !');      
    -- Gestion de l'exception en cas d'absence de données
    WHEN NO_DATA_FOUND THEN      
        :NEW.ID_Spectacle := :NEW.ID_Spectacle;      -- Assignation de l'ID_Spectacle dans la nouvelle ligne (action par défaut)
END;   
/


-- Trigger Empilement des theatres
-- Ce trigger est conçu pour empêcher la Empilement des représentations dans un même théâtre.
-- Il vérifie que les dates et durées des nouvelles représentations ne se chevauchent pas avec celles déjà planifiées.

CREATE OR REPLACE TRIGGER Empilement_theatre  -- Création ou remplacement d'un trigger nommé 'Empilement_theatre'
BEFORE INSERT ON Representation FOR EACH ROW    -- Ce trigger est déclenché avant chaque insertion dans la table 'Representation'
DECLARE  
    date_proche_moins representation.date_debut%type;  -- Variable pour stocker la date de début la plus proche inférieure
    date_proche_plus representation.date_debut%type;   -- Variable pour stocker la date de début la plus proche supérieure
    durr_moins representation.duree%type;              -- Variable pour stocker la durée de la représentation précédente
    err1 EXCEPTION;                                    -- Déclaration d'une exception personnalisée 'err1'

BEGIN  
    -- Sélection de la date de début et de la durée de la représentation précédente la plus proche dans le même théâtre
    SELECT date_debut, duree INTO date_proche_moins, durr_moins FROM representation 
    WHERE date_debut <= :NEW.date_debut AND ID_theatre = :NEW.ID_theatre 
    ORDER BY date_debut DESC FETCH FIRST 1 ROWS ONLY;  
     
    -- Vérification du chevauchement avec la représentation précédente
    IF (:NEW.Date_debut <= date_proche_moins + durr_moins) THEN  
        RAISE err1;  
    END IF;  

    -- Sélection de la date de début de la représentation suivante la plus proche dans le même théâtre
    SELECT date_debut INTO date_proche_plus FROM representation 
    WHERE date_debut >= :NEW.date_debut AND ID_theatre = :NEW.ID_theatre 
    ORDER BY date_debut ASC FETCH FIRST 1 ROWS ONLY;  
     
    -- Vérification du chevauchement avec la représentation suivante
    IF (:NEW.Date_debut + :New.duree >= date_proche_plus) THEN  
        RAISE err1;  
    END IF;  
     
EXCEPTION  
    -- Gestion de l'exception personnalisée avec un message d'erreur spécifique
    WHEN err1 THEN  
        raise_application_error(-20000, 'Un théâtre ne peut accueillir une seule représentation par soir !');  
    -- Gestion de l'exception en cas d'absence de données
    WHEN NO_DATA_FOUND THEN 
        :NEW.Date_debut := :NEW.date_debut;  -- Assignation de la date de début dans la nouvelle ligne (action par défaut)
END;
/


-- Trigger Empilement des Compagnie_Theatrale
-- Ce trigger est conçu pour empêcher la programmation de plusieurs représentations par la même compagnie théâtrale le même jour.
-- Il vérifie que les dates et durées des nouvelles représentations ne se chevauchent pas avec celles déjà planifiées pour la même compagnie théâtrale.

CREATE OR REPLACE TRIGGER Empilement_Compagnie_Theatrale             
BEFORE INSERT ON Representation FOR EACH ROW               -- Ce trigger est déclenché avant chaque insertion dans la table 'Representation'
DECLARE             
    date_proche_moins representation.date_debut%type;       -- Variable pour la date de début la plus proche inférieure
    date_proche_plus representation.date_debut%type;        -- Variable pour la date de début la plus proche supérieure
    durr_moins representation.duree%type;                   -- Variable pour la durée de la représentation précédente
    err1 EXCEPTION;                                         -- Déclaration d'une exception personnalisée 'err1'

BEGIN             
    -- Sélection de la date de début et de la durée de la représentation précédente la plus proche pour la même compagnie théâtrale
    SELECT date_debut, duree INTO date_proche_moins, durr_moins FROM representation 
    WHERE date_debut <= :NEW.date_debut AND ID_Compagnie_Theatrale = :NEW.ID_Compagnie_Theatrale 
    ORDER BY date_debut DESC FETCH FIRST 1 ROWS ONLY;        

    -- Vérification du chevauchement avec la représentation précédente
    IF (:NEW.Date_debut <= date_proche_moins + durr_moins) THEN 
        RAISE err1;       
    END IF; 

    -- Sélection de la date de début de la représentation suivante la plus proche pour la même compagnie théâtrale
    SELECT date_debut INTO date_proche_plus FROM representation 
    WHERE date_debut >= :NEW.date_debut AND ID_Compagnie_Theatrale = :NEW.ID_Compagnie_Theatrale 
    ORDER BY date_debut ASC FETCH FIRST 1 ROWS ONLY;  

    -- Vérification du chevauchement avec la représentation suivante
    IF (:NEW.Date_debut + :NEW.duree >= date_proche_plus) THEN 
        RAISE err1;       
    END IF;     
        
EXCEPTION       
    -- Gestion de l'exception personnalisée avec un message d'erreur spécifique
    WHEN err1 THEN      
        raise_application_error(-20000, 'Une compagnie théâtrale est limitée à une seule représentation par soir !');       
    -- Gestion de l'exception en cas d'absence de données
    WHEN NO_DATA_FOUND THEN     
        :NEW.Date_debut := :NEW.date_debut;  -- Assignation de la date de début dans la nouvelle ligne (action par défaut)
END;
/


-- Procédure Villes par période
-- Cette procédure récupère et affiche les adresses des théâtres où une compagnie théâtrale spécifique a des représentations programmées dans une période donnée.

CREATE OR REPLACE PROCEDURE ville_Compagnie_Theatrale(Compagnie_Theatrale INT, debut DATE, fin DATE) 
IS 
    adresses Theatre.adresse%TYPE;  -- Variable pour stocker les adresses des théâtres

BEGIN 
    -- Boucle sur chaque théâtre où la compagnie théâtrale spécifiée a des représentations programmées dans la période donnée
    FOR c IN (SELECT adresse FROM Theatre T 
              JOIN Representation R ON R.ID_theatre = T.ID_theatre 
              JOIN Compagnie_Theatrale C ON C.ID_Compagnie_Theatrale = R.ID_Compagnie_Theatrale 
              WHERE C.ID_Compagnie_Theatrale = Compagnie_Theatrale AND R.date_debut >= debut AND (R.date_debut + R.duree) <= fin) LOOP    
        adresses := c.adresse;  -- Assignation de l'adresse du théâtre à la variable 'adresses'
        dbms_output.put_line(adresses);  -- Affichage de l'adresse du théâtre
    END LOOP; 

    EXCEPTION 
        -- Gestion des exceptions non spécifiées
        WHEN OTHERS THEN 
        raise_application_error(-20001, 'Une erreur est survenue - ' || SQLCODE || ' -ERROR- ' || SQLERRM); 
END;
/



-- Procédure Prix selon le jour
-- Cette procédure est conçue pour afficher le prix d'un billet pour un jour spécifique.
-- Elle sélectionne le tarif normal du premier billet trouvé pour la date donnée et affiche ce prix.

-- Configuration de la session pour le format de date 'YYYY-MM-DD'
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Création ou remplacement de la procédure
CREATE OR REPLACE PROCEDURE price_day (jour DATE) 
IS 
    prix Billet.tarif_normal%TYPE;  -- Définition d'une variable pour stocker le prix du billet
BEGIN 
    -- Sélection du tarif normal du premier billet trouvé pour la date spécifiée
    SELECT tarif_normal INTO prix FROM Billet WHERE Billet.date_accees = jour FETCH FIRST 1 ROWS ONLY; 
    
    -- Affichage du prix du billet
    dbms_output.put_line('Le billet coûte ' || prix || '€'); 
    
    EXCEPTION 
        WHEN OTHERS THEN 
            -- Gestion des erreurs en affichant un message d'erreur avec le code SQL et la description de l'erreur
            raise_application_error(-20001,'Une erreur est survenue - '||SQLCODE||' -ERROR- '||SQLERRM); 
END;
/



-- Procédure Distribution des prix
-- Cette procédure est conçue pour calculer et afficher le nombre de billets vendus à tarif normal et réduit pour un spectacle donné.
-- Elle sélectionne la date du spectacle spécifié, puis compte séparément les billets à tarif normal et réduit vendus pour cette date.

CREATE OR REPLACE PROCEDURE price_Spectacle (Spectacle INT) 
IS 
    prix_normal Billet.tarif_normal%TYPE;   -- Variable pour stocker le nombre de billets à tarif normal
    prix_reduit Billet.tarif_reduit%TYPE;   -- Variable pour stocker le nombre de billets à tarif réduit
    dt Representation.date_debut%TYPE;      -- Variable pour stocker la date de début du spectacle

BEGIN 
    -- Sélection de la date de début du spectacle spécifié
    SELECT date_debut INTO dt FROM Representation WHERE ID_Representation = Spectacle; 
 
    -- Boucle pour compter les billets à tarif normal vendus pour le spectacle
    FOR c IN (SELECT COUNT(nrml) as ct FROM (SELECT tarif_normal AS nrml FROM Billet Tk JOIN Spectateur Sp ON Tk.ID_Spectateur = Sp.ID_Spectateur WHERE Sp.statut = 'normal' AND Tk.date_accees = dt)) LOOP    
        prix_normal := c.ct;  -- Assignation du compte à la variable 'prix_normal'
        dbms_output.put_line('Le nombre de prix normal est de : ' || prix_normal);  -- Affichage du nombre de billets à tarif normal
    END LOOP; 

    -- Boucle pour compter les billets à tarif réduit vendus pour le spectacle
    FOR c IN (SELECT COUNT(red) AS ct FROM (SELECT tarif_reduit AS red FROM Billet Tk JOIN Spectateur Sp ON Tk.ID_Spectateur = Sp.ID_Spectateur WHERE Sp.statut = 'reduit' AND Tk.date_accees = dt)) LOOP    
        prix_reduit := c.ct;  -- Assignation du compte à la variable 'prix_reduit'
        dbms_output.put_line('Le nombre de prix réduit est de : ' || prix_reduit);  -- Affichage du nombre de billets à tarif réduit
    END LOOP; 

    EXCEPTION 
        -- Gestion des exceptions non spécifiées
        WHEN OTHERS THEN 
        raise_application_error(-20001, 'Une erreur est survenue - ' || SQLCODE || ' -ERROR- ' || SQLERRM); 
END;
/


-- Trigger Salaire Budget
-- Ce trigger est conçu pour ajuster le budget des compagnies théâtrales en fonction des salaires payés pour les représentations.
-- Après chaque mise à jour de la table 'date_theatre', il calcule les salaires pour les représentations actuelles et met à jour le budget des compagnies concernées.

CREATE OR REPLACE TRIGGER budget_salaire 
AFTER update ON date_theatre for each row  -- Déclenchement du trigger après chaque mise à jour de la table 'date_theatre'
BEGIN 
    -- Insertion dans la table temporaire des salaires et des identifiants des compagnies théâtrales pour les représentations en cours
    Insert into TEMP(salaires, ID_Compagnie_Theatrale) 
    SELECT Salaires, ID_Compagnie_Theatrale 
    FROM Representation 
    WHERE date_debut <= :New.date_actuelle and date_debut + duree >= :New.date_actuelle; 

    -- Mise à jour du budget de chaque compagnie théâtrale en déduisant les salaires payés pour les représentations en cours
    UPDATE Compagnie_Theatrale set budget = budget - (SELECT salaires FROM Temp WHERE TEMP.ID_Compagnie_Theatrale = Compagnie_Theatrale.ID_Compagnie_Theatrale) 
    WHERE EXISTS (SELECT ID_Compagnie_Theatrale FROM Temp WHERE Compagnie_Theatrale.ID_Compagnie_Theatrale = Temp.ID_Compagnie_Theatrale); 

    -- Suppression des enregistrements de la table temporaire après la mise à jour
    DELETE FROM temp; 
END;
/


-- Trigger Budget et Rémunération
-- Ce trigger est conçu pour ajuster le budget des compagnies théâtrales en fonction des rémunérations reçues.
-- Après chaque mise à jour de la table 'date_theatre', il calcule les rémunérations pour les paiements effectués à la date actuelle et met à jour le budget des compagnies concernées.

CREATE OR REPLACE TRIGGER budget_remuneration 
AFTER update ON date_theatre for each row  -- Déclenchement du trigger après chaque mise à jour de la table 'date_theatre'
BEGIN 
    -- Insertion dans la table temporaire des rémunérations et des identifiants des compagnies théâtrales pour les paiements effectués à la date actuelle
    Insert into TEMP(salaires, ID_Compagnie_Theatrale) 
    SELECT Total, ID_Compagnie_Theatrale 
    FROM Remunerer 
    WHERE date_paiement = :New.date_actuelle; 

    -- Mise à jour du budget de chaque compagnie théâtrale en ajoutant les rémunérations reçues à la date actuelle
    UPDATE Compagnie_Theatrale SET budget = budget + (SELECT salaires FROM Temp WHERE TEMP.ID_Compagnie_Theatrale = Compagnie_Theatrale.ID_Compagnie_Theatrale) 
    WHERE EXISTS (SELECT ID_Compagnie_Theatrale FROM Temp WHERE Compagnie_Theatrale.ID_Compagnie_Theatrale = Temp.ID_Compagnie_Theatrale); 

    -- Suppression des enregistrements de la table temporaire après la mise à jour
    DELETE FROM temp; 
END;
/


-- Trigger Budget et Coûts de Production
-- Ce trigger est conçu pour ajuster le budget des compagnies théâtrales en fonction des coûts de production des spectacles.
-- Après chaque mise à jour de la table 'date_theatre', il calcule les coûts de production pour les représentations ayant lieu à la date actuelle et met à jour le budget des compagnies concernées.

CREATE OR REPLACE TRIGGER budget_cout_production 
AFTER UPDATE ON date_theatre FOR EACH ROW  -- Déclenchement du trigger après chaque mise à jour de la table 'date_theatre'
BEGIN 
    -- Insertion dans la table temporaire des coûts de production et des identifiants des compagnies théâtrales pour les représentations à la date actuelle
    INSERT INTO TEMP(salaires, ID_Compagnie_Theatrale) 
    SELECT couts_production, ID_Compagnie_Theatrale 
    FROM Representation R INNER JOIN Spectacle S ON R.ID_Spectacle = S.ID_Spectacle 
    WHERE date_debut = :New.date_actuelle; 

    -- Mise à jour du budget de chaque compagnie théâtrale en soustrayant les coûts de production
    UPDATE Compagnie_Theatrale SET budget = budget - (SELECT salaires FROM Temp WHERE TEMP.ID_Compagnie_Theatrale = Compagnie_Theatrale.ID_Compagnie_Theatrale) 
    WHERE EXISTS (SELECT ID_Compagnie_Theatrale FROM Temp WHERE Compagnie_Theatrale.ID_Compagnie_Theatrale = Temp.ID_Compagnie_Theatrale); 

    -- Suppression des enregistrements de la table temporaire après la mise à jour
    DELETE FROM temp; 
END;
/


-- Trigger Budget et Frais de Déplacement
-- Ce trigger est conçu pour ajuster le budget des compagnies théâtrales en fonction des frais de déplacement des représentations.
-- Après chaque mise à jour de la table 'date_theatre', il calcule les frais de déplacement pour les représentations ayant lieu à la date actuelle et met à jour le budget des compagnies concernées.

CREATE OR REPLACE TRIGGER budget__frais_deplacement 
AFTER UPDATE ON date_theatre FOR EACH ROW  -- Déclenchement du trigger après chaque mise à jour de la table 'date_theatre'
BEGIN 
    -- Insertion dans la table temporaire des frais de déplacement et des identifiants des compagnies théâtrales pour les représentations à la date actuelle
    INSERT INTO TEMP(salaires, ID_Compagnie_Theatrale) 
    SELECT frais_deplacement, ID_Compagnie_Theatrale 
    FROM Representation R INNER JOIN Theatre T ON R.ID_theatre = T.ID_theatre 
    WHERE date_debut = :New.date_actuelle; 

    -- Mise à jour du budget de chaque compagnie théâtrale en soustrayant les frais de déplacement
    UPDATE Compagnie_Theatrale SET budget = budget - (SELECT salaires FROM Temp WHERE TEMP.ID_Compagnie_Theatrale = Compagnie_Theatrale.ID_Compagnie_Theatrale) 
    WHERE EXISTS (SELECT ID_Compagnie_Theatrale FROM Temp WHERE Compagnie_Theatrale.ID_Compagnie_Theatrale = Temp.ID_Compagnie_Theatrale); 

    -- Suppression des enregistrements de la table temporaire après la mise à jour
    DELETE FROM temp; 
END;
/


-- Trigger Budget et Subvention
-- Ce trigger est conçu pour ajuster le budget des compagnies théâtrales en fonction des subventions reçues.
-- Après chaque mise à jour de la table 'date_theatre', il calcule les subventions pour les compagnies théâtrales ayant des subventions actives à la date actuelle et met à jour leur budget.

CREATE OR REPLACE TRIGGER budget_Subvention 
AFTER UPDATE ON date_theatre FOR EACH ROW  -- Déclenchement du trigger après chaque mise à jour de la table 'date_theatre'
BEGIN 
    -- Insertion dans la table temporaire des montants de subvention et des identifiants des compagnies théâtrales
    INSERT INTO TEMP(salaires, ID_Compagnie_Theatrale) 
    SELECT Somme_donnee, ID_Compagnie_Theatrale 
    FROM Subvention 
    WHERE date_debut = :New.date_actuelle OR (ADD_MONTHS(date_debut, frequence) = :New.date_actuelle AND date_fin >= :New.date_actuelle); 

    -- Mise à jour du budget de chaque compagnie théâtrale en ajoutant les montants de subvention
    UPDATE Compagnie_Theatrale SET budget = budget + (SELECT salaires FROM Temp WHERE TEMP.ID_Compagnie_Theatrale = Compagnie_Theatrale.ID_Compagnie_Theatrale) 
    WHERE EXISTS (SELECT ID_Compagnie_Theatrale FROM Temp WHERE Compagnie_Theatrale.ID_Compagnie_Theatrale = Temp.ID_Compagnie_Theatrale); 

    -- Suppression des enregistrements de la table temporaire après la mise à jour
    DELETE FROM temp; 
END;
/


