#Reading files
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#2
nei.ds1<-aggregate(Emissions ~ year, data=NEI[NEI$fips==24510,], FUN=sum)

png("plot2.png",width = 480, height = 480, units = "px")
plot(nei.ds1$Emissions~nei.ds1$year,type="l",xlab = "Years",ylab = "Total Emission PM2.5",
      main="Baltimore City Total Emission PM2.5")
dev.off()


