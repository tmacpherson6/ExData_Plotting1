## The purpose of this R script is to obtain and 
  #subset the data in a replicable fashion.

# Create the working directory

if(!file.exists("./data")){dir.create("./data")}

# Download Data set to work with
# Note: This is a very large data set, make sure your computer can handle it

fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="./data/Dataset.zip",method="curl")
dateDownloaded<-date()

# Unzip the downloaded files
zipF<-"./data/Dataset.zip"
outDir<-",/data/UnzipedData"
unzip(zipF,exdir=outDir)

# Load Libraries
library(dplyr)

# Read data into R
data<-read.csv("./data/UnzipedData/")
head(data)
str(data)

# Subset Data on 2007-02-01 and 2007-02-02
data<-select(data,date=="2007-02-01" & date =="2007-02-01")
head(data)
str(data)