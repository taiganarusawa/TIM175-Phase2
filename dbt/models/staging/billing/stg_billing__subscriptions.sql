{{ config(materialized='view') }}

SELECT
  sub_id                       AS sub_id,
  org_id::integer              AS org_id,
  customer_id                  AS customer_id,
  plan_id::integer             AS plan_id,
  started_at::timestamptz      AS started_at,
  ended_at::timestamptz        AS ended_at,
  status                       AS status,
  billing_cycle                AS billing_cycle,
  seats_purchased::integer     AS seats_purchased,
  updated_at::timestamptz      AS updated_at
FROM {{ source('raw', 'billing_subscriptions') }}
