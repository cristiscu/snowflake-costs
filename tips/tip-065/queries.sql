ALTER TABLE snowflake_sample_data.tpcds_sf100tcl.store_sales
    CLUSTER BY (ss_sold_date_sk, ss_item_sk);

-- tables with Automatic Clustering and the volume of credits consumed
-- over the last 30 days, broken out by day
-- see https://docs.snowflake.com/en/user-guide/tables-auto-reclustering
SELECT TO_DATE(start_time) AS date,
  database_name, schema_name, table_name,
  SUM(credits_used) AS credits_used
FROM snowflake.account_usage.automatic_clustering_history
WHERE start_time >= DATEADD(month, -1, CURRENT_TIMESTAMP())
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;

-- average daily credits consumed by Automatic Clustering
-- grouped by week over the last year --> identify anomalies
WITH credits_by_day AS (
  SELECT TO_DATE(start_time) AS date,
    SUM(credits_used) AS credits_used
  FROM snowflake.account_usage.automatic_clustering_history
  WHERE start_time >= DATEADD(year, -1, CURRENT_TIMESTAMP())
  GROUP BY 1
  ORDER BY 2 DESC)
SELECT DATE_TRUNC('week',date),
    AVG(credits_used) AS avg_daily_credits
FROM credits_by_day
GROUP BY 1
ORDER BY 1;