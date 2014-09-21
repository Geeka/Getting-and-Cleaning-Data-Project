Cleaning and obtaining a tidy dataset Assignment

The following steps were followed to convert the given raw data into a tidy dataset

Step 1: Merges the training and the test sets to create one data set.
The raw data was read from the files X_test.txt and X_train.txt
Test Dataset and train datasets were populated with this data
Activity data was read from  Y_test.txt and Y_train.txt and added as a column to the above datasets
Subject data was read from subject_test.txt and subject_train.txt and added as a column to the above datasets
Merging of two datasets were done with rbind to create one single dataset

Step 2:Extracts only the measurements on the mean and standard deviation for each measurement.
The columns in the raw data files are described by the data in features.txt.
This file was read and the columns which contained 'mean' and 'std' were extracted using grep 
The raw columns of test and train data were subsetted using the extracted columns from the feature data so we get only the columns related to mean and standard deviation in the output data.

Step 3:Uses descriptive activity names to name the activities in the data set
The activity labels were read from activity_labels.txt.
The new column activity was made a factor and the activity labels assigned to the factor variable so nwe get descriptive names for the activity column of the new dataset

Step 4:Appropriately labels the data set with descriptive variable names.
The raw data contains column names such as V1,V2 ...
To make the column name descriptive,we are reading the column names from features.txt into the test and training datasets

Step5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
This is done using the plyr package ddply and colwise to group the new dataset from step 4 by activity and subject.
Used colwise to compute the mean of every column grouped by the activity and subject variables.
