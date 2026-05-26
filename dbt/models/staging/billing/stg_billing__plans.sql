{{ config(materialized='view') }}

SELECT
  plan_id::integer             AS plan_id,
  name                         AS plan_name,
  tier                         AS plan_tier,
  monthly_price_cents::integer AS monthly_price_cents,
  annual_price_cents::integer  AS annual_price_cents,
  seats_included::integer      AS seats_included
FROM {{ source('raw', 'billing_plans') }}
