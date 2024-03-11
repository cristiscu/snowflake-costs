use schema test.public;

create or replace table search_table(id int, c1 int, c2 string, c3 date);
insert into search_table values
    (1, 3, '4',  '1985-05-11'),
    (2, 4, '3',  '1996-12-20'),
    (3, 2, '1',  '1974-02-03'),
    (4, 1, '2',  '2004-03-09'),
    (5, null, null,  null);

alter table search_table
add search optimization;

alter table search_table
add search optimization on substring(*), equality(id, c1);

describe search optimization on search_table;

select * from search_table where id = 2;
select * from search_table where c2 = '1';
select * from search_table where c3 = '1985-05-11';
select * from search_table where c1 is null;
select * from search_table where c1 = 4 and c3 = '1996-12-20';
select * from search_table where c2 = 2;

-- not!
select * from search_table where cast(c2 as number) = 2;

select id, c1, c2, c3
from search_table
where id IN (2, 3)
order by id;

select id, c1, c2, c3
from search_table
where c1 = 1 and c3 = TO_DATE('2004-03-09')
order by id;

delete from search_table where id = 3;
update search_table set c1 = 99 where id = 4;


alter table search_table
drop search optimization on c1;

alter table search_table
drop search optimization;
