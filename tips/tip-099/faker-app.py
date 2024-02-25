# use Faker
from faker import Faker
f = Faker()
output = [[f.name(), f.address(), f.city(), f.state(), f.email()]
    for _ in range(10000)]

# connect to Snowflake
import os
from snowflake.snowpark import Session
pars = {
    "account": 'FHB91278',
    "user": 'cristiscu',
    "password": os.environ['SNOWSQL_PWD'],
    "database": 'TEST',
    "schema": 'PUBLIC'}
session = Session.builder.configs(pars).create()

# generate 10K fake rows
df = session.create_dataframe(output,
    schema=["name", "address", "city", "state", "email"])

# display them in a Streamlit data frame
import streamlit as st
st.dataframe(df)
