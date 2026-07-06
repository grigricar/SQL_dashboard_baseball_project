-- PART I: SCHOOL ANALYSIS
-- 1. View the schools and school details tables
SELECT * FROM schools;
SELECT * FROM school_details;

-- 2. In each decade, how many schools were there that produced players?
SELECT  FLOOR(s.yearID/10) AS decade, sd.name_full			-- ALTERNATIVE: Neater as well FLOOR(yearID/10)*10 rounds to the given decade
FROM 	schools s LEFT JOIN school_details sd
		ON s.schoolID = sd.schoolID
ORDER BY s.yearID;

WITH de AS (SELECT  FLOOR(s.yearID/10) AS decade, sd.name_full AS school
				FROM 	schools s LEFT JOIN school_details sd
				ON s.schoolID = sd.schoolID
				ORDER BY s.yearID)

SELECT decade, COUNT(DISTINCT(school)) AS num_school
FROM de
GROUP BY decade;

-- Alternative MODEL ANSWER ATTAINS the result with just one table
SELECT FLOOR(yearID/10) * 10 AS decade2, COUNT(DISTINCT schoolID) AS num_schools
FROM schools
GROUP BY decade2;

-- 3. What are the names of the top 5 schools that produced the most players?
SELECT  sd.name_full, COUNT(DISTINCT(s.playerID)) AS num_players
FROM 	schools s LEFT JOIN school_details sd
		ON s.schoolID = sd.schoolID
GROUP BY sd.name_full;						-- Could just smack in an ORDER BY here, but you can reference the alias				


WITH plyr_count AS (SELECT  sd.name_full, COUNT(DISTINCT(s.playerID)) AS num_players
					FROM 	schools s LEFT JOIN school_details sd
							ON s.schoolID = sd.schoolID
					GROUP BY sd.name_full)
SELECT *
FROM plyr_count
ORDER BY num_players DESC
LIMIT 5;

-- 4. For each decade, what were the names of the top 3 schools that produced the most players?
WITH plyr_count AS (SELECT  ROUND(s.yearID/10) AS decade, sd.name_full AS school, s.playerID AS player
					FROM 	schools s LEFT JOIN school_details sd
					ON s.schoolID = sd.schoolID
				    ORDER BY decade),
sch_num_players AS	(SELECT decade, school, COUNT(DISTINCT(player)) AS num_players
					FROM plyr_count
					GROUP BY decade, school)
SELECT *
FROM (SELECT  decade, school, num_players,
			  DENSE_RANK() OVER(PARTITION BY decade ORDER BY num_players DESC) AS school_rank  -- Model answer uses ROW_NUMBER(). Using DENSE_RANK() is actually more accurate. Rankings are shared/tied in many cases.
	  FROM sch_num_players) AS ranked
WHERE school_rank < 4
ORDER BY decade DESC, school_rank;


-- PART II: SALARY ANALYSIS


-- 1. View the salaries table
SELECT * FROM salaries;

-- 2. Return the top 20% of teams in terms of average annual spending
WITH sal_yr AS (SELECT teamID, yearID, SUM(salary) AS annual_spend						-- NOTE: BY grouping by year teamID AND yearID, I can then average over years in the next GROUP BY 
				FROM salaries
				GROUP BY teamID, yearID
				ORDER BY yearID, teamID),
                
 avg_annual AS	(SELECT teamID, AVG(annual_spend) AS avg_annual_spend
				FROM sal_yr
				GROUP BY teamID
				ORDER BY avg_annual_spend DESC),
                
	sal_per AS (SELECT  teamID, ROUND(avg_annual_spend,2) AS avg_annual_spend,
						NTILE(5) OVER(ORDER BY avg_annual_spend) AS percentile				-- Had to think here: No PARTITION BY required SINCE each teamID is unique. We want all of them as a ranked 20% percentile
				FROM avg_annual)

SELECT * FROM sal_per
WHERE percentile = 1;


-- 3. For each team, show the cumulative sum of spending over the years
WITH sal_yr AS (SELECT teamID, yearID, SUM(salary) AS annual_spend						-- NOTE: BY grouping by year teamID AND yearID, I can then average over years in the next GROUP BY 
				FROM salaries
				GROUP BY teamID, yearID
				ORDER BY teamID, yearID)

SELECT teamID, yearID, annual_spend,
		SUM(annual_spend) OVER(PARTITION BY teamID ORDER BY yearID DESC) AS cumulative_spend
FROM sal_yr;

-- 4. Return the first year that each team's cumulative spending surpassed 1 billion
WITH sal_yr AS (SELECT teamID, yearID, SUM(salary) AS annual_spend						 
				FROM salaries
				GROUP BY teamID, yearID
				ORDER BY teamID, yearID),

cumu_spend 	AS (SELECT  teamID, yearID, annual_spend,
						SUM(annual_spend) OVER(PARTITION BY teamID ORDER BY yearID DESC) AS cumulative_spend
				FROM sal_yr),
                
adjust		AS	(SELECT teamID, yearID, annual_spend, ROUND(cumulative_spend/1000000, 2) AS cumulative_spend_mil
				 FROM cumu_spend),

ranked      AS	(SELECT teamID, yearID, cumulative_spend_mil,
						 RANK() OVER(PARTITION BY teamID ORDER BY cumulative_spend_mil) AS cumu_over_1bill
				FROM adjust
				WHERE cumulative_spend_mil > 1000) 

SELECT teamID, yearID AS first_year_cumlative_spend_over_1billion 
FROM ranked
WHERE cumu_over_1bill = 1
ORDER BY first_year_cumlative_spend_over_1billion;


-- PART III: PLAYER CAREER ANALYSIS
-- 1. View the players table and find the number of players in the table
SELECT * FROM players;
SELECT COUNT(DISTINCT playerID), COUNT( playerID) -- Just to check that all IDs are unique as expected
FROM players;

-- 2. For each player, calculate their age at their first game, their last game, and their career length (all in years). Sort from longest career to shortest career.
CREATE TEMPORARY TABLE career AS
WITH date_convert AS (SELECT playerID, nameGiven, CAST(CONCAT(birthYear,"-",birthMonth,"-",birthDay) AS DATE) AS birth_date, 
					  CAST(CONCAT(deathYear,"-",deathMonth,"-",deathDay) AS DATE) AS death_date, debut, finalGame
					  FROM players)

SELECT playerID, nameGiven, FLOOR((DATEDIFF(debut, birth_date))/365) AS age_debut, FLOOR((DATEDIFF(finalGame, birth_date))/365) AS age_last_game, 
	   FLOOR((DATEDIFF(finalGame, debut))/365) AS career_length	-- I was concerned about the leap years by just dividing by 360. MODEL ANSWER used TIMESTAMPDIFF() to avoid this! This seems to have checked out.
FROM date_convert
ORDER BY career_length DESC;

SELECT * FROM career;
-- 3. What team did each player play on for their starting and ending years?
CREATE TEMPORARY TABLE temp AS 

WITH info AS (SELECT p.playerID, p.nameGiven, YEAR(p.debut) AS start_year, YEAR(p.finalGame) AS end_year, s.teamID, s.yearID
			  FROM salaries s LEFT JOIN players p
			  ON s.playerID = p.playerID),
              
start_team AS (SELECT * 
			   FROM info
			   WHERE start_year = yearID),
               
end_team AS (SELECT * 
			   FROM info
			   WHERE end_year = yearID)             -- Players who have not ended their careers are excluded


               
SELECT st.playerID, st.nameGiven, st.teamID AS start_team, et.teamID AS end_team
FROM start_team AS st lEFT JOIN end_team AS et
	 ON st.playerID = et.playerID;
     

SELECT * 
FROM temp;


-- 4. How many players started and ended on the same team and also played for over a decade?
WITH combined AS (SELECT t.playerID, t.nameGiven, t.start_team, t.end_team, c.career_length
				  FROM temp t LEFT JOIN career c
				  ON t.playerID = c.playerID)

SELECT * 
FROM combined
WHERE start_team = end_team AND career_length > 10; 

-- With a count the answer comes to 19, which checks out with the SOLUTION. The names also check out but my method was different. 
-- I used more CTEs where the MODEL answer used multiple inner joins. It was shorter in terms of code, but the logic was less obvious. 
     
-- PART IV: PLAYER COMPARISON ANALYSIS

-- 1. View the players table
SELECT * FROM players;
SELECT * FROM salaries;
-- 2. Which players have the same birthday?  -- MISLEADING QUESTION. It should read birthdate. My answer checks out for the requirements. 
WITH birthday AS (SELECT playerID, nameGiven,birthMonth, birthDay
				  FROM players)
                  
SELECT b1.nameGiven, b1.birthMonth, b1.BirthDay
FROM birthday b1 INNER JOIN birthday b2
	 ON b1.birthMonth = b2.birthMonth AND b1.birthDay = b2.birthDay
WHERE b1.nameGiven <> b2.nameGiven
ORDER BY b1.birthMonth, b1.birthDay;

-- 3. Create a summary table that shows for each team, what percent of players bat right, left and both
WITH bat_RL AS (SELECT s.teamID, p.bats
				FROM salaries s LEFT JOIN players p
				ON s.playerID = p.playerID)
                
SELECT teamID, 
	   ROUND((SUM(CASE WHEN bats = "R" THEN 1 ELSE 0 END)/COUNT(teamID))*100) AS bat_R,				-- Very finicky using CASE WHEN ... THEN ... ELSE ... END. Got it in the end. 
       ROUND((SUM(CASE WHEN bats = "L" THEN 1 ELSE 0 END)/COUNT(teamID))*100) AS bat_L,
       ROUND((SUM(CASE WHEN bats = "B" THEN 1 ELSE 0 END)/COUNT(teamID))*100) AS bat_Both
FROM bat_RL
GROUP BY teamID;



-- 4. How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?

SELECT  (FLOOR(YEAR(debut)/10))*10 as debut_year,AVG(weight), AVG(height)
FROM players
GROUP BY debut_year  
ORDER BY debut_year;

WITH avg_W_H AS (SELECT  (FLOOR(YEAR(debut)/10))*10 as decade, AVG(weight) AS avg_W, AVG(height) AS avg_H
				 FROM players
				 GROUP BY decade  
				 ORDER BY decade),

	priors AS (SELECT * ,
					  LAG(avg_W) OVER(ORDER BY decade) AS prior_W,
					  LAG(avg_H) OVER(ORDER BY decade) AS prior_H
				FROM avg_W_H
                WHERE decade IS NOT NULL)
                
SELECT decade , (avg_W - prior_W) AS decade_diff_W, (avg_H - prior_H) AS decade_diff_H
FROM priors;              

-- Interesting to see the drop on avg weight from 1900s to 1910s. WW2 + Depression? AVG difference increased in weight since 90s is striking. 
