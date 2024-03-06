use schema test.public;

create or replace table orders(id int, name string, amount int);
insert into orders values
(1, 'John', 22), (2, 'Mary', 10), (3, 'John', 26),
(4, 'Dan', 2), (5, 'Mary', 12), (6, 'Mark', 14),
(7, 'Mary', 22), (8, 'Mark', 5), (9, 'Dan', 44), (10, 'Dan', 19);

create or replace materialized view balances
as
    select name, sum(amount) as balance
    from orders
    group by name;

select * from balances
order by name;

insert into orders values
(11, 'Dan', 22), (12, 'Mary', 14), (13, 'George', 11);

select * from balances
order by name;





create or replace dynamic table balances_dt
    warehouse = compute_wh
    target_lag = '1 minute'
as
    select name, sum(amount) as balance
    from orders
    group by name;

select * from balances_dt
order by name;

insert into orders values
(14, 'Laura', 20), (15, 'Mary', 2);

select * from balances_dt
order by name;

alter dynamic table balances_dt suspend;
alter dynamic table balances_dt resume;
