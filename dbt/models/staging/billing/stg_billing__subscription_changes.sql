{{ config(materialized='view') }}

SELECT
  change_id::integer            AS change_id,
  sub_id                        AS sub_id,
  org_id::integer               AS org_id,
  change_type                   AS change_type,
  from_plan_id::integer         AS from_plan_id,
  to_plan_id::integer           AS to_plan_id,
  from_seats::integer           AS from_seats,
  to_seats::integer             AS to_seats,
  changed_at::timestamptz       AS changed_at,
  changed_by_user_id::integer   AS changed_by_user_id
FROM {{ source('raw', 'billing_subscription_changes') }}
