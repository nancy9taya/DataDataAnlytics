rm(list=ls())
library("e1071")
library("caret")
#install required packages
#install.packages('gmodels')
#import required library 
library(gmodels)
#install.packages("caret")

getwd()
dframe <- read.table("nbtrain.csv", header=TRUE, sep=",")
dframe
dim(dframe)
summary(dframe)
#1- the variables are age , gender , education, income
traindata <- as.data.frame(dframe[1:9000,])
testdata <- as.data.frame(dframe[9001:10010,])
#Display data frames
traindata
testdata
#2- the training data is to train the model and then the test data to get the accuracy of the model
#to know if it is good enough for classification this specific data or not

model <- naiveBayes(income~.,traindata,laplace=.01)
model
#3- Laplace smoothing is a smoothing technique that helps tackle the problem of zero probability in the Naive Bayes 
# because if there is feature missing not in dataset and we want to calculate its probability it will be zero and the overall probability will be zero too so
# there is too solution ignore it or put laplace smoothing
# predict with testdata
results <- predict (model, testdata)
# display results
results
factor(results)
factor(testdata$income)
acc<-confusionMatrix(factor(results), factor(testdata$income))
acc
# 4 - here the more samples the model classified correct  probational to classified wrong in test data in class 10-15K
#the more accuracy the model is in this class 

#Computes the crosstable calculations
CrossTable(factor(results), factor(testdata$income))
AcuracyModel = acc$overall['Accuracy']
Accuracy = ((797+8) / 1010 ) *100
AcuracyModel
table(traindata$income)
table(testdata$income)
acc$byClass
#in naive bayes to make sure that prediction is correct i must have the same number of records for each class to not preferred class to another based on occurrence
# here the accuracy is good because also the majority  as train data to class 10-15k

predicted.classes<-1-acc$byClass[,'Recall']
predicted.classes
missRateC1 = 6/(797+6)
missRateC2 = 132/132
missRateC3 = 67/(67+8)
error_rate = 100 - Accuracy 
error_rate 

acc$overall
#sensitivity: true positive rate
#specificity: true negative rate 