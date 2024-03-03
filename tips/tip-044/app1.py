import os
import snowflake.connector

con = snowflake.connector.connect(
    account='FHB91278',
    user='cristiscu',
    password=os.environ['SNOWSQL_PWD'],
    session_parameters={'QUERY_TAG': 'qtag2'})
cur = con.cursor()
cur.execute("SHOW PARAMETERS in SESSION")
for row in cur:
    print(f'{str(row[0])}={str(row[1])}')
