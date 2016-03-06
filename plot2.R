plot2 <- function() {
  par(mfrow = c(1,1))
  with(powerConsumptionData, plot(powerConsumptionData$dt, powerConsumptionData$Global_active_power, type = "l", main = "", xlab = "", ylab = "Global Active Power (kilowatts)"))
  dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
  dev.off()
  
}