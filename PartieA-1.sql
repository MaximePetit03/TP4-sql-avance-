EXPLAIN ANALYZE
SELECT *
FROM commandes
WHERE statut = 'LIVREE'
  AND YEAR(date_commande) = 2026
ORDER BY montant_total DESC
LIMIT 10;

-- Non-SARGabilité (YEAR(date_commande) = 2026) parcours complet avec un Seq Scan en 0(N)
-- Opérateur Sort coûteux + SELECT * non couvrant
