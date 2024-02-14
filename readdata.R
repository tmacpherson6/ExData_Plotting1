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
outDir<-"./data/UnzipedData"
unzip(zipF,exdir=outDir)

# Load Libraries
library(dplyr)
library(lubridate)

# Read data into R
data<-read.table("./data/UnzipedData/household_power_consumption.txt",sep=";",skip=1,na.strings="?")
head(data)
dim(data)
str(data)

# Name columns for understanding
colnames(data)<-c("date","time","global_active_power",
                  "global_reactive_power","voltage",
                  "global_intensity","sub_metering_1",
                  "sub_metering_2","sub_metering_3")

# Convert date classes in R for easy sub-setting
data$date<-as.Date(data$date,"%d/%m/%Y")
  
# Subset Data on 2007-02-01 and 2007-02-02
data<-filter(data,date == "2007-02-01" | date == "2007-02-02")

# Combine date/time and convert classes in R using lubridate
data<-mutate(data,datetime=paste(date,time))

data$datetime<-ymd_hms(data$datetime)

#Organize the data and only get what we need
data<-select(data,datetime,
             global_active_power,global_reactive_power,
             voltage,global_intensity,sub_metering_1,
             sub_metering_2,sub_metering_3)

# We now have a manageable subset of data showing proper date and time format