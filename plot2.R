## Plot 2 - Global Active Power vs time.

# Open Graphic Device
PNG(filename="plot2.png",width=480,height=480,units="px")

# Create line graph
with(data,plot(datetime,global_active_power,
     type="l",xlab=" ",ylab="Global Active Power (kilowatts)",xaxt="n"))
x<-ymd_hms("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-02 23:59:00")
x<-as.numeric(x)
axis(1,at=x,labels=c("Thu","Fri","Sat"))

# Close Graphic Device
dev.off()