## Global active power histogram with Base Graphics

# Open Graphics Device (PNG File)
png(filename="plot1.png",width=480,height=480,units="px")

# Construct simple histogram
hist(data$global_active_power,col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")


# Close Graphics Device
dev.off()