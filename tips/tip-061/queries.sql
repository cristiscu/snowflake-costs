select name, service_type,
    sum(credits_used),
    sum(credits_used_compute),
    sum(credits_used_cloud_services)
from snowflake.account_usage.metering_history
group by name, service_type;

select service_type,
    sum(credits_used),
    sum(credits_used_compute),
    sum(credits_used_cloud_services)
from snowflake.account_usage.metering_history
group by service_type;
