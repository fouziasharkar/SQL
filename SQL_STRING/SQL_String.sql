USE sql_subquery;


-- ############################################ Like Operator ###################################################
-- ############################################ WILDCARDS( _ , %) ###############################################

-- #################### UNDERSCORE(_) ####################
SELECT name FROM movies
WHERE name LIKE '_____'; # five _ means five string movie names 

SELECT name FROM movies
WHERE name LIKE 'A____'; # starts with a and has 4 strings

-- #################### Percentile(%) ###################
SELECT name FROM movies
WHERE name LIKE '%man%'; # The percent sign represents zero, one, or more characters,


-- ############################################ STRING FUNCTIONS ###################################################

-- ############################################ UPPER()/LOWER() ###################################################

SELECT name, UPPER(name), LOWER(name) FROM movies;

-- ############################################ CONCAT/CONCAT_WS ###################################################

-- ################ CONCAT ################
SELECT CONCAT(name,' ', director, ' ', budget) FROM movies;

-- ################ CONCAT_WS ##############
SELECT CONCAT_WS('----',name, director, budget) FROM movies;


-- ############################################ SUBSTR() ###################################################
SELECT name, SUBSTR(name, 1,5) FROM movies;
SELECT name, SUBSTR(name, 5) FROM movies; # it will print all from 5 to end
SELECT name, SUBSTR(name, -5) FROM movies; # it will print the last 5 char

SELECT name, SUBSTR(name, -5,1) FROM movies; #it will print the 5th char from last 
SELECT name, SUBSTR(name, -5,2) FROM movies; # it will print 2 character from the 5th position of last char


-- ############################################ REPLACE ###################################################

SELECT REPLACE('HELLO WORLD', 'WORLD', 'BANGLADESH') AS 'replace';

SELECT name, REPLACE (name, 'man', 'woman') FROM movies;


-- ############################################ REVERSE/Palindrome ###################################################
SELECT REVERSE  ('Hello');

SELECT name FROM movies 
WHERE name =  REVERSE(name);


-- ############################################ CHAR_length VS length ###################################################
-- read the concept from pdf
SELECT name, LENGTH(name) , CHAR_LENGTH(name) FROM movies
WHERE LENGTH(name) <> CHAR_LENGTH(name);

-- ############################################ insert(str, pos, len, newstr) ###################################################
SELECT INSERT('HELLO WORLD', 7,0, 'My' ); #if the len is zero it means it wont replace the string. It will just add the str in the pos   

-- ############################################ left and right ###################################################
SELECT name, LEFT(name,3), RIGHT(name,3) FROM movies;

-- ############################################ REPEAT ###################################################
SELECT REPEAT(name,3) FROM movies ;

-- ############################################ trim[ltrim and rtrim] ###################################################

SELECT TRIM('                      FOUZIA                    '); # it will trem the blank spaces
SELECT TRIM(BOTH "." FROM '..............FOUZIA.............');  
SELECT TRIM(LEADING "." FROM '..............FOUZIA.............');
SELECT TRIM(TRAILING "." FROM '..............FOUZIA.............');

-- ################################# SUBSTRING_INDEX(very much similar like python split) ##########################################
SELECT SUBSTRING_INDEX('www.mysql.com', '.', 1); # it will print only www. 1 means first '.' occurance porjonto print koro
SELECT SUBSTRING_INDEX('www.mysql.com', '.', -1); 


-- ############################################ strcmp(string comparison) ###################################################
-- The STRCMP() function returns an integer that indicates the relationship between the two strings:
             -- If str1 is less than str2, the function returns a negative integer.
             -- If str1 is greater than str2, the function returns a positive integer.
             -- If str1 is equal to str2, the function returns 0.

SELECT STRCMP('text', 'text2');
        -- -> -1
SELECT STRCMP('text2', 'text');
        -- -> 1
SELECT STRCMP('text', 'text');
        -- -> 0

-- ############################################ LOCATE() ###################################################

SELECT LOCATE('WORLD', 'HELLO WORLD'); # it gives the first position of the sub-string


-- ############################################ LPAD/RPAD ###################################################

-- ############## LPAD ############
SELECT LPAD('1554129673',14,'+880');
        -- -> '??hi'
-- ############## RPAD ############
SELECT RPAD('015541296',11,'73');
        -- -> '01554129673'
        

-- REGEX()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        












