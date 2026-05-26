{{ config(materialized='view') }}

SELECT
  event_id::integer        AS event_id,
  org_id::integer          AS org_id,
  user_id::integer         AS user_id,
  event_type               AS event_type,
  channel                  AS channel,
  status                   AS status,
  sent_at::timestamptz     AS sent_at
FROM {{ source('raw', 'notifications_events') }}
