import streamlit as st
from database import add_data_Names_,add_data_Titles

def create_Names_():
    col1, col2 = st.columns(2)
    with col1:
        name_id = st.text_input("Enter Name id:")
        name_ = st.text_input("Enter Name:")
            
    with col2:
        birth_year = st.text_input("Enter Birth Year:")
        death_year = st.text_input("Enter Death Year:")
    
    if st.button("ADD NAME"):
        add_data_Names_(name_id,name_,birth_year,death_year)
        st.success("Successfully added Name: {} {}".format(name_, name_id))

def create_Titles():
    col3, col4 = st.columns(2)
    with col3:
        title_id = st.text_input("Enter Title id:")
        title_types = ["short", "movie", "tvSeries", "tvShort", "tvMovie", "tvEpisode", "tvMiniSeries", "tvSpecial", "video", "videoGame", "tvPilot"]
        title_type = st.selectbox("Enter Title Type:",title_types)
        primary_title = st.text_input("Enter Primary Title:")
        original_title = st.text_input("Enter Original Title:")

    with col4:
        is_adult = st.radio("Enter if Title is A Rated:",(0,1))
        start_year = st.text_input("Enter Start Year:")
        end_year  = st.text_input("Enter End Year:")
        run_time  = st.text_input("Enter Run-Time (In Minutes):")
    if st.button("ADD TITLE"):
        add_data_Titles(title_id,title_type,primary_title,original_title,is_adult,start_year,end_year,run_time)
        st.success("Successfully added APP: {} {}".format(primary_title, title_id))