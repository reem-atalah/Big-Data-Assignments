# Let us get the appropriate libraries loaded for NB Classifier. 
#install.packages("e1071")
library("e1071")

######## 2.Import the dataset nbtrain.csv into a data frame. What are the variables of this dataset?
sample <- read.table("nbtrain.csv", header=TRUE, sep=",")

# The variables are: 1.Age, 2.Gender, 3.Education(educ), 4.Income

######## 3.Divide the data into two data frames: a training set containing the first 9000 rows, and a test set containing the remaining rows. 
# we will now define the data frames to use the NB classifier
traindata <- as.data.frame(sample[1:9000,])
testdata <- as.data.frame(sample[9000:nrow(sample),])
#Display data frames
traindata
testdata

#Why do we split data into training and test sets: To test accuracy of the model on data it didn't see before

######## 4.Train a Naïve Bayes Classifier model with income as the target variable and all other variables as independent variables. Smooth the model with Laplace smoothing coefficient = 0.0
# Use the NB classifier -------------------------------
model <- naiveBayes(income~.,traindata,laplace=0.01)

#What does Laplace smoothing coefficient mean: Its value is added to every class while calculating probabilities to protect from zero probability problem


######## 5.Display model
model

######## 6.Predict with testdata
results <- predict (model, testdata[,1:3])
# display results
results

######## 7. Display the confusion matrix and investigate the results
# Create the confusion matrix
conv_mat = table(results,testdata[,4])
print(conv_mat)
# Rows are the predicted and columns are the actual data
###
#   results  10-50K 50-80K GT 80K
#   10-50K    798    127     67 ---> All of this is classified as (10-50k)
#   50-80K      0      0      0 ---> The model didn't classify any point as belonging to the class (50-80k)
#   GT 80K      6      5      8
###             |
#               |
#               |
#               v
#           All of this should be classified as (10-50k)
# 
## Explain the variation in the model's classification power across income classes
#--> The model is strongly over fitted on the first class (992 data points are classified as 10-50k)
# completely neglecting the second class (zero classification)
# It's weekly seeing the third class

######## 8. Calculate the accuracy of the model as a general measure of its performance
# Accuracy = (TP+TN)/(TP+TN+FP+FN)
accuracy = sum(diag(conv_mat))/sum(conv_mat)
# Display accuracy
accuracy

# Accuracy is 0.79 which seems to be a good accuracy but it's not because the model is over fitted on the first class
# and totally neglecting the second class which indicates that the model is not generalizing well and that the accuracy 
# is not a good measure of the model's performance

######## 9. Calculate the overall misclassification rate of each class
# Misclassification rate for each class

misclassification = 1 - (diag(conv_mat)/colSums(conv_mat))

# Display misclassification

misclassification