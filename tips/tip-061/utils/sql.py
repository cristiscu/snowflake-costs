CONSUMPTION_PER_SERVICE_TYPE_QUERY = """
select date_trunc('hour', convert_timezone('UTC', start_time)) as start_time,
       name,
       service_type,
       round(sum(credits_used), 1) as credits_used,
       round(sum(credits_used_compute), 1) as credits_compute,
       round(sum(credits_used_cloud_services), 1) as credits_cloud
from snowflake.account_usage.metering_history
where start_time >= convert_timezone('UTC', 'UTC', ('{date_from}T00:00:00Z')::timestamp_ltz)
and start_time < convert_timezone('UTC', 'UTC', ('{date_to}T00:00:00Z')::timestamp_ltz)
group by 1, 2, 3;
"""
