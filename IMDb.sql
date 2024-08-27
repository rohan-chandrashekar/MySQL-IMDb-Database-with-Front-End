-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 30, 2022 at 08:35 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `IMDb`
--

-- Delete IMDb database if necessary
DROP DATABASE IF EXISTS IMDb;

-- Create IMDb database

CREATE DATABASE IMDb;

-- Use IMDb database

USE IMDb;

-- Character set
-- want to be able to distinguish text with accents
ALTER DATABASE IMDb CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- Drop old tables if they exist

-- DROP TABLE IF EXISTS Titles;
-- DROP TABLE IF EXISTS Title_ratings;
-- DROP TABLE IF EXISTS Aliases;
-- DROP TABLE IF EXISTS Alias_types;
-- DROP TABLE IF EXISTS Alias_attributes;
-- DROP TABLE IF EXISTS Episode_belongs_to;
-- DROP TABLE IF EXISTS Title_genres;
-- DROP TABLE IF EXISTS Names_;
-- DROP TABLE IF EXISTS Name_worked_as;
-- DROP TABLE IF EXISTS Had_role;
-- DROP TABLE IF EXISTS Known_for;
-- DROP TABLE IF EXISTS Directors;
-- DROP TABLE IF EXISTS Writers;
-- DROP TABLE IF EXISTS Principals;

-- Create tables only

CREATE TABLE Titles (
  title_id 			  VARCHAR(255) NOT NULL, -- not null bc PK
  title_type 			VARCHAR(50),
  primary_title 	TEXT, -- some are really long
  original_title 	TEXT, -- some are really long
  is_adult 			  BOOLEAN,
  start_year			INTEGER, -- add better domain here (>1800)
  end_year 			  INTEGER, -- add better domain here (>0)
  runtime_minutes	INTEGER -- add better domain here (>0)

);

CREATE TABLE Title_ratings (
  title_id 			  VARCHAR(255) NOT NULL, -- not null bc PK
  average_rating	FLOAT,
  num_votes			  INTEGER
);

CREATE TABLE Aliases (
  title_id          VARCHAR(255) NOT NULL, -- not null bc PK
  ordering          INTEGER NOT NULL, -- not null bc PK
  title             TEXT NOT NULL,
  region				    CHAR(4),
  language          CHAR(4),
  is_original_title	BOOLEAN
);

CREATE TABLE Alias_types (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  ordering			INTEGER NOT NULL, -- not null bc PK
  type				  VARCHAR(255) NOT NULL-- Only stored if not null
);

CREATE TABLE ALias_attributes (
  title_id			VARCHAR(255) NOT NULL, -- not null bc PK
  ordering			INTEGER NOT NULL, -- not null bc PK
  attribute			VARCHAR(255) NOT NULL -- only stored if not null
);

CREATE TABLE Episode_belongs_to (
  episode_title_id          VARCHAR(255) NOT NULL, -- not null bc PK
  parent_tv_show_title_id   VARCHAR(255) NOT NULL,
  season_number             INTEGER,
  episode_number            INTEGER
);

CREATE TABLE Title_genres (
  title_id    VARCHAR(255) NOT NULL, -- not null bc PK
  genre				VARCHAR(255) NOT NULL -- not null bc PK
);

-- Names and name is a reserved word in MySQL, so we add an underscore

CREATE TABLE Names_ (
  name_id       VARCHAR(255) NOT NULL, -- not null bc PK
  name_         VARCHAR(255) NOT NULL, -- everybody has a name
  birth_year    SMALLINT, -- add a better domain here
  death_year    SMALLINT -- add a better domain here
);

CREATE TABLE Name_worked_as (
  name_id       VARCHAR(255) NOT NULL, -- not null bc PK
  profession    VARCHAR(255) NOT NULL -- not null bc PK
);

-- NOTE: All 3 must must be used as the primary key
-- role is a reserved word in MySQL, so we add an underscore

CREATE TABLE Had_role (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  name_id       VARCHAR(255) NOT NULL, -- not null bc PK
  role_         TEXT NOT NULL -- not null bc PK
);

CREATE TABLE Known_for (
  name_id       VARCHAR(255) NOT NULL, -- not null bc PK
  title_id      VARCHAR(255) NOT NULL -- not null bc PK
);

CREATE TABLE Directors (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  name_id       VARCHAR(255) NOT NULL -- not null bc PK
);

CREATE TABLE Writers (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  name_id       VARCHAR(255) NOT NULL -- not null bc PK
);

CREATE TABLE Principals (
  title_id      VARCHAR(255) NOT NULL, -- not null bc PK
  ordering      TINYINT NOT NULL, -- not null bc PK
  name_id       VARCHAR(255) NOT NULL,
  job_category  VARCHAR(255),
  job           TEXT
);

-- SHOW VARIABLES LIKE "local_infile";
SET GLOBAL local_infile = 1;

-- Load Aliases.tsv into Aliases table
LOAD DATA LOCAL INFILE  '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Aliases.tsv'
INTO TABLE Aliases
COLUMNS TERMINATED BY '\t';

-- Load Alias_attributes.tsv into Alias_attributes table
LOAD DATA LOCAL INFILE  '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Alias_attributes.tsv'
INTO TABLE Alias_attributes
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Alias_types.tsv into Alias_types table
LOAD DATA LOCAL INFILE  '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Alias_types.tsv'
INTO TABLE Alias_types
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Directors.tsv into Directors table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Directors.tsv'
INTO TABLE Directors
COLUMNS TERMINATED BY '\t';

-- Load Writers.tsv into Writers table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Writers.tsv'
INTO TABLE Writers
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Episode_belongs_to.tsv into Episode_belongs_to table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Episode_belongs_to.tsv'
INTO TABLE Episode_belongs_to
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Names_.tsv into Names_ table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Names_.tsv'
INTO TABLE Names_
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Name_worked_as.tsv into Name_worked_as table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Name_worked_as.tsv'
INTO TABLE Name_worked_as
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Known_for.tsv into Known_for table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Known_for.tsv'
INTO TABLE Known_for
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Principals.tsv into Principals table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Principals.tsv'
INTO TABLE Principals
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Had_role.tsv into Had_role table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Had_role.tsv'
INTO TABLE Had_role
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Titles.tsv into Titles table
LOAD DATA LOCAL INFILE '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Titles.tsv'
INTO TABLE Titles
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Title_genres.tsv into Title_genres table
LOAD DATA LOCAL INFILE  '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Title_genres.tsv'
INTO TABLE Title_genres
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Load Title_ratings.tsv into Title_ratings table
LOAD DATA LOCAL INFILE  '/Users/rohan/Documents/Programming/DBMS/Project/MySQL_IMDb_Project-master/Title_ratings.tsv'
INTO TABLE Title_ratings
COLUMNS TERMINATED BY '\t'
IGNORE 1 LINES;

-- Add constraints individually
ALTER TABLE Names_
ADD CONSTRAINT Names_pri_key PRIMARY KEY (name_id);

ALTER TABLE Titles
ADD CONSTRAINT Titles_pri_key PRIMARY KEY (title_id);

ALTER TABLE Aliases
ADD CONSTRAINT Aliases_pri_key PRIMARY KEY (title_id,ordering);

ALTER TABLE Alias_attributes
ADD CONSTRAINT Alias_attributes_pri_key PRIMARY KEY (title_id,ordering);

ALTER TABLE Alias_types
ADD CONSTRAINT Alias_types_pri_key PRIMARY KEY (title_id,ordering);

ALTER TABLE Directors
ADD CONSTRAINT Directors_pri_key PRIMARY KEY (title_id,name_id);

ALTER TABLE Directors
ADD CONSTRAINT Directors_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);

ALTER TABLE Writers
ADD CONSTRAINT Writers_pri_key PRIMARY KEY (title_id,name_id);

ALTER TABLE Writers
ADD CONSTRAINT Writers_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);

ALTER TABLE Episode_belongs_to
ADD CONSTRAINT Episode_belongs_to_pri_key PRIMARY KEY (episode_title_id);

ALTER TABLE Episode_belongs_to
ADD CONSTRAINT Episode_belongs_to_ep_title_id_fkey FOREIGN KEY (episode_title_id) REFERENCES Titles(title_id);

ALTER TABLE Name_worked_as
ADD CONSTRAINT Name_worked_as_pri_key PRIMARY KEY (name_id,profession);

ALTER TABLE Name_worked_as
ADD CONSTRAINT Name_worked_as_name_id_fkey FOREIGN KEY (name_id) REFERENCES Names_(name_id);

ALTER TABLE Known_for
ADD CONSTRAINT Known_for_pri_key PRIMARY KEY (name_id,title_id);

ALTER TABLE Known_for
ADD CONSTRAINT Known_for_name_id_fkey FOREIGN KEY (name_id) REFERENCES Names_(name_id);

ALTER TABLE Principals
ADD CONSTRAINT Principals_pri_key PRIMARY KEY (title_id,ordering);

-- role_ is TEXT, so we need to add indexing length (255)
ALTER TABLE Had_role
ADD CONSTRAINT Had_role_pri_key PRIMARY KEY (title_id,name_id,role_(255));

ALTER TABLE Title_genres
ADD CONSTRAINT Title_genres_pri_key PRIMARY KEY (title_id,genre);

ALTER TABLE Title_genres
ADD CONSTRAINT Title_genres_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);

ALTER TABLE Title_ratings
ADD CONSTRAINT Title_ratings_pri_key PRIMARY KEY (title_id);

ALTER TABLE Title_ratings
ADD CONSTRAINT Title_ratings_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);

-- Issues with missing data in title.basics.tsv.gz, name.basics.tsv.gz, ...

-- Disable foreign key check lock
SET foreign_key_checks = 0;

-- Aliases has titles that do not exist in Titles, i.e., there are entries in
-- IMDb's title.akas.tsv.gz that are not present in title.basics.tsv.gz. The same
-- issue arises when setting the foreign key for the Alias_attributes and
-- Alias_types tables.
ALTER TABLE Aliases
ADD CONSTRAINT Aliases_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);
-- SELECT * FROM Aliases AS A WHERE A.title_id NOT IN (SELECT title_id FROM Titles) LIMIT 10;
-- SELECT * FROM Titles WHERE title_id = 'tt0021006';
-- SELECT * FROM Aliases WHERE title_id = 'tt0021006';

ALTER TABLE Alias_attributes
ADD CONSTRAINT Alias_attributes_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);

ALTER TABLE Alias_types
ADD CONSTRAINT Alias_types_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);

-- Ditto for Episode_belongs_to table.
ALTER TABLE Episode_belongs_to
ADD CONSTRAINT Episode_belongs_to_show_title_id_fkey FOREIGN KEY (parent_tv_show_title_id) REFERENCES Titles(title_id);
-- SELECT DISTINCT E.parent_tv_show_title_id
-- FROM Episode_belongs_to AS E
-- WHERE E.parent_tv_show_title_id NOT IN (SELECT title_id FROM Titles)
-- LIMIT 10;
-- SELECT * FROM Titles WHERE title_id = 'tt6403604';
-- SELECT * FROM Episode_belongs_to WHERE parent_tv_show_title_id = 'tt6403604';

ALTER TABLE Known_for
ADD CONSTRAINT Known_for_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);
-- SELECT * FROM Known_for AS K WHERE K.title_id NOT IN (SELECT title_id FROM Titles) LIMIT 10;
-- SELECT * FROM Titles WHERE title_id = 'tt0331007';
-- SELECT * FROM Known_for WHERE title_id = 'tt0331007' LIMIT 5;

ALTER TABLE Principals
ADD CONSTRAINT Principals_name_id_fkey FOREIGN KEY (name_id) REFERENCES Names_(name_id);
-- SELECT * FROM Principals AS P WHERE P.name_id NOT IN (SELECT name_id FROM Names_) LIMIT 10;
-- SELECT * FROM Names_ WHERE name_id = 'nm0730493';
-- SELECT * FROM Principals WHERE name_id = 'nm0730493';

ALTER TABLE Principals
ADD CONSTRAINT Principals_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);
-- SELECT * FROM Principals AS P WHERE P.title_id NOT IN (SELECT title_id FROM Titles) LIMIT 10;
-- SELECT * FROM Titles WHERE title_id = 'tt0047941';
-- SELECT * FROM Principals WHERE title_id = 'tt0047941';

ALTER TABLE Had_role
ADD CONSTRAINT Had_role_title_id_fkey FOREIGN KEY (title_id) REFERENCES Titles(title_id);
-- SELECT * FROM Had_role AS H WHERE H.title_id NOT IN (SELECT title_id FROM Titles) LIMIT 10;
-- SELECT * FROM Titles WHERE title_id = 'tt0047941';
-- SELECT * FROM Had_role WHERE title_id = 'tt0047941';

ALTER TABLE Had_role
ADD CONSTRAINT Had_role_name_id_fkey FOREIGN KEY (name_id) REFERENCES Names_(name_id);
-- SELECT * FROM Had_role AS H WHERE H.name_id NOT IN (SELECT name_id FROM Names_) LIMIT 10;
-- SELECT * FROM Names_ WHERE name_id = 'nm0241605';
-- SELECT * FROM Had_role WHERE name_id = 'nm0241605';

ALTER TABLE Directors
ADD CONSTRAINT Directors_name_id_fkey FOREIGN KEY (name_id) REFERENCES Names_(name_id);
-- SELECT * FROM Directors AS D WHERE D.name_id NOT IN (SELECT name_id FROM Names_) LIMIT 10;
-- SELECT * FROM Names_ WHERE name_id = 'nm10576972';
-- SELECT * FROM Directors WHERE name_id = 'nm10576972';

ALTER TABLE Writers
ADD CONSTRAINT Writers_name_id_fkey FOREIGN KEY (name_id) REFERENCES Names_(name_id);
-- SELECT * FROM Writers AS W WHERE W.name_id NOT IN (SELECT name_id FROM Names_) LIMIT 10;
-- SELECT * FROM Names_ WHERE name_id = 'nm10032129';
-- SELECT * FROM Writers WHERE name_id = 'nm10032129';

-- Enable foreign key check lock
SET foreign_key_checks = 1;

-- Add at least one index per table

-- Alias_attributes
CREATE INDEX Alias_attributes_index ON Alias_attributes(title_id);

-- Alias_types
CREATE INDEX Alias_types_index ON Alias_types(title_id);

-- Aliases
CREATE INDEX Aliases_index ON Aliases(title_id);

-- Directors
CREATE INDEX Directors_title_id_index ON Directors(title_id);
CREATE INDEX Directors_name_id_index ON Directors(name_id);

-- Episode_belongs_to
CREATE INDEX Episode_belongs_to_ep_title_id_index ON Episode_belongs_to(episode_title_id);
CREATE INDEX Episode_belongs_to_show_title_id_index ON Episode_belongs_to(parent_tv_show_title_id);

-- Had_role
CREATE INDEX Had_role_title_id_index ON Had_role(title_id);
CREATE INDEX Had_role_name_id_index ON Had_role(name_id);

-- Known_for
CREATE INDEX Known_for_index ON Known_for(name_id);

-- Name_worked_as
CREATE INDEX Name_worked_as_index ON Name_worked_as(profession);

-- Names_
CREATE INDEX Names_index ON Names_(name_id);

-- Principals
CREATE INDEX Principals_index ON Principals(title_id);

-- Title_genres
CREATE INDEX Title_genres_title_id_index ON Title_genres(title_id);
CREATE INDEX Title_genres_genre_index ON Title_genres(genre);

-- Title_ratings
CREATE INDEX Title_ratings_index ON Title_ratings(title_id);

-- Titles
CREATE INDEX Titles_index ON Titles(title_id);

-- Writers
CREATE INDEX Writers_title_id_index ON Writers(title_id);
CREATE INDEX Writers_name_id_index ON Writers(name_id);

-- ALL QUERIES RUN AS A PART OF THE PROJECT

-- Query 1
-- Select All titles that are of Horror Genre, Not adult, and released later than 2021
SELECT * FROM Titles AS T
JOIN Title_genres AS TG ON T.title_id = TG. title_id
WHERE genre LIKE 'Horror%' AND is_adult = 0 AND start_year>2021
LIMIT 25;

-- Query 2
-- Select the Name and Role of all the cast members of Sholay?
SELECT name_, role_
FROM Names_ AS N
JOIN Had_role AS H ON N.name_id = H.name_id
WHERE title_id IN
(SELECT title id FROM Titles 
WHERE primary_title LIKE 'Sholay');

-- Query 3
-- Names And id's of actors who have played the role of James Bond
SELECT N.name_id, N.name FROM Names_ AS N
INNER JOIN Had_role AS H WHERE N.name_id = H.name_id
AND H.role_ LIKE '%James Bond%'
AND title_id IN
(SELECT title_id FROM Titles
WHERE title_type LIKE 'movie')
GROUP BY name_id;

-- Query 4
-- List All Movies of Tom Cruise and the Role Played in them in Ascending order of their release
SELECT T.title_id, T.primary_title, T.start_year, H.role_
FROM Titles AS T JOIN Had_role AS H ON T.title_id = H.title_id
WHERE H.name_id =
(SELECT name_id FROM Names_ AS N WHERE N.name_ LIKE 'Tom Cruise')
AND T.title_type LIKE 'movie' ORDER BY T.start_year ASC;

--Aggregate Queries

-- Query 1
-- Total number of titles of type 'movie' grouped by genre in descending order?
SELECT G.genre, COUNT (G. genre) AS Count
FROM Title_genres AS G, Titles AS T
WHERE T. title_id = G.title_id
AND T.title_type = 'movie'
GROUP BY genre
ORDER BY Count DESC;


-- Query 2
-- How many times has an actor played the role of James Bond?
SELECT N.name_id, N. name_, COUNT (*) AS number_of_films
FROM Names_ AS N, Had_role AS H, Titles AS T
WHERE H. role_ LIKE 'James Bond'
AND T. title_type LIKE 'movie'
AND T.title_id = H.title_id
AND N. name_id = H. name_
GROUP BY N. name_id;

-- Query 3
-- Most popular episode of The tv show 'The X Files'?
CREATE OR REPLACE VIEW Q( season_number, episode_number,primary_title, average_rating)
AS SELECT E. season_number, E.episode_number, T2.primary_title, R.average_rating
FROM Titles AS T1, Titles AS T2, Episode_belongs_to AS E, Title_ratings AS R
WHERE T1.primary_title = 'The X-Files'
AND T1. title_type = 'tvSeries'
AND T1.title_id = E.parent_tv_show_title_id
AND T2.title_type = 'tvEpisode'
AND T2.title_id = E.episode_title_id
AND T2.title_id = R.title_id
ORDER BY E. season_number, E.episode_number;

SELECT Q. season_number, Q.episode_number, Q.primary_title, Q.average_rating
FROM O
WHERE Q.average_rating = (SELECT MAX(Q.average_rating) FROM Q);

-- Query 4
-- How many episodes were there in The X-Files per season? And what was the average of the episode ratings ?
CREATE OR REPLACE VIEW Q(season_number, episode_number,primary_title, average_rating)
AS SELECT E. season_number, E.episode_number, T2.primary_title, R.average_rating
FROM Titles AS T1, Titles AS T2, Episode_belongs_to AS E, Title_ratings AS R
WHERE TI.primary_title = 'The X-Files'
AND T1.title_type = 'tvSeries'
AND TI.title_id = E.parent_tv_show_title_id
AND T2.title_type = 'tvEpisode'
AND T2.title_id = E.episode_title_id
AND T2.title_id = R.title_id
ORDER BY E. season_number, E.episode_number;

SELECT Q. season_number, COUNT (*) AS Number_of_episodes, AVG(Q.average_rating) AS Average_of_ep_average_ratings
FROM Q
GROUP BY Q.season_number
ORDER BY Q.season_number;

-- Set Queries

-- Query 1
-- Movies Directed by both Karan Johar and Sanjay Leela Bhansali
SELECT T.title id, T.primary title FROM Titles AS T JOIN Directors AS D ON T.title_id D.title id WHERE D. name id = (SELECT N.name_id FROM Names_ AS N WHERE N.name_ = 'Karan Johar')
UNION
SELECT T.title id, T.primary title FROM Titles AS T JOIN Directors AS D ON T.title_id D.title id WHERE D. name id = (SELECT N.name_id FROM Names_ AS N WHERE N.name_ = 'Sanjay Leela Bhansali');

-- Query 2
-- Movies starring both Chris Hemsworth and Chris Evans
(SELECT T.title_id, T.primary_title, T.start_year FROM Titles AS T
JOIN Had_role AS H ON T.title_id=H.title_id
WHERE H.name_id = (SELECT N. name_id FROM Names_ AS N WHERE N. name_ LIKE 'Chris Hemsworth'
AND T.title_type LIKE 'movie'))
INTERSECT
(SELECT T.title_id, T.primary_title, T.start_year FROM Titles AS T
JOIN Had_role AS H ON T.title_id=H.title_id
WHERE H.name_id = (SELECT N. name_id FROM Names_ AS N WHERE N. name_ LIKE 'Chris Evans'))

-- Query 3
-- Find all movies starring either Ranveer Singh and Deepika Padukone
-- OR Ranbir Kapoor and Alia Bhatt

((SELECT DISTINCT T.title_id, T.primary_title, T.start_year FROM Titles AS T JOIN Had_role AS H ON T.title_id=H.title_id WHERE H.name_id IN (SELECT N. name_id FROM
Names_ AS N WHERE N.name_ LIKE 'Deepika Padukone') AND T.title_type LIKE 'movie')
INTERSECT
(SELECT DISTINCT T.title_id, T.primary_title, T.start_year FROM Titles AS T JOIN Had_role AS H ON T.title_id=H.title_id WHERE H.name_id IN (SELECT N. name_id FROM
Names_ AS N WHERE N.name_ LIKE 'Ranveer Singh') AND T.title_type LIKE 'movie'))
UNION
((SELECT DISTINCT T.title id, T.orimarv title, T.start vear FROM Titles AS T JOIN Had_role AS H ON T.title_id=H.title_id WHERE H.name_id IN (SELECT N. name id FROM
Names_ AS N WHERE N.name_ LIKE 'Alia Bhatt') AND T.title_type LIKE 'movie')
INTERSECT
(SELECT DISTINCT T.title id, T.orimarv title, T.start vear FROM Titles AS T JOIN Had_role AS H ON T.title_id=H.title_id WHERE H. name_id IN (SELECT N. name id FROM
Names_ AS N WHERE N.name_ LIKE 'Ranbir Kapoor') AND T. title_type LIKE 'movie'));

-- Query 4
-- Movies Starring Alia Bhatt BUT NOT Shah Rukh Khan
(SELECT DISTINCT T.title_id, T.primary_title, T.start_year FROM Titles AS T JOIN Had_role AS H ON T.title_id=H.title_id WHERE H.name_id IN (SELECT N.name_id FROM
Names_ AS N WHERE N.name_ LIKE 'Alia Bhatt') AND T.title_type LIKE 'movie')
EXCEPT
(SELECT DISTINCT T.title_id, T.primary_title, T.start_year FROM Titles AS T JOIN Had_role AS H ON T.title_id=H.title_id WHERE H.name_id IN (SELECT N. name_id FROM
Names_ AS N WHERE N. name_ LIKE 'Shah Rukh Khan') AND T.title_type LIKE 'movie');

-- Function

-- To classify recency of titles

DELIMITER $$
CREATE FUNCTION title_recency (title_age INT)
RETURNS VARCHAR(50)
DETERMINISTIC
  BEGIN
    DECLARE recency VARCHAR;
    IF title_age > 2022 THEN:
      SET recency = 'Not Released';
    ELSE IF (title_age > 2021) THEN:
      SET recency = Latest
    ELSE IF (title_age >2015) THEN:
      SET recency = 'NEW':
    ELSE IF (title_age >2000) THEN:
      SET recency = 'Old';
    ELSE IF tItle_age>1990 THEN:
      SET recency = 'very old';
    ELSE IF title_age <1990 THEN:
      SET recency = 'Ancient'
    END IF ;
RETURN (recencv);
END: $$
DELIMITER H

SELECT Titles.title_id, Titles.primary_title, Titles.start_year, title_recency(Titles.start_year) FROM Titles ORDER BY Titles.primary_title DESC;

-- Procedure

-- To return the number of movies directed by a director

DELIMITER $$
CREATE PROCEDURE display_count_movies(IN id_director VARCHAR(50), OUT num INT)
BEGIN
  SELECT COUNT(title_id) INTO num FROM Directors WHERE name_id = id_director;
END $$
DELIMITER ;
CALL display_count_movies((SELECT name_id FROM Names WHERE name_ LIKE 'Rajkumar Hirani'), @num);
SELECT @num;


-- Trigger

-- To prevent name from being deleted if it is birth_year is greater than 2022

BEGIN
    DECLARE error_msg VARCHAR(255);
    SET error_msg = ('Birth Year Cannot be later than 2022');
    IF new.birth_year > 2022 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = error_msg;
    END IF;
END

--Cursor

DELIMITER $$
CREATE OR REPLACE PROCEDURE get_time_span (IN id_title VARCHAR(255), INOUT fullList varchar(4000))
BEGIN
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE full varchar(100) DEFAULT "";
      DECLARE curName
        CURSOR FOR
             SELECT concat(start_year , '-' , end_year) FROM Titles WHERE Titles.title_id=id_title;
               DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
               OPEN curName;
               getName: LOOP
                              FETCH curName INTO full;
                              IF finished = 1 THEN LEAVE getName;
                              END IF;
                              SET fullList = CONCAT(full," ",fullList);
               END LOOP getName;
               CLOSE curName;
END$$
DELIMITER ;

SET @fullList = "";

CALL get_time_span('tt0039123', @fullList);

SELECT @fullList;

--Other Miscellaneous Queries

-- Query 1
-- How many different title_types are there? How many of each?
CREATE OR REPLACE VIEW Q1(title_type,Count)
AS SELECT T.title_type, COUNT(*)
FROM Titles AS T
GROUP BY T.title_type
ORDER BY T.title_type ASC;

SELECT * FROM Q1;

-- Query 2
-- How many different professions are there? What are they?
CREATE OR REPLACE VIEW Q2(Job, Count)
AS SELECT P.job_category, COUNT(*)
FROM Principals AS P
GROUP BY P.job_category
ORDER BY P.job_category ASC;

SELECT * FROM Q2;

-- Query 3
-- What genres are there? How many movies are there in each genre?
CREATE OR REPLACE VIEW Q3(Genre,Count)
AS SELECT G.genre, COUNT(G.genre) AS Count
FROM Title_genres AS G, Titles AS T
WHERE T.title_id = G.title_id
AND T.title_type = 'movie'
GROUP BY genre
ORDER BY Count DESC;

SELECT * FROM Q3;

-- Query 4
-- List movies (runtime_minutes, title_type, primary_title) which are
-- longer than 10 hours. Place them in descending ordering of runtime_minutes.
CREATE OR REPLACE VIEW  Q4(runtime_minutes, title_type, primary_title) AS
SELECT runtime_minutes, title_type, primary_title
FROM Titles WHERE runtime_minutes > (10*60)
ORDER BY runtime_minutes DESC, title_type ASC;

SELECT * FROM Q4 LIMIT 10;

-- Query 5
-- How many actors are there in the database?
CREATE OR REPLACE VIEW Q5(Number_of_actors)
AS SELECT COUNT(DISTINCT N.name_id) AS Number_of_actors
FROM Name_worked_as AS N
WHERE N.profession IN ('actor','actress');

SELECT * FROM Q5;

-- Query 6
-- How many movies are there in the database?
CREATE OR REPLACE VIEW Q6(Number_of_movies)
AS SELECT COUNT(DISTINCT T.title_id) AS Number_of_movies
FROM Titles AS T
WHERE T.title_type IN ('movie','video');

SELECT * FROM Q6;

-- Query 7
-- What time period does the database cover?
CREATE OR REPLACE VIEW Q7(Earliest,Latest)
AS SELECT LEAST(MIN(T.start_year), MIN(T.end_year)) AS Earliest,
GREATEST(MAX(T.start_year), MAX(T.end_year)) AS Latest
FROM Titles AS T;

SELECT * FROM Q7;

-- Query 8
-- How many movies where made each year over the past 30 years? (Up to and
-- including 2019)
CREATE OR REPLACE VIEW Q8(Year, Number_of_movies)
AS SELECT T.start_year, COUNT(*) AS  Number_of_movies
FROM Titles AS T
WHERE T.title_type IN ('movie','video')
GROUP BY T.start_year
HAVING T.start_year BETWEEN 1990 AND 2019
ORDER BY T.start_year ASC;

SELECT * FROM Q8;

-- Query 9
-- Who are the actors who played James Bond in a movie? How many times did they
-- play the role of James Bond?
CREATE OR REPLACE VIEW Q9(name_id,name_,number_of_films)
AS SELECT N.name_id, N.name_, COUNT(*) AS number_of_films
FROM Names_ AS N, Had_role AS H, Titles AS T
WHERE H.role_ LIKE 'James Bond'
AND T.title_type LIKE 'movie'
AND T.title_id = H.title_id
AND N.name_id = H.name_id
GROUP BY N.name_id;

SELECT * FROM Q9;

-- Query 10
-- How many actors played James Bond?
CREATE OR REPLACE VIEW Q10(number_of_JB_actors)
AS SELECT COUNT(DISTINCT name_id) AS number_of_JB_actors
FROM Q9;

SELECT * FROM Q10;

-- Query 11
-- I don't recognise some of these names lets look at them more closely
CREATE OR REPLACE VIEW Q11(name_,title_id,primary_title,start_year)
AS SELECT Q9.name_, T.title_id, T.primary_title, T.start_year
FROM Q9, Titles AS T, Had_role AS H
WHERE Q9.name_id = H.name_id
AND H.role_ LIKE 'James Bond'
AND T.title_id = H.title_id
AND T.title_type LIKE 'movie'
ORDER BY T.start_year DESC;

SELECT * FROM Q11;

-- Query 12
-- Find all the movies made by Don "The Dragon" Wilson, the former light heavy
-- weight kickboxing champion. He was born in 1954 and is famous for the
-- Bloodfist series. Omit entries where he appears as himself. Output the start
-- year, the title type, title and the role he played. Order these by year.
CREATE OR REPLACE VIEW Q12(start_year, title_type, primary_title, role_)
AS SELECT DISTINCT T.start_year, T.title_type, T.primary_title, H.role_
FROM Titles AS T, Had_role AS H
WHERE T.title_id = H.title_id
AND H.role_ <> 'Himself'
AND T.title_type IN ('movie','video')
AND H.name_id = (
  SELECT N.name_id
  FROM Names_ AS N
  WHERE N.name_ LIKE 'Don Wilson' AND N.birth_year = 1954)
ORDER BY T.start_year ASC;

SELECT * FROM Q12;


-- Query 13
-- Did he ever play a role multiple times ?
CREATE OR REPLACE VIEW Q13(role_,Count)
AS SELECT Q12.role_, COUNT(*) AS Count
FROM Q12
GROUP BY Q12.role_
HAVING Count >=2;

SELECT * FROM Q13;

-- Query 14
-- What movies were these ?
CREATE OR REPLACE VIEW Q14(primary_title,role_)
AS SELECT Q12.primary_title, Q12.role_
FROM Q12, Q13
WHERE Q12.role_ = Q13.role_;

SELECT * FROM Q14;

-- Query 15
-- What are the top 250 movies as determined by the average rating with the over
-- 100,000 votes?
CREATE OR REPLACE VIEW Q15(title_id,primary_title,average_rating)
AS SELECT T.title_id, T.primary_title, R.average_rating
FROM Titles AS T, Title_ratings AS R
WHERE T.title_id = R.title_id
AND T.title_type = 'movie'
AND R.num_votes > 100000
ORDER BY R.average_rating DESC
LIMIT 250;

SELECT * FROM Q15 LIMIT 15;

-- Query 16
-- Who are the top 10 actors who have made the most movies listed in the top
-- 250 movies (determined as in Q15) and how many?
CREATE OR REPLACE VIEW Q16(name_id,name_,Count)
AS SELECT H.name_id, N.name_, COUNT(*) AS Count
FROM Q15, Titles AS T, Names_ AS N, Had_role AS H
WHERE Q15.title_id = T.title_id
AND T.title_id = H.title_id
AND N.name_id = H.name_id
GROUP BY H.name_id
ORDER BY Count DESC
LIMIT 10;

SELECT * FROM Q16;

-- Query 17
-- List all actor names and their roles who starred in the movie Back to the
-- future
CREATE OR REPLACE VIEW Q17(name_,role_)
AS SELECT N.name_, H.role_
FROM Titles AS T, Had_role AS H, Names_ AS N
WHERE T.primary_title LIKE 'Back to the Future'
AND T.title_type LIKE 'movie'
AND T.title_id = H.title_id
AND H.name_id = N.name_id;

SELECT * FROM Q17;

-- Query 18
-- What are the average ratings of the entire back to the future series?
CREATE OR REPLACE VIEW Q18(primary_title,average_rating)
AS SELECT T.primary_title, R.average_rating
FROM Titles AS T, Title_ratings AS R
WHERE T.primary_title REGEXP '^Back to the Future.*'
AND T.title_id = R.title_id
AND T.title_type = 'movie';

SELECT * FROM Q18;

-- Query 19
-- What are the average ratings of the entire Trancers series?
CREATE OR REPLACE VIEW Q19(primary_title,average_rating)
AS SELECT T.primary_title, R.average_rating
FROM Titles AS T, Title_ratings AS R
WHERE T.primary_title REGEXP '^Trancers.*'
AND T.title_id = R.title_id
AND T.title_type IN ('movie','video');

SELECT * FROM Q19;

-- Query 20
-- How many horror movies are made in leap years>? (~start_year divisible by 4)
CREATE OR REPLACE VIEW Q20(start_year,Number_of_horror_movies)
AS SELECT T.start_year, COUNT(DISTINCT T.title_id) AS Number_of_horror_movies
FROM Titles AS T, Title_genres AS G
WHERE T.title_id = G.title_id
AND G.genre = 'Horror'
AND T.title_type IN ('movie','video')
AND (T.start_year % 4) = 0
GROUP BY T.start_year
ORDER BY T.start_year DESC;

SELECT * FROM Q20;

-- Query 21
-- What were the episodes of Fawlty Towers?
CREATE OR REPLACE VIEW Q21(season_number,episode_number,primary_title)
AS SELECT E.season_number, E.episode_number, T2.primary_title
FROM Titles AS T1, Titles AS T2, Episode_belongs_to AS E
WHERE T1.primary_title = 'Fawlty Towers'
AND T1.title_type = 'tvSeries'
AND T1.title_id = E.parent_tv_show_title_id
AND T2.title_type = 'tvEpisode'
AND T2.title_id = E.episode_title_id
ORDER BY E.season_number, E.episode_number;

SELECT * FROM Q21;

-- Query 22
-- What were the names and average ratings of each episode of The X-Files?
CREATE OR REPLACE VIEW Q22(season_number,episode_number,primary_title,average_rating)
AS SELECT E.season_number, E.episode_number, T2.primary_title, R.average_rating
FROM Titles AS T1, Titles AS T2, Episode_belongs_to AS E, Title_ratings AS R
WHERE T1.primary_title = 'The X-Files'
AND T1.title_type = 'tvSeries'
AND T1.title_id = E.parent_tv_show_title_id
AND T2.title_type = 'tvEpisode'
AND T2.title_id = E.episode_title_id
AND T2.title_id = R.title_id
ORDER BY E.season_number, E.episode_number;

SELECT * FROM Q22;

-- Query 23
-- What was the most popular episode of The X-Files?
CREATE OR REPLACE VIEW Q23(season_number,episode_number,primary_title,average_rating)
AS SELECT Q22.season_number, Q22.episode_number, Q22.primary_title, Q22.average_rating
FROM Q22
WHERE Q22.average_rating = (SELECT MAX(Q22.average_rating) FROM Q22);

SELECT * FROM Q23;

-- Query Q24
-- How many episodes were there in The X-Files per season? And what was the average of the average episode ratings ?
CREATE OR REPLACE VIEW Q24(season_number,Number_of_episodes,Average_of_ep_average_ratings)
AS SELECT Q22.season_number, COUNT(*) AS Number_of_episodes, AVG(Q22.average_rating) AS Average_of_ep_average_ratings
FROM Q22
GROUP BY Q22.season_number
ORDER BY Q22.season_number;

SELECT * FROM Q24;