rm(list=ls())
#install.packages("arules")
#install.packages("arulesViz")
setwd("C:/Users/Lenovo/Desktop/Senior 1/BigData/Labs/Lab 3 - Association Rule Mining/lab 3")  
getwd()
library("arules")
library("arulesViz")
tr<-read.transactions("AssociationRules.csv", header = FALSE)
inspect(tr[1:100])
itemLabels(tr)
itms<-itemFrequency(tr, type = "absolute")
head(sort(itms, decreasing = TRUE), n = 20)# item 13
itemFrequencyPlot(tr, topN = 5)
rules <- apriori(tr, parameter = list (supp = 0.01, conf = 0.5,minlen=2)) 
summary(rules)
rules_supp <- sort (rules, by="support", decreasing=TRUE) 
inspect(head(rules_supp,n=6))
rules_conf <- sort (rules, by="confidence", decreasing=TRUE) 
inspect(head(rules_conf,n=6))
rules_lift<- sort (rules, by="lift", decreasing=TRUE) 
inspect(head(rules_lift,n=6))
plot(rules, measure = c("support", "confidence"), shading = "lift")
#we choose base on confidence then support
#as While mining association rules, you prefer the ones with high confidence  over ones with high support .
#That is why usually the minSupport may be on the lower side,
#even lower than 50%, while minConfidence is usually set higher, above 50% for example.