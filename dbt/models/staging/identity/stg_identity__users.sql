{{ config(materialized='view') }}

SELECT
  user_id::integer        AS user_id,
  name                    AS user_name,
  email                   AS email,
  role                    AS role,
  created_at::timestamptz AS created_at
FROM {{ source('raw', 'identity_users') }}
