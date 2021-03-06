library(raster)
library(rgdal)
library(dismo)
library(rgeos)
library(biomod2)

#####################
#   2050 INMCM4 #
#####################
occurdat<-list.files("D:\\IPPC 5 Data\\2050 (average for 2041-2060)\\INMCM4\\",pattern=".tif$",full=T)
months <- seq(0,60,12)
for (i in months){
  occurdat[(1+i):(12+i)] <- c(occurdat[1+i],occurdat[(5+i):(12+i)],occurdat[(2+i):(4+i)])
}
r1 <- raster(occurdat[1], package="raster")
for (i in 2:length(occurdat)){
  r2 <- raster(occurdat[i], package="raster")
  r1 <- stack(r1,r2)
}
calclim <- r1
names(calclim)
calclim <- crop(calclim,extent(-86,-77,45,48))

#load gps points
setwd("C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project")
x<-read.csv("TVZ_Algoma.csv")
attach(x)
gps <- data.frame(x=Longitude ,y=Latitude)
crs.world <-CRS("+proj=longlat +datum=WGS84")
coordinates(gps) <- ~x+y
proj4string(gps) <- crs.world
inprtntx701 <- spTransform(gps, calclim@crs)
#extract data points
presence <- extract(calclim, inprtntx701)
x1 <- data.frame(presence)
names(x1)
x2 <- cbind(x1[, c(13:36)])
x3 <- cbind(x1[, c(49:72)])
x2<-x2[, ]/10
x3<-x3[, ]/10
x6<-cbind(x1[, c(1:12)])
x7<-cbind(x1[, c(37:48)])
x10<-data.frame(x6,x2,x7,x3)
names(x10)
for (i in 1:12)
{
  col2 <- paste("in45tmean50",i, sep="")
  x10[,col2] <- NA
}
for (i in 1:12)
{
  col4 <- paste("in85tmean50",i, sep="")
  x10[,col4] <- NA
}
names(x10)
x11 <- x10[, c(1:36, 73:84, 37:72, 85:96)]
names(x11)
for (i in c(13:24, 61:72)){
  for (j in 1:45){
    x11[j,i+24]<-(x11[j,i]+x11[j,i+12])/2
  }
}
names(x11)
x12 <- data.frame(x, x11)
names(x12)
write.csv (x12, file = "TVZ_Algoma.csv",row.names=FALSE)


#####################
#   2070 INMCM4  #
#####################


occurdat<-list.files("D:\\IPPC 5 Data\\2070 (average for 2061-2080)\\INMCM4\\",pattern=".tif$",full=T)
months <- seq(0,60,12)
for (i in months){
  occurdat[(1+i):(12+i)] <- c(occurdat[1+i],occurdat[(5+i):(12+i)],occurdat[(2+i):(4+i)])
}
r1 <- raster(occurdat[1], package="raster")
for (i in 2:length(occurdat)){
  r2 <- raster(occurdat[i], package="raster")
  r1 <- stack(r1,r2)
}
calclim <- r1
names(calclim)
calclim <- crop(calclim,extent(-86,-77,45,48))

#load gps points
setwd("C:\\Users\\adminuser\\Desktop\\EVERYTHING THOMAS\\OMNR Alagae project")
x<-read.csv("TVZ_Algoma.csv")
attach(x)
gps <- data.frame(x=Longitude ,y=Latitude)
crs.world <-CRS("+proj=longlat +datum=WGS84")
coordinates(gps) <- ~x+y
proj4string(gps) <- crs.world
inprtntx701 <- spTransform(gps, calclim@crs)
#extract data points
presence <- extract(calclim, inprtntx701)
x1 <- data.frame(presence)
names(x1)
x2 <- cbind(x1[, c(13:36)])
x3 <- cbind(x1[, c(49:72)])
x2<-x2[, ]/10
x3<-x3[, ]/10
x6<-cbind(x1[, c(1:12)])
x7<-cbind(x1[, c(37:48)])
x10<-data.frame(x6,x2,x7,x3)
names(x10)
for (i in 1:12)
{
  col2 <- paste("in45tmean70",i, sep="")
  x10[,col2] <- NA
}
for (i in 1:12)
{
  col4 <- paste("in85tmean70",i, sep="")
  x10[,col4] <- NA
}
names(x10)
x11 <- x10[, c(1:36, 73:84, 37:72, 85:96)]
names(x11)
for (i in c(13:24, 61:72)){
  for (j in 1:45){
    x11[j,i+24]<-(x11[j,i]+x11[j,i+12])/2
  }
}
names(x11)
x12 <- data.frame(x, x11)
names(x12)
write.csv (x12, file = "TVZ_Algoma.csv",row.names=FALSE)
