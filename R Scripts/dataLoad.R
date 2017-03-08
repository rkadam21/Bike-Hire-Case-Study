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

#####Read from a Zip File#####
# This is a sister function that is called in the Extract Data Field for reading zip file.

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

#####Clean Data Function#####
cleanData <- function(dataset){
    datasetC<<- dataset[!is.na(dataset$EndStation.Id),];
}
#####End of Clean Data Function#####