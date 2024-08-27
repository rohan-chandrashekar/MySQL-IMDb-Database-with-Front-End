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

    menu2 = ["ADD_NAME","VIEW_NAME","EDIT_NAME","REMOVE_NAME"]
    choice2 = st.sidebar.selectbox("NAME",menu2)

    database.create_table_Names_()
    if choice2 == "ADD_NAME":
        st.subheader("NAME details:")
        create.create_Names_()

    #elif choice2 == "VIEW_NAME":
        #st.subheader("VIEW existing NAME")
        #read.read_Names_()

    elif choice2 == "EDIT_NAME":
        st.subheader("UPDATE NAME details")
        update.update_Names_()

    elif choice2 == "REMOVE_NAME":
        st.subheader("DELETE NAME details")
        delete.delete_Names_()

    st.progress(100)

if __name__ == '__main__':
    main()