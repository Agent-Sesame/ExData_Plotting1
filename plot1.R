plot1 <- function() {

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
        
        ## Subset column 3 from 'plotData' to variable 'gap'.
        
        gap <- plotData[, 3]
        
        ## Create .PNG file.
        
        png("plot1.png", width = 480, height = 480)
        
        ## Print histogram to PNG file. 
        
        print({
                
                ## Note this histogram plots global active power values and 
                ## shows the frequency of each values appearance.
                
                hist(gap, # Plot histogram of gap
                     freq = TRUE, # Defines what to plot in the histogram
                     col = "Red", # Configure histogram bar fill color
                     border = "Black", # Configure histogram bar borders
                     main = paste("Global Active Power"), # Create main title
                     xlab = "Global Active Power (kilowats)", # Correct X label
                     ylab = "Frequency", # Correct Y label
                     ylim=c(0, 1200)) # Configure Y axis increment.
                
        })
        
        ## Close graphics device control.
        
        dev.off()
}