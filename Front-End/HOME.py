import streamlit as st

def main():
    st.balloons()
    st.title("IMDb Movie Database")

    st.header("Names_")
    st.write("This table consists of the names of the people who have worked in the movies.")
    st.progress(100)

    st.header("Titles")
    st.write("This table consists of the titles of the Movies and TV Shows")
    st.progress(100)
    
if __name__ == '__main__':
    main()