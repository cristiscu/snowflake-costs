select *
from snowflake.account_usage.grant_to_roles;

select count(*)
from snowflake.account_usage.query_history;

select qh.query_text,
   src.value:objectName::string as sourceObj,
   src.value:columnName::string as sourceCol,
   om.value:objectName::string as targetObj,
   col.value:columnName::string as targetCol,
   ah.objects_modified
from snowflake.account_usage.access_history ah
   left join snowflake.account_usage.query_history qh
   on ah.query_id = qh.query_id,
   lateral flatten(input => objects_modified) om,
   lateral flatten(input => om.value: "columns", outer => true) col,
   lateral flatten(input => col.value:directSources, outer => true) src
order by ah.query_start_time;

