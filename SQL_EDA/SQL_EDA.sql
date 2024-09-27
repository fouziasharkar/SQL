USE sql_journey;

-- head
SELECT * FROM laptopdata
ORDER BY `index` LIMIT 5;

-- tail
SELECT * FROM laptopdata
ORDER BY `index` DESC LIMIT 5;

-- sample
SELECT * FROM laptopdata
ORDER BY RAND() LIMIT 5;

-- min/max/count/std
SELECT COUNT(Price) OVER(),
MIN(Price) OVER(),
MAX(Price) OVER(),
AVG(Price) OVER(),
STD(Price) OVER()
FROM laptopdata
ORDER BY `index` LIMIT 1;

-- missing value
SELECT COUNT(Price)
FROM laptopdata
WHERE Price IS NULL;

-- Outliers(boxplot formula)
-- connect with sql server and then perform this. because mysql workbench does not support percentile_cont

-- ##############################################  Horizontal Histogram  ##########################################################
SELECT 
    CASE
        WHEN Price BETWEEN 0 AND 25000 THEN '0-25k'
        WHEN Price BETWEEN 25001 AND 50000 THEN '26k-50k'
        WHEN Price BETWEEN 50001 AND 75000 THEN '51-75k'
        WHEN Price BETWEEN 75001 AND 100000 THEN '76k-100k'
        WHEN Price > 100001 THEN '>100k'
    END AS 'price_range',
    COUNT(*) AS 'Frequency',
    REPEAT('*', COUNT(*) / 5) AS 'Histogram'
FROM
    laptopdata
GROUP BY price_range;

-- ################################################################################################################################

-- contingency table(a type of table in a matrix format that displays the multivariate frequency distribution of the variables)
SELECT Company,
SUM(CASE WHEN touch_screen = 1 THEN 1 ELSE 0 END) AS 'Touchscreen_yes',
SUM(CASE WHEN touch_screen = 0 THEN 1 ELSE 0 END) AS 'Touchscreen_no'
FROM laptopdata
GROUP BY Company;

-- copy the tables and paste it or use it in another tools to make bar or pie charts 





































































