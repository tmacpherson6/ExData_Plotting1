## Global active power histogram Base Graphics

# Realistically, this simple hist can be called in a single line
# I have broken into a few just for an example 

# Open Graphics Device (PNG File)
png(filename="plot1.png",width=480,height=480,units="px")

# Construct simple histogram
hist(data$global_active_power,col="red")
title(main="Global Active Power",xlab="Global Active Power (kilowatts)")

# Close Graphics Device
dev.off()