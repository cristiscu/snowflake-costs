show parameters for warehouse compute_wh;

select created_on, privilege, granted_to gt
from snowflake.account_usage.grants_to_roles;

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


select sum(credits_used) as credits
from snowflake.account_usage.WAREHOUSE_METERING_HISTORY
where warehouse_name = 'COMPUTE_WH'
    and date(start_time) = current_date();

select sum(EXECUTION_TIME
    * ifnull(QUERY_LOAD_PERCENT, 100) / 100) / 1000 as secs
from snowflake.account_usage.QUERY_HISTORY
where warehouse_name = 'COMPUTE_WH'
    and date(start_time) = current_date();
