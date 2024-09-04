SELECT * FROM mysql_sorting_grouping.smartphones;

-- SELECT 
-- 1. Find top 5 samsumg phones with the biggest screen size 
SELECT model, screen_size FROM mysql_sorting_grouping.smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC LIMIT 5;


-- 2. Sort all the phones in descending order of number of total cameras 
SELECT model, num_rear_cameras+num_front_cameras AS 'total_cameras' FROM mysql_sorting_grouping.smartphones
ORDER BY total_cameras DESC LIMIT 10;


-- 3. sort data on the basis of ppi in descending order 
SELECT model, ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size) AS 'PPI'
FROM mysql_sorting_grouping.smartphones
ORDER BY PPI DESC;


-- 4. find the phone with second largest battery
SELECT model, battery_capacity FROM mysql_sorting_grouping.smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;


-- 5. find the name and rating of the worst rated apple phone
SELECT model, rating FROM mysql_sorting_grouping.smartphones
WHERE brand_name = 'apple'
ORDER BY rating ASC LIMIT 1;

 
-- 6. sort phones alphabetically and then on the basis of rating in desc order
SELECT brand_name, model, rating FROM mysql_sorting_grouping.smartphones
ORDER BY brand_name ASC, rating DESC;

















