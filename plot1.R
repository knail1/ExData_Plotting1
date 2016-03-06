plot1 <- function() {
  par(mfrow = c(1,1))
  with(powerConsumptionData, hist(powerConsumptionData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = c("red")))
  dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
  dev.off()
  } 