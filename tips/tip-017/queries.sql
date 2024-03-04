USE SCHEMA test.public;

CREATE OR REPLACE TABLE target_table(id NUMBER, description text);
CREATE OR REPLACE TRANSIENT TABLE stage_table(id NUMBER, description text)
    DATA_RETENTION_TIME_IN_DAYS = 0;

CREATE OR REPLACE TASK task1
  WAREHOUSE = compute_wh
  SCHEDULE = '1 minute'
AS
    MERGE INTO target_table t
    USING stage_table s ON t.id = s.id
    WHEN MATCHED AND s.description is null
        THEN DELETE
    WHEN MATCHED AND s.id < 1000000
        THEN UPDATE SET t.description = s.description
    WHEN NOT MATCHED
        THEN INSERT VALUES (s.id, s.description);

CREATE OR REPLACE TASK task2
  WAREHOUSE = compute_wh
  SCHEDULE = '1 minute'
AS
    MERGE INTO target_table t
    USING stage_table s ON t.id = s.id
    WHEN MATCHED AND s.id >= 1000000 AND s.id < 2000000
        AND s.description is not null
        THEN UPDATE SET t.description = s.description;

CREATE OR REPLACE TASK task3
  WAREHOUSE = compute_wh
  SCHEDULE = '1 minute'
AS
    MERGE INTO target_table t
    USING stage_table s ON t.id = s.id
    WHEN MATCHED AND s.id >= 2000000 AND s.id < 3000000
        AND s.description is not null
        THEN UPDATE SET t.description = s.description;
