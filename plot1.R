fname <- "household_power_consumption.txt"

# Read Data
data <- read.delim(fname, header = TRUE, sep = ";", na.strings ="?")
library(dplyr)

# Filter data to 2 dates of interest 2007-02-01 & 2007-02-02
data <- data %>% mutate(Date=as.Date(Date,"%d/%m/%Y")) %>% 
   filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) %>% 
   mutate(DateTime=strptime(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")) 

png("plot1.png", width=480, height=480)

# Plot Global Active Power frequency distribution
hist(data$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)",  
     main="Global Active Power")

dev.off()
