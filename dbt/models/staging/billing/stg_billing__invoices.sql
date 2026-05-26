{{ config(materialized='view') }}

SELECT
  invoice_id                  AS invoice_id,
  sub_id                      AS sub_id,
  org_id::integer             AS org_id,
  amount_cents::integer       AS amount_cents,
  status                      AS status,
  issued_at::timestamptz      AS issued_at,
  paid_at::timestamptz        AS paid_at,
  period_start::date          AS period_start,
  period_end::date            AS period_end
FROM {{ source('raw', 'billing_invoices') }}
