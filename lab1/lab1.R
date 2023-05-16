
#Osama Magdy sec:1, BN: 15
#Reem Emad sec:1 BN: 33

# clean workspace

rm(list=ls())

# 1
# change the directory
setwd("D:/faculty/CMP4/semester2/Big Data/Assignments")

# check if directory has changed correctly
getwd()

# 2
# Import our excel file
dfm <- read.csv("titanic.csv")
dfm

# 3)a)
# get dimensions of data frame
dim(dfm)

# 3)b)
# show structure of the data frame
str(dfm)

# 3)c)
# get first 10 records
head(dfm,10)

# 3)c)
# get last 10 records
tail(dfm,10)

# 3)d)
# summary of the data frame
summary(dfm)

# 4)a)
# show summary of variable age in the data frame
summary(dfm[c('Age')])

# 4)b) 
# first quartile in age:
# it means that the mean of the *first* half values are 20.12
# where first half values are the values before the mean of all values in the age  
# 1st Qu.:20.12

# third quartile in age:
# it means that the mean of the *second* half values are 38.00
# where second half values are the values after the mean of all values in the age  
# 3rd Qu.:38.00 

# 4)c)
# The generic function is.na indicates which elements are missing
# The data frame method for is.na returns a logical matrix with the same dimensions as the data frame, 
# and with dimnames taken from the row and column names of the data frame
# where it shows false if no NA, and True when cell is empty.

is.na(dfm$Age)

# The generic function anyNA implements any(is.na(x)) in a possibly faster way,
# where it gets TRUE if any NA values are detected in the data frame.

anyNA(dfm$Age) #True

# in the case that we want to know if there are any missing values in the variable age,
# it is better to use  anyNA.

# 4)d) 
# type of the variable 'embarked' is char, can check it using the following command
str(dfm$Embarked)

# levels of 'Embarked' variable
#levels(dfm$Embarked) # gives NULL
#nlevels(dfm$Embarked) # gives 0
factor(dfm$Embarked)
# it has 4 levels (space and 3 characters):   C Q S

# 4)e)
# we need pre-processing on data to remove this space, because the expected output is C or Q or S

# 5) pre-processing
# 5)a)
# Remove the rows containing <NA> in the age variable from the data frame.
dfm <- dfm[!is.na(dfm$Age),]
dfm

# 5)b)
# Remove the rows containing any unexpected value in the embarked variable from the data set
# we want only C or Q or S to exist
data_frame_mod <- dfm[dfm$Embarked %in% c("S","C","Q") & !is.na(dfm$Embarked),]
data_frame_mod

# 5)c)
# check that no NA values exist in the age variable.
anyNA(data_frame_mod$Age) # False

# 5)c) 
# factor the embarked variable and display its levels. Is that what you are expecting?
factor(data_frame_mod$Embarked) # now they are C Q S without space
# yes this was expected as we should keep only C,S,Q

# 5)d)
# Remove columns Cabin and Ticket from the data set because they're not important for the value of survived or not
data_frame_mod <- subset( data_frame_mod, select = -c(Cabin, b=Ticket))
data_frame_mod


# 6) statistical description and visualization
# 6)a)
# number of females = 259
female_num <- nrow(data_frame_mod[data_frame_mod$Gender == 'female',])
# we can also use table(data_frame_mod$Gender) to get a table with data of female and male counts
# but using nrow was more suitable to get directly the number and re-use it.

# number of males = 453
male_num <- nrow(data_frame_mod[data_frame_mod$Gender == 'male',])

# 6)b), c)
# Plot a pie chart showing the number of males and females aboard the Titanic.
pie(c(female_num,male_num), labels = c('female num','male num'), col = c('red','blue'))

# 6)d)
# survived females : 195
female_survived <- nrow(data_frame_mod[data_frame_mod$Gender == 'female' & data_frame_mod$Survived == 1,])
# not survived females
# We can use either ways
female_notsurvived <- female_num - female_survived
female_notsurvived <- nrow(data_frame_mod[data_frame_mod$Gender == 'female' & data_frame_mod$Survived == 0,])

# survived males : 93
male_survived <- nrow(data_frame_mod[data_frame_mod$Gender == 'male' & data_frame_mod$Survived == 1,])
#not survived males
male_notsurvived <- male_num - male_survived
male_notsurvived <- nrow(data_frame_mod[data_frame_mod$Gender == 'male' & data_frame_mod$Survived == 0,])

# Plot a pie chart showing the number of males and females aboard the Titanic who survived.
pie(c(female_survived,male_survived), labels = c('female survived','male survived'), col = c('red','blue'))

# 6)e) 
# Conclude from 6)d) that number of female survived is much larger than the males according to each gender total number
prob_female_survived <- female_survived / female_num #0.75

prob_male_survived <- male_survived / male_num #0.2

# 6)f) 
class1 <- nrow(data_frame_mod[data_frame_mod$Pclass == 1,])
class2 <- nrow(data_frame_mod[data_frame_mod$Pclass == 2,])
class3 <- nrow(data_frame_mod[data_frame_mod$Pclass == 3,])

# show how many survived from each gender for each class
class1_survived <- nrow(data_frame_mod[data_frame_mod$Survived == 1 & data_frame_mod$Pclass == 1,])
class2_survived <- nrow(data_frame_mod[data_frame_mod$Survived == 1 & data_frame_mod$Pclass == 2,])
class3_survived <- nrow(data_frame_mod[data_frame_mod$Survived == 1 & data_frame_mod$Pclass == 3,])

class1_not_survived <- nrow(data_frame_mod[data_frame_mod$Survived == 0 & data_frame_mod$Pclass == 1,])
class2_not_survived <- nrow(data_frame_mod[data_frame_mod$Survived == 0 & data_frame_mod$Pclass == 2,])
class3_not_survived <- nrow(data_frame_mod[data_frame_mod$Survived == 0 & data_frame_mod$Pclass == 3,])

# 6)g)h)
class_survived_mat <- as.matrix(data.frame(class1 = c(class1_survived, class1_not_survived),      
                                           class2 = c(class2_survived, class2_not_survived),
                                           class3 = c(class3_survived, class3_not_survived)))
rownames(class_survived_mat) <- c("Survived", "Not Survived")
 
barplot(class_survived_mat,col = c("blue", "red"))

legend("topleft",legend = c("Survived", "Not Survived"),fill = c("blue", "red"))

# 6)i)
prob_class1 <- class1_survived / class1 #0.65
prob_class2 <- class2_survived / class2 #0.47
prob_class3 <- class3_survived / class3 #0.2

# conclude from previous chart and the probabilities that the passengers for class 1 had better chances to survive
# while class 3 had hardly a chance to survive, and class 2 in between 
# survive on which class you are !

# 6)j)
boxplot(data_frame_mod$Age) 

# 6)k)
# it's representation is a visualization for "summary(data_frame_mod[c('Age')])"
# the output of boxplot means:
# circles are outliers, less people were above age 65 till 80, 
# upper horizontal is the highest value in the age which is about 65, 
# upper part of rectangle is upper/3rd quartile which is about 40 , 
# mid of the rectangle is the median which is about 30, 
# lower part of rectangle is lower/1st quartile which is about 20, 
# lower horizontal is the lowest value in the age which is about 1.

# 6)L)
# plot a density distribution of Age
plot(density(data_frame_mod$Age), main = "Age Density plot")

# 7)

data_frame_mod <- subset( data_frame_mod, select = c(Survived, Name))
write.csv(data_frame_mod, "D:/faculty/CMP4/semester2/Big Data/Assignments/titanic_preprocessed.csv", row.names=FALSE)









