getwd()
#setwd("~/LAB")
rm(list=ls())
library(Metrics)
#install.packages("Metrics")
#=============================Part(1)=====================================
x <- runif(100, 0, 10)     # 100 draws between 0 & 10
rnorm(100, sd = 1)
mean(rnorm(100))
#(Q1) Try changing the value of standard deviation (sd) in the next command 
#How do the data points change for different values of standard deviation?
y <- 5 + 6*x + rnorm(100, sd = 1)  # default values for rnorm (mean = 0 and sigma = 1)

#Plot it
plot (x,y)

# OLS model
# OLS : Ordinary Least Squares
model1 <- lm(y ~ x)
# Learn about this object by saying ?lm and str(d)

# Compact model results
print(model1)
#(Q2) How are the coefficients of the linear model affected by changing the value
#of standard deviation in Q1?

# Regression diagnostics --
ypred <- predict(model1) # use the trained model to predict the same training data
# Learn about predict by saying ?predict.lm

par(mfrow=c(1,1))
plot(y,y, type="l", xlab="true y", ylab="predicted y") # ploting the ideal line
points(y, ypred) # plotting the predicted points
                 # the nearer to the ideal line the better

# Detailed model results
summary(model1)


#(Q3) How is the value of R-squared affected by changing the value
#of standard deviation in Q1?

# Learn about this object by saying ?summary.lm and by saying str(d)
cat("OLS gave slope of ", d1$coefficients[2,1],   
    "and an R-sqr of ", d1$r.squared, "\n")

#Graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model1, 1) # plot one diagnostic graphs
mean((model1$resid )^ 2)
hist(model1$resid, main="Histogram of Residuals",ylab="Residuals")
#Q-Q Plot
qqnorm(model1$resid)
qqline(model1$resid)
#(Q4)What do you conclude about the residual plot? Is it a good residual plot?
#========================End of Part(1)==============================================

#========================Part(2)=====================================================
#Training a linear regression model
x1 <- runif(100) 
# introduce a slight nonlinearity
#(A)
y1 = 5 + 6*x1 + 70*x1*x1 + rnorm(100)
plot(x1,y1)
model <- lm(y1 ~ x1)

summary(model)

#Creating a test set (test vector)

#EDIT: We renamed the variable as x1 instead of xtest (in previous versions)
#becaues the lm function searches in the formula for variables named 
#with x1 and not any other name.
#So, if you used xtest, the lm function will not know what is xtest and
#a random plot will be generated. 

x1 <- runif(100)
#(B)
ytrue = 5 + 6*x1 +70*x1*x1 + rnorm(100)  # same equation of y1 but on xtest to get true y for xtest

ypred <- predict(model, data.frame(x1))

par(mfrow=c(1,1))
plot(ytrue, ytrue, type="l", xlab="true y", ylab="predicted y")
points(ytrue, ypred)

# graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model, 1) # plot the diagnostic graphs

#(Q5)What do you conclude about the residual plot? Is it a good residual plot?

#(Q6)Now, change the coefficient of the non-linear term in the original model for (A) training 
#and (B) testing to a large value instead. What do you notice about the residual plot?
#===============================End of Part(2)=============================================

#=================================Part(3)==================================================
#(Q7) Import the dataset LungCapData.tsv. What are the variables in this dataset?
df <- read.table("LungCapData.tsv",header=TRUE)
names(df)
#Answer: LungCap Age Height Smoke Gender Caesarean
df$Age
#(Q8) Draw a scatter plot of Age (x-axis) vs. LungCap (y-axis). Label x-axis "Age" and y-axis "LungCap"
plot(df$Age, df$LungCap, main="scatter plot of Age vs.LungCap", xlab="Age ", ylab="LungCap ")
#(Q9) Draw a pair-wise scatter plot between Lung Capacity, Age and Height. 
df[,1:3]
pairs(df[,1:3])
#Check the slides for how to plot a pair-wise scatterplot

#(Q10) Calculate correlation between Age and LungCap, and between Height and LungCap.
#Hint: You can use the function cor
cor(df[,1:3])
#(Q11) Which of the two input variables (Age, Height) are more correlated to the 

#dependent variable (LungCap)?
#answer:Height

#(Q12) Do you think the two variables (Height and LungCap) are correlated ? why ?
#yes,It might be due to the increased surface area of the lungs in relation with increasing height.
#taller people tend to have larger chests and hence larger total lung capacities 
#and as a short person i have many breathing problems :)

#(Q13) Fit a liner regression model where the dependent variable is LungCap 
#and use all other variables as the independent variables<

# we need to convert categorical to numerical 
df$Smoke<-ifelse(df$Smoke=="Yes",1,0)
df$Caesarean<-ifelse(df$Caesarean=="Yes",1,0)
df$Gender<-ifelse(df$Gender=="female",1,0)
x1<- df$Age
x2<- df$Height
X3<- df$Smoke
x4<- df$Caesarean
x5<- df$Gender
y1<- df$LungCap
fit <- lm(y1 ~ x1 + x2 +X3 +x4+ x5 )
fit2<- lm(y1 ~ x1)
summary(fit)
#(Q17) Redraw a scatter plot between Age and LungCap. Display/Overlay the linear model (a line) over it.
plot(df$Age, df$LungCap, main="scatter plot of Age vs.LungCap", xlab="Age ", ylab="LungCap ")
abline(fit, col="red")

#Hint: Use the function abline(model, col="red").
#Note (1) : A warning will be displayed that this function will display only the first two 
#           coefficients in the model. It's OK.
#Note (2) : If you are working correctly, the line will not be displayed on the plot. Why?
#answer: Because it depend on other variable not just Age but in case fit 2 it gives us a line fitted

#(Q18)Repeat Q13 but with these variables Age, Smoke and Cesarean as the only independent variables.
fit3 <- lm(y1 ~ x1+ X3 +x4 )
summary(fit3)
plot(df$Age, df$LungCap, main="scatter plot of Age vs.LungCap", xlab="Age ", ylab="LungCap ")
X<-abline(fit3, col="red")
data.frame(X)
#(Q19)Repeat Q16, Q17 for the new model. What happened?
# the line displayed
#(Q20)Predict results for this regression line on the training data.
ypred <- predict(fit3, data.frame(df$Age))
par(mfrow=c(1,1))
plot(y1, y1, type="l", xlab="true y", ylab="predicted y")
points(y1, ypred)

#(Q21)Calculate the mean squared error (MSE)of the training data.
result <- mean((y1 - ypred) ^ 2)
result
