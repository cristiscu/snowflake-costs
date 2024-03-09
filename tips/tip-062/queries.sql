use schema test.public;

create or replace table task12_history(stamp string);
insert into task12_history values ('anything');

create or replace warehouse task12_wh auto_suspend=60;

create or replace task task12 warehouse=task12_wh schedule='1 minute'
as insert into task12_history values ('anything');

alter task task12 resume;

-- let it run for several minutes

alter task task12 suspend;

select sum(timestampdiff('millisecond', query_start_time, completed_time)) as ms
from table(information_schema.task_history(task_name => 'TASK12'));

select sum(credits_used) as credits
from table(information_schema.warehouse_metering_history(warehouse_name => 'TASK12_WH'));
