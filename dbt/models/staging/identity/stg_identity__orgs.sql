{{ config(materialized='view') }}

SELECT
  org_id::integer         AS org_id,
  name                    AS org_name,
  industry                AS industry,
  country                 AS country,
  created_at::timestamptz AS created_at
FROM {{ source('raw', 'identity_orgs') }}
