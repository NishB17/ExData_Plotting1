#installing required libraries
library(dplyr)

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
data$DateTime <- strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")

# defining the range where analysis is to be made
startDate <- strptime("01/02/2007 00:00:00",format="%d/%m/%Y  %H:%M:%S")
endDate <- strptime("02/02/2007 23:59:59",format="%d/%m/%Y  %H:%M:%S")

# creating Subset for the data that falls within the analysis range
finalData <- subset(data,DateTime >= startDate & DateTime <= endDate)
rm(data)

#filename for png
pngPath = "plot1.png"

#creating device for png
png(pngPath)

# drawing the plot to png
with(finalData,hist(Global_active_power,main="Global Active Power",col="red",
                    xlab="Global Active Power (kilowatts)"))


# closing the device connection
dev.off()


