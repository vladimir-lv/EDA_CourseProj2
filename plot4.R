#Reading files
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#4
aaa<-merge(NEI,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)
nei.coal<-aaa[grep("COAL",toupper(aaa$Short.Name)),c("Emissions","year")]
nei.coal_agg<-aggregate(Emissions ~ year, data=nei.coal, FUN=sum)

png("plot4.png",width = 480, height = 480, units = "px")
plot(nei.coal_agg$Emission~nei.coal_agg$year,type="l",xlab = "Year",ylab = "PM2.5 Emission",
      main="Emissions from coal combustion-related sources")
dev.off()

#5 
nei.all <-NEI[NEI$fips %in% c("24510","06037"),]
aaa<-merge(nei.all,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)
nei.vehicle<-aaa[grep("VEHICLE",toupper(aaa$Short.Name)),]
nei.vehicle_agg<-aggregate(Emissions ~ fips+year, data=nei.vehicle, FUN=sum)
nei.bltm<-nei.vehicle_agg[nei.vehicle_agg$fips=="24510",]
nei.la<-nei.vehicle_agg[nei.vehicle_agg$fips=="06037",]
plot(nei.la$Emission~nei.la$year,col="red",type="l")
lines(nei.bltm$Emission~nei.bltm$year,col = "blue")
