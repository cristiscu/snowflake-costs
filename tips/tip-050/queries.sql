use schema test.public;

create or replace table test1(id int);
insert into test1 values
    (1), (5), (7),
    (12), (16),
    (23), (28), (29);

create or replace table test11 like test1;
create or replace table test12 like test1;
create or replace table test13 like test1;

insert into test11 select id from test1 where id < 10;
insert into test12 select id from test1 where id >= 10 and id < 20;
insert into test13 select id from test1 where id >=20 and id < 30;

truncate table test12;
truncate table test12;
truncate table test13;

insert first
    when id < 10 then into test11
    when id >= 10 and id < 20 then into test12
    else into test13
select id from test1;
