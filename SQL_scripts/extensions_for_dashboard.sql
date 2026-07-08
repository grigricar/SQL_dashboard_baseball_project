-- EXTENSION TO PROJECT
USE maven_advanced_sql;
-- BELOW IS extension code I used to create/adjust tables for a basic Dashboard using dataStudio

-- SOME CLEANING WAS required to remove some incomplete records

SELECT * FROM salaries
WHERE teamID IN ( "SFN" ,"NYN") AND yearID = 2014; -- The only entry for the year for player cainma01. Inflating avg salary

SELECT * FROM salaries
WHERE teamID = "NYN" and yearID=2014; -- Only three players distorts the avg salary

CREATE TEMPORARY TABLE sal_clean AS
			
SELECT * FROM salaries;

SET SQL_SAFE_UPDATES = 0; -- NEAT trick to allow for deletion!

DELETE FROM sal_clean
WHERE teamID IN ( 'SFN' ,'NYN') AND yearID = 2014; 

SET SQL_SAFE_UPDATES = 1;

-- Just converting information to different units for Data Studio Dashboard
WITH avg_W_H AS (SELECT  (FLOOR(YEAR(debut)/10))*10 as decade, AVG(weight) AS avg_W, AVG(height) AS avg_H
				 FROM players
				 GROUP BY decade  
				 ORDER BY decade)
SELECT decade, ROUND(avg_W*0.453592, 1) AS weight_Kg, ROUND(avg_H*0.0254, 2) AS height_m
FROM avg_W_H
WHERE decade IS NOT NULL;

-- Transforming into a wide for piechart

WITH bat_RL AS (SELECT s.teamID, p.bats
				FROM salaries s LEFT JOIN players p
				ON s.playerID = p.playerID),
                
  per_table AS (SELECT  teamID, 
					   ROUND((SUM(CASE WHEN bats = "R" THEN 1 ELSE 0 END)/COUNT(teamID))*100) AS bat_R,				
					   ROUND((SUM(CASE WHEN bats = "L" THEN 1 ELSE 0 END)/COUNT(teamID))*100) AS bat_L,
					   ROUND((SUM(CASE WHEN bats = "B" THEN 1 ELSE 0 END)/COUNT(teamID))*100) AS bat_Both
				   FROM bat_RL
				   GROUP BY teamID)

SELECT teamID, 'Right' AS batting_style, bat_R AS percentage FROM per_table
UNION ALL
SELECT teamID, 'Left' AS batting_style, bat_L AS percentage FROM per_table
UNION ALL
SELECT teamID, 'Both' AS batting_style, bat_Both AS percentage FROM per_table;

-- Career length
CREATE TEMPORARY TABLE career AS
WITH date_convert AS (SELECT playerID, nameGiven, CAST(CONCAT(birthYear,"-",birthMonth,"-",birthDay) AS DATE) AS birth_date, 
					  CAST(CONCAT(deathYear,"-",deathMonth,"-",deathDay) AS DATE) AS death_date, debut, finalGame
					  FROM players)

SELECT playerID, nameGiven, FLOOR((DATEDIFF(debut, birth_date))/365) AS age_debut, FLOOR((DATEDIFF(finalGame, birth_date))/365) AS age_last_game, 
	   FLOOR((DATEDIFF(finalGame, debut))/365) AS career_length	-- I was concerned about the leap years by just dividing by 360. MODEL ANSWER used TIMESTAMPDIFF() to avoid this! This seems to have checked out.
FROM date_convert
ORDER BY career_length DESC;

SELECT * FROM career;

SELECT nameGiven ,age_last_game, career_length
FROM career;

-- Salaries and team spend

#1 Annual Total Spend per team
WITH sal_yr AS (SELECT teamID, yearID, SUM(salary)/1000000 AS annual_spend_mill						
				FROM salaries
				GROUP BY teamID, yearID
				ORDER BY teamID, yearID)
                
                
SELECT * FROM sal_yr;

-- avg yearly spend per team

WITH sal_yr AS (SELECT teamID, yearID, SUM(salary) AS annual_spend						
				FROM salaries
				GROUP BY teamID, yearID
				ORDER BY teamID, yearID),
                
 avg_annual AS	(SELECT teamID, AVG(annual_spend)/100000 AS avg_annual_spend
				FROM sal_yr
				GROUP BY teamID
				ORDER BY avg_annual_spend DESC)

SELECT *
FROM avg_annual;

-- avg player salary by teams every year

SELECT teamID, yearID, (AVG(salary)/1000000) AS avg_player_salary     -- Abnormality in two teams with incomplete data for 2014 addressed in sal_clean
FROM sal_clean
GROUP BY teamID, yearID
ORDER BY YearID, avg_player_salary DESC;

-- avg salary per team over period

SELECT teamID, ROUND(AVG(salary)/1000000, 2) AS avg_player_salary
FROM sal_clean
GROUP BY teamID
ORDER BY avg_player_salary DESC;

-- Try to find the highest paid players since 1985 to 2014

WITH total_sal AS	(SELECT playerID, ROUND(SUM(salary)/1000000, 2) AS total_salary_mil
					 FROM salaries
					 GROUP BY playerID
					 ORDER BY total_salary_mil DESC)

SELECT p.nameGiven, total_salary_mil
FROM total_sal s LEFT JOIN players p
	 ON s.playerID = p.playerID;
     
-- Top three highest paid players every year

WITH salary_rank AS (SELECT playerID, yearID, salary/1000000 AS sal_mil,
					 ROW_NUMBER() OVER(PARTITION BY yearID ORDER BY salary DESC) AS salary_rank
				     FROM salaries
				     ORDER BY yearID, salary DESC)

SELECT p.nameGiven, s.yearID, s.sal_mil, s.salary_rank
FROM salary_rank s LEFT JOIN players p
	 ON s.playerID = p.playerID
WHERE salary_rank IN (1, 2, 3);

