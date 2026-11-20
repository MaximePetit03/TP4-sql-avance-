-- DENSE_RANK() attribue des rangs sans sauter de rang en cas d'ex-aequo
-- ce qui est bien pour sélectionner le Top 2 par catégorie
-- Le PARTITION BY p.categorie_id classe indépendamment les produits de chaque catégorie par prix_unitaire décroissant

WITH classement_produits AS (
    SELECT
        cat.nom AS categorie_nom,
        p.nom AS produit_nom,
        p.prix_unitaire,
        DENSE_RANK() OVER (
            PARTITION BY p.categorie_id
            ORDER BY p.prix_unitaire DESC
        ) AS rang_prix
    FROM produits p
    JOIN categories cat ON cat.id = p.categorie_id
)
SELECT
    categorie_nom,
    produit_nom,
    prix_unitaire,
    rang_prix
FROM classement_produits
WHERE rang_prix <= 2
ORDER BY categorie_nom ASC, rang_prix ASC;