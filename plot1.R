## Course Project1

## --------------------- LOAD & READ DATA ------------------------
temp <-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
epc_data<-read.table (unz(temp,"household_power_consumption.txt"), sep = ";",as.is = TRUE, header = TRUE)
unlink(temp)


# convert Date and Time cols to 'date' class
epc_data$Date <- paste(epc_data$Date, epc_data$Time)
epc_data$Date <- strptime(epc_data$Date, format = "%d/%m/%Y %X")

# extract two day data 
epc_mod <- epc_data[(epc_data$Date >= "2007-02-01" & epc_data$Date < "2007-02-03"),]

# remove original dataset
rm(epc_data)

# remove NAs
epc_mod <- epc_mod[!is.na(epc_mod$Date),]
epc_mod$Global_active_power<-as.numeric(epc_mod$Global_active_power)
epc_mod$Voltage<-as.numeric(epc_mod$Voltage)

## ----------------- GENERATE PLOTS -------------------------------



# plot #1
png('plot1.png', width = 480, height = 480)
hist(epc_mod$Global_active_power,col = "red",
     main ="Global Active Power", xlab = "Global Active Power (kilowatts)")
#save plot 
dev.off()

