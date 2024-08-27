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
