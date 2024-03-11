# adapted from the Snowflake Usage Insights open-source app
# see https://github.com/streamlit/snowflake-usage-app

import streamlit as st
from utils import snowflake_connector as sf
from utils import sql, charts, gui, processing

st.title("Data Transfer")
tabTransfer, tabStorage = st.tabs(["Data Transfer", "Storage"])

with st.sidebar:
    date_from, date_to = gui.date_selector()

    query = sql.DATA_TRANSFER_QUERY
    df = sf.sql_to_dataframe(query.format(date_from=date_from, date_to=date_to))

    all_values = df["TARGET_REGION"].unique().tolist()
    selected_value = st.selectbox("Choose target region", ["All"] + all_values, 0)
    if selected_value == "All": selected_value = all_values
    else: selected_value = [selected_value]

    df = df[df["TARGET_REGION"].isin(selected_value)]
    consumption = int(df["BYTES_TRANSFERRED"].sum())
    if df.empty:
        st.caption("No data found.")
        st.stop()
    if consumption == 0:
        st.caption("No consumption!")
        st.stop()

    credits_used_html = gui.underline(
        text=gui.pretty_print_bytes(consumption),
        color=gui.BLUE_COLOR)
    credits_used_html += " were used"
    st.write(credits_used_html, unsafe_allow_html=True)

with tabTransfer:
    st.write("Data Transfer spend over time - Aggregated by day")

    df_resampled = processing.resample_by_day(df, date_column="START_TIME")
    chart = charts.get_bar_chart(
        df=df_resampled, date_column="START_TIME", value_column="BYTES_TRANSFERRED")
    st.altair_chart(chart, use_container_width=True)

with tabStorage:
    st.write("Storage spend - Grouped by TRANSFER_TYPE - Top 10")

    df_grouped = (df
        .groupby(["TRANSFER_TYPE", "TARGET_CLOUD", "TARGET_REGION"])
        .agg({"BYTES_TRANSFERRED": "sum"})
        .reset_index())
    df_grouped_top_10 = df_grouped.sort_values(
        by="BYTES_TRANSFERRED", ascending=False).head(10)
    df_grouped_top_10["BYTES_TRANSFERRED"] \
        = df_grouped_top_10["BYTES_TRANSFERRED"].apply(gui.pretty_print_bytes)
    st.dataframe(
        gui.dataframe_with_podium(
            df_grouped_top_10[["TRANSFER_TYPE",
                "TARGET_CLOUD", "TARGET_REGION", "BYTES_TRANSFERRED"]]),
        width=600)
