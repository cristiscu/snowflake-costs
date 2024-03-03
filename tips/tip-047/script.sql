-- drop all roles
drop role if exists role1;
drop role if exists role2;
drop role if exists role3;
drop role if exists role4;
drop role if exists role5;
drop role if exists role6;
drop role if exists role7;

-- create roles
create role role1;
create role role2;
create role role3;
create role role4;
create role role5;
create role role6;
create role role7;

-- create role hierarchy
grant role role1 to role sysadmin;
grant role role2 to role role1;
grant role role3 to role role1;
grant role role4 to role role1;
grant role role5 to role role2;
grant role role6 to role role2;
grant role role7 to role role3;
