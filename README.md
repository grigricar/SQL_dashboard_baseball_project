<h1>SQL Foundational Major League Baseball Project</h1>

<a href="https://datastudio.google.com/reporting/3f91010e-93d3-42f2-8d5d-f9aec0d34822">CLICK TO INTERACT WITH THE FULL PROJECT DASHBOARD</a>

<p align="center">
  <br/>
<img src="https://github.com/grigricar/SQL_dashboard_baseball_project/blob/main/images_screenshots/Gemini_Generated_Image_7fjwco7fjwco7fjw.png" height="60%" width="60%"/>
<br />
</p>

<h2>Project Description</h2>
<p>
I had encountered bits of SQL in database theory and some short courses, but I felt I needed a better overview. Moreover, in the age of AI, I knew I needed the foundational logic and structural thinking that working with SQL gives. Alice Zhao’s course, “Advanced SQL Querying Techniques” (through Maven on Udemy), was the perfect foundation for this and the origin point for this project.

The course was fast-paced with plenty of practical problem exposure which is just what I required to fully grasp those sneaky GROUP BY interactions with categorical and numerical observations. CTEs are now my go-to, WINDOW functions are second nature and the logic of aggregation and pivoting are mine. 

So the origin point of this project was, indeed, the final course project of the course. I completed every section without AI or regular glimpse-at-solution assistance. Comparing my answers to solutions I was happy to find I was correct in my querying, but often through different combinations of code. SQL is more of a flexible language than I originally expected. 

I then extended this initial foundation into a full-blown dashboard project. Before I knew it I had to go back to SQL to develop some of my own queries in answer to some of my new questions. I used Google’s Datastudio as an easy introduction to dashboarding. Switching back and forth between mySQL and Datastudio, I learnt much about the important of the initial stage of data structuring, cleaning and organising  and how essential this is to unlocking insights from a large dataset and then communicating findings. 

As usual the project morphed into something bigger than initially expected, where the difficulty lay in placing practical limits on the scope of the project. Next time I will get stuck into a dataset I really care about.    
</p>

<h2>Languages and Utilities Used</h2>

- <b>SQL (MySQL) – Database querying and script development.</b>
- <b>MySQL Workbench – Local database administration and query design.</b>
- <b>Datastudio - Business Intelligence (BI) modeling and interactive dashboard engineering.</b>
- <b>Git & GitHub – Source control, version history management, and portfolio deployment.</b>
- <b>Command line prompting</b>
- <b>Basic HTML </b>

<h2> Skills </h2>

- <b>SQL basics: Big 6 structure, order of execution</b>
- <b>Advanced SQL Querying – Implementing Common Table Expressions (CTEs), Window Functions (DENSE_RANK), and schema-based filtering.</b> 
- <b>Data Transformation & Engineering – Reshaping complex datasets (long-to-wide formatting), execution optimization using Temporary Tables, managing matrix-staggered records, and handling null anomalies.</b>
- <b>Data pipeline integration – Bridging the gap between a relational SQL engine and external BI visual layers.</b>
- <b>Analytical Dashboard Design – Engineering user-centric controls (dynamic metric filtering, sliding timelines, discrete coordinate axes).</b>
- <b>Data Storytelling & Contextualization – Turning fragmented historical sports statistics into structured, chronological narratives with executive headlines.</b> 



<h2>Key Findings and Analysis</h2>
<a href="https://datastudio.google.com/reporting/3f91010e-93d3-42f2-8d5d-f9aec0d34822">PROJECT DASHBOARD CAN BE FOUND HERE</a>
<p> The database composed of four tables, with the ’salaries’ table extending to 24,758 rows, and the ‘players’ table consisting of 24 columns. The data spanned information from 1860 to 2014. There was much data to wrangle with.

Key finding for the project consisted of:

- Finding that in 1860s only two universities produced players; this peaked in 1990 where 493 universities produced players.

- Across the time period I found the top five player producing schools with The University of Austin Texas producing the most with 107 players.

- I found the top 20% of teams who have the highest annual avg. spend on combined team salaries. Oaklands has the highest at $39.5 mil . (This measure heavily biases teams that only began competing later as this raises their average.)

- Considering the cumulative spending of teams over years, I found that the earliest year that cumulative spending went over one billion dollars was 1993, for Oaklands and Kansas City Royals.

- The oldest career length went to “Nicholas” who played for 35 years. (This was probably a very early player, before the Major Leagues)

- One of the most complex queries was finding that only 19 players with a career length > 10 years started and ended on the same team. 

- I found which players share the same birthday (given the numbers there are hundreds for each day of the year)

- I found the percentage of left, right and both side batters for each team. 

- The change in average weight and height for players across the time period. Both increase, but weight increase more particularly from the 1980s. 

</p>

</br>

<h2>Reflection and Questions</h2>

Reflection and questions:

<b>1. SQL QUERYING </b>

SQL is more versatile than I originally expected. As a tool used to draw insights and mange big relational databases it is essential. Through the course of the project I began to reflexively think and code in SQL script, which helped me to attain my goal of absorbing the SQL logic. While querying itself may become a dying art with LLMs, knowledge of the logic is essential. 

Some of the hurdles I had to navigate had more to do with thinking about the data than SQL itself. For example, to GROUP by decade I initially just removed the final digit in the date using ROUND, but then realised that many years in the decade would be incorrectly rounded up. FLOOR was the better move. For the sake of clarity multiplying by 10 afterwards produced a cleaner figure (1970 vs 197) for the decade.

I thought I had mastered GROUP BY, but ran into a few hurdles that are now resolved. It is now clear that the aggregation is calculated over the category/period that you ‘collapse’ when using GROUP BY, particularly when more than one category (ie: ’teamID’ and ‘yearID’.)

I cannot get enough of CTEs and WINDOW functions, and I enjoyed the logic I used to find the first year that a team’s cumulative spending supposed 1 billion dollars. In reflection and comparison to the SOLUTION, I can avoid too many CTEs by using some double-subjoins in future. This can become less clear to follow, however. 

<p align = "center"> 
<img src="https://github.com/grigricar/SQL_dashboard_baseball_project/blob/main/images_screenshots/%231%20reflection_image.png" height="80%"  width="80%"/>
  <br />
  <b>Loving those CTEs</b>
</p>

Many small ‘tricks’ were covered in the course. Including handy functions. One I learnt about in the project was using the TIMESTAMPDIFF() function as apposed to a simple DATEDIFF() to specify the required output type. However, I got around this with a conversion relating that DATEDIFF() would take into account leap years. When using a window function I also became aware that PARTITION BY is not required in cases where the column already contains unique values, but a handy ranking can then be easily produced. 

One of the more complex queries involved finding the team for which a player debut and then ended their career. This involved joint between multiple tables. I ended up joining to of the tables I created in my CTEs to bring all the information together. (I could have avoided one CTE, bu doing a subquery join for start_team and end_team). 
<p align = "center"> 
<img src="https://github.com/grigricar/SQL_dashboard_baseball_project/blob/main/images_screenshots/%232%20refelection_image.png" height="80%" width="80%"/>
</p>

I was also happy with my approach to finding the shared birthdays of all players (the question at hand was actually misleading here it should have read ‘brith date’), but my finding was more interesting: it turns out that with 18589 players, every birthday is shared by multiple players. The most birthdays shared are on 18 of November, where 75 players share a birthday!

 <b>2. DASHBOARD With Datastudio</b> 

Leaving the project at SQL querying alone felt incomplete. So in an attempt to visualise some of the findings I looked for a quick and easy way of setting up an accessible dashboard. I took the chance to investigate how well this can be done in Datastudio, mainly because I did not need a platform to help me aggregate and explore the data. Having played with Tableau before, I may have made the wrong choice. In terms of storytelling and presentation Tableau has far more advantages. 

In the end I was able to layer in some interactivity into the findings, but Datastudio is laggy, and some of the changes I required to the charts, like setting a specific interactive dropdown to work on only one visual, were not very intuitive and often required strange workarounds. Nevertheless, the objective of connecting to findings was achieved. I did find myself being pulled back to SQL, frequently, to respond to new questions and to tweak outputs. My biggest extensions to the original project include finding the average yearly spend per team, as well as the top 3 highest paid players for every decade.
<p align = "center"> 
<img src="https://github.com/grigricar/SQL_dashboard_baseball_project/blob/main/images_screenshots/%233%20dashboard.png" height="80%" width="80%"/>
</p>

In many cases, I went back to SQL to handle conversions (from weight in pounds to kg; and from inches to meters) or, in the case of the piechart, to transpose the data into long format.

I also began to pick up issues/irregularities with the data that were not important to the original basic project. The data goes up to 2014 but for some two teams only one players data was captured in that year (the highest paid) completed skewing that team’s average total pay.  I deleted the rows for those entries (more data gathering could have filled in the gaps; or imputation could have been explored based on the previous year’s averages). Many teams had missing data for certain years and 2014 proved to be problematic for more than one team and should perhaps have been removed. The result is that gaps can be seen in the line graph for certain teams for their average salary pay in certain years.

The intricacy and importance of detail, and the options that arose when there were gaps, exposed for me the critical decision making required when engineering the data from source. 

</p>

</br>

-  <b>Next time around I want to explore the greater freedom of a platform like Tableau or go into a fully coded dashboard using Streamlit.</b>
-  <b>The nature of the project was a bit scattered. Next time I want to approach a dashboard with more of a focused objective to create a narrative around big insights. </b>
-  <b>Aesthetics and colour code were woefully wanting in this project, but this was not the focus here.</b>
- <b> I want to apply SQL to bigger datasets in other and more diverse interests to me. So much can be discovered and answered with just a bit of exploration</b>
- <b> How would I begin to approach a ‘moving’, dynamic dashboard display, where the data updates on a daily or hourly basis? </b> 


  

<!--
 ```diff
- text in red
+ text in green
