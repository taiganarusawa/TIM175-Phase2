{{ config(materialized='table') }}

WITH pro_plus_april AS (
    SELECT DISTINCT org_id
    FROM {{ ref('fact_subscription_months') }}
    WHERE month_start = '2026-04-01'
      AND plan_tier IN ('Pro', 'Enterprise')
),

rollout_users AS (
    SELECT DISTINCT org_id
    FROM {{ ref('stg_notifications__events') }}
    WHERE (
        event_type LIKE 'rollout\_%' ESCAPE '\'
        OR event_type LIKE 'rollback\_%' ESCAPE '\'
        OR event_type LIKE 'threshold\_%' ESCAPE '\'
    )
    AND sent_at >= '2026-01-01'
),

adoption AS (
    SELECT
        p.org_id,
        CASE WHEN r.org_id IS NOT NULL THEN true ELSE false END AS has_used_rollouts
    FROM pro_plus_april p
    LEFT JOIN rollout_users r ON r.org_id = p.org_id
)

SELECT
    COUNT(*)                                            AS total_pro_plus_orgs,
    SUM(CASE WHEN has_used_rollouts THEN 1 ELSE 0 END) AS orgs_using_rollouts,
    ROUND(
        100.0 * SUM(CASE WHEN has_used_rollouts THEN 1 ELSE 0 END) / COUNT(*), 1
    )                                                   AS adoption_pct
FROM adoption