use schema test.public;

create or replace table test2(id int, stamp string);
insert into test2 values (1, 'stamp1');

begin transaction;
update test2 set stamp='stamp2' where id=1;
-- try to run in another SQL Worksheet:
-- update test2 set stamp='stamp3' where id=1;
commit;

show locks in account;

select * from test2;