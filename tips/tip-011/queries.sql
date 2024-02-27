-- see https://quickstarts.snowflake.com/guide/resource_optimization_setup/index.html

SHOW WAREHOUSES;

SELECT "name", "size"
FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))
WHERE "resource_monitor" = 'null';
