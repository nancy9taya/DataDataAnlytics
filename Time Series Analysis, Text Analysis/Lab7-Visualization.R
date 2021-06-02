rm(list=ls())
setwd("D:/Rehab/Studies/Senior 2/Spring 2021/Big Data/Labs/Lab 7 - Time Series Analysis, Text Analysis and Visualization/Visualization in R")  #Replace this working directory with the directory containing the R file. 
install.packages("ggplot2") 
library("ggplot2")

#Question 1
data <- read.csv("datasets/EconomistData.csv", header = TRUE, sep = ',')
summary(data)

#Question 2
ggplot(data, aes(x=CPI,y=HDI))+ geom_point()

#Question 3
ggplot(data, aes(x=CPI,y=HDI))+ geom_point(color = "blue")

#Question 4
ggplot(data, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region))

#Question 5
ggplot(data, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region))+geom_smooth()

#Question 6
ggplot(data, aes(x=CPI,y=HDI))+ geom_text(aes(label = Country))

#Question 7
ggplot(data, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region),size = 2)

#Question 8
ggplot(data, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region ,size = HDI.Rank))

#Question 9
middleEast <- subset(data, Region == "MENA")
ggplot(middleEast, aes(x=CPI,y=HDI))+ geom_point() #2
ggplot(middleEast, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region)) #4
ggplot(middleEast, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region))+geom_smooth() #5
ggplot(middleEast, aes(x=CPI,y=HDI))+ geom_text(aes(label = Country)) #6
ggplot(middleEast, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region ,size = HDI.Rank)) #8
#Egypt is located at (CPI,HDI) = (2.9,0.64)

#Question 10
european <- subset(data, Region == "EU W. Europe")
ggplot(european, aes(x=CPI,y=HDI))+ geom_point() #2
ggplot(european, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region)) #4
ggplot(european, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region))+geom_smooth() #5
ggplot(european, aes(x=CPI,y=HDI))+ geom_text(aes(label = Country)) #6
ggplot(european, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region ,size = HDI.Rank)) #8

#Question 11
european_egy <- subset(data, Region == "EU W. Europe" | Country == "Egypt")
ggplot(european_egy, aes(x=CPI,y=HDI))+ geom_point() #2
ggplot(european_egy, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region)) #4
ggplot(european_egy, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region))+geom_smooth() #5
ggplot(european_egy, aes(x=CPI,y=HDI))+ geom_text(aes(label = Country)) #6
ggplot(european_egy, aes(x=CPI,y=HDI))+ geom_point(aes(color = Region ,size = HDI.Rank)) #8
#Egypt is located at (CPI,HDI) = (2.9,0.64) N.B: Not exactly whether it is 2.9 or 2.8






