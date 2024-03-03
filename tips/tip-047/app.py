import os
from snowflake.snowpark import Session

pars = {
    "account": 'FHB91278',
    "user": 'cristiscu',
    "password": os.environ['SNOWSQL_PWD']}
session = Session.builder.configs(pars).create()
session.query_tag = 'role_hierarchy2'

results = session.sql("show roles").collect()
roles = [str(row[1]) for row in results]
s = ''
for role in roles:
    results = session.sql(f'show grants to role "{role}"').collect()
    for row in results:
        if str(row[2]) == "ROLE" and str(row[1]) == "USAGE":
            s += f'\n  "{str(row[3])}" -> "{role}";'

import streamlit as st
st.title("Role Hierarchy Viewer")
st.graphviz_chart(f'digraph {{{s}}}')