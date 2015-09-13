## Load the sqldf package necessary to only read in the required part of the data
install.packages("sqldf")
library(sqldf)

## Read in data from February 1, 2007 & Febraury 2, 2007 only
data <- read.csv.sql("./household_power_consumption.txt", sql = "select * from file where Date in('1/2/2007','2/2/2007')", sep = ";")
closeAllConnections()

## Combine the Date and Time columns into one, convert this into date/time classes, combine this column with the rest of the data
Date_Time <- paste(data$Date, data$Time, sep = " ")
household_data <- cbind(Date_Time, data[ ,3:9])
household_data$Date_Time <- strptime(household_data$Date_Time, "%d/%m/%Y %H:%M:%S")

## Set to plot to a png file
png("plot1.png")

## Plot the Global_active_power with appropriate colour, titles
hist(household_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Closes the png file device
dev.off()
