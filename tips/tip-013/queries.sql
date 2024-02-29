use schema SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL;
use warehouse COMPUTE_LIMIT;

show parameters
for warehouse COMPUTE_LIMIT;

alter warehouse COMPUTE_LIMIT
set STATEMENT_TIMEOUT_IN_SECONDS=20;

select count(*) as countexp
from store_sales, household_demographics, time_dim, store
where ss_sold_time_sk = time_dim.t_time_sk
  and ss_hdemo_sk = household_demographics.hd_demo_sk
  and ss_store_sk = s_store_sk
  and time_dim.t_hour = 8
  and time_dim.t_minute >= 30
  and household_demographics.hd_dep_count = 5
  and store.s_store_name = 'ese'
order by count(*)
limit 100;

