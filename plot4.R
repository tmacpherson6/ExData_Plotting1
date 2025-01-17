## Plot 2 - Global Active Power vs time.

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

# Open Graphic Device
png(filename="plot4.png",width=480,height=480,units="px")

# Create proper layout
par(mfrow=c(2,2))

# Create line graph Global Active Power
with(data,plot(datetime,global_active_power,
     type="l",xlab=" ",ylab="Global Active Power",xaxt="n"))
x<-ymd_hms("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-02 23:59:00")
x<-as.numeric(x)
axis(1,at=x,labels=c("Thu","Fri","Sat"))

# Create line graph for Voltage
with(data,plot(datetime,voltage,
               type="l",xlab="datetime",ylab="Voltage",xaxt="n"))
x<-ymd_hms("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-02 23:59:00")
x<-as.numeric(x)
axis(1,at=x,labels=c("Thu","Fri","Sat"))

# Create line graph of sub_metering
with(data,plot(datetime,sub_metering_1,
               type="l",xlab="",ylab="Energy sub metering",xaxt="n"))
x<-ymd_hms("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-02 23:59:00")
x<-as.numeric(x)
axis(1,at=x,labels=c("Thu","Fri","Sat"))
lines(data$datetime,data$sub_metering_2,col="red")
lines(data$datetime,data$sub_metering_3,col="blue")
legend("topright",lwd=c(2,2),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Create line graph of Global Reactive Power
with(data,plot(datetime,global_reactive_power,
               type="l",xlab="datetime",ylab="Global_reactive_power",xaxt="n"))
x<-ymd_hms("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-02 23:59:00")
x<-as.numeric(x)
axis(1,at=x,labels=c("Thu","Fri","Sat"))
# Close Graphic Device
dev.off()