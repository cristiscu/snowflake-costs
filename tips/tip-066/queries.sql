-- see https://docs.snowflake.com/en/user-guide/tutorials/query-acceleration-service
use schema snowflake_sample_data.tpcds_sf10tcl;

-- look for ALL QAS eligible queries in the account
SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_ACCELERATION_ELIGIBLE
ORDER BY eligible_query_acceleration_time DESC;

-- ~8min w/o QAS on XSmall WH
SELECT d.d_year as year1, i.i_brand_id as brand_id1,
  i.i_brand as brand1, SUM(ss_net_profit) as profit1
FROM date_dim d, store_sales s, item i
WHERE d.d_date_sk = s.ss_sold_date_sk
  AND s.ss_item_sk = i.i_item_sk
  AND i.i_manufact_id = 939
  AND d.d_moy = 12
GROUP BY d.d_year, i.i_brand, i.i_brand_id
ORDER BY 1, 4, 2
LIMIT 200;

-- check if last query is QAS eligible
SELECT PARSE_JSON(
    SYSTEM$ESTIMATE_QUERY_ACCELERATION(
        '01b2a889-0002-238d-0050-2a0700053032'));
/*
{
  "estimatedQueryTimes": {
    "1": 245,
    "14": 40,
    "2": 166,
    "4": 103,
    "8": 61
  },
  "originalQueryTime": 476.498,
  "queryUUID": "01b2a889-0002-238d-0050-2a0700053032",
  "status": "eligible",
  "upperLimitScaleFactor": 14
}
*/

-- enable QAS in WH
ALTER WAREHOUSE COMPUTE_WH SET
  ENABLE_QUERY_ACCELERATION = true
  QUERY_ACCELERATION_MAX_SCALE_FACTOR = 14;

-- 40 secs w/ QAS on XSmall WH
SELECT d.d_year as year2, i.i_brand_id as brand_id2
  i.i_brand as brand2, SUM(ss_net_profit) as profit2
FROM date_dim d, store_sales s, item i
WHERE d.d_date_sk = s.ss_sold_date_sk
  AND s.ss_item_sk = i.i_item_sk
  AND i.i_manufact_id = 939
  AND d.d_moy = 12
GROUP BY d.d_year, i.i_brand, i.i_brand_id
ORDER BY 1, 4, 2
LIMIT 200;

-- disable QAS in WH
ALTER WAREHOUSE COMPUTE_WH SET
  ENABLE_QUERY_ACCELERATION = false;

-- check diffs (replace IDs)
SELECT *
FROM TABLE(snowflake.information_schema.query_history())
WHERE query_id IN (
  '01b2a889-0002-238d-0050-2a0700053032',
  '01b2a89c-0002-234f-0050-2a0700054062')
ORDER BY start_time;

-- see QAS cost in the past day
SELECT *
FROM TABLE(SNOWFLAKE.INFORMATION_SCHEMA.QUERY_ACCELERATION_HISTORY(
    DATE_RANGE_START => DATEADD('days', -1, CURRENT_DATE()),
    WAREHOUSE_NAME => 'COMPUTE_WH'));