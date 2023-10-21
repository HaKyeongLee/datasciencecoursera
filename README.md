## Project Instructions

The purpose of this project is to demonstrate your ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. You will be graded by your peers on a
series of yes/no questions related to the project. You will be required
to submit: 1) a tidy data set as described below, 2) a link to a Github
repository with your script for performing the analysis, and 3) a code
book that describes the variables, the data, and any transformations or
work that you performed to clean up the data called CodeBook.md. You
should also include a README.md in the repo with your scripts. This repo
explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is
wearable computing - see for example this article . Companies like
Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
algorithms to attract new users. The data linked to from the course
website represent data collected from the accelerometers from the
Samsung Galaxy S smartphone. A full description is available at the site
where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

You should create one R script called run\_analysis.R that does the
following.

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation
    for each measurement.
3.  Uses descriptive activity names to name the activities in the data
    set.
4.  Appropriately labels the data set with descriptive variable names.
5.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

## Merges the training and the test set to create one data set.

#### 1. Download and Unzip the File

    setwd("~/datasciencecoursera")
    fileUrl <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
    download.file(fileUrl, destfile="dataset.zip")
    unzip("dataset.zip")

#### 2. Read the Data

Activity Data

    activityTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
    activityTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")

Subject Data

    subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
    subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

Features Data

    featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt")
    featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt")

#### 3. Merges the training and test sets by rows

    subjectDT <- rbind(subjectTest, subjectTrain)
    activityDT <- rbind(activityTest, activityTrain)
    featuresDT <- rbind(featuresTest, featuresTrain) 

#### 4. Set names to variables

    names(subjectDT) <- c("subject")
    names(activityDT) <- c("activity")
    featuresLabel <- read.table("UCI HAR Dataset/features.txt")
    names(featuresDT) <- featuresLabel$V2

#### 5. Merge columns to get DT for all data

    mergedDT <- cbind(featuresDT, subjectDT, activityDT)

## Extracts only the measurements on the mean and standard deviation for each measurement.

#### 1. Subset names of features by measurements on the mean and s.d.

    featuresLabel <- featuresLabel$V2[grep("mean\\(\\)|std\\(\\)", featuresLabel$V2)]

#### 2. Subset the merged data by selected names of features

    selectedNames<-c(as.character(featuresLabel), "subject", "activity" )
    mergedDT <- subset(mergedDT, select=selectedNames)

## Uses descriptive activity names to name the activities in the data set.

    mergedDT$activity[which(mergedDT$activity == 1)] ="WALKING"
    mergedDT$activity[which(mergedDT$activity == 2)] ="WALKING_UPSTAIRS"
    mergedDT$activity[which(mergedDT$activity == 3)] ="WALKING_DOWNSTAIRS"
    mergedDT$activity[which(mergedDT$activity == 4)] ="SITTING"
    mergedDT$activity[which(mergedDT$activity == 5)] ="STANDING"
    mergedDT$activity[which(mergedDT$activity == 6)] ="LAYING"

## Appropriately labels the data set with descriptive variable names.

1.  Prefix t is replaced by time
2.  Prefix f is replaced by freq
3.  BodyBody is replaced to Body

<!-- -->

    names(mergedDT) <- gsub("^t", "time", names(mergedDT))
    names(mergedDT) <- gsub("^f", "freq", names(mergedDT))
    names(mergedDT) <- gsub("BodyBody", "Body", names(mergedDT))

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    mergedDT$subject <- as.factor(mergedDT$subject)
    tidyDT <- aggregate(. ~subject + activity, tidyDT, mean)
    tidyDT <- tidyDT[order(tidyDT$subject, tidyDT$activity), ]
    write.table(tidyDT, file="tidy_data.txt", row.names=FALSE)
