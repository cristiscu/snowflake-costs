# adapted from the Snowflake Usage Insights open-source app
# see https://github.com/streamlit/snowflake-usage-app

import streamlit as st
from utils import sql, charts, gui, processing
from utils import snowflake_connector as sf

st.title("Compute")
tabComputeOverTime, tabComputeByName = \
    st.tabs(["Compute over Time", "Compute by Name"])

with st.sidebar:
    date_from, date_to = gui.date_selector()

    query = sql.CONSUMPTION_PER_SERVICE_TYPE_QUERY
    df = sf.sql_to_dataframe(query.format(date_from=date_from, date_to=date_to))
    all_values = df["SERVICE_TYPE"].unique().tolist()
    selected_value = st.selectbox("Choose service type", ["All"] + all_values, 0)
    selected_value = all_values if selected_value == "All" else [selected_value]
    df = df[df["SERVICE_TYPE"].isin(selected_value)]

    consumption = int(df["CREDITS_USED"].sum())
    if df.empty: st.caption("No data found.")
    elif consumption == 0: st.caption("No consumption found.")
    else:
        credits_used_html = gui.underline(text=gui.pretty_print_credits(consumption),)
        credits_used_html += " were used"
        st.write(credits_used_html, unsafe_allow_html=True)

with tabComputeOverTime:
    st.write("Compute spend over time - Aggregated by day")

    df_resampled = processing.resample_by_day(df, date_column="START_TIME")
    bar_chart = charts.get_bar_chart(
        df=df_resampled, date_column="START_TIME", value_column="CREDITS_USED")
    st.altair_chart(bar_chart, use_container_width=True)

with tabComputeByName:
    st.write("Compute spend - Grouped by NAME - Top 10")
    
    df_grouped = df.groupby(["NAME", "SERVICE_TYPE"]).agg({"CREDITS_USED": "sum"}).reset_index()
    df_grouped_top_10 = df_grouped.sort_values(by="CREDITS_USED", ascending=False).head(10)
    df_grouped_top_10["CREDITS_USED"] = \
        df_grouped_top_10["CREDITS_USED"].apply(gui.pretty_print_credits)
    st.dataframe(
        gui.dataframe_with_podium(df_grouped_top_10)[["NAME", "SERVICE_TYPE", "CREDITS_USED"]],
        width=600)
