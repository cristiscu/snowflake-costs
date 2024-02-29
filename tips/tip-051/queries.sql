-- see https://medium.com/snowflake/understanding-the-exploding-joins-problem-in-snowflake-6b4f89f006c7
use schema SNOWFLAKE_SAMPLE_DATA.TPCH_SF1;

-- total customer rows ~= 150K rows
select count(*)
from customer;

-- One-to-One Joins
select c1.c_name
from customer c1 join customer c2
  on c1.c_custkey = c2.c_custkey
where c1.c_acctbal > 3000;

-- Cross Joins (Cartesian Product)
select c1.c_name
from customer c1, customer c2
where c1.c_acctbal > 3000;

-- “Exploding” Joins
select c1.c_name
from customer c1 join customer c2
  on c1.c_nationkey = c2.c_nationkey
where c1.c_acctbal > 3000;
