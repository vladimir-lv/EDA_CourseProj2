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
