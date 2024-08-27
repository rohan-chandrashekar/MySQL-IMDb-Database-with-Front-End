# Importing pakages
import streamlit as st
import mysql.connector

from importlib.machinery import SourceFileLoader
create = SourceFileLoader("create","/Users/rohan/Documents/Programming/DBMS/Project/Front-End/create.py").load_module()
database = SourceFileLoader('database', '/Users/rohan/Documents/Programming/DBMS/Project/Front-End/database.py').load_module()
delete = SourceFileLoader('delete', '/Users/rohan/Documents/Programming/DBMS/Project/Front-End/delete.py').load_module()
#read = SourceFileLoader('read', '/Users/rohan/Documents/Programming/DBMS/Project/Front-End/read.py').load_module()
update = SourceFileLoader('update', '/Users/rohan/Documents/Programming/DBMS/Project/Front-End/update.py').load_module()
window = SourceFileLoader('window', '/Users/rohan/Documents/Programming/DBMS/Project/Front-End/window.py').load_module()
import time

def main():
    st.title("IMDb Movie Database")

    menu3 = ["ADD_TITLES","VIEW_TITLES","EDIT_TITLES","REMOVE_TITLES"]
    choice3 = st.sidebar.selectbox("TITLES",menu3)

    database.create_table_Titles()
    if choice3 == "ADD_TITLES":
        st.subheader("TITLE details:")
        create.create_Titles()

    #elif choice3 == "VIEW_TITLES":
        #st.subheader("VIEW existing TITLE details:")
        #read.read_Titles()

    elif choice3 == "EDIT_TITLES":
        st.subheader("UPDATE TITLE details")
        update.update_Titles()

    elif choice3 == "REMOVE_TITLES":
        st.subheader("DELETE TITLE details")
        delete.delete_Titles()

    st.progress(100)

if __name__ == '__main__':
    main()