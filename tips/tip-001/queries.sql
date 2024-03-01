CREATE WAREHOUSE if not exists TPCDS_BENCH_10T
with
  WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  INITIALLY_SUSPENDED = TRUE
  COMMENT = 'TEST WH for TPCDS 10TB BENCHMARK';

ALTER WAREHOUSE TPCDS_BENCH_10T
  RESUME IF SUSPENDED;

ALTER WAREHOUSE TPCDS_BENCH_10T
  SET WAIT_FOR_COMPLETION = TRUE
      WAREHOUSE_SIZE = XXLARGE;

USE SCHEMA snowflake_sample_data.tpcds_sf10tcl;
ALTER SESSION SET use_cached_result = FALSE;
SET start_time = CURRENT_TIMESTAMP();

select count(*)
from store_sales, household_demographics, time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk
    and ss_hdemo_sk = household_demographics.hd_demo_sk
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and household_demographics.hd_dep_count = 6
    and store.s_store_name = 'ese'
order by count(*)
limit 100;
