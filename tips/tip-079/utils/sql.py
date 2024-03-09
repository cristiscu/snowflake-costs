STORAGE_QUERY = """
select convert_timezone('UTC', usage_date) as usage_date,
       database_name as object_name,
       'database' as object_type,
       max(AVERAGE_DATABASE_BYTES) as database_bytes,
       max(AVERAGE_FAILSAFE_BYTES) as failsafe_bytes,
       0 as stage_bytes
from snowflake.account_usage.database_storage_usage_history
where usage_date >= date_trunc('day', ('{date_from}T00:00:00Z')::timestamp_ntz)
and usage_date < date_trunc('day', ('{date_to}T00:00:00Z')::timestamp_ntz)
group by 1, 2, 3
union all
select convert_timezone('UTC', usage_date) as usage_date,
       'Stages' as object_name,
       'stage' as object_type,
       0 as database_bytes,
       0 as failsafe_bytes,
       max(AVERAGE_STAGE_BYTES) as stage_bytes
from snowflake.account_usage.stage_storage_usage_history
where usage_date >= date_trunc('day', ('{date_from}T00:00:00Z')::timestamp_ntz)
and usage_date < date_trunc('day', ('{date_to}T00:00:00Z')::timestamp_ntz)
group by 1, 2, 3;
"""
