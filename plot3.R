fname <- "household_power_consumption.txt"

# Read Data
data <- read.delim(fname, header = TRUE, sep = ";", na.strings ="?")
library(dplyr)

# Filter data to 2 dates of interest 2007-02-01 & 2007-02-02
data <- data %>% mutate(Date=as.Date(Date,"%d/%m/%Y")) %>% 
   filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) %>% 
   mutate(DateTime=strptime(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")) 

png("plot3.png", width=480, height=480)
# Plot a series of 3 overlapping Submetering Vs DateTime plots
with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)

dev.off()
