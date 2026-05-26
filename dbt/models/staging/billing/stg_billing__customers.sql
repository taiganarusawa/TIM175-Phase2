{{ config(materialized='view') }}

SELECT
  customer_id              AS customer_id,
  org_id::integer          AS org_id,
  email                    AS email,
  name                     AS customer_name,
  payment_method           AS payment_method,
  created_at::timestamptz  AS created_at
FROM {{ source('raw', 'billing_customers') }}
