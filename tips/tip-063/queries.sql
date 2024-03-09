use schema test.public;

create or replace table task15_history(stamp string);

create or replace warehouse task15_wh auto_suspend=60;

create or replace task task15
    warehouse=task15_wh
    schedule='1 minute'
as insert into task15_history values ('task15');

create or replace task task15s
    user_task_managed_initial_warehouse_size='XSMALL'
    schedule='1 minute'
as insert into task15_history values ('task15s');

alter task task15 resume;
alter task task15s resume;

-- let them run for several minutes

alter task task15 suspend;
alter task task15s suspend;

select sum(timestampdiff('millisecond', query_start_time, completed_time)) as ms
from table(information_schema.task_history(task_name => 'TASK15'));

select sum(credits_used) as credits
from table(information_schema.warehouse_metering_history(warehouse_name => 'TASK15_WH'));

select sum(credits_used) as consumption
from table(information_schema.serverless_task_history(task_name => 'TASK15S'));