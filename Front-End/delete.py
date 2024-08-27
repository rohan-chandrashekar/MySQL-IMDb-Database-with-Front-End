import pandas as pd
import streamlit as st
from database import view_all_data_Names_,view_all_data_Titles,view_only_Names_,view_only_Titles,delete_data_Names_,delete_data_Titles


def delete_Names_():
    result = view_all_data_Names_()
    df = pd.DataFrame(result, columns=['name_id', 'name', 'birth_year', 'death_year'])
    with st.expander("CURRENT DATA PRESENT"):
        st.dataframe(df)

    #list_of_Names_ = [i[0] for i in view_only_Names_()]
    selected_Names_ = st.text_input("ENTER name_id TO DELETE:")
    st.warning("Do you want to delete ::\t{}".format(selected_Names_))
    if st.button("DELETE NAMES_"):
        delete_data_Names_(selected_Names_)
        st.success("NAME has been deleted successfully")
    new_result = view_all_data_Names_()
    df2 = pd.DataFrame(new_result, columns=['name_id', 'name', 'birth_year', 'death_year'])
    with st.expander("NAMES UPDATED"):
        st.dataframe(df2)

def delete_Titles():
    result = view_all_data_Titles()
    df = pd.DataFrame(result, columns=['title_id', 'title_type', 'primary_title', 'original_title', 'is_adult', 'start_year', 'end_year', 'runtime_minutes'])
    with st.expander("CURRENT TITLES PRESENT"):
        st.dataframe(df)

    Selected_Titles = st.text_input("ENTER title_id TO DELETE:")
    #list_of_Titles = [i[1] for i in view_only_Titles()]
    #selected_Titles = st.selectbox("Titles to Delete", list_of_Titles, key="25")
    st.warning("Do you want to delete ::{}?".format(Selected_Titles))
    if st.button("DELETE TITLES"):
        delete_data_Titles(Selected_Titles)
        st.success("Title has been deleted successfully")
    new_result = view_all_data_Titles()
    df2 = pd.DataFrame(new_result, columns=['title_id', 'title_type', 'primary_title', 'original_title', 'is_adult', 'start_year', 'end_year', 'runtime_minutes'])
    with st.expander("TITLES UPDATED"):
        st.dataframe(df2)