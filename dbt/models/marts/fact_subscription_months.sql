{{ config(materialized='table') }}

WITH months AS (
    SELECT generate_series(
        '2026-01-01'::date,
        '2026-04-01'::date,
        interval '1 month'
    )::date AS month_start
),

month_ends AS (
    SELECT
        month_start,
        (month_start + interval '1 month' - interval '1 day')::date AS month_end
    FROM months
),

last_change_per_month AS (
    SELECT DISTINCT ON (sc.org_id, me.month_start)
        sc.org_id,
        me.month_start,
        me.month_end,
        sc.to_plan_id  AS plan_id,
        sc.to_seats    AS seats
    FROM {{ ref('stg_billing__subscription_changes') }} sc
    JOIN month_ends me
        ON sc.changed_at::date <= me.month_end
    WHERE sc.change_type != 'cancelled'
      AND sc.to_plan_id IS NOT NULL
      AND sc.to_seats   IS NOT NULL
    ORDER BY sc.org_id, me.month_start, sc.changed_at DESC
),

with_plan AS (
    SELECT
        l.org_id,
        l.month_start,
        l.month_end,
        l.plan_id,
        l.seats,
        p.plan_tier,
        p.monthly_price
    FROM last_change_per_month l
    JOIN {{ ref('dim_plan') }} p ON p.plan_id = l.plan_id
)

SELECT
    org_id,
    month_start,
    month_end,
    plan_id,
    plan_tier,
    seats,
    monthly_price,
    (monthly_price * seats) AS mrr
FROM with_plan