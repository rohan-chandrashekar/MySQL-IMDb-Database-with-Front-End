# pip install mysql-connector-python
import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="IMDb"
)
c = mydb.cursor()

def create_table_Names_():
    c.execute('CREATE TABLE IF NOT EXISTS Names_(name_id VARCHAR(255),name_ VARCHAR(255),birth_year INT(6), death_year SMALLINT(6))')

def create_table_Titles():
    c.execute('CREATE TABLE IF NOT EXISTS Titles(title_id VARCHAR(255),title_type VARCHAR(50),primary_title TEXT,original_title TEXT,is_adult TINYINT(1),start_year INT(11),end_year INT(11),runtime_minutes INT(11))')

def add_data_Names_(name_id,name_,birth_year,death_year):
    c.execute('insert into Names_(name_id,name_,birth_year,death_year) VALUES (%s,%s,%s,%s)',(name_id,name_,birth_year,death_year))
    mydb.commit()

def add_data_Titles(title_id,title_type,primary_title,original_title,is_adult,start_year,end_year,runtime_minutes):
    c.execute('insert into Titles(title_id,title_type,primary_title,original_title,is_adult,start_year,end_year,runtime_minutes) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)',(title_id,title_type,primary_title,original_title,is_adult,start_year,end_year,runtime_minutes))
    mydb.commit()

def view_all_data_Names_():
    c.execute('select * FROM Names_ LIMIT 15')
    data = c.fetchall()
    return data

def view_all_data_Titles():
    c.execute('select * FROM Titles LIMIT 15')
    data = c.fetchall()
    return data

def view_only_Names_():
    c.execute('select name_id, name_ FROM Names_ LIMIT 15')
    data = c.fetchall()
    return data

def view_only_Titles():
    c.execute('select title_id, primary_title FROM Titles LIMIT 15')
    data = c.fetchall()
    return data

def get_Names_(name_id):
    c.execute('select * from Names_ WHERE name_id="{}"'.format(name_id))
    data = c.fetchall()
    return data

def get_Titles(title_id):
    c.execute('select * from Titles WHERE title_id="{}"'.format(title_id))
    data = c.fetchall()
    return data

def edit_Names_(new_name_id, new_name_, new_birth_year, new_death_year, name_id, name_, birth_year, death_year):
    c.execute("update Names_ SET name_id=%s, name_=%s, birth_year=%s, death_year=%s WHERE name_id=%s and name_=%s and birth_year=%s and death_year=%s", (new_name_id, new_name_, new_birth_year, new_death_year, name_id, name_, birth_year, death_year))
    mydb.commit()
    data = c.fetchmany()
    return data

def edit_Titles(new_title_id, new_title_type, new_primary_title, new_original_title, new_is_adult, new_start_year, new_end_year, new_runtime_minutes, title_id, title_type, primary_title, original_title, is_adult, start_year, end_year, runtime_minutes):
    c.execute("update Titles SET title_id=%s, title_type=%s, primary_title=%s, original_title=%s, is_adult=%s, start_year=%s, end_year=%s, runtime_minutes=%s WHERE title_id=%s and title_type=%s and primary_title=%s and original_title=%s and is_adult=%s and start_year=%s and end_year=%s and runtime_minutes=%s", (new_title_id, new_title_type, new_primary_title, new_original_title, new_is_adult, new_start_year, new_end_year, new_runtime_minutes, title_id, title_type, primary_title, original_title, is_adult, start_year, end_year, runtime_minutes))
    mydb.commit()
    data = c.fetchmany()
    return data

def delete_data_Names_(name_):
    c.execute('delete from Names_ WHERE name_id="{}"'.format(name_))
    mydb.commit()

def delete_data_Titles(title_id):
    c.execute('delete from Titles WHERE title_id="{}"'.format(title_id))
    mydb.commit()