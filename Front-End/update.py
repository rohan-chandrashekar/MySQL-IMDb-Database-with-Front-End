import datetime
import pandas as pd
import streamlit as st
from database import view_all_data_Names_,view_all_data_Titles,view_only_Names_,view_only_Titles,get_Names_,get_Titles,edit_Names_,edit_Titles


def update_Names_():
    result = view_all_data_Names_()
    #st.write(result)
    df = pd.DataFrame(result, columns=['name_id', 'name', 'birth_year', 'death_year'])
    with st.expander("CURRENT NAMES:"):
        st.dataframe(df)
    #list_of_Names_ = [(i[0],i[1]) for i in view_only_Names_()]
    selected_Names_ = st.text_input("ENTER name_id to edit:")
    selected_result = get_Names_(selected_Names_)
    st.write(selected_result)
    if selected_result:
        name_id = selected_result[0][0]
        name_ = selected_result[0][1]
        birth_year = selected_result[0][2]
        death_year = selected_result[0][3]

        # Layout of Create

        col1, col2 = st.columns(2)
        with col1:
            new_name_id = st.text_input("Name_id:")
            new_name_ = st.text_input("Name:")
            
        with col2:
            new_birth_year = st.text_input("Birth Year:")
            new_death_year = st.text_input("Death Year:")
        if st.button("UPDATE NAME"):
            edit_Names_(new_name_id,new_name_,new_birth_year, new_death_year,name_id,name_,birth_year,death_year)
            st.success("Successfully updated:: {} to ::{}".format(name_id, new_name_id))

    result2 = view_all_data_Names_()
    df2 = pd.DataFrame(result2, columns=['name_id', 'name', 'birth_year', 'death_year'])
    with st.expander("UPDATED NAMES"):
        st.dataframe(df2)



def update_Titles():
    result = view_all_data_Titles()
    # st.write(result)
    df = pd.DataFrame(result, columns=['title_id', 'title_type', 'primary_title', 'original_title', 'is_adult', 'start_year', 'end_year', 'runtime_minutes'])
    with st.expander("CURRENT TITLES"):
        st.dataframe(df)
    #list_of_titles = [(i[0]) for i in view_only_Titles()]
    selected_Titles = st.text_input("Enter title_id to edit:")
    #selected_Titles = st.selectbox("TITLES TO EDIT", list_of_titles)
    selected_result = get_Titles(selected_Titles)
    st.write(selected_result)
    if selected_result:
        title_id = selected_result[0][0]
        title_type = selected_result[0][1]
        primary_title = selected_result[0][2]
        original_title = selected_result[0][3]
        is_adult = selected_result[0][4]
        start_year = selected_result[0][5]
        end_year = selected_result[0][6]
        runtime_minutes = selected_result[0][7]

        # Layout of Create

        col1, col2 = st.columns(2)
        with col1:
            new_title_id = st.text_input("TITLE ID:")
            new_title_type = st.selectbox("TITLE TYPE", ["short", "movie", "tvSeries", "tvShort", "tvMovie", "tvEpisode", "tvMiniSeries", "tvSpecial", "video", "videoGame", "tvPilot"])
            new_primary_title = st.text_input("PRIMARY TITLE")
            new_original_title = st.text_input("ORIGINAL TITLE")
            
        with col2:
            new_is_adult = st.radio("IS ADULT",(0,1))
            new_start_year = st.text_input("START YEAR")
            new_end_year = st.text_input("END YEAR")
            new_runtime_minutes = st.text_input("RUNTIME MINUTES")
        if st.button("Update Titles"):
            edit_Titles(new_title_id,new_title_type,new_primary_title,new_original_title,new_is_adult,new_start_year,new_end_year,new_runtime_minutes,title_id,title_type,primary_title,original_title,is_adult,start_year,end_year,runtime_minutes)
            st.success("Successfully updated:: {} to ::{}".format(title_id, new_title_id))

    result2 = view_all_data_Titles()
    df2 = pd.DataFrame(result2, columns=['title_id', 'title_type', 'primary_title', 'original_title', 'is_adult', 'start_year', 'end_year', 'runtime_minutes'])
    with st.expander("UPDATED TITLES"):
        st.dataframe(df2)