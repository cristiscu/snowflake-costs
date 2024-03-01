use schema test.public;

create table persons(id int, name text);

insert into persons
values (1, 'Mark'), (2, 'Mary'), (3, 'Dan');

create table persons_copy
as select * from persons;

create table persons_clone
clone persons;

insert into persons values (4, 'John');
insert into persons_copy values (4, 'John');
insert into persons_clone values (4, 'John');

-- TODO: try clone/copy large table (cannot shared!)
