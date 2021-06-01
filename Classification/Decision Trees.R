getwd()

install.packages("rpart.plot")
library("rpart")
library("rpart.plot")
library("ROCR")

#Read the data
play_decision <- read.table("DTdata.csv",header=TRUE,sep=",")
play_decision
summary(play_decision)

#Build the tree to "fit" the model
# Q1: what is the default value for split?                                      
#The default splitting method for classification is "gini".
#The splitting index can be gini or information
# Gini impurity measures the degree or probability of a particular variable being wrongly classified when it is randomly chosen.
fit <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2, maxdepth = 3),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit, type = 1, extra = 1)
summary(fit)

# Q2: what are the meanings of these control parameters?  
#          1- "minsplit=2"parameter is the smallest number of observations in the parent node that could be split further
#
#          2- "maxdepth=3" parameter prevents the tree from growing past a certain depth / height.
#
#          3- "minbucket=4" provides the smallest number of observations that are allowed in a terminal node. 
#                           If a split decision breaks up the data into a node with less than the minbucket, it won't accept it.
#
# Support your answers with graphs for different values of these parameters.
fit <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=4,minbucket =3,maxdepth = 3),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit, type = 4, extra = 1)
#######################################################################################


#Q3: What will happen if only one of either minsplit or minbucket is specified
#    and not the other?

#Answer: If only one of minbucket or minsplit is specified, the code either sets minsplit to minbucket*3 or minbucket to minsplit/3, as appropriate.

#Q4: What does 'type' and 'extra' parameters mean in the plot function?

# type to decide which plot shape we what to display types 0,1,2,3,4,5
#extra to show extra information on the plot as name , probability ...etc

#Q5: Plot the tree with probabilities instead of number of observations in each node.
fit <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2,maxdepth = 3),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit, type = 4, extra = 4)
######################################################################################
 
#Predict if Play is possible for condition rainy, mild humidity, high temperature and no wind
newdata <- data.frame(Outlook="overcast",Temperature="mild",Humidity="high",Wind=FALSE)
newdata
print(fit) 
predict(fit,newdata=newdata,type=c("class"))
# type can be class, prob or vector for classification trees.

######################################################################################
#Q6: What is the predicted class for this test case?
# yes 

#Q7: State the sequence of tree node checks to reach this class (label).
#1)humidity branch high get us to temperature --> mild then branch outlook--> overcast  and the wind is 50% true and 50% false in this branch so it not considered 
#then predication is yes play
## ================================= END ===================================== ##