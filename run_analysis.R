## This script merges, cleans, and analyzes data contained in eight datasets 
## (X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, 
## subject_test.txt, features.txt, activity_labels.txt) that were created by 
## researchers measuring human activity levels using Samsung Galaxy S II smartphones.

## The datasets come from the website 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## final output of this script is a single data set containing the average for
## each mean and standard deviation for each variable measured in the original
## datasets, grouped by subject and activity type.

## This script requires the dplyr library in R.

library(dplyr)

## read seven of the data sets into R and combine them into one dplyr table

labels <- read.table("features.txt", header = FALSE, colClasses = "character", 
                     encoding = "UTF-8")
labels <- select(labels, V2)
cnames <- as.vector(labels$V2)

testsubs <- read.table("subject_test.txt", header = FALSE, colClasses = "numeric")
testsubs <- rename(testsubs, subject = V1)

testacts <- read.table("y_test.txt", header = FALSE, colClasses = "numeric")
testacts <- rename(testacts, activity = V1)

testdat <- read.table("X_test.txt", header = FALSE, colClasses = "numeric")

test <- cbind (testsubs, testacts, testdat)

trainsubs <- read.table("subject_train.txt", header = FALSE, colClasses = "numeric")
trainsubs <- rename(trainsubs, subject = V1)

trainacts <- read.table("y_train.txt", header = FALSE, colClasses = "numeric")
trainacts <- rename(trainacts, activity = V1)

traindat <- read.table("X_train.txt", header = FALSE, colClasses = "numeric")

train <- cbind (trainsubs, trainacts, traindat, stringsAsFactors = FALSE)

comp <- rbind(train, test, stringsAsFactors = FALSE)

cnames <- c("Subject", "ActivityCode", cnames)

colnames(comp) <- cnames

comptbl <- tbl_df(comp)

rm(test, testacts, testdat, testsubs, train, trainacts, traindat, trainsubs, labels, 
   cnames, comp)

## extract only the mean and standard deviation for each measurement

slim <- comptbl[, c(1, 2, grep("mean()", colnames(comptbl), fixed=TRUE), grep("std()", 
                    colnames(comptbl), fixed = TRUE))]

rm(comptbl)

## convert the values in the activity column to descriptive activity names using
## the file "activity_labels.txt" to provide the descriptions

acts <- read.table("activity_labels.txt", header = FALSE, colClasses = "character")
acts$V2 <- sub("_", " ", acts$V2, fixed = TRUE)
colnames(acts) <- c("ActivityCode", "Activity")

slim$ActivityCode <- as.character(slim$ActivityCode)

slimmod <- left_join(slim, acts, by="ActivityCode")

rm(slim, acts)

## label the data set with descriptive variable names and remove special characters
## that would prevent the use of certain dplyr functions

varnames <- colnames(slimmod)

varnames <- sub("mean()", "Mean", varnames, fixed = TRUE)
varnames <- sub("std()", "Std", varnames, fixed = TRUE)

varnames <- sub("-X", "Xaxis", varnames, fixed = TRUE)
varnames <- sub("-Y", "Yaxis", varnames, fixed = TRUE)
varnames <- sub("-Z", "Zaxis", varnames, fixed = TRUE)
varnames <- sub("-", "", varnames, fixed = TRUE)

varnames <- sub("^f", "Frequency", varnames)
varnames <- sub("^t", "Time", varnames)
varnames <- sub("BodyBody", "Body", varnames, fixed = TRUE)
varnames <- sub("BodyGyro", "Gyro", varnames, fixed = TRUE)

colnames(slimmod) <- varnames

rm(varnames)

slimmod <- select(slimmod, Subject, Activity, 
    TimeBodyAccMeanXaxis:FrequencyGyroJerkMagStd)

## create a second data set with the average of each variable for each activity
## and each subject and write it to the file "tidy.txt"

tidier <- group_by(slimmod, Subject, Activity)

tidiest <-summarise_each(tidier, funs(mean), 
        TimeBodyAccMeanXaxis:FrequencyGyroJerkMagStd)

tidiest <- tidiest[2:181,]

write.table(tidiest, file = "means.txt", row.name = FALSE)
