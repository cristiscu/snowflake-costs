use schema SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL;
use warehouse COMPUTE_WH;

select count(*) as count1
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

select SYSTEM$CANCEL_QUERY(last_query_id());
select SYSTEM$CANCEL_QUERY('...');