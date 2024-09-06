-- JOin more than two tables 

-- filtering columns

-- order details r pashe customer name r jonno eta join kora hoise
SELECT t1.order_id, t1.amount, t3.name  FROM sql_join_1.order_details t1
JOIN sql_join_1.orders t2
ON t1.order_id = t2.order_id 
JOIN sql_join_1.users t3
ON t2.user_id = t3.user_id;


-- find order_id,name,city by joining users and orders 
SELECT t2.order_id,t1.name,t1.city 
FROM sql_join_1.users t1
JOIN sql_join_1.orders t2 
ON t1.user_id = t2.user_id;


-- filtering rows

-- find all the orders placed in PUNE 
SELECT * FROM sql_join_1.users t1
JOIN sql_join_1.orders t2
ON t1.user_id = t2.user_id
WHERE t1.city = 'Pune';

-- find all orders under chair category
SELECT * FROM sql_join_1.category t1
JOIN sql_join_1.category t2
ON t1.category_id=t2.category_id
WHERE t1.vertical = 'Chairs';

-- #############################################################################
-- Practice 
-- 1. Find all profitable orders
SELECT t1.order_id, SUM(t2.profit) FROM sql_join_1.orders t1
JOIN sql_join_1.order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING SUM(t2.profit) >0 ;

-- 2. Find the customers who has placed max number of orders
SELECT name, COUNT(*) AS 'count'
FROM sql_join_1.orders t1
JOIN sql_join_1.users t2
ON t1.user_id = t2.user_id 
GROUP BY t2.name
ORDER BY count DESC LIMIT 1;


-- 3. Which is the most profitable category
SELECT vertical, SUM(profit) AS 'profit' FROM sql_join_1.category t1
JOIN sql_join_1.order_details t2
ON t1.category_id = t2.category_id
GROUP BY vertical
HAVING profit>0
ORDER BY profit DESC LIMIT 1;


-- 4.which is the most profitable state 
SELECT state, sum(profit) AS 'profit'
FROM sql_join_1.users t1
JOIN sql_join_1.orders t2
ON t1.user_id = t2.user_id
JOIN sql_join_1.order_details t3
ON t2.order_id = t3.order_id
GROUP BY state
HAVING profit>0
ORDER BY profit DESC LIMIT 1;

-- 5. Find all categories profit higher than 3000
SELECT vertical, SUM(profit) AS 'profit'
FROM sql_join_1.category t1
JOIN sql_join_1.order_details t2
ON t1.category_id = t2.category_id
GROUP BY vertical
HAVING profit>3000
ORDER BY profit DESC;















