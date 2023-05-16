setwd("")

#install.packages("rpart.plot")
library("rpart")
library("rpart.plot")
library("ROCR")

#Read the data
play_decision <- read.table("DTdata.csv",header=TRUE,sep=",")
play_decision
summary(play_decision)

#Build the tree to "fit" the model
fit <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2, maxdepth = 3),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit, type = 4, extra = 1)

summary(fit)
#######################################################################################
# Q1: what is the defult value for split?                                      
# It is "gini" which is favoring large partitions (The Gini Index is calculated by subtracting the sum of the squared probabilities of each class from one)
# Q2: what are the meanings of these control parameters?  
#          1- "minsplit=2"
#--> minsplit is the smallest number of data points that we can split further in the tree. "minsplit=2" means that if we have less than 2 records in the node, it'll be considered a terminal node
#          2- "maxdepth=3" 
#--> It is the maximum depth of the tree that we can not split after reaching it 
#          3- "minbucket=4" 
#--> minbucket is the minimum number of observations that are allowed in a terminal node. If we decided to split based on some decision and that decision will result in breaking up the data into a node with less than the minbucket, it won’t be accepted.
# Support your answers with graphs for different values of these parameters.
fit2 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=1, maxdepth = 1),
             parms=list(split='information'))
rpart.plot(fit2, type = 4, extra = 1)

fit3 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=5, maxdepth = 2),
             parms=list(split='information'))

rpart.plot(fit3, type = 4, extra = 1)

fit4 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2, maxdepth = 3,minbucket=3),
             parms=list(split='information'))

rpart.plot(fit4, type = 4, extra = 1)

#Q3: What will happen if only one of either minsplit or minbucket is specified
#    and not the other?
# --> If only one of minbucket or minsplit is specified, the code either sets minsplit to minbucket*3 or minbucket to minsplit/3, as appropriate

#Q4: What does 'type' and 'extra' parameters mean in the plot function?
# --> 'type': is the type of the plot. Possible values: (0,1,2,3,4,5)
#     0 Default. Draw a split label at each split and a node label at each leaf.
#     4 Like 3 but label all nodes, not just leaves. Similar to text.rpart’s fancy=TRUE.
#     'extra': is to Display extra information at the nodes. Possible values:
#     0 Default. No extra information.
#     1 Display the number of observations that fall in the node.

#Q5: Plot the tree with propabilities instead of number of observations in each node.
######################################################################################
rpart.plot(fit, type = 4, extra = 4 ) 

#Predict if Play is possible for condition rainy, mild humidity, high temperature and no wind
newdata <- data.frame(Outlook="overcast",Temperature="mild",Humidity="high",Wind=FALSE)
newdata
predict(fit,newdata=newdata,type=c("class"))
# type can be class, prob or vector for classification trees.

######################################################################################
#Q6: What is the predicted class for this test case?
# -->yes
#Q7: State the sequence of tree node checks to reach this class (label).
# --> 1. Check on temperature --> mild
# --> 2. Check on outlook --> overcast
# Then it will be yes
## ================================= END ===================================== ##
