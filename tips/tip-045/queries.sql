select *
from table(test.information_schema.query_history())
where query_type = 'SELECT'
  and query_text ilike '%current_session%'
order by start_time;

select query_text, count(*) counts
from snowflake.account_usage.query_history
where query_type = 'SELECT'
  and query_text ilike '%current_session%'
group by query_text
having counts > 1;