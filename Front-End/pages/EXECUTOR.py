# Importing pakages
import streamlit as st
import mysql.connector

from importlib.machinery import SourceFileLoader
window = SourceFileLoader('window', '/Users/rohan/Documents/Programming/DBMS/Project/Front-End/window.py').load_module()

def main():
    st.title("IMDb Movie Database")
    window.executioner()
    st.progress(100)

if __name__ == '__main__':
    main()
