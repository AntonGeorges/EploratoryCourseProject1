fname <- "household_power_consumption.txt"

# Read Data
data <- read.delim(fname, header = TRUE, sep = ";", na.strings ="?")
library(dplyr)

# Filter data to 2 dates of interest 2007-02-01 & 2007-02-02
data <- data %>% mutate(Date=as.Date(Date,"%d/%m/%Y")) %>% 
   filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) %>% 
   mutate(DateTime=strptime(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")) 

png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))

# Plot 1: Global Active Power Vs DateTime
with(data, plot(DateTime, Global_active_power, 
                ylab="Global Active Power (kilowatts)", 
                xlab="",
                type="l"))

# Plot 2: Voltage vs DateTime
with(data, plot(DateTime, Voltage, xlab="datetime", type="l"))

# Plot 3: Series of Submetering plots Vs DateTime
with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)

# Plot 4: Global Reactive Power Vs DateTime
with(data, plot(DateTime, Global_reactive_power, xlab="datetime", type="l"))

dev.off()
