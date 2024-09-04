SELECT * FROM mysql_sorting_grouping.smartphones;

-- HAVING CLAUSE -> this condition is similar to where and it provide condition on aggregations

-- 1. find the avg rating of smartphone brands which have more than 20 phones
SELECT brand_name,
COUNT(*) AS 'count',
Round(AVG(rating),2) AS 'avg_rating'
FROM mysql_sorting_grouping.smartphones
GROUP BY brand_name
HAVING count>20
ORDER BY avg_rating DESC;


-- 2. find the top 3 brands with the highest avg ram that have a refresh rate of at least 90hz and
-- fast charging available and dont consider brands which have less than 10 phones
SELECT brand_name,
COUNT(*) AS 'count',
AVG(ram_capacity) AS 'avg_ram'
FROM mysql_sorting_grouping.smartphones
WHERE refresh_rate>90 and fast_charging_available = 1
GROUP BY brand_name
HAVING count>10
ORDER BY avg_ram DESC LIMIT 3;


-- 3. find the avg price of all the phone brands with avg rating > 70 and num phones more than 10 among all 5g enabled phones 




