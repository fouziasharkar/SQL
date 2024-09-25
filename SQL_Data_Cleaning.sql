-- 1. Create backup
-- 2. Check number of rows
-- 3. Check memory consumption for reference
-- 4. Drop non important cols
-- 5. Drop null values
-- 6. Drop duplicates
-- 7. Clean RAM -> change col data type
-- 8. Clean weight -> change col type
-- 9. ROUND price col and change to integer
-- 10. Change the OpSys col
-- 11. Gpu
-- 12. Cpu

USE sql_journey;

-- data_backup (creating a same table like laptopdata)
CREATE TABLE laptop_backup LIKE laptopdata;

INSERT INTO laptop_backup
SELECT * FROM laptopdata;

-- number of rows
SELECT COUNT(*) FROM laptopdata; # 1272 rows

-- Checking memory consumption for reference
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'sql_journey' AND TABLE_NAME = 'laptopdata';

-- Drop non important columns
-- SELECT * FROM laptopdata;
-- ALTER TABLE laptopdata DROP COLUMN `Unnamed: 0`;

-- rename column
ALTER TABLE laptopdata 
RENAME COLUMN `Unnamed: 0` TO `index`;

-- DROP NULL VALUES
SELECT * FROM laptopdata
WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL
AND ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL
AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL AND
WEIGHT IS NULL AND Price IS NULL;

SET SQL_SAFE_UPDATES = 0; # this is because so that permanent deletation in table query can run without error. 

DELETE FROM laptopdata
WHERE `index` IN (
    SELECT temp_index FROM (
        SELECT `index` AS temp_index FROM laptopdata
        WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL
        AND ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL
        AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL
        AND WEIGHT IS NULL AND Price IS NULL
    ) AS subquery
);

-- DROP Duplicates

-- Clean RAM -> change col data type
SELECT * FROM laptopdata;

-- Inches column
ALTER TABLE laptopdata MODIFY column Inches DECIMAL(10);

-- RAM column
ALTER TABLE laptopdata 
RENAME COLUMN `RAM` TO `RAM(GB)`;

SET SQL_SAFE_UPDATES = 0;
SELECT REPLACE(`RAM(GB)`, 'GB', '') FROM laptopdata;
UPDATE laptopdata
SET `RAM(GB)` = REPLACE(`RAM(GB)`, 'GB', '');

ALTER TABLE laptopdata MODIFY `RAM(GB)` INTEGER;


-- weight column
UPDATE laptopdata
SET Weight = REPLACE(Weight, 'kg', '');

-- price column 
UPDATE laptopdata
SET Price = ROUND(price);

ALTER TABLE laptopdata MODIFY Price INTEGER;


-- OpSys
UPDATE laptopdata
SET OpSys = CASE 
	WHEN OpSys LIKE '%mac%' THEN 'macos'
    WHEN OpSys LIKE 'windows%' THEN 'windows'
    WHEN OpSys LIKE '%linux%' THEN 'linux'
    WHEN OpSys LIKE '%No Os%' THEN 'N/A'
    ELSE 'other'
END;

-- GPU column 

ALTER TABLE laptopdata
ADD COLUMN gpu_name VARCHAR(255) AFTER Gpu,
ADD COLUMN gpu_brand VARCHAR(255) AFTER gpu_name;

SELECT SUBSTRING_INDEX(Gpu, ' ', 1) FROM laptopdata;

UPDATE laptopdata
SET gpu_brand = SUBSTRING_INDEX(Gpu, ' ', 1);

SELECT REPLACE(Gpu, gpu_brand, '') From laptopdata;

UPDATE laptopdata
SET gpu_name = REPLACE(Gpu, gpu_brand, '');

ALTER TABLE laptopdata
DROP COLUMN Gpu;

SELECT * FROM laptopdata;

-- CPU 
ALTER TABLE laptopdata
ADD COLUMN cpu_brand VARCHAR(255) AFTER Cpu,
ADD COLUMN cpu_name VARCHAR(255) AFTER cpu_brand,
ADD COLUMN cpu_speed DECIMAL(10,1) AFTER cpu_name;

UPDATE laptopdata
SET cpu_brand = SUBSTRING_INDEX(Cpu, ' ', 1);

UPDATE laptopdata
SET cpu_speed = REPLACE(SUBSTRING_INDEX(Cpu, ' ', -1), 'GHz', '');

ALTER TABLE laptopdata MODIFY COLUMN cpu_speed DECIMAL(10,1);

UPDATE laptopdata
SET cpu_name = REPLACE(REPLACE(REPLACE(Cpu, cpu_brand, ''), cpu_speed, ''), 'GHz', '');

ALTER TABLE laptopdata
DROP COLUMN Cpu;

-- SELECT SUBSTRING_INDEX(Cpu, ' ', 2) FROM laptopdata;
-- SELECT REPLACE(REPLACE(REPLACE(Cpu, cpu_brand, ''), cpu_speed, ''), 'GHz', '') FROM laptopdata;

-- ScreenResolution Column
SELECT ScreenREsolution, SUBSTRING_INDEX(ScreenREsolution, ' ', -1),
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenREsolution, ' ', -1), 'x', 1),
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenREsolution, ' ', -1), 'x', -1)
FROM laptopdata;

ALTER TABLE laptopdata
ADD COLUMN resolution_width INTEGER AFTER ScreenREsolution,
ADD COLUMN resolution_height INTEGER AFTER resolution_width;

UPDATE laptopdata
SET resolution_width = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenREsolution, ' ', -1), 'x', 1);

UPDATE laptopdata
SET resolution_height = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenREsolution, ' ', -1), 'x', -1);

ALTER TABLE laptopdata
ADD COLUMN touch_screen INTEGER AFTER resolution_height;

SELECT ScreenResolution LIKE '%touch%' FROM laptopdata;

UPDATE laptopdata
SET touch_screen = CASE 
    WHEN ScreenResolution LIKE '%touch%' THEN 1 
    ELSE 0 
END; 

ALTER TABLE laptopdata
DROP COLUMN ScreenResolution;

-- cpu_name
SELECT cpu_name,
SUBSTRING_INDEX(TRIM(cpu_name), ' ', 2)
FROM laptopdata;

UPDATE laptopdata
SET cpu_name = SUBSTRING_INDEX(TRIM(cpu_name), ' ', 2);

SELECT * FROM laptopdata;

-- Memory
SELECT Memory,
CASE 
    WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
	WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
	WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' AND Memory LIKE '%Hybrid%' THEN 'Hybrid'
    ELSE Null
END AS 'memory_type'
FROM laptopdata;

ALTER TABLE laptopdata
ADD COLUMN primary_storage INTEGER AFTER memory_type,
ADD COLUMN secondary_storage INTEGER AFTER primary_storage,
ADD COLUMN meory_type VARCHAR(255) AFTER Memory;

ALTER TABLE laptopdata
RENAME COLUMN meory_type TO memory_type;

ALTER TABLE laptopdata
DROP COLUMN meory_type;

UPDATE laptopdata
SET memory_type = CASE 
    WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
	WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' AND Memory LIKE '%Hybrid%' THEN 'Hybrid'
	WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    ELSE Null
END;

SELECT * FROM laptopdata;

SELECT DISTINCT Memory,
REGEXP_SUBSTR(SUBSTRING_INDEX(Memory, '+', 1), '[0-9]+'), 
CASE
	WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory, '+', -1), '[0-9]+')
    ELSE 0
    END AS 'secondary_memory'
FROM laptopdata;

UPDATE laptopdata
SET primary_storage = REGEXP_SUBSTR(SUBSTRING_INDEX(Memory, '+', 1), '[0-9]+');

UPDATE laptopdata
SET secondary_storage = CASE
							WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory, '+', -1), '[0-9]+')
							ELSE 0
							END;


SELECT primary_storage,
CASE 
	WHEN primary_storage <=2 THEN primary_storage*1024
    ELSE primary_storage
    END
FROM laptopdata;

UPDATE laptopdata 
SET primary_storage = CASE 
						WHEN primary_storage <=2 THEN primary_storage*1024
						ELSE primary_storage
						END;


SELECT secondary_storage,
CASE 
	WHEN secondary_storage <=2 THEN secondary_storage*1024
    ELSE secondary_storage
    END
FROM laptopdata;

UPDATE laptopdata 
SET secondary_storage = CASE 
							WHEN secondary_storage <=2 THEN secondary_storage*1024
							ELSE secondary_storage
							END;

ALTER TABLE laptopdata
DROP COLUMN Memory;

ALTER TABLE laptopdata
DROP COLUMN gpu_name;

SELECT * FROM laptopdata
























