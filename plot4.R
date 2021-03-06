#### Download Data and Unzip Data ####
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile<- "project1data.zip"

download.file(url,destfile, method="curl")
unzip(zipfile="project1data.zip", exdir=as.character(getwd()))

#### Load Data into R ####

df<- read.table("household_power_consumption.txt", 
                header= TRUE, 
                sep=";",
                na.strings = "?")
#### Convert Date and Time variables to Date and Time class ####

df$DT <- strptime(paste(df$Date,df$Time),format="%d/%m/%Y%H:%M:%S")
df$Date<- as.Date(df$Date, format="%d/%m/%Y")
df$Time <- strptime(df$Time, format= "%H:%M:%S")

#### Subsetting for 1/2/07 and 2/2/07 ####

index <- which(df$Date == '2007-02-01'|df$Date == '2007-02-02')

subdata <- df[index,]

#### Constructing Plot ####

png("plot4.png")
par(mfrow=c(2,2))

#Plot global active power #

plot(subdata$DT,
     subdata$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Powere (kilowatts)")

#Plot Votage #

plot(subdata$DT,
     subdata$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

#Plot Submetering #

plot(subdata$DT,
     subdata$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")
lines(subdata$DT,
      subdata$Sub_metering_2,
      col="red")
lines(subdata$DT,
      subdata$Sub_metering_3,
      col="blue")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col= c("black","red","blue"),
       lty=1)
#Plot Global reactive power #

plot(subdata$DT,
     subdata$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")
dev.off()




