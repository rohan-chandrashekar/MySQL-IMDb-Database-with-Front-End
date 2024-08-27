# 🎬 IMDb MySQL Database Project with Streamlit Front-End 🎥

Welcome to the **IMDb MySQL Database Project**! This project showcases how to efficiently store, query, and visualize the popular IMDb dataset in a structured MySQL database, with a user-friendly interface built using **Streamlit**. Perfect for both SQL enthusiasts and Python developers, this project aims to demonstrate advanced database design, querying, and data visualization techniques.

## 📑 Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Dataset Details](#dataset-details)
- [Entity-Relationship Diagram](#entity-relationship-diagram)
- [Installation](#installation)
- [Usage](#usage)
- [Technologies Used](#technologies-used)
- [Sample SQL Queries](#sample-sql-queries)
- [Front-End Demo](#front-end-demo)
- [Future Enhancements](#future-enhancements)

## 🌟 Introduction
This project uses the **IMDb dataset** to build a relational database in MySQL and integrates a **Streamlit-based web interface** for easy interaction. You'll explore:
- Database design using Entity-Relationship (ER) diagrams and normalization.
- Building and managing a MySQL database.
- Querying IMDb data using SQL, Python, and data visualization techniques.
- A user-friendly front-end interface using Streamlit for real-time querying and updates.

## 🚀 Features
- **MySQL Database**: Design, create, and manage a database using the IMDb dataset.
- **Streamlit Front-End**: Simple and interactive web interface to query and manipulate IMDb data.
- **Advanced SQL Queries**: Answer complex questions like "Who played James Bond the most?" or "How many actors played James Bond?"
- **Data Visualization**: Visualize IMDb data with charts and tables using Python’s pandas and matplotlib libraries.

## 📊 Dataset Details
This project utilizes IMDb’s publicly available datasets (in `.tsv` format), including:
- `name.basics.tsv`: Basic info about people (actors, directors, etc.).
- `title.basics.tsv`: Information about movies and series.
- `title.crew.tsv`: Director and writer details for all titles.
- `title.ratings.tsv`: IMDb rating and votes information.

These datasets are processed and loaded into a MySQL database after being cleaned and normalized.

## 🛠 Entity-Relationship Diagram
The project features a carefully designed **Entity-Relationship (ER) Diagram** to model the complex relationships in the IMDb dataset. The database follows standard normalization practices to ensure efficient querying and storage.

![ER Diagram](path-to-ER-diagram.png)

## ⚙️ Installation
### Requirements:
- Python 3.8+
- MySQL Server
- Streamlit

### Steps to Install:
1. Clone this repository:
   ```bash
   git clone https://github.com/rohan-chandrashekar/imdb-mysql-streamlit.git
   cd imdb-mysql-streamlit
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Set up the MySQL Database:
   - Ensure MySQL is running.
   - Run the SQL scripts to create the database and tables:
     ```bash
     mysql -u root -p < sql/imdb-create-tables.sql
     mysql -u root -p < sql/imdb-load-data.sql
     ```

4. Launch the Streamlit app:
   ```bash
   streamlit run HOME.py
   ```

## 💻 Usage
- Navigate to the Streamlit interface, where you can:
  - Search for movies or actors.
  - Update, delete, or insert records into the IMDb database.
  - Visualize ratings, genres, and other movie data interactively.

## 🔧 Technologies Used
- **MySQL**: Database management.
- **Python**: Backend scripting for data processing and visualization.
- **Streamlit**: Front-end web interface.
- **Pandas**: Data manipulation and analysis.
- **Matplotlib**: Data visualization.
- **IMDb Datasets**: Data source for movies, people, and ratings.

## 📝 Sample SQL Queries
Here are a few interesting SQL queries that you can run:
- **Actors who played James Bond and the number of times they played the role**:
   ```sql
   SELECT N.name, COUNT(*) AS number_of_films
   FROM Names N, Titles T, Roles R
   WHERE R.role = 'James Bond' AND N.name_id = R.name_id AND T.title_type = 'movie'
   GROUP BY N.name;
   ```

- **Count of James Bond actors**:
   ```sql
   SELECT COUNT(DISTINCT N.name_id) AS number_of_JB_actors
   FROM Roles R, Names N
   WHERE R.role = 'James Bond' AND N.name_id = R.name_id;
   ```

For more queries, refer to the [SQL Queries File](path-to-sql-queries).

## 🌐 Front-End Demo
The **Streamlit front-end** allows you to:
- Search for specific movies or actors.
- View detailed records such as crew information, ratings, and roles.
- Perform CRUD (Create, Read, Update, Delete) operations with a clean and simple UI.
  
![Streamlit Interface](path-to-interface-screenshot.png)

## 📈 Future Enhancements
- **Enhanced Data Visualizations**: More advanced visualizations like actor performance over time or genre trends.
- **Improved Search Functionality**: Enhanced filtering options for more granular queries.
- **User Authentication**: Adding role-based access control for database modifications.
