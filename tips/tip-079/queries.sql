select max(AVERAGE_STAGE_BYTES) as stage_bytes
from snowflake.account_usage.stage_storage_usage_history;

select *
from snowflake.account_usage.database_storage_usage_history;

select database_name,
    max(AVERAGE_DATABASE_BYTES) as database_bytes,
    max(AVERAGE_FAILSAFE_BYTES) as failsafe_bytes,
    max(AVERAGE_HYBRID_TABLE_STORAGE_BYTES) as ht_bytes
from snowflake.account_usage.database_storage_usage_history
group by database_name
order by database_bytes desc;


select *
from snowflake.account_usage.table_storage_metrics;

select table_catalog, table_schema, table_name, last_altered
from snowflake.account_usage.tables
where table_catalog is not null
    and last_altered < current_date() - 30
order by last_altered
limit 10;

with cte1 as (
    select ah.query_start_time,
        oa.value:objectName::string as table_name
    from snowflake.account_usage.access_history ah,
        lateral flatten(ah.base_objects_accessed) as oa
    where oa.value:objectDomain::string = 'Table'
        and oa.value:objectId is not null)
select table_name, max(query_start_time) as last_access
from cte1
group by table_name
-- having last_access < current_date() - 30
order by last_access
limit 10;
