plot2 <- function() {
        
        ## If then statement tests for course project resource files in working
        ## directory. If resource file does not exist, it is downloaded, and 
        ## unzipped in working directory.
        
        if (!file.exists("household_power_consumption.txt")) {
                
                fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                
                download.file(fileUrl, "household_power_consumption.zip")
                
                unzip("household_power_consumption.zip")
                
        }
        
        ## Resource file read into R as variable 'dat'.
        
        dat <- read.table("household_power_consumption.txt", 
                          header = TRUE, 
                          sep = ";", 
                          na.strings = "?", 
                          colClasses = c("character", "character", 
                                         rep("numeric", 5)))
        
        ## Subset 'dat' on dates specified in course project as variable
        ## 'plotData'.
        
        plotData <- dat[dat$Date == "1/2/2007" | dat$Date == "2/2/2007", ]
        
        ## Create a time and date vector variable as 'plotDate'
        
        plotDate <- (paste(plotData$Date, plotData$Time, sep = " "))
        
        ## Load 'lubridate' library.
        
        library(lubridate)
        
        ## Create .PNG file.
        
        png("plot2.png", width = 480, height = 480)

        ## Print the following plot to the PNG file.
        
        print({
        
                plot(dmy_hms(plotDate), # Plot by date on the X
                     plotData$Global_active_power, # Plot this value on the Y
                     ylab='Global Active Power (kilowatts)', # Label Y
                     xlab = "", # Label X
                     type = "l") # Set plot to line type

        })

        ## Close graphics device control.
        
        dev.off()

}