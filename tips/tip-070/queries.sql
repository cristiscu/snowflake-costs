use schema test.public;

create or replace hybrid table ht(
    id int primary key,
    name string,
    city string,
    amount int,
    index idx_city (city) include (name)
);

show hybrid tables;
show indexes;

insert into ht values
    (1, 'John', 'Paris', 22), (2, 'Mary', 'London', 10),
    (3, 'John', 'Paris', 26), (4, 'Dan', 'Toronto', 2),
    (5, 'Mary', 'London', 12), (6, 'Mark', 'New York', 14),
    (7, 'Mary', 'London', 22), (8, 'Mark', 'New York', 5),
    (9, 'Dan', 'Toronto', 44), (10, 'Dan', 'Toronto', 19);

select name
from ht
where city in ('London', 'Paris');

select *
from ht
order by name;

select name, sum(amount) as total
from ht
group by name
order by name;

-- consumption
select *
from snowflake.account_usage.HYBRID_TABLES;

select *
from snowflake.account_usage.HYBRID_TABLE_USAGE_HISTORY;

select * -- HYBRID_TABLE_STORAGE_BYTES
from snowflake.account_usage.STORAGE_USAGE;

select * -- AVERAGE_HYBRID_TABLE_STORAGE_BYTES
from snowflake.account_usage.DATABASE_STORAGE_USAGE_HISTORY;

-- cleanup!
drop table ht;

show hybrid tables;
show indexes;
