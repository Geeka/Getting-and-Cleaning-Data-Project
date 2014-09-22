library(plyr)

##Obtain a tidy dataset by setting one variable per column,
## one observation per row and also create a new dataset with average values 
## per group
run_analysis<-function(){
  
  #Activity labels describing the activity for which the readings were taken
  actLabels<-read.table("data/activity_labels.txt",col.names=c("id","name"))
  
  #Features are the various measurement values and computed columns 
  #which are columns of the test and training data
  features<-read.table("data/features.txt",col.names=c("id","name"))
  
  #Step 2
  #We need only the measurements related to mean and median
  #Extracting the columns with mean or std in the feature name
  columns1<-grep("mean",features$name,fixed=F)
  columns2<-grep("std",features$name,fixed=F)
  columns<-c(columns1,columns2)
  
  #The feature names will be the descriptive column names of the 
  #measurements in the test and training data.Therefore
  #special characters like () and - need to be removed to be valid column names
  features$name<-sub("\\(\\)","",features$name)
  features$name<-gsub("\\-","_",features$name)

  
  ##TestData
  
  #Step 4
  #Read the measurement values into R 
  #set the descriptive column names from features
  testdata<-read.table("data/test/X_test.txt",
      header=F,sep="",col.names=features$name)
  
  #Subset the data by extracted mean and std columns
  testdata<-testdata[,columns]
  
  #Read the subject data
  subjTest<-read.table("data/test/subject_test.txt")
  #Add the subject data as a new column to data
  testdata$subject<-unlist(subjTest)
  
  #Read the activity data 
  actTest<-read.table("data/test/Y_test.txt")
  #Add the activity data as a new column to data
  testdata$activity<-unlist(actTest)
  
  ##Training Data

  #Step 4
  #Read the measurement values into R 
  #set the descriptive column names from features
  traindata<-read.table("data/train/X_train.txt",
      header=F,sep="",col.names=features$name)
  
  #Subset the data by extracted mean and std columns
  traindata<-traindata[,columns]
  
  #Read the subject data
  subjTrain<-read.table("data/train/subject_train.txt")
  #Add the subject data as a new column to data
  traindata$subject<-unlist(subjTrain)
  
  #Read the activity data 
  actTrain<-read.table("data/train/Y_train.txt")
  #Add the activity data as a new column to data
  traindata$activity<-unlist(actTrain)
  
  ##Step 1: 
  #Merge the test and training datasets
  
  #Combine the rows of test data and train data into one dataset
  mergeddata<-rbind(testdata,traindata)
  
  #Step 3 
  #Assign the descriptive activity labels instead of numeric values
  #Convert the activity as a factor variable  
  mergeddata$activity<-as.factor(mergeddata$activity)
  levels(mergeddata$activity)<-actLabels$name

  #Step 5
  #Create a new tidy data set 
  #with the average of each variable for each activity and each subject.
  tidydata<-ddply(mergeddata,.(activity,subject),colwise(mean))
  
  #Write the tidy dataset to a file
  write.table(tidydata,file="tidydata.txt",row.names=F)
  
}