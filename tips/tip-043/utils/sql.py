QUERIES_QUERY = """
select *
from snowflake.account_usage.query_history
where START_TIME >= convert_timezone('UTC', 'UTC', ('{date_from}T00:00:00Z')::timestamp_ltz)
and START_TIME < convert_timezone('UTC', 'UTC', ('{date_to}T00:00:00Z')::timestamp_ltz);
"""

QUERIES_COUNT_QUERY = """
select QUERY_TEXT,
       count(*) as number_of_queries,
       sum(TOTAL_ELAPSED_TIME)/1000 as execution_seconds,
       sum(TOTAL_ELAPSED_TIME)/(1000*60) as execution_minutes,
       sum(TOTAL_ELAPSED_TIME)/(1000*60*60) as execution_hours
from SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY Q
where 1=1
  and Q.START_TIME >= convert_timezone('UTC', 'UTC', ('{date_from}T00:00:00Z')::timestamp_ltz)
  and Q.START_TIME <= convert_timezone('UTC', 'UTC', ('{date_to}T00:00:00Z')::timestamp_ltz)
  and TOTAL_ELAPSED_TIME > 0 --only get queries that actually used compute
  and WAREHOUSE_NAME = '{warehouse_name}'
group by 1
having count(*) >= {num_min}
order by 2 desc
limit {limit};
"""
