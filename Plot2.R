#installing required libraries
library(dplyr)
library(lubridate)

# file path for accessing data
filePath <- "./household_power_consumption.txt"

# downloading data if it does not already exists
if (!file.exists(filePath)){
  zipLink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipPath <- "PowerConsumption.zip"
  download.file(zipLink,zipPath)
  
  unzip(zipPath)
  rm(zipLink,zipPath)
}

# reading data using read.csv, the ? is replaced with NA 
data <- read.csv(filePath,sep=";",na.strings = "?")

# joining date and time and converting into posix time
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateTime <- strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S")

# defining the range where analysis is to be made
startDate <- as.Date("01/02/2007",format="%d/%m/%Y")
endDate <- as.Date("02/02/2007",format="%d/%m/%Y")

# creating Subset for the data that falls within the analysis range
finalData <- subset(data,Date>= startDate & Date <= endDate)
# rm(data)

#filename for png
pngPath = "plot2.png"

#creating device for png
png(pngPath)

# drawing the plot to png
with(finalData,plot(DateTime, Global_active_power,type="l",
                    xlab = "", ylab="Global Active Power (kilowatts)", xaxt="n"))
atPoints <- as.POSIXct(c("01/02/2007","02/02/2007","03/02/2007"),format="%d/%m/%Y")
axis(1, at=atPoints, labels = c("Thu","Fri","Sat"))

# closing the device connection
dev.off()

