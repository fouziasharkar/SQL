
-- CROSS JOIN 
SELECT * FROM sql_join_2.users1 t1
CROSS JOIN sql_join_2.groups t2;

-- INNER JOIN 
SELECT * FROM sql_join_2.membership t1
INNER JOIN sql_join_2.users1 t2
ON t1.user_id = t2.user_id;

-- Left join
SELECT * FROM sql_join_2.membership t1
LEFT JOIN sql_join_2.users1 t2
ON t1.user_id = t2.user_id;

-- RIGHT join
SELECT * FROM sql_join_2.membership t1
RIGHT JOIN sql_join_2.users1 t2
ON t1.user_id = t2.user_id;

-- FULL OUTER JOIN
-- this is not possible in my sql by default. to perform full outer join we have to use set solutions and manually do that. 
SELECT * FROM sql_join_2.membership t1
LEFT JOIN sql_join_2.users1 t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM sql_join_2.membership t1
RIGHT JOIN sql_join_2.users1 t2
ON t1.user_id = t2.user_id;

-- SELF JOIN 
SELECT * FROM sql_join_2.users1 t1
JOIN sql_join_2.users1 t2
ON t1.emergency_contact = t2.user_id;

-- ######################################################################

-- Multiple Column JOIN
SELECT * FROM sql_join_2.`students (1)` t1
JOIN sql_join_2.class t2
ON t1.enrollment_year = t2.class_year AND t1.class_id = t2.class_id




