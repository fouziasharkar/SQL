-- ######################################## Window Functions ##################################################
-- ########################################Rank/Dense Rank/Row Number #########################################

-- ####################################### RANK() ###############################################################
-- ########### if two marks are similar then rank function will alot both of them the same rank. After that the number which is second highest will be considered as rank 3. Check ECE branch.############

-- rank students in their each group 
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;

-- ####################################### DENSE_RANK() ###############################################################
-- ######## Only difference between rank and dense rank is if the two number is similar both of them will be ranked same but after these two third number will be ranked as 2. CHECK ECE #############
SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'rank',
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'dense_rank'
FROM marks;

-- ####################################### ROW_NUMBER() ###############################################################
-- It just creates row number to the each row 
SELECT *,
ROW_NUMBER() OVER(partition by branch)
FROM marks;

-- ####################################### Practice ###############################################################
use sql_casestudies_1;

-- Find top two most paying customers of each month
SELECT * FROM (SELECT user_id, MONTHNAME(date) AS 'month', SUM(amount) AS 'total',
				RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS 'month_rank'
				FROM orders
				GROUP BY user_id, month
				ORDER BY month DESC) t
WHERE t.month_rank<3;


-- ######################################## Window Functions ##################################################
-- ####################################### First_Value/Last_value/Nth_Value #########################################

-- ####################################### First_Value() #######################################################
use sql_journey;

-- it extracts the first value
SELECT *,
FIRST_VALUE(marks) OVER(ORDER BY marks DESC) 
FROM marks;

-- ####################################### Last_Value() #######################################################
-- ################################## FRAMES CONCEPT(check the note) #####################################

SELECT *,
LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
					   Rows between unbounded preceding and Unbounded Following) 
FROM marks;


-- ####################################### NTH_Value() #######################################################

SELECT *,
NTH_VALUE(marks,2) OVER(PARTITION BY branch ORDER BY marks DESC
					   Rows between unbounded preceding and Unbounded Following) AS '2nd topper'
FROM marks;

-- ####################################### PRACTICE #######################################################
-- Find the branch topper
SELECT name,branch,marks FROM(SELECT *,
              RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'rank',
			  NTH_VALUE(name,1) OVER(PARTITION BY branch ORDER BY marks DESC
			  Rows between unbounded preceding and Unbounded Following) AS '2nd topper'
              FROM marks)t
WHERE t.rank<2;


-- ######################################## Window Functions ##################################################
-- ####################################### LEAD/LAG #######################################################
USE sql_journey;

SELECT * ,
LAG(marks) OVER(ORDER BY student_id),
LEAD(marks) OVER(ORDER BY student_id)
FROM marks;
















