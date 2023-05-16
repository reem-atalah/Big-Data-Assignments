  #Lab 1 Introduction to R Language
  #--------------------------------------------------------------------------------#
  #clean environment and remove all variables in the global environment. 
  rm(list=ls())
  #display work items
  ls()
  #get working directory
  getwd()
  #set working directory
  #setwd("D:\CMP\TA-CU\Big Data\Labs\Lab 1\Tutorial Code")  #Replace this working directory with the directory containing the R file. 
  #get working directory
  #getwd()
  #--------------------------------------------------------------------------------#
  #Getting Started#
  str <- "Hello World"
  str = "Hello world"
  "hello world" -> str
  print(str)
  str2 <- str
  str <- "hello "
  #--------------------------------------------------------------------------------#
  #Comments#
  #This is a single line comment in R.
  #R does not support multi-line comments but you can perform a trick which is something as follows
  if(FALSE) {
    "This is a demo for multi-line comments and it should be put inside either a 
        single OR double quote"
  }
  #--------------------------------------------------------------------------------#
  #In contrast to other programming languages like C and java in R, the variables are not 
  #declared as some data type. The variables are assigned with R-Objects and the data type 
  #of the R-object becomes the data type of the variable. 
  
  #There are many types of R-objects. The frequently used ones are:
  #Vectors, Lists, Matrices, Arrays, Factors, Data Frames.
  
  #vectors in R
  #There are six data types of these atomic vectors:
  v1 <- c(1,2,3,4.5,2,3) #numeric
  v2 <- c("tree","street","car") #character
  v3 <- c(TRUE , FALSE ,TRUE) #logical
  
  v4 <- c(23L, 192L, 0L) #integer
  v5 <- c(3+2i, 4-5i, -2i) #complex
  v6 <- charToRaw("Hello") #raw
  v7 <- c(6,"data", 22.5, TRUE)
  #Question: v7 <- c("data", 22.5, TRUE) What will be the type of v7?
  typeof(v7)
  #Get the length of a vector
  length(v3)
  #Extracting elements
  #(1)
  #Positive integers return elements at the specified positions (even if duplicate):
  #=================================================================================
  v1 <- c(10, 20, 30, 40, 50, 60)
  v1[2]
  v1[c(2,4)]
  v1[c(4,4)]
  v1[2:5]
  v1[5:2]
  v1[c(2.2,3.6)]  #Real numbers are silently truncated to integers.
  #(2)
  #Negative integers omit elements at the specified positions:
  #============================================================
  v1 <- v1[-3]
  v1
  v1[-c(2,1)]
  v1
  #(3)
  #Logical Vectors
  #=================
  v1 <- c(1,2,3,4.5,3,2)
  v1>2
  v1==2
  v1!=2
  v1[v1>2]
  2%in%v1
  9%in%v1
  #If the logical vector is shorter than the vector being subsetted,
  #it will be recycled to be the same length.
  v1[v3]
  v2[v3]
  #(4) Sorting vectors and displaying information
  #=============================================
  #Sort elements.
  sort(v1)    
  sort(v1, decreasing = TRUE)  #Seek help for sort.int for example 
  #Display vectors' information 
  str(v1)
  #Display summary of vectors (mean, median, min, max, 1st and 3rd quartiles)
  summary(v1)
  #(5)Assignment and vector manipulation
  v4 <- v1[c(2,4)]
  v1[3] -> v5
  v6 = v4 + 2
  v7 <- v1+v4  #broadcasting
  v7
  #--------------------------------------------------------------------------------#
  #(5)Factors
  #============================================
  f <- factor(v1)
  f 
  v8 <- c(v2, "car", "plane")
  factor(v8)
  
  #(6)lists
  #============================================
  list1 <- list(2,'car',TRUE)
  list1
  list1[[2]]
  #Notice the difference
  list2 <- c(2,'car',TRUE)
  list2
  l <- list(v1,v2)
  l
  summary(l[[1]])
  str(l)
  l[1]
  l[2]
  l[[1]]
  l[[2]][2]
  #Structured Data Types
  #============================================
  #(7) Matrix 
  #============
  cells <- seq(10,80,by=10)
  rnames <- c("R1", "R2","R3")
  cnames <- c("C1", "C2","C3") 
  mymatrix <- matrix(cells, nrow = 3, ncol = 3, byrow =TRUE, dimnames = list(rnames, cnames))
  mymatrix
  #second column
  mymatrix[,2]
  #or equivalently
  mymatrix[,"C2"]
  #second and third column
  mymatrix[,c("C2","C3")]
  #first row
  mymatrix[1,]
  #all matrix except second row
  mymatrix[-2,]
  mymatrix[1,-3]
  #--------------------------------------------------------------------------------#
  #(8) IMPORTANT: Data Frames
  #============================
  d <- c(1,2,3,4,4,4)
  e <- c("red", "white", "red", NA,"red","red")
  f <- c(TRUE,TRUE,TRUE,FALSE,FALSE,NA)
  mydata <- data.frame(d,e,f)
  mydata
  colnames(mydata) <- c("ID","Color","Passed") # variable names
  mydata
  
  # identify elements in data frames 
  mydata[1,] #extract first row of the data frame
  mydata[2] #extract the second column
  mydata[2:3] # columns 2,3 of data frame
  mydata[c("ID","Color")] # columns ID and color from data frame
  
  mydata$ID # variable ID in the data frame
  mydata$Passed # variable Passed in the data frame
  
  #Subsetting the dataframe based on one or more conditions.
  subdfm<- subset(mydata, ID <= 3, select=c(ID,Color))
  subdfm
  
  subdfm<- subset(mydata, ID <= 3 & Color == 'red', select=c(ID,Color))
  subdfm
  #Can we write it in another way?
  mydata[mydata$ID <= 3, c('ID', 'Color')]
  with(mydata, mydata[ID<=3, c('ID','Color')])
  
  #(9) IMPORTANT: Tables 
  #=======================
  #Create contingency table
  t<- table(mydata$ID)
  t
  table(mydata$Color, mydata$Passed)
  table(mydata$Color, mydata$Passed, mydata$ID)
  #(10)
  #===============================================================
  #Testing arguments whether they belong to a certain class or not
  is.matrix(mymatrix)
  is.list(mymatrix)
  is.matrix(list1)
  is.list(list1)
  #Attempting to turn arguments into certain classes
  mymatrix
  vectorizedMatrix <- as.vector(mymatrix)
  vectorizedMatrix
  
  #(11)
  #Importing data from csv files and reading data into a data frame
  #================================================================
  dfm <- read.csv("forestfires.csv")
  dfm$X
  #get dimensions of data frame
  dim(dfm)
  nrow(dfm)
  ncol(dfm)
  #visualize some of the data
  head(dfm)
  tail(dfm)
  summary(dfm)
  table(dfm$month)
  table(dfm$month, dfm$day)
  #--------------------------------------------------------------------------------#
  #examples of importing files 
  #text files 
  dftxt <- read.table("testfile.txt",header = FALSE)
  dftxt
  #from csv file 
  dfcsv <- read.csv("csvone.csv",header = TRUE)
  dfcsv
  #--------------------------------------------------------------------------------#
  #(12)Graphical and Statistical Functions
  #=======================================
  #Graphical functions 
  v1 <- c(1,2,3,3.6,4.5,2,3) #numeric
  plot(v1, type="b")  #Check the type of plot
  #There are many plots that can be drawn: pie chart, bar plot, box and whisker plot. 
  #Check them. 
  hist(v1)
  #Statistical functions
  mean(v1)
  median(v1)
  sd(v1)
  var(v1)
  #--------------------------------------------------------------------------------#
  #(13)Functions
  #=============
  #Function to calculate the Euclidean distance between two 2D points.
  euclideanDistance <- function(x,y) sqrt((x[1] - x[2])^2 + (y[1] - y[2])^2)
  euclideanDistance(c(2,3), c(4,5))
  #--------------------------------------------------------------------------------#
  #(14) Flow control statements
  #=============================
  names <- c('Ali', 'Hussein', 'Ahmed')
  if ('Ali' %in% names) {
    print('Ali exists')
  } else if ('Hussein' %in% names) {  #Note that you should write the closing braces together with else if keyword on the same line
    print('Hussein exists')
  } else { 
    print('Neither Ali nor Hussein exists')
  }
  
  for (name in names)
    print(name)
  #--------------------------------------------------------------------------------#
  #(15)String Manipulation
  #=======================
  paste(names[1], names[2], names[3])
  paste(names[1], names[2], names[3],  sep= "+")
  toupper(names[1])
  tolower(names[2])
  
  