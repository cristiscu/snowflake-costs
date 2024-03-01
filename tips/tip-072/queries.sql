using schema test.public;

CREATE TABLE store_sales
AS SELECT * FROM snowflake_sample_data.tpcds_sf100tcl.store_sales
LIMIT 2000000000;

CREATE TABLE store_sales
CLONE store_sales_c;

DROP TABLE store_sales;
UNDROP TABLE store_sales;
DROP TABLE store_sales;

SELECT *
FROM test.INFORMATION_SCHEMA.table_storage_metrics 
where TABLE_CATALOG = 'TEST'
  and table_schema = 'PUBLIC'
  and table_name = 'STORE_SALES';
