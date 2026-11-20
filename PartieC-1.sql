-- PIÈGE DU NOT IN (logique ternaire SQL : TRUE, FALSE, UNKNOWN) :
-- La sous-requête SELECT manager_id FROM employes contient la valeur NULL
-- Or, "id NOT IN (val1, val2, NULL)" revient à exiger que id soit différent
-- La condition WHERE ne vaut jamais TRUE et la requête retourne 0 ligne

SELECT
    employe.id,
    employe.nom
FROM employes AS employe
WHERE NOT EXISTS (
    SELECT 1
    FROM employes AS subordonne
    WHERE subordonne.manager_id = employe.id
);