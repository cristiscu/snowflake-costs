select * from test.information_schema.packages
order by package_name, version desc;

select * from test.information_schema.packages
where package_name = 'snowflake-snowpark-python'
  and runtime_version = '3.9'
order by version desc;
