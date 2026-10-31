-- Reference solution — NEVER shown to the candidate.
SELECT DISTINCT ON (o.customer_id)
       o.customer_id,
       o.id            AS latest_order_id,
       o.created_at    AS latest_order_at,
       o.total_cents   AS latest_total_cents,
       count(*) OVER (PARTITION BY o.customer_id) AS orders_in_window
FROM   orders o
WHERE  o.created_at >= now() - interval '30 days'
  AND  o.created_at <  now()
ORDER  BY o.customer_id,
          o.created_at DESC,
          o.id DESC;   -- deterministic tie-break; without this, ties return an arbitrary row
