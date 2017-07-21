# The zipped data file can be downloaded here: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Make sure to unzip the data file into the working directory: household_power_consumption.txt. 

# For better efficiency, use the sqldf package to read the data.
if (!"sqldf" %in% rownames(installed.packages())) { install.packages("sqldf") }
library(sqldf)

# Read data file from the dates 2007-02-01 and 2007-02-02
elecdata <- read.csv.sql("household_power_consumption.txt",sep=";",header=TRUE, sql="SELECT * FROM file where Date = '1/2/2007' OR Date = '2/2/2007' ")

# Add DateTime column with class POSIXct/POSIXt
elecdata2 <- cbind(elecdata, strptime(paste(elecdata$Date, " ",elecdata$Time), format="%d/%m/%Y %H:%M:%S"))
names(elecdata2) <- c(names(elecdata), "DateTime")

# Initialize the graphics device: 480 pixels by 480 pixels
windows(height=8,width=8,xpinch=60,ypinch=60)

# Plot the graph
plot(elecdata2$Sub_metering_1, x=elecdata2$DateTime, type="l", ylab = "Energy sub metering", xlab="", col="black")
lines(elecdata2$Sub_metering_2, x=elecdata2$DateTime, type="l", col="red")
lines(elecdata2$Sub_metering_3, x=elecdata2$DateTime, type="l", col="blue")
legend(x="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), cex=0.9, inset=0)

# Copy the graph to a png file and save in the working directory
dev.copy(png, "plot3.png")
dev.off()