# Using the R Scripts
## _[dataLoad.R](https://github.com/rkadam21/Bike-Hire-Case-Study/blob/master/R%20Scripts/dataLoad.R)_
This script helps load data from csv formatted files or csv formatted files packaged as a zip file.

To use this script please follow the below steps

1. Source the R script with **source(dataLoad.R)** or the relative path to the script from the working directory.
2. Execute the **extractData(fileList)** function to load the data in the Global environment.
  * The fileList above can be a text file with the list of the files either as URLs to a webiste or relative paths to the location.
  * In the repo, you can use the _file_list_small.txt_ in the Data folder as it downloads only a small subset of data.
3. The script has **read.zip()** function as well that is internally called to extract csv files from a zip file. 
