#Core pkgs
import streamlit as st
import pandas as pd

#DB Mgmt
import mysql.connector
conn = mysql.connector.connect(host='localhost',
                                         database='IMDb',
                                         user='root',
                                         password='')
c=conn.cursor()

# Fxn Make function
def sql_execution(raw_code):
    c.execute(raw_code)
    data = c.fetchall()
    return data

Names_ = ['name_id','name_','birth_year','death_year']
Titles = ['title_id','title_type','primary_title','original_title','is_adult','start_year','end_year','runtime_minutes']
Aliases = ['title_id','ordering','title','region','language','is_original_title']
Alias_Attributes = ['title_id','ordering','attribute']
Alias_types = ['title_id','ordering','type']
Directors = ['title_id','name_id']
Episode_belongs_to = ['episode_title_id','parent_tv_show_title_id','season_number','episode_number']
Had_role = ['title_id','name_id','role_']
Known_for = ['name_id','title_id']
Name_worked_as = ['name_id','profession']
Principals = ['title_id','ordering','name_id','job_category','job']
Title_genres = ['title_id','genre']
Title_ratings = ['title_id','average_rating','num_votes']
Writers = ['title_id','name_id']

def executioner():
    st.subheader("SQL QUERY EXECUTOR")
        
        #columns/Layout
    col1, col2 = st.columns(2)

    with col1:
        with st.form(key='query_form'):
            raw_code = st.text_area("ENTER SQL QUERY")
            submit_code = st.form_submit_button(label='EXECUTE')
            
        #Table of info
        with st.expander("TABLE INFO"):
            table_info = {'Names_':Names_,'Titles':Titles,'Aliases':Aliases,'Alias_Attributes':Alias_Attributes,'Alias_types':Alias_types,'Directors':Directors,'Episode_belongs_to':Episode_belongs_to,'Had_role':Had_role,'Known_for':Known_for,'Name_worked_as':Name_worked_as,'Principals':Principals,'Title_genres':Title_genres,'Title_ratings':Title_ratings,'Writers':Writers}
            st.json(table_info)
                
    #Result Layout
    with col2:
        if submit_code:
            st.success("Query Executed")
            st.code(raw_code)

            #Results
            query_results = sql_execution(raw_code)
            with st.expander("Results"):
                st.write(query_results)

            with st.expander("Dataframe Table"):
                df = pd.DataFrame(query_results)
                st.dataframe(df)