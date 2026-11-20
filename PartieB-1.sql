--- Problèmes identifiés pour 1FN, 2FN et 3FN :
--  1FN : projets_liste regroupe plusieurs projets dans une même colonne
--  2FN : employe_nom et dept_nom ne dépendent que de employe_id
--
-- Dépendance fonctionnelle :
--  employe_id     -> employe_nom, dept_nom
--  chef_projet_id -> chef_projet_nom, chef_projet_tel
--  projet_id      -> projet_nom, chef_projet_id

CREATE TABLE employes_3fn (
    employe_id INT PRIMARY KEY,
    employe_nom VARCHAR(100) NOT NULL,
    dept_nom VARCHAR(80) NOT NULL
);

CREATE TABLE chefs_projet_3fn (
    chef_projet_id INT PRIMARY KEY,
    chef_projet_nom VARCHAR(100) NOT NULL,
    chef_projet_tel VARCHAR(20) NOT NULL
);

CREATE TABLE projets_3fn (
    projet_id INT PRIMARY KEY,
    projet_nom VARCHAR(120) NOT NULL,
    chef_projet_id INT NOT NULL,
    CONSTRAINT fk_projets_chef_3fn
        FOREIGN KEY (chef_projet_id) REFERENCES chefs_projet_3fn(chef_projet_id)
);

CREATE TABLE affectations_3fn (
    employe_id INT NOT NULL,
    projet_id INT NOT NULL,
    PRIMARY KEY (employe_id, projet_id),
    CONSTRAINT fk_affectations_employe_3fn
        FOREIGN KEY (employe_id) REFERENCES employes_3fn(employe_id),
    CONSTRAINT fk_affectations_projet_3fn
        FOREIGN KEY (projet_id) REFERENCES projets_3fn(projet_id)
);