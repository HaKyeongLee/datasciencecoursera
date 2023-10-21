#   Getting and Cleaning Data Project 
#   Author: Ha Kyeong Lee

#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#   Download and Unzip the File
setwd("~/datasciencecoursera")
fileUrl <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(fileUrl, destfile="dataset.zip")
unzip("dataset.zip")

#   Read data from the filees into the variables
activityTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
activityTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt")
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt")

#   Merges the training and test sets by rows
subjectDT <- rbind(subjectTest, subjectTrain)
activityDT <- rbind(activityTest, activityTrain)
featuresDT <- rbind(featuresTest, featuresTrain)

#   Set names to variables
names(subjectDT) <- c("subject")
names(activityDT) <- c("activity")
featuresLabel <- read.table("UCI HAR Dataset/features.txt")
names(featuresDT) <- featuresLabel$V2

#   Merge columns to get DT for all data
mergedDT <- cbind(featuresDT, subjectDT, activityDT)

#   Subset names of features by measurements on the mean and s.d. 
featuresLabel <- featuresLabel$V2[grep("mean\\(\\)|std\\(\\)", featuresLabel$V2)]

#   Subset the merged data by selected names of featurees
selectedNames<-c(as.character(featuresLabel), "subject", "activity" )
mergedDT <- subset(mergedDT, select=selectedNames)

#   Uses descriptive activity names to name the activities in the data set
mergedDT$activity[which(mergedDT$activity == 1)] ="WALKING"
mergedDT$activity[which(mergedDT$activity == 2)] ="WALKING_UPSTAIRS"
mergedDT$activity[which(mergedDT$activity == 3)] ="WALKING_DOWNSTAIRS"
mergedDT$activity[which(mergedDT$activity == 4)] ="SITTING"
mergedDT$activity[which(mergedDT$activity == 5)] ="STANDING"
mergedDT$activity[which(mergedDT$activity == 6)] ="LAYING"

#   Appropriately labels the data set with descriptive variable names. 
#     1. Prefix t is replaced by time
#     2. Prefix f is replaced by freq
#     3. BodyBody is replaced to Body
names(mergedDT)
names(mergedDT) <- gsub("^t", "time", names(mergedDT))
names(mergedDT) <- gsub("^f", "freq", names(mergedDT))
names(mergedDT) <- gsub("BodyBody", "Body", names(mergedDT))

#   Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#     1. Sort the variables.
#     2. Set subject as a factor variable
#     3. Get averages
mergedDT$subject <- as.factor(mergedDT$subject)
tidyDT <- aggregate(. ~subject + activity, tidyDT, mean)
tidyDT <- tidyDT[order(tidyDT$subject, tidyDT$activity), ]
write.table(tidyDT, file="tidy_data.txt", row.names=FALSE)
