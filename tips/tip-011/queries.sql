SHOW WAREHOUSES;
SELECT "name", "size"
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))
    WHERE "resource_monitor" = 'null';

create or replace resource monitor compute_wh_monitor
    with
        credit_quota = 100
        frequency = never
        start_timestamp = immediately
    triggers
        on 90 percent do notify
        on 100 percent do suspend
        on 105 percent do suspend_immediate;
alter warehouse compute_wh
    set resource_monitor = compute_wh_monitor;

show users;
CREATE OR REPLACE RESOURCE MONITOR batch_wh_monitor
    WITH
        CREDIT_QUOTA = 100
        FREQUENCY = DAILY
        START_TIMESTAMP = IMMEDIATELY
        END_TIMESTAMP = '2025-01-01'
        NOTIFY_USERS = (CRISTISCU)
    TRIGGERS
        ON 75 PERCENT DO NOTIFY
        ON 100 PERCENT DO SUSPEND
        ON 110 PERCENT DO SUSPEND_IMMEDIATE;
create or replace warehouse batch_wh
    AUTO_SUSPEND = 60
    INITIALLY_SUSPENDED = TRUE
    resource_monitor = batch_wh_monitor;

CREATE OR REPLACE RESOURCE MONITOR account_monitor
    WITH CREDIT_QUOTA = 5000
    TRIGGERS
        ON 60 PERCENT DO NOTIFY
        ON 95 PERCENT DO SUSPEND
        ON 100 PERCENT DO SUSPEND_IMMEDIATE;
ALTER ACCOUNT
    SET RESOURCE_MONITOR = account_monitor;

show resource monitors;
