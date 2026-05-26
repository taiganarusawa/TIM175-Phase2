{{ config(materialized='view') }}

SELECT
  membership_id::integer  AS membership_id,
  user_id::integer        AS user_id,
  org_id::integer         AS org_id,
  role_in_org             AS role_in_org,
  added_at::timestamptz   AS added_at
FROM {{ source('raw', 'identity_memberships') }}
