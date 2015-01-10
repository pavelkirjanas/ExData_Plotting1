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
png(filename = "plot4.png",
    width = 480, height = 480)

#Creating plots with appropriate parameters
#
par(mfrow = c(2, 2))
#
#plot number 1
with(data, plot(Global_active_power ~ Full.Date,
                ylab="Global Active Power",
                xlab="",
                type="l"))
#
#plot number 2
with(data, plot(Voltage ~ Full.Date,
                ylab="Voltage",
                xlab="datetime",
                type="l"))
#
#plot number 3
with(data, {
        plot(Sub_metering_1 ~ Full.Date,
             ylab="Energy sub metering",
             xlab="",
             type="l")
        lines(Sub_metering_2 ~ Full.Date, col="red")     
        lines(Sub_metering_3 ~ Full.Date, col="blue")
})
legend("topright", pch="", lwd=1, 
       col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
#
#plot number 4
with(data, plot(Global_reactive_power ~ Full.Date,
                ylab="Global_reactive_power",
                xlab="datetime",
                type="l"))

#Closing the device
dev.off()