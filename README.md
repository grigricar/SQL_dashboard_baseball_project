<h1>SQL Foundational Major League Baseball Project</h1>



<p align="center">
  <br/>
<img src="" height="60%" width="60%"/>
<br />
</p>

<h2>Project Description</h2>
<p>
This initially began as a crossover exercise, where one of my stats courses used SPSS as the main main statistical programme. I slowly adapted many of the techniques and workflows and learnt how to apply them in python. Although occasionally a hit and miss, LLM use helped enormously to speed up my learning curve here. Eventually, I was able to adapt a full part of an assignment given by the Open University and build on and add to the statistical methods taught to Python. 

The idea grew and scale as various options offered by the Python libraries became to tempting not to full explore, and, indeed, speed up some of the statistical work with easily attained diagnostic plots and my personal best find in the "pmdarima" library, which offered a more robust statistical method for developing ARIMA models compared to theorising the best models by finding multiple patterns in ACFs and PACFs. Needless to say so of the traditional methods were employed, which took some work in overlaying graphs. Huge learning experience, and there is still so much to explore in the realm of timeseries modeling. 
</p>

<h2>Languages and Utilities Used</h2>

- <b>Python</b> 
- <b>Jupyter Notebooks (Python kernels)</b>
- <b>Adapted to VScode IDE, using uv to setup the project environment</b>
- <b>Libraries used: pandas, numpy, matplotlib, statsmodels, pmdarima</b>
- <b>GitHub </b>
- <b>Basic HTML </b>

<h2> Skills </h2>

- <b>Python</b> 
- <b>Time Series, modeling choices</b>
- <b>Statistical reasoning</b>
- <b>Data Transformation</b>
- <b>Data Visualization</b> 
- <b>Data communication and contextualisation</b>


<h2>Key Findings and Analysis</h2>

<p> Laid out in the Jupyter Notebook.


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
