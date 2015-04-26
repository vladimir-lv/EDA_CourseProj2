#Reading files
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")


nei.all <-NEI[NEI$fips %in% c("24510","06037"),]
aaa<-merge(nei.all,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)
nei.vehicle<-aaa[grep("VEHICLE",toupper(aaa$Short.Name)),]
nei.vehicle_agg<-aggregate(Emissions ~ fips+year, data=nei.vehicle, FUN=sum)
nei.bltm<-nei.vehicle_agg[nei.vehicle_agg$fips=="24510",]
nei.la<-nei.vehicle_agg[nei.vehicle_agg$fips=="06037",]

png("plot6.png",width = 480, height = 480, units = "px")
par(mfrow=c(1,2))
plot(nei.bltm$Emission~nei.bltm$year,col="blue",type="l",xlab = "Year",ylab = "PM2.5 Emission",
     main="PM2.5 Emission Baltimore"
     )
plot(nei.la$Emission~nei.la$year,col="red",type="l",xlab = "Year",ylab = "PM2.5 Emission",
     main="PM2.5 Emission Los Angeles"
     )

dev.off()

