-- 5.2. Top 25 Longest Queries
-- H Bars: sum(exec_time), Query_text on Y
-- labels X: Execution Time (minutes)

select query_id, query_text,
   (execution_time / 60000) as exec_time
from snowflake.account_usage.query_history
where execution_status = 'SUCCESS'
order by execution_time desc
limit 25;

-- 5.1. Execution Time by Query Type (Avg Seconds)
-- H Bars: sum(average_execution_time), query_type on Y

select
    query_type,
    warehouse_size,
    avg(execution_time) / 1000 as average_execution_time
from snowflake.account_usage.query_history
where start_time = :daterange
group by 1, 2
order by 3 desc;

-- 6.2. Average Query Execution Time (By User)
-- V Bars: sum(average_execution_time), user_name on X
-- labels X: Username, Y: Execution Time (seconds)

select user_name,
    (avg(execution_time)) / 1000 as average_execution_time
from snowflake.account_usage.query_history
where start_time = :daterange
group by 1
order by 2 desc;

-- 7.1. GS Utilization by Query Type (Top 10)
-- V Bars: sum(cs_credits), query_type on X

select
    query_type,
    sum(credits_used_cloud_services) cs_credits,
    count(1) num_queries
from snowflake.account_usage.query_history
where true and start_time >= timestampadd(day, -1, current_timestamp)
group by 1
order by 2 desc
limit 10;

-- 5.3. Total Execution Time by Repeated Queries
-- H Bars: sum(exec_time), query_text on Y
-- label X: Execution Time (Sum)

select query_text,
   (sum(execution_time) / 60000) as exec_time
from snowflake.account_usage.query_history
where execution_status = 'SUCCESS'
group by query_text
order by exec_time desc
limit 25;