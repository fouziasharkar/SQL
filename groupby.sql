SELECT * FROM mysql_sorting_grouping.smartphones;

-- GROUPING 
-- 1. Group smartphones by brand and get the count, avg price, max rating, avg screen size, avg battery capacity 
SELECT brand_name,
COUNT(*) AS 'total_phones',
AVG(price) AS 'avg_price',
MAX(rating) As 'max_rating',
AVG(screen_size) AS 'screen_size',
AVG(battery_capacity) AS 'avg_battery_capacity'
FROM mysql_sorting_grouping.smartphones
GROUP BY brand_name
ORDER BY total_phones DESC;


-- 2. group smart phones whether they have a NFC and get the average price and rating
SELECT brand_name, has_nfc,
AVG(price) AS 'avg_price',
Round(AVG(rating),2) AS 'avg_rating'
FROM mysql_sorting_grouping.smartphones
WHERE has_nfc = 'TRUE'
GROUP BY brand_name;


-- 3.group smartphones by the extended memory available and get the average price
SELECT extended_memory_available,
AVG(price) AS 'avg_price'
FROM mysql_sorting_grouping.smartphones
GROUP BY extended_memory_available;


-- 4. group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution
SELECT brand_name, processor_brand,
COUNT(*) AS 'total_phone',
AVG(primary_camera_rear) AS 'avg_camera_resolution'
FROM mysql_sorting_grouping.smartphones
GROUP BY brand_name,processor_brand;


-- 5. find top 5 most costly phone brands
SELECT brand_name,
AVG(price) AS 'avg_price'
FROM mysql_sorting_grouping.smartphones
GROUP BY brand_name
ORDER BY avg_price DESC LIMIT 5;


-- 6. which brand makes the smallest screen smartphones
SELECT brand_name,
MIN(screen_size) AS 'min_screen_size'
FROM mysql_sorting_grouping.smartphones
GROUP BY brand_name
ORDER BY min_screen_size ASC LIMIT 1;


-- 7. AVG price of 5g phones vs avg price of non 5g phones
SELECT has_5g,
AVG(price) AS 'avg_price'
FROM mysql_sorting_grouping.smartphones
GROUP BY has_5g;

-- 8. group smartphones by the brand and find the brand with the highest number of models that have both NFC and Ir blaster
SELECT brand_name,
COUNT(*) AS 'count'
FROM mysql_sorting_grouping.smartphones
WHERE has_nfc = 'True' AND has_ir_blaster = 'TRUE'
GROUP BY brand_name;





