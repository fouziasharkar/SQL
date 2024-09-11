-- ############################### INDEPENDEN SUB-QUERY and SCALAR SUB-Query ##################################

-- Find the highest rated movies
SELECT MAX(score) FROM sql_subquery.movies;
SELECT * FROM sql_subquery.movies
WHERE  score = (SELECT MAX(score) FROM sql_subquery.movies);

-- find the movie with highest profit
SELECT * FROM sql_subquery.movies 
WHERE gross- budget = (SELECT MAX(gross- budget) FROM sql_subquery.movies);

-- Find how many movies have a rating > the avg of all the movie ratings (Find the count of above average movies)
SELECT COUNT(*) FROM sql_subquery.movies
WHERE score > (SELECT AVG(score) FROM sql_subquery.movies) ;

-- Find the highest rated movie of 2000
SELECT * FROM sql_subquery.movies
WHERE year = '2000' AND score = (SELECT MAX(score) 
                                 FROM sql_subquery.movies
                                 WHERE year = '2000');

-- Find the highest rated movie among all movies whose number of votes are > the dataset avg vote


SELECT MAX(score) FROM sql_subquery.movies
WHERE votes > (SELECT ROUND(AVG(votes)) AS 'avg_votes'FROM sql_subquery.movies);

SELECT * FROM sql_subquery.movies
WHERE score = (SELECT MAX(score) 
               FROM sql_subquery.movies
			   WHERE votes > 
               (SELECT ROUND(AVG(votes)) AS 'avg_votes'FROM sql_subquery.movies));


-- ############################### INDEPENDEN SUB-QUERY - ROW SUB-Query(One column Multiple ROws) ##################################
-- Find all the users who never ordered 
SELECT user_id,name FROM sql_casestudies_1.users
WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM sql_casestudies_1.orders);

-- Find all movies of all those actors whose filmography's avg rating > 8.5(take 25000 votes as cutoff)

SELECT * FROM sql_subquery.movies
WHERE star IN (SELECT star from sql_subquery.movies
			WHERE votes>25000
            GROUP BY star
            HAVING AVG(score)>8.5);
            

-- #################### INDEPENDEN SUB-QUERY - Table SUB-Query(Multiple columns and single row or Multiple ROws) ##########################

-- Find the most profitable movie of each year
SELECT * FROM sql_subquery.movies
WHERE (year,gross-budget) IN (SELECT year, MAX(gross-budget) 
                              FROM sql_subquery.movies
							  GROUP BY year);


-- find the highest rated movie of each genre votes cutoff of 25000
SELECT * FROM sql_subquery.movies
WHERE (genre,score) IN (SELECT genre, MAX(score) 
                       FROM sql_subquery.movies
                       WHERE votes>25000
					   GROUP BY genre) 
AND votes>25000;

-- Find the highest grossing movies of top 5 actor/director in terms of total gross income 
WITH top_duos AS (SELECT star,director,MAX(gross)
							    FROM sql_subquery.movies
                                GROUP BY star,director
								ORDER BY MAX(gross) DESC LIMIT 5)
SELECT * FROM sql_subquery.movies
WHERE (star,director,gross) IN (SELECT * FROM top_duos);

-- ########################################## CO-RELATED SUB_QUERY ##################################

-- find all the movies that have a rating higher than the average rating of movies in the same genre 
SELECT * FROM sql_subquery.movies m1
WHERE score > (SELECT AVG(score) FROM sql_subquery.movies m2 WHERE m1.genre = m2.genre);

-- Find the favourite food of each customer 
WITH fav_food AS ( SELECT t1.user_id, t1.name, t4.f_name, COUNT(*) AS 'frequency' 
				  FROM sql_casestudies_1.users t1
                  JOIN sql_casestudies_1.orders t2
                  ON t1.user_id = t2.user_id
				  JOIN sql_casestudies_1.order_details t3
				  ON t2.order_id = t3.order_id
                  JOIN sql_casestudies_1.food t4
                  ON t3.f_id = t4.f_id
				  GROUP BY t1.user_id,t1.name, t4.f_name)
                  
SELECT * FROM fav_food f1
WHERE frequency = (SELECT MAX(frequency) FROM fav_food f2 WHERE f2.user_id = f1.user_id);	
                  
-- ################################### SELECT(SELECT) #########################################
-- Display all movie names, genre, score, and avg(score) of genre
SELECT name, genre, score, (SELECT AVG(score) FROM sql_subquery.movies m2 WHERE m2.genre = m1.genre) AS 'avg_score_genre'
FROM sql_subquery.movies m1;


-- ################################### SELECT(FROM) #########################################
-- Display average rating of all the restaurants
SELECT r_name, avg_rating FROM(SELECT r_id, AVG(restaurant_rating) AS 'avg_rating'
                               FROM sql_casestudies_1.orders
                               GROUP BY r_id) t1 JOIN sql_casestudies_1.restaurants t2
                               ON t1.r_id = t2.r_id;

-- ################################### SELECT(HAVING) #########################################
-- find genres having avg score > avg score of all the movies
SELECT genre,AVG(score) FROM sql_subquery.movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score) FROM sql_subquery.movies)

-- ################################### INSERT #########################################
-- ################################### UPDATE #########################################
-- ################################### DELETE #########################################



