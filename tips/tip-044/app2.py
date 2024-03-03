import os
from snowflake.snowpark import Session

pars = {
    "account": 'FHB91278',
    "user": 'cristiscu',
    "password": os.environ['SNOWSQL_PWD']}
session = Session.builder.configs(pars).create()
session.query_tag = 'qtag2'

results = session.sql("SHOW PARAMETERS in SESSION").collect()
for row in results:
    print(f'{str(row[0])}={str(row[1])}')
