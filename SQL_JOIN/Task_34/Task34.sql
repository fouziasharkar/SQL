SELECT * FROM task_34.country_ab;

-- Q-1 Find out top 10 countries' which have maximum A and D values.
SELECT A.Country, A,D FROM (SELECT Country, A FROM task_34.country_ab
ORDER BY A DESC LIMIT 10) A
LEFT JOIN 
(SELECT Country, D FROM task_34.country_cd
ORDER BY D DESC LIMIT 10) D
ON A.Country = D.Country
UNION 
SELECT D.Country, A,D FROM (SELECT Country, A FROM task_34.country_ab
ORDER BY A DESC LIMIT 10) A
RIGHT JOIN 
(SELECT Country, D FROM task_34.country_cd
ORDER BY D DESC LIMIT 10) D
ON A.Country = D.Country;


-- Q-2 Find out highest CL value for 2020 for every region. Also sort the result in descending order. Also display the CL values in descending order.
SELECT Region, MAX(CL) AS 'max_cl' FROM task_34.country_cl t1
JOIN task_34.country_cd t2
ON t1.Country = t2.Country
WHERE t1.Edition = '2020' 
GROUP BY Region
ORDER BY max_cl DESC;


-- Q-3 Find top-5 most sold products.
SELECT t1.ProductId, t2.Name, SUM(t1.Quantity) As 'total_quantity'
FROM task_34.sales1 t1
JOIN task_34.products t2
ON t1.ProductID = t2.ProductID
GROUP BY t1.ProductId, t2.name
ORDER BY total_quantity DESC LIMIT 5;


-- Q-4: Find sales man who sold most no of products.
SELECT t1.SalesPersonID, CONCAT(FirstName,' ', MiddleInitial, ' ',LastName) AS 'Name', SUM(t1.Quantity) As 'total_quantity'
FROM task_34.sales1 t1
JOIN task_34.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, Name
ORDER BY total_quantity DESC LIMIT 1;


-- Q-5: Sales man name who has most no of unique customer.
SELECT t1.SalesPersonID, CONCAT(t2.FirstName,' ', t2.MiddleInitial, ' ',t2.LastName) AS 'Name', COUNT(DISTINCT(t1.CustomerID)) As 'total_unique_customer'
FROM task_34.sales1 t1
JOIN task_34.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, Name
ORDER BY total_unique_customer DESC LIMIT 5;


-- Q-6: Sales man who has generated most revenue. Show top 5.
SELECT t1.SalesPersonID, ROUND(SUM(t2.Price)) As 'total_price'
FROM task_34.sales1 t1
JOIN task_34.products t2
ON t1.ProductID = t2.ProductID
GROUP BY t1.SalesPersonID
ORDER BY total_price DESC LIMIT 5;


-- Q-7: List all customers who have made more than 10 purchases.
SELECT t1.CustomerID, t2.FirstName, t2.LastName, COUNT(*) AS PurchaseCount
FROM task_34.sales1 t1
JOIN task_34.customers t2 ON t1.CustomerID = t2.CustomerID
GROUP BY t1.CustomerID, t2.FirstName, t2.LastName
HAVING COUNT(*) > 10;


-- Q-8 : List all salespeople who have made sales to more than 5 customers.
SELECT t1.SalesPersonID, CONCAT(t2.FirstName,' ', t2.MiddleInitial, ' ',t2.LastName) AS 'Name', COUNT(DISTINCT(t1.CustomerID)) As 'total_unique_customer'
FROM task_34.sales1 t1
JOIN task_34.employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID, Name
HAVING total_unique_customer>5;


-- Q-9: List all pairs of customers who have made purchases with the same salesperson.
-- SELF JOIN 
SELECT DISTINCT t1.CustomerID AS 'first_customer',
t2.CustomerID AS 'second_customer', t1.SalesPersonID
FROM task_34.sales1 t1
JOIN task_34.sales1 t2
ON t1.SalesPersonID = t2.SalesPersonID AND t1.CustomerID != t2.CustomerID 




