CREATE MATERIALIZED VIEW mv_synthese_segments AS
SELECT
    c.segment,
    COUNT(cmd.id) AS nb_commandes,
    COALESCE(ROUND(SUM(cmd.montant_total), 2), 0) AS ca_total
FROM clients c
LEFT JOIN commandes cmd ON cmd.client_id = c.id
GROUP BY c.segment;

INSERT INTO commandes (client_id, date_commande, montant_total, statut)
VALUES (25, '2026-11-20 10:00:00', 3200.00, 'LIVREE');

SELECT segment, nb_commandes, ca_total
FROM mv_synthese_segments
WHERE segment = 'PME';

REFRESH MATERIALIZED VIEW mv_synthese_segments;

SELECT segment, nb_commandes, ca_total
FROM mv_synthese_segments
WHERE segment = 'PME';