## Read already downloaded data into csv
data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subset the data
data_feb2007 <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Create a DateTime column that contains date and time in POSIXct format
data_feb2007$DateTime <- paste(as.Date(data_feb2007$Date), data_feb2007$Time)
data_feb2007$DateTime <- as.POSIXct(data_feb2007$DateTime)

## Create plot
with(data_feb2007, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex=.5, text.font=3,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save as png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
