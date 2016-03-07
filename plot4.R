plot4 <- function() {
  
  # #1 first, download, unzip, 
  source("FetchAndUnzipData.R")
  FetchAndUnzipData()
  
  
  ########
  
  # #2  load data into powerConsumptionData data.frame
  
  # here we load the data, casting the data appropriately. For now, i'm casting the time as "character", as
  # I only need to sort by date ..
  powerConsumptionData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), colClasses = c("character", "character", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" ))
  
  #update date field to class type Date.
  powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, "%d/%m/%Y")
  
  
  # need to filter: 2007-02-01 and 2007-02-02
  powerConsumptionDataSubset <- powerConsumptionData[powerConsumptionData$Date %in% as.Date(c('2007-02-01', '2007-02-02')), ]
  
  
  # need to format the time column as well:
  powerConsumptionDataSubset$Time <- strptime(powerConsumptionDataSubset$Time, format = "%H:%M:%S")
  # remove references to the date, only let the time remain:
  # i.e. go from "2016-03-06 00:00:00 CST"  ----> "00:00:00"
  powerConsumptionDataSubset$Time <- sub(".* ", "", powerConsumptionDataSubset$Time)
  
  # create a new column with accurate date/time of recording as the correct POSIXlt class type:
  powerConsumptionDataSubset$dt <- as.POSIXlt(paste(powerConsumptionDataSubset$Date, powerConsumptionDataSubset$Time), format = "%Y-%m-%d %H:%M:%S")
  
  ########
  
  # 3 , create the plot
  
  
  # dev.copy (from screen to png)  was truncating the legend in upper right, so i saved it straight into png.
  png("plot4.png", width = 480, height = 480, type = "quartz")
  par(mfrow = c(2,2))
  
  #graph1
  with(powerConsumptionDataSubset, plot(powerConsumptionDataSubset$dt, powerConsumptionDataSubset$Global_active_power, main = "", xlab = "", ylab = "Global Active Power",type = "l"))
  
  #graph2
  with(powerConsumptionDataSubset, plot(powerConsumptionDataSubset$dt, powerConsumptionDataSubset$Voltage, main = "", xlab = "datetime", ylab = "Voltage",type = "l"))
  
  #graph3
  with(powerConsumptionDataSubset, plot(powerConsumptionDataSubset$dt, powerConsumptionDataSubset$Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering",type = "l"))
  lines(powerConsumptionDataSubset$dt, powerConsumptionDataSubset$Sub_metering_2, type = "l", col = "red")
  lines(powerConsumptionDataSubset$dt, powerConsumptionDataSubset$Sub_metering_3, type = "l", col = "blue")
  legend("topright", pch = "-", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  #graph4
  with(powerConsumptionDataSubset, plot(powerConsumptionDataSubset$dt, powerConsumptionDataSubset$Global_reactive_power, main = "", xlab = "datetime", ylab = "Global_reactive_power",type = "l"))

  dev.off()

  }