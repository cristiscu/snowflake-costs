CREATE TABLE test.public.store_sales
AS SELECT * FROM snowflake_sample_data.tpcds_sf100tcl.store_sales
LIMIT 2000000000;

CREATE TABLE test.public.store_sales_c
CLONE test.public.store_sales;

DROP TABLE test.public.store_sales;
UNDROP TABLE test.public.store_sales;
DROP TABLE test.public.store_sales;

SELECT *
FROM test.INFORMATION_SCHEMA.table_storage_metrics 
where TABLE_CATALOG = 'TEST'
  and table_schema = 'PUBLIC'
  and table_name = 'STORE_SALES';
