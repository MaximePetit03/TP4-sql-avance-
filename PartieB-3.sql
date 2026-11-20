WITH RECURSIVE organigramme_employes AS (
    SELECT
        id,
        nom,
        poste,
        departement,
        1 AS niveau,
        CAST(nom AS CHAR(1000)) AS chemin
    FROM employes
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        subordonne.id,
        subordonne.nom,
        subordonne.poste,
        subordonne.departement,
        superieur.niveau + 1 AS niveau,
        CONCAT(superieur.chemin, ' > ', subordonne.nom) AS chemin
    FROM employes subordonne
    JOIN organigramme_employes superieur
        ON subordonne.manager_id = superieur.id
    WHERE superieur.niveau < 20
)
SELECT
    id,
    nom,
    poste,
    departement,
    niveau,
    chemin
FROM organigramme_employes
ORDER BY niveau ASC, id ASC;