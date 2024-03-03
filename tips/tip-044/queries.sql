ALTER SESSION SET QUERY_TAG = 'qtag1';
SHOW PARAMETERS in SESSION;

ALTER SESSION UNSET QUERY_TAG;
SHOW PARAMETERS in SESSION;

select query_text, query_tag
from table(test.information_schema.query_history(
    dateadd('hours', -1, current_timestamp()), current_timestamp()))
where query_tag = 'qtag1'
order by start_time desc;

select query_text, query_tag
from SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
where query_tag <> '';
