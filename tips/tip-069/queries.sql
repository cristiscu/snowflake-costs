-- enable replication
use role orgadmin;

show organization accounts;

select SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER(
    'yictmgu.raa41860', 'ENABLE_ACCOUNT_DATABASE_REPLICATION', 'true');
select SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER(
    'yictmgu.xtractpro_std', 'ENABLE_ACCOUNT_DATABASE_REPLICATION', 'true');

-- create objects
use role accountadmin;

create or replace database db_primary;

create or replace table orders(id int, name string, amount int);
insert into orders values
    (1, 'John', 22), (2, 'Mary', 10), (3, 'John', 26),
    (4, 'Dan', 2), (5, 'Mary', 12), (6, 'Mark', 14),
    (7, 'Mary', 22), (8, 'Mark', 5), (9, 'Dan', 44), (10, 'Dan', 19);



alter database db_primary enable replication to accounts aws_us_west_2.xtractpro_std;

create database db_secondary as replica of aws_us_west_2.xtractpro_std.db_primary;

alter database db_secondary refresh;

create database db_secondary_cloned clone db_secondary;

drop database db_secondary;
