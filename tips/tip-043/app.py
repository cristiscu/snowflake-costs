# adapted from the Snowflake Usage Insights open-source app
# see https://github.com/streamlit/snowflake-usage-app

import plost
import streamlit as st
from utils import sql, charts, gui, processing
from utils import snowflake_connector as sf

st.title("Queries")
tabs = st.tabs([
    "Histogram Query Duration",
    "Heatmap Query Duration",
    "Day-hour histogram",
    "Longest Queries"])

with st.sidebar:
    date_from, date_to = gui.date_selector()
    queries_data = sf.get_queries_data(date_from, date_to)

    warehouses = queries_data.WAREHOUSE_NAME.dropna().unique().tolist()
    warehouse = st.selectbox("Choose warehouse", warehouses)
    queries_data = queries_data[queries_data.WAREHOUSE_NAME.eq(warehouse)]

with tabs[0]:
    st.write("Histogram of queries duration (in secs) - Log scale")
    histogram = charts.get_histogram_chart(df=queries_data, date_column="DURATION_SECS")
    st.altair_chart(histogram, use_container_width=True)

    queries_podium_df = gui.dataframe_with_podium(queries_data, "DURATION_SECS").head(3)
    if len(queries_podium_df) >= 3:
        with st.expander("Zoom into top-3 longest queries in detail"):
            for query in queries_podium_df.itertuples():
                st.caption(f"{query.Index} {query.DURATION_SECS_PP}")
                st.code(query.QUERY_TEXT_PP, "sql")

with tabs[1]:
    st.write("Time-histograms of aggregate queries duration (in secs) - Week-day histogram")
    queries_data = processing.resample_date_period(
        queries_data, date_from, date_to, "DURATION_SECS")
    num_days_selected = (date_to - date_from).days
    if num_days_selected > 14:
        plost.time_hist(
            data=queries_data,
            date="START_TIME", x_unit="week", y_unit="day",
            color={"field": "DURATION_SECS", "scale": {"scheme": charts.ALTAIR_SCHEME}},
            aggregate="sum", legend=None)

with tabs[2]:
    plost.time_hist(
        data=queries_data,
        date="START_TIME", x_unit="day", y_unit="hours",
        color={"field": "DURATION_SECS", "scale": {"scheme": charts.ALTAIR_SCHEME}},
        aggregate="sum", legend=None)

with tabs[3]:
    st.write("Longest and most frequent queries - Log scales (hover for real values!)")
    queries_agg = sf.sql_to_dataframe(
        sql.QUERIES_COUNT_QUERY.format(
            date_from=date_from, date_to=date_to,
            num_min=1, limit=10_000, warehouse_name=warehouse))
    queries_agg = processing.apply_log1p(
        df=queries_agg, columns=["EXECUTION_MINUTES", "NUMBER_OF_QUERIES"])
    scatter_chart = charts.get_scatter_chart(df=queries_agg)
    st.altair_chart(scatter_chart, use_container_width=True)
