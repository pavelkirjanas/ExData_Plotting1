### Reading in and modifying the data ###

#Reading in only the rows corresponding to the dates from 1/2/2007 to 2/2/2007
library(data.table)
data <- fread("sed '1p;/^[12]\\/2\\/2007/!d' household_power_consumption.txt",
              na.strings = c("?", ""))

#Adding a new column with date and time pasted together
library(dplyr)
data <- mutate(data, Full.Date=paste(Date, Time))

#Converting 'Full.Date' column to a date class
library(lubridate)
data$Full.Date <- dmy_hms(data$Full.Date)

### Creating a plot ###

#Opening a PNG device
png(filename = "plot1.png",
    width = 480, height = 480)

#Creating a histogram with appropriate parameters
with(data, hist(Global_active_power, 
                main="Global Active Power",
                xlab="Global Active Power (kilowatts)",
                col="red"))

#Closing the device
dev.off()