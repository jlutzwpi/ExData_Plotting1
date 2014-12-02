## Project 1 for Exploratory Data Analysis

# read from large data file, will subset here instead of reading in entire data
# data of interest is from 01/02/2007 to 02/02/2007
# first row of interest is 66637
# last row of interest is 69516
#column names
cols <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data.file <- "./household_power_consumption.txt"
data <- read.csv(data.file, sep=";", skip=66636, nrows=2880, 
                 na.strings="?", col.names=cols)

#convert data and time factors to date and time objects
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, "%H:%M:%S")
#remove default date from the time column
data$Time <- format(data$Time, "%H:%M:%S")

#Plot 3: date vs Energy sub metering (there are 3 of them)
png("./plot3.png")
plot(data$Sub_metering_1, type="l", lty="solid", main="",
     xlab="",ylab="Energy sub metering", col="black", xaxt='n',yaxt='n')
points(data$Sub_metering_2, type="l", lty="solid", col="red")
points(data$Sub_metering_3, type="l", lty="solid", col="blue")
#create a legend
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright",  lty=c(1,1,1), col=c("black", "red","blue"), leg.txt)
#get the number of rows
len <- nrow(data)
#set the x axis to display the days at the start, midpoint, and end
axis(1, at=c(0, len/2, len), labels=c("Thu", "Fri", "Sat"))
#set y axis
axis(2, at=c(0,10,20,30), labels=TRUE)
dev.off()