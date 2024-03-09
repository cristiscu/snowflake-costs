DATA_TRANSFER_QUERY = """
select date_trunc('hour', convert_timezone('UTC', start_time)) as start_time,
       target_cloud,
       target_region,
       transfer_type,
       sum(bytes_transferred) as bytes_transferred
from snowflake.account_usage.data_transfer_history
where start_time >= convert_timezone('UTC', 'UTC', ('{date_from}T00:00:00Z')::timestamp_ltz)
and start_time < convert_timezone('UTC', 'UTC', ('{date_to}T00:00:00Z')::timestamp_ltz)
group by 1, 2, 3, 4;
"""
