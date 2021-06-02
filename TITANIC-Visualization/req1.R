#1
rm(list=ls())
setwd("C:/Users/DELL/Desktop/Senior 1/BigData/Requirement_ TITANIC-20210324T115352Z-001/Requirement_ TITANIC")  
getwd()
#2
dfcsv <- read.csv("titanic.csv",header = TRUE)
dfcsv
#3
dim(dfcsv)
str(dfcsv)
head(dfcsv,n=10)
tail(dfcsv,n=10)
summary(dfcsv)
#4
summary(dfcsv$Age)
print("1st QU is 20.12")
#1st QU is 20.12 it represents the cut off the 25%  of data at 20
print("3rd QU is 38 ")
#3rd QU is 38 it represents the cut off the 75% of data at 38 
is.na(dfcsv$Age)
#is.na checks each row if it is NA or not 
anyNA(dfcsv$Age)
#anyNA checks if exists in the entirely data a NA row or not 
#anyNA is better because it is faster 
typeof(dfcsv$Embarked)
x<-factor(dfcsv$Embarked)
x
str(x)
# no should remove the NA and empty rows
#5
dfcsv<-dfcsv[!is.na( dfcsv$Age),]
anyNA(dfcsv$Age)
v<-c("C","Q", "S")
dfcsv<-dfcsv[dfcsv$Embarked%in%v,]
x<-factor(dfcsv$Embarked)
str(x)
dfcsv<-subset(dfcsv,select = -c(Cabin,Ticket))
#6
t<-table(dfcsv$Gender) 
t
labels<-c("female","male")
pie(t, labels ,col = c("Red","Blue"))
table(dfcsv$Survived[dfcsv$Gender== "female"])
table(dfcsv$Survived[dfcsv$Gender== "male"])
t2<-table(dfcsv$Gender[dfcsv$Survived == 1])
pie(t2)
# that most of survived are females
t3<-table(dfcsv$Survived,dfcsv$Pclass)
barplot(t3 , col = c("Red","Blue"))
# most survived from class A
boxplot( dfcsv$Age)
#median is between 20 and 40 so range 30 and small circle is outlier 
d<-density(dfcsv$Age)
plot(d,main = "kernel density for age")
#7
d<-subset(dfcsv,select = c(Survived, Name))
d
write.csv(d,"titanic_preproccesed.csv")

