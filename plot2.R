## Plot 2 - Global Active Power vs time.

with(data,plot(datetime,global_active_power,
     type="l",xlab=" ",ylab="Global Active Power (kilowatts)",xaxt="n"))
axis(1,at=c(-4,1,0),
     labels=c("Thu","Fri","Sat"))