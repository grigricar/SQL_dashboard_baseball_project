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

So the origin point of this project was, indeed, the final course project of the course. I completed every section without AI or regular glimpse-at-solution assistance. Comparing my answers I had arrived at the correct solutions, but often through different means. SQL is more of a flexible language than I originally expected. 

I then extended this initial foundation into a full-blown dashboard project. Before I knew it I had to go back to SQL to develop some of my own queries in answer to some of my new questions. I used Google’s Datastudio (formally “Looker”) as an easy introduction to dashboarding. Switching back and forth between mySQL and Datastudio, I learnt much about the important of the initial stage of data structuring, cleaning and organising  and how essential this is to unlocking insights from a large dataset and then communicating findings. 

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
<p>Numerous challenges were overcome. The first one being the transformation of the datafiles which were adapted for .sav. Using pandas to adjust the format into the required for the pandas data frame format was not always straight forward. For one dataset LLM prompting had to be manipulated twice to achieve suitable Regex code when basic string manipulation was no sufficient. This was all done in a separate python file, and the new cleaned files saved to be read into the main file. 

The second crucial learning curve, was adjusting to the indexing and frequency process required for times series. This part of the workflow was essential, and was often overlooked in the easily accessed formatted uni files. I found thinking about the frequency to be helpful in better understanding the data sets, in terms of scale and detail required and seasonality patterns this is where decisions concerning timeseries modelling begin. 

I was already familiar with the statistical concepts involved but there were quirks and intricacies learnt about how to best apply the techniques with the python libraries. For instance, in the case of applying and comparing the effect of differencing to achieve stationarity in the wheat data set using the .diff() method, I assumed wrongly that specifying a number would increase the number of times a sequence is differences. This, in fact, just shifted the indexing of which two numbers were differenced. To attain an order of 2 differencing the differenced series had to be differenced again using: .diff().diff()  . I was also familiar with many of the summary outputs and measures but had to adjust to how they were expressed: eg error variance is sigma2. Overall the information provided for the models was more in depth than SPSS and it was helpful to find ACI values for the model in addition to other useful model measures and indicators. Most pleasing were the many methods available to directly extract model outputs and specific measures: e.g .fittedvalues or .plot_diagnostics() or .resid(). These options to my mind are what give using python for analysis much more flexibility and control than a poin-and-click programme like SPSS. 

Such flexibility in approach also mean I had far more options in the control over the plotting and visualization of the analysis. Understanding how layers like fig, ax can be applied to control almost every aspect of complex plots was the most challenging concept to grasp. However, when the intricacies of labeling, axis placement, colour and font can be manipulated, it was easy to see how you can be carried away by the aesthetics. Plotting confidence intervals and choosing a colour to match the predication line was as artful as I got here. Almost any plot imaginable could be created. 


</p>

</br>

-  <b>The next obvious step is to add interactivity to some of the plots, for instance a user defined time-scale </b>
-  <b>I used many foundational checks but there must be more efficient methods to create a PACF</b>
-  <b>I would like to explore splitting the data set to use part of it for testing and model validation.   </b>
- <b> Exploring the effect of removing influential points and comparing the models, is a natural extension  </b>
- <b> I need to begin expanding my knowledge to different times series with varying frequencies, seasonal requirements, multiplicative and mixed models </b> 

  

<!--
 ```diff
- text in red
+ text in green
