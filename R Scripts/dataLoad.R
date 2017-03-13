## This is a R-code to extract data from either a file directory or from a website
## is a CSV formatted data and outputs a dataset to the Global Environment as a dataframe.
## Date:- 03/05/2017
## Rahul Kadam

#####Extract Data Function#####

extractData <- function (filelist) {
    fileList <- read.table(filelist, header=F, sep='\t');
    fileListVec <- as.vector(fileList$V1);
  
    dataset <<- do.call("rbind",lapply(fileListVec, function(files){
                                            ext<- substring(files,nchar(files)-2,nchar(files))
                                            if (ext=="csv")
                                            {read.csv(files, header=T)}
                                            else if(ext=="zip")
                                             {read.zip(files)}
                                        }
                                    )
                     );

}
#####End of Extract Data Function#####


#####Clean Data Function#####

cleanData <- function(dataset){
    dataset <- head(dataset,100);
    datasetC<- dataset[!is.na(dataset$EndStation.Id),];
    
    datasetC$Start.Date <- strptime(x=as.character(datasetC$Start.Date), format = "%d/%m/%Y %H:%M");
    datasetC$End.Date <- strptime(x=as.character(datasetC$End.Date), format = "%d/%m/%Y %H:%M");
    
    dBorCordStrt <<- read.csv("../Data/Docking station Boroughs and Coords.csv", colClasses= c(NA,NA,"NULL","NULL",NA,NA)
                                  ,header=T, col.names=c('Start.Site','Start.Borough','Start.Easting','Start.Northing','Start.Latitude','Start.Longitude')); # load Borough and Coordinate data to be added to the final dataset
    dBorCordEnd <<- read.csv("../Data/Docking station Boroughs and Coords.csv", colClasses= c(NA,NA,"NULL","NULL",NA,NA)
                                  ,header=T, col.names=c('End.Site','End.Borough','End.Easting','End.Northing','End.Latitude','End.Longitude')); # load Borough and Coordinate data to be added to the final dataset
    
    Start.Site <- sapply(datasetC$StartStation.Name, FUN=function(vec){trim(substring(vec, 1, regexpr(',',vec)[1]-1))});
    End.Site <- sapply(datasetC$EndStation.Name, FUN=function(vec){trim(substring(vec, 1, regexpr(',',vec)[1]-1))});
    
    datasetC <- cbind(datasetC,Start.Site);
    datasetC <- cbind(datasetC,End.Site);
    
    datasetBC <- merge(datasetC,dBorCordStrt, by.x="Start.Site",by.y="Start.Site", all.x=TRUE);
    datasetBC <- merge(datasetBC,dBorCordEnd, by.x = "End.Site",by.y="End.Site", all.x=TRUE);
    datasetS <<- datasetBC[order(datasetBC$Bike.Id,datasetBC$Start.Date),]; # sorts the data by BikeId,StartDate to aid in matching Start and End destinations
    
}
#####End of Clean Data Function#####

#####Read from a Zip File#####
# This is a sister function that is called in the Extract Data Function for reading zip file.

read.zip <- function(files){
  zipdir <-tempfile()
  dir.create(zipdir)
  unzip(files, exdir=zipdir)
  filez<-list.files(zipdir)
  do.call("rbind",lapply(paste(zipdir,filez,sep="/"), function (files){
    read.csv(files, header=T)
                             }
                        )
    );
  
}
#####End of Read Zip function#####

#####Trim Function#####

trim <- function(vec) {
  gsub("^\\s+|\\s+$", "", vec);
}
#####End of Trim Function####
