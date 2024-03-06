use warehouse large_wh;

select o_orderstatus, "'2-HIGH'" high2, "'5-LOW'" low
from snowflake_sample_data.tpch_sf1000.orders
pivot (count(o_orderkey) for o_orderpriority in ('2-HIGH', '5-LOW')) p
order by o_orderstatus;

use warehouse compute_wh;

SELECT query_text,
    bytes_spilled_to_local_storage,
    bytes_spilled_to_remote_storage
FROM  snowflake.account_usage.query_history
WHERE (bytes_spilled_to_local_storage > 0
    OR  bytes_spilled_to_remote_storage > 0 )
    AND start_time::date > dateadd('days', -1, current_date)
ORDER BY start_time DESC
LIMIT 10;
