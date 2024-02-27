import streamlit as st

for key in st.session_state:
    st.session_state[key] = st.session_state[key]

st.title("Snowflake Usage Insights")
st.markdown("Select a page in the sidebar!")
