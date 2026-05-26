{{ config(materialized='view') }}

SELECT
  ticket_id::integer                AS ticket_id,
  org_id::integer                   AS org_id,
  user_id::integer                  AS user_id,
  category_id::integer              AS category_id,
  subject                           AS subject,
  priority                          AS priority,
  status                            AS status,
  created_at::timestamptz           AS created_at,
  resolved_at::timestamptz          AS resolved_at,
  assigned_agent_id::integer        AS assigned_agent_id,
  resolution_time_seconds::integer  AS resolution_time_seconds
FROM {{ source('raw', 'tickets_tickets') }}
