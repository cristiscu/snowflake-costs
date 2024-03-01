use schema test.pubic;

create or replace table store_sales_c
as select * from snowflake_sample_data.tpcds_sf10tcl.store_sales
limit 2000000000;

select count(*)
from store_sales_c;

create or replace table stores_clone
clone store_sales_c;

create or replace table stores_copy
as select * from store_sales_c;