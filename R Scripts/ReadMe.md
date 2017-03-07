# Using the R Scripts
## _[dataLoad.R](https://github.com/rkadam21/Bike-Hire-Case-Study/blob/master/R%20Scripts/dataLoad.R)_
This script helps load data from multiple csv formatted files or csv formatted files packaged as a zip file into a single dataframe.

To use this script please follow the below steps

1. Source the R script with **source(dataLoad.R)** or the relative path to the script from the working directory.
2. Execute the **extractData(fileList)** function to load the data in the Global environment.
  * The **fileList** above can be a text file with the list of the files either as URLs to a webiste or relative paths to the location of the data files.
  * From the repo, you can use _file_list_small.txt_ from the **Data** folder as the **fileList** as it downloads a small subset of cycling data from the TFL website.
3. The script has a **read.zip()** function that is internally called to extract csv files from a zip file. This function can be called on it's own as well.
