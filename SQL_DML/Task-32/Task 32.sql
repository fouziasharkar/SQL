SELECT * FROM mysql_task1.insurance_data;
-- 1. Show records of 'male' patient from 'southwest' region.
SELECT * FROM mysql_task1.insurance_data
WHERE gender = 'male' AND region = 'southwest';

-- 2. Show all records having bmi in range 30 to 45 both inclusive.
SELECT * FROM mysql_task1.insurance_data
WHERE bmi BETWEEN 30 AND 45;

-- 3. Show minimum and maximum bloodpressure of diabetic patient who smokes.Make column names as MinBP and MaxBP respectively.
SELECT MIN(bloodpressure) AS 'MinBP',
MAX(bloodpressure) AS 'MaxBP'
FROM mysql_task1.insurance_data
WHERE diabetic = 'Yes' AND smoker = 'Yes';


-- 4. Find no of unique patients who are not from southwest region.
SELECT COUNT(DISTINCT(patientID)) FROM mysql_task1.insurance_data
WHERE region <> 'southwest';


-- 5. Total claim amount from male smoker.
SELECT SUM(claim) FROM mysql_task1.insurance_data
WHERE gender='male';
-- 6. Select all records of south region.
SELECT * FROM mysql_task1.insurance_data
WHERE region LIKE 'south%';

-- 7. No of patient having normal blood pressure. Normal range[90-120]
SELECT COUNT(*) FROM mysql_task1.insurance_data 
WHERE bloodpressure BETWEEN 90 AND 120;


-- 8. No of patient below 17 years of age having normal blood pressure as per below formula -
-- BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)
-- Note: Formula taken just for practice, don't take in real sense.
SELECT COUNT(*) FROM mysql_task1.insurance_data
WHERE age < 17 
AND (bloodpressure BETWEEN 80+(age * 2) AND 100 + (age * 2));


-- 9. What is the average claim amount for non-smoking female patients 
-- who are diabetic?
SELECT * FROM mysql_task1.insurance_data 
WHERE gender ='female' AND smoker='No';

-- 10. Write a SQL query to update the claim amount for the patient 
-- with PatientID = 1234 to 5000.
SET SQL_SAFE_UPDATES = 0;
UPDATE mysql_task1.insurance_data 
SET claim='5000'
WHERE PatientID =1234; 

SELECT * FROM mysql_task1.insurance_data WHERE  PatientID =1234;

-- 11. Write a SQL query to delete all records for patients 
-- who are smokers and have no children.
DELETE FROM mysql_task1.insurance_data
WHERE smoker='Yes' AND children=0;

SELECT * FROM mysql_task1.insurance_data





