{{ config(materialized='table') }}

SELECT
    p.plan_id,
    p.plan_name,
    p.plan_tier,
    p.monthly_price_cents / 100.0 AS monthly_price,
    p.annual_price_cents  / 100.0 AS annual_price,
    p.seats_included
FROM {{ ref('stg_billing__plans') }} p