-- Top warehouses by cost
select warehouse_name, warehouse_id, sum(credits_used) as credits
from snowflake.account_usage.warehouse_metering_history
where start_time >= TO_TIMESTAMP_LTZ('2024-02-24T00:00:00Z')
    and start_time < TO_TIMESTAMP_LTZ('2024-03-03T00:00:00Z')
group by 1, 2
order by 3 desc
limit 1000;

-- Top databases by storage
select database_name, database_id, MAX(AVERAGE_DATABASE_BYTES) as database_bytes
from snowflake.account_usage.database_storage_usage_history
where usage_date >= '2024-02-24T00:00:00Z'
    and usage_date < '2024-03-03T00:00:00Z'
group by 1,2
order by 3 desc
limit 1000;

