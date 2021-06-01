#Lab material adopted from R-statistics blog and UCI machine learning data sets
rm(list=ls())

#include libraries 
#install.packages("rattle.data")
#install.packages(c("HSAUR", "NbClust"))
library(rattle.data)
library(NbClust)
library(cluster)
library(HSAUR)

#include data 
data(wine, package="rattle.data")
#remove classification 
dfm.data <- scale(wine[-1])

# examine the best number of clusters 
mydata <- dfm.data
wss <-list()
for (i in 1:15) wss[i] <- sum(kmeans(mydata, centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")


# another way to examine the best number of clusters 
nc <- NbClust(dfm.data, min.nc=2, max.nc=15, method="kmeans")
#see the voting results 
table(nc$Best.n[1,])


#set seed to avoid random initiation for every run
set.seed(1234)
# apply kmeans clustering 
km <- kmeans(dfm.data,3,10)
#examine results 
km
km$cluster
km$centers
km$size
str(km)
km$iter
#plot results 
plot(mydata, col=km$cluster)
points(km$center,col=1:3,pch=8,cex=1)

#try another number of clusters 
km2 <- kmeans(dfm.data,5,10)
km2
km2$size
str(km2)
km2$iter
plot(dfm.data, col=km2$cluster)
points(km2$center,col=1:5,pch=8,cex=1)


#using colored plot 
clusplot(dfm.data, km$cluster, color=TRUE, shade=TRUE,  labels=0, lines=0)


# calculate the effeciency
# note that the arrangement may be different 
conf<-table(wine$Type,km$cluster)
conf

accuracy  <- sum(diag(conf))/sum(conf)
accuracy

missclass <-(sum(conf)-sum(diag(conf)))/sum(conf)
missclass
