{{ config(materialized='table') }}

WITH days AS (
  SELECT generate_series(
    DATE '2025-01-01',
    DATE '2027-12-31',
    INTERVAL '1 day'
  )::date AS date
)
SELECT
  TO_CHAR(date, 'YYYYMMDD')::integer  AS date_key,
  date,
  TO_CHAR(date, 'YYYY-MM')            AS year_month,
  EXTRACT(DOW FROM date)::integer     AS day_of_week,
  TO_CHAR(date, 'Day')                AS day_name,
  EXTRACT(MONTH FROM date)::integer   AS month,
  TO_CHAR(date, 'Month')              AS month_name,
  EXTRACT(QUARTER FROM date)::integer AS quarter,
  EXTRACT(YEAR FROM date)::integer    AS year,
  DATE_TRUNC('month', date)::date     AS month_start,
  DATE_TRUNC('week', date)::date      AS week_start
FROM days
