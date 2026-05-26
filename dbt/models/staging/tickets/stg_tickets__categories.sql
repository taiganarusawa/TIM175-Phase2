{{ config(materialized='view') }}

SELECT
  category_id::integer  AS category_id,
  name                  AS category_name,
  is_rollouts_related   AS is_rollouts_related,
  description           AS description
FROM {{ source('raw', 'tickets_categories') }}
