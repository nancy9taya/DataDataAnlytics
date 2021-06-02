install.packages('tm')
install.packages("wordcloud")
library("tm")
library("wordcloud")
rm(list=ls())
setwd("D:/Rehab/Studies/Senior 2/Spring 2021/Big Data/Labs/Lab 7 - Time Series Analysis, Text Analysis and Visualization/Text Analytics")  #Replace this working directory with the directory containing the R file. 


#Question 1
dfm <- data.frame(read.csv("movie_reviews.csv", header=TRUE, sep = ',')) ## sentiment labeled reviews

#Question 2
summary(dfm)
head(dfm, n=5)

#Question 3
corpus_obj <- Corpus(VectorSource(dfm$text))
#corpus_obj[[1]]$content

#Question 4
corpus_preprocess <- tm_map(corpus_obj, tolower)
#corpus_preprocess[[1]]$content

#Question 5
corpus_preprocess <- tm_map(corpus_preprocess, removePunctuation)
corpus_preprocess <- tm_map(corpus_preprocess, removeNumbers)
corpus_preprocess <- tm_map(corpus_preprocess, stripWhitespace)
#corpus_preprocess[[1]]$content

#Question 6
corpus_preprocess <- tm_map(corpus_preprocess, removeWords, stopwords("en"))
#corpus_preprocess[[1]]$content

#Question 7
dtm <- DocumentTermMatrix(corpus_preprocess)

#Question 8
inspect(dtm)
#Sparsity percentage = 100%

#Question 9
dtm <- removeSparseTerms(dtm, 0.9999)

#Question 10
freq <- findFreqTerms(dtm, 65)

#Question 11
assocs <- findAssocs(dtm, c("titanic","marvel"),0.05)

#Question 12
dtm <- removeSparseTerms(dtm, 0.999)

#Question 13
matrix <- as.matrix(dtm)
normal_matrix <- colSums(matrix)
sorted <- sort(normal_matrix,decreasing = TRUE)

#Question 14
head(sorted, n = 5)

#Question 15
freq_100 <- head(sorted, n = 100)
pnames <- names(freq_100)
cloud <- wordcloud(pnames,freq_100)
