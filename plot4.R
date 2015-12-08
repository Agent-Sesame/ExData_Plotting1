plot4 <- function() {

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
        
        ## Load 'lubridate' resource
        
        library(lubridate)
        
        ## Create .PNG file.
        
        png("plot4.png", width = 480, height = 480)
        
        ## Print the following plots to the PNG file.
        
        print({
                
                ## Create 2 by 2 plot gride
                
                par(mfrow=c(2,2))

                # Upper left plot - copy of plot2() with minor changes 
                plot(dmy_hms(plotDate), 
                     plotData$Global_active_power, 
                     ylab="Global Active Power",
                     xlab = "",
                     type = "l")
                
                # Upper right plot - new plot
                plot(dmy_hms(plotDate), # Plot this on X
                     plotData$Voltage, # Plot on Y
                     ylab= "Voltage", # Label Y
                     xlab = "datetime", # Label X
                     type = "l", # Define plot as line type
                     yaxt = "n") # Remove default Y axis increments
                axis(side = 2, # Set custom Y axis increment
                     at = seq(230, 250, by = 2), # Set min & max range
                     labels=c("", "", "234", "", "238", "", "242", "", "246", 
                              "", "")) # Set labels for against the at arg.
                
                #Lower left plot - copy of plot3() with minor changes
                plot(dmy_hms(plotDate),
                     plotData$Sub_metering_1,
                     ylab="Energy sub metering",
                     xlab = "",
                     type = "l",
                     col = "black")
                lines(dmy_hms(plotDate),
                      plotData$Sub_metering_2,
                      ylab ="",
                      xlab = "",
                      type = "l",
                      col = "red")
                lines(dmy_hms(plotDate),
                      plotData$Sub_metering_3,
                      ylab ="",
                      xlab = "",
                      type = "l",
                      col = "blue")
                legend("topright",
                       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       lty=c(1, 1, 1),
                       col=c("black", "red", "blue"),
                       bty = "n")
                
                # Lower right plot - new plot
                plot(dmy_hms(plotDate), # Plot on X
                     plotData$Global_reactive_power, # Plot on Y
                     ylab= "Global_reactive_power", # Label Y
                     xlab = "datetime", # Label X
                     type = "l") # Define plot type as line
                
        })
        
        ## Close interaction to PNG graphics device.
        
        dev.off()
        
}
