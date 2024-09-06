-- SET Operations
SELECT * FROM sql_join_2.person1;
SELECT * FROM sql_join_2.person2;


-- UNION (unique elements from both table and remove duplicates)
SELECT * FROM sql_join_2.person1
UNION
SELECT * FROM sql_join_2.person2;


-- UNION ALL (same as UNION but one different is it does not remove duplicates)
SELECT * FROM sql_join_2.person1
UNION ALL
SELECT * FROM sql_join_2.person2;


-- INTERSECT (only the common element from both tables)
SELECT * FROM sql_join_2.person1
INTERSECT
SELECT * FROM sql_join_2.person2;


-- EXCEPT (The EXCEPT or MINUS operation return the unique values of first table)
SELECT * FROM sql_join_2.person1
EXCEPT
SELECT * FROM sql_join_2.person2;



