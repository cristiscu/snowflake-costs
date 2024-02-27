SHOW STAGES IN ACCOUNT;

select *
from test.information_schema.stages;

select * from snowflake.account_usage.stages
where deleted is null;

select *
from snowflake.account_usage.stage_storage_usage_history
order by usage_date desc;

select top 1 stage_bytes
from snowflake.account_usage.storage_usage
order by usage_date desc;


REMOVE @mystage;
REMOVE @%mytable;
REMOVE @~;
