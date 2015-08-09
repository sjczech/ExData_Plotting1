## Download and read data into csv
file <- "household_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", file, mode= "wb")
unzip(file)
data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Convert date column format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subset the data
data_feb2007 <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Create a DateTime column that contains date and time in POSIXct format
data_feb2007$DateTime <- paste(as.Date(data_feb2007$Date), data_feb2007$Time)
data_feb2007$DateTime <- as.POSIXct(data_feb2007$DateTime)

## Create plot
hist(data_feb2007$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", title="Global Active Power")

## Save as png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
