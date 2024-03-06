use schema test.public;

create table task11_history(ts timestamp, tname string);

create or replace warehouse task11_wh
    auto_suspend=60;

create or replace task task11
    warehouse=task11_wh
    schedule='2 minute'
as
    insert into task11_history
    values (current_timestamp(), 'task11');

alter task task11 resume;

-- after 1h
alter task task11 suspend;

show tasks in database;

select *
from table(information_schema.task_history())
where database_name = current_database()
    and name = 'TASK11'

select round(sum(timestampdiff('millisecond',
    query_start_time, completed_time)) / 1000) as seconds
from table(information_schema.task_history())
where database_name = current_database()
    and name = 'TASK11';

select sum(credits_used) as credits
from table(information_schema.warehouse_metering_history(
    dateadd('days', -1, current_date())))
where warehouse_name = 'TASK11_WH';
