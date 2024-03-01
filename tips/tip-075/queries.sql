USE SCHEMA test.public;

CREATE OR REPLACE TABLE target_table(id NUMBER, description text);
INSERT INTO target_table
VALUES (1, 'First'), (2, 'Second'), (3, 'Third');

CREATE OR REPLACE TRANSIENT TABLE stage_table(id NUMBER, description text)
    DATA_RETENTION_TIME_IN_DAYS = 0;

LIST @tests_stage;
COPY INTO stage_table
FROM @tests_stage/test.csv
FILE_FORMAT = (TYPE=CSV SKIP_HEADER=1);

SELECT * FROM stage_table;

MERGE INTO target_table t
    USING stage_table s ON t.id = s.id
    WHEN MATCHED AND s.description is null
        THEN DELETE
    WHEN MATCHED
        THEN UPDATE SET t.description = s.description
    WHEN NOT MATCHED
        THEN INSERT VALUES (s.id, s.description);

DROP TABLE target_table;
UNDROP TABLE target_table;
SELECT * FROM target_table;

DROP TABLE stage_table;
UNDROP TABLE stage_table;
