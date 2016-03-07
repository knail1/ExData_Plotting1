plot1 <- function() {
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
  par(mfrow = c(1,1))
  with(powerConsumptionDataSubset, hist(powerConsumptionDataSubset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = c("red")))
  dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
  dev.off()
  } 