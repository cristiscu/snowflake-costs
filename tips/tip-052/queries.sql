explain
select c1.c_custkey, c1.c_name, c1.c_nationkey, c1.c_acctbal
from snowflake_sample_data.tpch_sf1.customer c1
where c1.c_acctbal > 3000;

explain using text
select c1.c_name
from snowflake_sample_data.tpch_sf1.customer c1
    join snowflake_sample_data.tpch_sf1.customer c2
    on c1.c_nationkey = c2.c_nationkey
where c1.c_acctbal > 3000;

explain
select count(*)
from snowflake_sample_data.tpcds_sf10tcl.store_sales,
    snowflake_sample_data.tpcds_sf10tcl.household_demographics,
    snowflake_sample_data.tpcds_sf10tcl.time_dim,
    snowflake_sample_data.tpcds_sf10tcl.store
where ss_sold_time_sk = time_dim.t_time_sk
    and ss_hdemo_sk = household_demographics.hd_demo_sk
    and ss_store_sk = s_store_sk
    and time_dim.t_hour = 8
    and time_dim.t_minute >= 30
    and household_demographics.hd_dep_count = 6
    and store.s_store_name = 'ese'
order by count(*)
limit 100;
