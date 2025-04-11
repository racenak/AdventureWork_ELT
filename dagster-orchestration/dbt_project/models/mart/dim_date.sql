{{
  config(
    materialized='table',
    unique_key='date_key'
  )
}}

WITH date_spine AS (
  {{ dbt_utils.date_spine(
      datepart="day",
      start_date="toDate('2010-01-01')",
      end_date="toDate('2025-12-31')"
     )
  }}
),

date_dimension AS (
  SELECT
    toInt32(toYear(date_day) * 10000 + toMonth(date_day) * 100 + toDayOfMonth(date_day)) AS date_key,
    date_day AS full_date,
    toDayOfWeek(date_day) AS day_of_week, -- Note: 1=Monday to 7=Sunday in ClickHouse
    dateName('weekday', date_day) AS day_name,
    toDayOfMonth(date_day) AS day_of_month,
    toDayOfYear(date_day) AS day_of_year,
    toWeek(date_day) AS week_of_year,
    dateName('month', date_day) AS month_name,
    toMonth(date_day) AS month_of_year,
    toQuarter(date_day) AS quarter,
    concat('Q', toString(toQuarter(date_day))) AS quarter_name,
    toYear(date_day) AS year,
    CASE
      WHEN toDayOfWeek(date_day) IN (6, 7) THEN 1
      ELSE 0
    END AS is_weekend,
    CASE
      WHEN (toMonth(date_day) = 1 AND toDayOfMonth(date_day) = 1) OR
           (toMonth(date_day) = 12 AND toDayOfMonth(date_day) = 25)
      THEN 1
      ELSE 0
    END AS is_holiday
  FROM date_spine
)

SELECT *
FROM date_dimension
ORDER BY full_date