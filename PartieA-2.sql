CREATE INDEX idx_commandes_statut_date_montant
ON commandes (statut, date_commande, montant_total);

ALTER TABLE commandes
PARTITION BY RANGE (YEAR(date_commande)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_max  VALUES LESS THAN MAXVALUE
);

EXPLAIN ANALYZE
SELECT id, client_id, date_commande, montant_total, statut
FROM commandes
WHERE statut = 'LIVREE'
  AND date_commande >= '2026-01-01 00:00:00'
  AND date_commande <  '2027-01-01 00:00:00'
ORDER BY montant_total DESC
LIMIT 10;

-- Le coût total passe de O(N) à un coût extrêmement réduit (O(log N))
-- Grâce au prédicat borné sur date_commande l'optimiseur élimine l'analyse des partitions hors de l'année 2026
-- Le SGBD ne lit que la partition p2026 ce qui réduit les E/S disque (I/O)