select count(*) counts
from table(test.information_schema.query_history())
where query_type = 'SELECT'
  and query_text ilike '%information_schema%';

select *
from table(test.information_schema.query_history())
where query_type = 'SELECT'
  and query_text ilike '%information_schema%';

select count(*) counts
from table(test.information_schema.query_history())
where query_type = 'SELECT'
  and query_text ilike '%account_usage%';

select count(*) counts
from snowflake.account_usage.query_history
where query_type = 'SELECT'
  and query_text ilike '%information_schema%';

select count(*) counts
from snowflake.account_usage.query_history
where query_type = 'SELECT'
  and query_text ilike '%account_usage%';

select * 
from snowflake.account_usage.query_history
where query_type = 'SELECT'
    and query_text ilike '%account_usage%';