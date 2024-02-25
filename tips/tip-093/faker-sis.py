# use Faker
from faker import Faker
f = Faker()
output = [[f.name(), f.address(), f.city(), f.state(), f.email()]
    for _ in range(10000)]

# generate 10K fake rows and save them in CUSTOMERS_FAKE table
from snowflake.snowpark.types import StructType, StructField, StringType
schema = StructType([ 
    StructField("NAME", StringType(), False),  
    StructField("ADDRESS", StringType(), False), 
    StructField("CITY", StringType(), False),  
    StructField("STATE", StringType(), False),  
    StructField("EMAIL", StringType(), False)])

from snowflake.snowpark.context import get_active_session
df = get_active_session().create_dataframe(output, schema)
df.write.mode("overwrite").save_as_table("CUSTOMERS_FAKE")

# show table rows on screen
import streamlit as st
df = get_active_session().table("CUSTOMERS_FAKE")
st.dataframe(df)