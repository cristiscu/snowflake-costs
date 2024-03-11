-- [primary] create objects
use role accountadmin;
create or replace database database1;
create or replace table orders(name string, amount int);
insert into orders values ('John', 22), ('Mary', 10), ('Mark', 26);

-- enable replication in accounts
use role orgadmin;
show organization accounts;

select SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER(
    'YICTMGU.RAA41860', 'ENABLE_ACCOUNT_DATABASE_REPLICATION', 'true');
select SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER(
    'YICTMGU.XTRACTPRO_STD', 'ENABLE_ACCOUNT_DATABASE_REPLICATION', 'true');

use role accountadmin;
show replication accounts;
    
-- enable database replication
alter database database1
    enable replication to accounts YICTMGU.RAA41860, YICTMGU.XTRACTPRO_STD;
show replication databases;

-- [secondary] create secondary db as a replica
use role accountadmin;
create database database1 as replica of YICTMGU.RAA41860.database1;
alter database database1 refresh;

-- monitor replication progress
select *
from table(information_schema.database_refresh_progress(database1))
order by start_time;

select * 
from table(information_schema.database_refresh_history(database1));
