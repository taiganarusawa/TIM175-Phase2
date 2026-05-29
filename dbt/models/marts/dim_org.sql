{{ config(materialized='table') }}

SELECT
    o.org_id,
    o.org_name,
    o.industry,
    o.country,
    o.created_at
FROM {{ ref('stg_identity__orgs') }} o