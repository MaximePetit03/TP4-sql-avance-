EXPLAIN ANALYZE
SELECT id, client_id, date_commande, montant_total, statut
FROM commandes
WHERE statut = 'LIVREE'
  AND YEAR(date_commande) = 2026
ORDER BY montant_total DESC
LIMIT 10;

-- La non-SARGabilité : L'utilisation de la fonction YEAR(date_commande) = 2026
-- Cela force le SGBD à appliquer la fonction ligne par ligne c'est à dire un Full Table Scan
-- SELECT * combiné au tri global sur montant DESC sans index couvrant ni filtre performant sature la mémoire tampon et 
-- déclenche un tri externe coûteux sur disque
