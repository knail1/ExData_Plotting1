FetchAndUnzipData <- function() {
  # this pulls the data from the website, unzips it, and loads it into R
  # should be run prior to plotting any graphs.
  
  fetchAndUnzipData <- function(dataLocationURL) {
    if (!file.exists("exdata-data-household_power_consumption.zip")) {
      print("downloading exdata-data-household_power_consumption.zip ... ")
      download.file(url = dataLocationURL,"exdata-data-household_power_consumption.zip","curl")
    } else {
      print("exdata-data-household_power_consumption.zip already exists, skipping download")
    }
    
    if (!file.exists("household_power_consumption.txt")) {
      print("unzipping the data file")
      unzip(zipfile = "exdata-data-household_power_consumption.zip", overwrite = FALSE)
    } else {
      print("file household_power_consumption.txt already exists, skipping the uzipping..")
    }
    
    # first we fetch and unzip the data 
    projectDataLocation <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    fetchAndUnzipData(projectDataLocation)
    
    
  }
  
  