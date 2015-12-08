plot3 <- function() {

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
        
        ##  Load 'lubridate' library.
        
        library(lubridate)
        
        ## Create .PNG file.
        
        png("plot3.png", width = 480, height = 480)

        ## Print the following plot to the PNG file.
        
        print({

                ## Plot sub metering 1 on black line
                
                plot(dmy_hms(plotDate), # Plot by date on the X
                     plotData$Sub_metering_1, # Plot sub metering 1 on Y 
                     ylab="Energy sub metering", # Label X for entire plot
                     xlab = "", # Label Y for entire plot
                     type = "l", # Define plot type as line.
                     col = "black") # Set line color
                
                ## Add second line to plot sub meter 2 on red line.
                
                lines(dmy_hms(plotDate),
                      plotData$Sub_metering_2,
                      ylab ="",
                      xlab = "",
                      type = "l",
                      col = "red")
                
                ## Add third line to plot sub meter 3 on blue line.
                
                lines(dmy_hms(plotDate),
                      plotData$Sub_metering_3,
                      ylab ="",
                      xlab = "",
                      type = "l",
                      col = "blue")
                
                ## Add legend to plot.
                
                legend("topright",
                       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       lty=c(1, 1, 1),
                       col=c("black", "red", "blue")
                       ## bty = "n" Add this line for producing graph #4
                       )
                
        })

        ## Close interaction to PNG graphics device.
        
        dev.off()
        
}
