USE mysql_sorting_grouping;

-- ###################################### Ranking ######################################################
-- Find the top batsman of each batting team 
SELECT* FROM (SELECT BattingTeam,batter,SUM(batsman_run) AS 'total_run',
				DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS 'rank'
				FROM ipl_ball_by_ball_2008_2022
				GROUP BY BattingTeam,batter) t
WHERE t.rank<6;

-- ###################################### CUMULATIVE SUM ######################################################
-- virat kohli runs on 4,5,6th match
SELECT * FROM (SELECT CONCAT( "match-", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',SUM(batsman_run) AS 'total_run',
				SUM(SUM(batsman_run)) OVER(Rows between unbounded preceding and current row) AS 'career_runs'
				FROM ipl_ball_by_ball_2008_2022
				WHERE batter = 'V kohli'
				GROUP BY ID) t

WHERE match_no = 'match-4' OR match_no = 'match-5';


-- ###################################### CUMULATIVE AVERAGE ######################################################
SELECT * FROM (SELECT CONCAT( "match-", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',SUM(batsman_run) AS 'total_run',
				SUM(SUM(batsman_run)) OVER w AS 'career_runs',
                ROUND(AVG(SUM(batsman_run)) OVER w,2) AS 'career_avg'
				FROM ipl_ball_by_ball_2008_2022
				WHERE batter = 'V kohli'
				GROUP BY ID
                WINDOW w AS (Rows between unbounded preceding and current row)) t;


-- ###################################### RUNNING AVERAGE ######################################################
-- this used to figure out trends or patterns 
SELECT * FROM (SELECT CONCAT( "match-", CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',SUM(batsman_run) AS 'total_run',
				SUM(SUM(batsman_run)) OVER w AS 'cum_sum',
                ROUND(AVG(SUM(batsman_run)) OVER w,2) AS 'cum_avg',
                ROUND(AVG(SUM(batsman_run)) OVER (Rows between 2 preceding and current row),2) AS 'running_avg'
				FROM ipl_ball_by_ball_2008_2022
				WHERE batter = 'V kohli'
				GROUP BY ID
                WINDOW w AS (Rows between unbounded preceding and current row)) t;



-- ###################################### Percent of Total ######################################################
USE sql_casestudies_1;

SELECT f_name,
(total_value/SUM(total_value) OVER())*100 AS 'percent_of_total'
FROM (SELECT f_id,SUM(amount) AS 'total_value' FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
WHERE r_id = 5
GROUP BY f_id) t
JOIN food t3
ON t.f_id = t3.f_id
ORDER BY (total_value/SUM(total_value) OVER())*100 DESC


-- ###################################### Percent Change ######################################################
-- ((new value - old value)/old value) *100


-- ###################################### Percentile_DESC and Percentile_CONT ######################################################
-- workbench does not support these two functions directly i had o connect workbench with xampp mysql server
-- Find the median marks of all the students
USE general;
SELECT *,
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY marks) OVER (PARTITION BY branch) AS 'median_marks',
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY marks) OVER (PARTITION BY branch) AS 'median_marks_cont'
FROM marks;

-- ######## interquartile range (search google) ############
SELECT * FROM (SELECT *,
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY marks) OVER () AS 'q1',
       PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY marks) OVER () AS 'q2'
	   FROM marks) t
WHERE t.marks > t.q1-(1.5*(t.q2-t.q1)) AND t.marks < t.q2+(1.5*(t.q2-t.q1))
ORDER BY t.student_id;



-- ###################################### SEGMENTATION(NTILE) ######################################################
-- Segmentation using NTILE is a technique in SQL for dividing a dataset into equal-sized groups based on some criteria or conditions, and then performing
-- calculations or analysis on each group separately using window functions.

SELECT *,
NTILE(3) OVER(ORDER BY marks DESC)
FROM marks;

-- second problem 
USE mysql_sorting_grouping;

SELECT brand_name,model,price,
CASE
	WHEN bucket = 1 THEN 'Premium'
    WHEN bucket = 2 THEN 'Medium'
    WHEN bucket = 3 THEN 'Low'
END AS 'phone_type'
FROM (SELECT brand_name, model, price,
	  NTILE(3) OVER(ORDER BY price DESC) AS 'bucket'
	  FROM smartphones) t;


-- ###################################### CUM_DIST ######################################################
USE sql_journey;
SELECT * FROM (SELECT *,
CUME_DIST() OVER(ORDER BY marks) AS 'percentile_score'
FROM marks) t 
WHERE t.percentile_score>0.91
















