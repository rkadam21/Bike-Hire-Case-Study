# Using the R Scripts
## [dataLoad.R](https://github.com/rkadam21/Bike-Hire-Case-Study/blob/master/R%20Scripts/dataLoad.R)
This script helps load data from multiple csv formatted files or csv formatted files packaged as a zip file into a single dataframe. This script can be sourced with source command. _source("dataLoad.R")_. Brief explanation for each function in the script has been provided below.
### extractData(file)
This function helps load data from multiple csv formatted files or csv formatted files packaged as a zip file into a single dataframe.  
* The location of the csv files should be passed to the function as a list in a _.txt_ file.  _Example: extractData(filelist.txt)_
* From the repo, you can use *file_list_small.txt* from the _Data_ folder as the _fileList_ as it downloads a small subset of cycling data from the TFL website.
* csv files packaged as zip files are also read through this function. As long as the file name in the _filelist_ is suffixed by the file type _.zip_ or _.csv_ the function will automatically read the file. The _extractData()_ function internally calls the _read.zip()_ function to extract the data from the file.  

### read.zip(file.zip)
This function is internally called in the _extractData()_ function to extract csv files from a zip file. This function can be called on it's own as well.
  * The name of the zip file that includes is relative path needs to be provided to this function.
  * This function can be directly executed after loading the R Script.  
   _Example: read.zip(file.zip)_
  * This function in it's operational state is designed to pass data to its parent function. This can be easily modified to output the data as a dataframe to the parent environment or to the console.

### cleanData(dataframe)
This function is called on the dataset output provided by the _extractData()_ function. This function cleans and transforms the bike rental data. The output dataset from this function has features such borough information for both Start and End stations of a rental, mapping coordinates for both Start and End stations of a rental and redistribution indicator where a bicycle redistribution is suspected.
* The function removes any records with missing End Stations as these records are not useful for any analysis. These records constitute for a small portion of the data.
* The function uses a Borough and Coordinate data file (_Docking station Boroughs and Coords.csv_) from the _Data_ folder to add relevant Borough and Coordinate data for both Start and End stations of a rental.
* It also calculates and assigns a _Redistribution Indicator_ to each record to identify bikes that might have been redistributed. The records are ordered by Bike Id, Start Date of the rental hence an NA is populated in the indicator for the first occurrence of a Bike Id in the data.
* The function outputs the final dataset to the parent environment (Global) as a dataframe named _datasetS_.
