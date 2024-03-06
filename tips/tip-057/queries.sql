select *
from snowflake.account_usage.query_history
order by compilation_time desc
limit 100;

select *
from snowflake.account_usage.query_history
where compilation_time > execution_time
order by compilation_time desc
limit 100;

-- object dependencies in all account
with recursive cte as (
  select * from snowflake.account_usage.object_dependencies
    where referencing_object_name = ''
      and referencing_database = 'None'
      and referencing_schema = 'None'
  union all
  select deps.*
    from snowflake.account_usage.object_dependencies deps
    join cte
      on deps.referencing_object_id = cte.referenced_object_id
      and deps.referencing_object_domain = cte.referenced_object_domain)
select * from cte;

-- data lineage in all account
select qh.query_text,
   trim(ifnull(src.value:objectName::string, '')
      || '.' || ifnull(src.value:columnName::string, ''), '.') as source,
   trim(ifnull(om.value:objectName::string, '')
      || '.' || ifnull(col.value:columnName::string, ''), '.') as target,
   obj.value:objectName::string as sourceAccessed,
   ah.objects_modified, ah.direct_objects_accessed, ah.base_objects_accessed
from snowflake.account_usage.access_history ah
    left join snowflake.account_usage.query_history qh
    on ah.query_id = qh.query_id,
lateral flatten(input => objects_modified) om,
    lateral flatten(input => om.value: "columns", outer => true) col,
    lateral flatten(input => col.value:directSources, outer => true) src,
lateral flatten(input => direct_objects_accessed, outer => true) obj
order by ah.query_start_time;

with q as (
    select query_id
        ,query_parameterized_hash
        ,execution_time
        ,end_time
        ,warehouse_name
        ,warehouse_size
        ,query_text
        ,query_type
        ,case when warehouse_size = 'X-Small' then 1
            when warehouse_size = 'Small' then 2
            when warehouse_size = 'Medium' then 4
            when warehouse_size = 'Large' then 8
            when warehouse_size = 'X-Large' then 16
            when warehouse_size = '2X-Large' then 32
            when warehouse_size = '3X-Large' then 64
            when warehouse_size = '4X-Large' then 128
            when warehouse_size = '5X-Large' then 256
            when warehouse_size = '6X-Large' then 512
            else 0 end
            * 
            case 
                when warehouse_type = 'STANDARD' then 1 
                when warehouse_type = 'SNOWPARK-OPTIMIZED' then 1.5 
            else 0 end warehouse_value
            ,( ( execution_time ) * warehouse_value ) query_value
    from snowflake.account_usage.query_history 
    where end_time>=TO_TIMESTAMP_LTZ('2024-02-26T00:00:00Z') 
        and end_time<TO_TIMESTAMP_LTZ('2024-03-05T00:00:00Z') 
        and LENGTH(TRIM(query_text)) > 0
        and execution_time > 0 
        and query_parameterized_hash is not null
        and warehouse_name != 'COMPUTE_SERVICE_WH')
select max_by(query_text, end_time) as most_recent_query_text
    ,max_by(query_type, end_time) as most_recent_query_type
    ,query_parameterized_hash as query_hash
    ,sum(execution_time) as total_execution_time
    ,count(distinct query_id) as num_queries
    ,round(avg(execution_time), 2) as avg_execution_time_ms
    ,max_by(warehouse_name, end_time) as last_used_warehouse
    ,max_by(warehouse_size, end_time) as last_used_warehouse_size
    ,min(execution_time) as min_execution_time_ms
    ,max(execution_time) as max_execution_time_ms
    ,median(execution_time) as median_execution_time_ms
    ,max_by(query_id, end_time) as most_recent_query_id
    ,max(end_time) as most_recent_query_end_time
from q
group by all
order by sum(query_value) desc
limit 1000;