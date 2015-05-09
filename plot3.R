# Script:     Plot 3 for Exploratory Data Analysis - Project 1
# Created by: Artemis Nika
# Date:       09/05/2015


# set working directory (change working directory to the appropriate one)
setwd("C:/Users/Pavlos-Dell/Desktop/Coursera Courses/Data Science Specialization/04 Exploratory Data Analysis/Project 1")



# Read data into R
rawData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
                      , stringsAsFactors = FALSE, na.strings = "\\?, ")



# check for NA entries
sapply(rawData, function(x){ return(sum(is.na(x)))})

# Variable description
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


# we will only be using data from the dates 2007-02-01 and 2007-02-02
# filter dataset
sum(rawData$Date == "1/2/2007") # check how many raws we have for each day
sum(rawData$Date == "2/2/2007")
dataToUse <- subset(rawData, Date == '1/2/2007' | Date == '2/2/2007')


# convert date and time
dataToUse$DateTime <- paste(dataToUse$Date, dataToUse$Time) # concatenate date and time into one column
head(dataToUse$DateTime) # check that the new column looks OK
dataToUse$DateTime <- strptime(dataToUse$DateTime, tz = "UTC", format = "%d/%m/%Y %H:%M:%S") # convert to date/time
head(dataToUse$DateTime) # check again

# convert character to numeric for appropriate columns
dataToUse[, 3:9] <- sapply(dataToUse[, 3:9], function(x){as.numeric(x)})

# check for NA entries
sapply(dataToUse, function(x){ return(sum(is.na(x)))}) # => no NAs


# plot 3
# Energy sub meterings versus date/time
png(filename = "plot3.png")
plot(x = dataToUse$DateTime, y = dataToUse$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = dataToUse$DateTime, y = dataToUse$Sub_metering_2, col = "red")
lines(x = dataToUse$DateTime, y = dataToUse$Sub_metering_3, col = "blue" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()







