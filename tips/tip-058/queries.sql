use schema snowflake_sample_data.tpch_sf1;
set USE_CACHED_RESULT = FALSE;

-- total customer rows ~= 150K rows
select count(*)
from customer;

-- Simple One-to-One Join
select c1.c_name
from customer c1 join customer c2
  on c1.c_custkey = c2.c_custkey
where c1.c_acctbal > 3000;

-- Cartesian Product/Cross Join
select c1.c_name
from customer c1, customer c2
where c1.c_acctbal > 3000;

-- “Exploding” Joins
select c1.c_name
from customer c1 join customer c2
  on c1.c_nationkey = c2.c_nationkey
where c1.c_acctbal > 3000;
