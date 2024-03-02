use role accountadmin;
create or replace role wh_operator;
grant role wh_operator to role sysadmin;

grant usage on warehouse compute_wh to role wh_operator;
grant usage on database test to role wh_operator;
grant usage on schema test.public to role wh_operator;
grant select on table test.public.emp to role wh_operator;

use role wh_operator;
select * from test.public.emp;
alter warehouse compute_wh suspend;

use role accountadmin;
grant operate on warehouse compute_wh to role wh_operator;

use role wh_operator;
alter warehouse compute_wh suspend;

alter warehouse compute_wh set warehouse_size = small;

use role accountadmin;
grant modify on warehouse compute_wh to role wh_operator;

use role wh_operator;
alter warehouse compute_wh set warehouse_size = small;

alter warehouse compute_wh set warehouse_size = xsmall;
use role accountadmin;
drop role wh_operator;
