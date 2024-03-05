select c1.c_name
from snowflake_sample_data.tpch_sf1.customer c1
    join snowflake_sample_data.tpch_sf1.customer c2
    on c1.c_nationkey = c2.c_nationkey
where c1.c_acctbal > 9500;

SELECT *
FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

ALTER SESSION SET USE_CACHED_RESULT = false;
ALTER SESSION SET USE_CACHED_RESULT = true;