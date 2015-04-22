---
title: "Getting Data-013 Final Project"
author: "Amy E. Phelan"
date: "14 Apr 2015"
---
 
## Project Description
  Course project for Getting and Cleaning Data (session getdata-013), objective is to create and process, using tools in R, a tidy data set from data collected from Samsung Galaxy S II smartphone accelerometers carried by 30 test subjects performing six different activities.  The final product is a tidy data set that contains averages for all the mean and standard deviations computed in the initial data sets, grouped by subject and activity.
 
##Study design and data processing
The study objective was to create a data set that could be used for machine learning for human activity recognition, using subjects who performed six different activities while carrying Samsung Galaxy S II smartphones on their waists. Thirty volunteers participated in the study and measurements from the accelerometers and gyroscopes on the phones were taken.  
  
The study designers pre-processed the raw data with noise filters and sampled it in fixed-width sliding windows. The sensor acceleration signal was further processed into separate body acceleration and gravity measurements.  The study authors then calculated a vector of 561 variables for each window, and split the data into two unequal sets, a large training set and a smaller test set. 
  
Additional details on the data processing performed by the study designers can be found in the README file contained with the data download (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

###Collection of the raw data
I downloaded the study dataset in .zip format from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and extracted the files using the Windows 7 unzip tool.
 
###Notes on the original (raw) data 
Original raw data contained a training data set of size 62.9 MB (containing data on the activities of 21 volunteers) and a training data set of size 25.2 MB (containing data on the activities of 9 volunteers), both in .txt format. Dataset labels and information on test subjects were contained in separate .txt files, as was a README document containing basic information on the data sets and how they were created. 

The download also contained raw inertial signals files, but I elected not to use them as they did not contain any data that was useful for the assignment.
 
##Creating the tidy datafile

I created the means.txt file by creating an R script called run_analysis.R to merge, clean, and analyze data from eight files contained in the raw data described above, which were:  

* X\_train.txt           main training dataset, containing the 561-element data vectors
* Y\_train.txt           activity code for each row in the training data set
* subject\_train.text    subject for each row of the training data set
* X\_test.txt            main test dataset, containing the 561-element data vectors
* Y\_test.txt            activity code for each row in the test data set
* subject\_test.txt      subject for each row of the test data set
* features.txt           list of the variables in the vector for each window
* activity\_labels.txt   table of activity codes and their corresponding activities

The cleaning script requires the dplyr package. Since the data frames created by the files above were so large and I was working on an older personal desktop computer, the script removes all the temporary data frames it creates in order to save computer memory.

More details on the script and how it runs can be found at https://github.com/aep123/Coursera-GettingData-Final-Project/blob/master/README.md.
 
##Overview of the means.txt file

The final means.txt file is a text file with 180 rows of data - one row for each subject and each activity (30 subjects x 6 activities). Each row contains a vector of 68 variables.  The first two values in the vector provide subject and activity type, and the remaining 66 variables provide an average for each mean and standard deviation calculation provided in the raw data files.   

##Variables in the means.txt file

####Subject  (class = numeric)
Each human subject in the dataset is represented by a number between 1 and 30. 

####Activity (class = character)
Each activity in the dataset is described simply with one or two words. The six activities represented in the dataset are laying, sitting, standing, walking, walking downstairs, and walking upstairs.

####TimeBodyAccMeanXaxis
####TimeBodyAccMeanYaxis
####TimeBodyAccMeanZaxis (class = numeric)

These variables hold the average means for body acceleration (BodyAcc) in the time (Time) domain along the X, Y, and Z axes respectively.  Body acceleration itself is a calculated field that is derived by splitting an acceleration signal from the accelerometers into its component gravity and body (ie human-subject-generated) acceleration signals.

####TimeGravityAccMeanXaxis
####TimeGravityAccMeanYaxis
####TimeGravityAccMeanZaxis (class = numeric)

These variables contain the average means for gravity acceleration (GravityAcc) in the time (Time) domain along the X, Y, and Z axes. As noted immediately above, gravity acceleration is a calculated field derived by splitting a raw acceleration signal from the accelerometers in the smartphones worn by the subjects. 

####TimeBodyAccJerkMeanXaxis
####TimeBodyAccJerkMeanYaxis
####TimeBodyAccJerkMeanZaxis (class = numeric)

These variables contain the average means for jerk (Jerk), also known as the rate of change of acceleration, for body acceleration in the time (Time) domain, along the X, Y, and Z axes respectively.

####TimeGyroMeanXaxis
####TimeGyroMeanYaxis
####TimeGyroMeanZaxis (class = numeric)

These variables hold the average means for the speed of rotation (Gyro) around the X, Y, and Z axes respectively in the time (Time) domain. These rates of rotation are themselves calculated from raw signals that come from the gyroscopes in the smartphones worn by the subjects. 

####TimeGyroJerkMeanXaxis
####TimeGyroJerkMeanYaxis
####TimeGyroJerkMeanZaxis (class = numeric) 

These variables contain the average means for rotational jerk (GyroJerk), aka the rate of change of acceleration around the X, Y, and Z axes respectively in the time (Time) domain. The gyrosope jerk mean is a calculated field derived from raw gyroscope signal data.

####TimeBodyAccMagMean
####TimeGravityAccMagMean
####TimeBodyAccJerkMagMean
####TimeGyroMagMean
####TimeGyroJerkMagMean (class = numeric) 

The MagMean variables contain calculated average means for the magnitude (Mag) of the three-dimensional signals for body acceleration (BodyAcc), gravity acceleration (GravityAcc), body acceleration jerk (BodyAccJerk), rotation (Gyro), and rotational jerk (GyroJerk). They are all calculated in the time (Time) domain. 

####FrequencyBodyAccMeanXaxis
####FrequencyBodyAccMeanYaxis
####FrequencyBodyAccMeanZaxis (class = numeric)

These variables hold the average means for body acceleration (BodyAcc) in the frequency (Frequency) domain along the X, Y, and Z axes respectively.  Body acceleration itself is calculated by splitting a signal from the accelerometer into its component gravity and body (ie human-subject-generated) acceleration signals. Calculations in the frequency domain allow for the analysis of signals over a range of frequencies.

####FrequencyBodyAccJerkMeanXaxis
####FrequencyBodyAccJerkMeanYaxis
####FrequencyBodyAccJerkMeanZaxis (class = numeric)

These variables contain the average means for jerk (Jerk), also known as the rate of change of acceleration, for body acceleration in the frequency (Frequency) domain, along the X, Y, and Z axes respectively.

####FrequencyGyroMeanXaxis
####FrequencyGyroMeanYaxis
####FrequencyGyroMeanZaxis (class = numeric)

These variables hold the average means for the speed of rotation (Gyro) around the X, Y, and Z axes respectively in the frequency (Frequency) domain. These rates of rotation are themselves calculated from raw signals that come from the gyroscopes in the smartphones worn by the subjects.

####FrequencyBodyAccMagMean
####FrequencyBodyAccJerkMagMean
####FrequencyGyroMagMean
####FrequencyGyroJerkMagMean (class = numeric)

The MagMean variables contain calculated average means for the magnitude (Mag) of the three-dimensional signals for body acceleration (BodyAcc), body acceleration jerk (BodyAccJerk), rotation (Gyro), and rotational jerk (GyroJerk). They are all calculated in the frequency (Frequency) domain. 

####TimeBodyAccStdXaxis
####TimeBodyAccStdYaxis
####TimeBodyAccStdZaxis (class = numeric)

These variables hold the average standard deviation (Std) for body acceleration (BodyAcc) in the time (Time) domain along the X, Y, and Z axes respectively.  Body acceleration itself is a calculated field that is derived by splitting an signal from the accelerometer into its component gravity and body (ie human-subject-generated) acceleration signals.

####TimeGravityAccStdXaxis
####TimeGravityAccStdYaxis
####TimeGravityAccStdZaxis (class = numeric)

These variables contain the average standard deviation (Std) for gravity acceleration (GravityAcc) in the time (Time) domain along the X, Y, and Z axes. As noted immediately above, gravity acceleration is a calculated field derived by splitting a raw acceleration signal from the accelerometers in the smartphones worn by the subjects. 

####TimeBodyAccJerkStdXaxis
####TimeBodyAccJerkStdYaxis
####TimeBodyAccJerkStdZaxis (class = numeric)

These variables contain the average standard deviation (Std) for jerk (Jerk), also known as the rate of change of acceleration, for body acceleration in the time (Time) domain, along the X, Y, and Z axes respectively.

####TimeGyroStdXaxis
####TimeGyroStdYaxis
####TimeGyroStdZaxis (class = numeric)

These variables hold the average standard deviation (Std) for the speed of rotation (Gyro) around the X, Y, and Z axes respectively in the time (Time) domain. These rates of rotation are themselves calculated from raw signals that come from the gyroscopes in the smartphones worn by the subjects. 

####TimeGyroJerkStdXaxis
####TimeGyroJerkStdYaxis
####TimeGyroJerkStdZaxis (class = numeric) 

These variables contain the average standard deviation (Std) for rotational jerk (GyroJerk), aka the rate of change of acceleration around the X, Y, and Z axes respectively in the time (Time) domain. The gyrosope jerk mean is a calculated field derived from raw gyroscope signal data.

####TimeBodyAccMagStd
####TimeGravityAccMagStd
####TimeBodyAccJerkMagStd
####TimeGyroMagStd
####TimeGyroJerkMagStd (class = numeric) 

The MagStd variables contain calculated average standard deviation (Std) for the magnitude (Mag) of the three-dimensional signals for body acceleration (BodyAcc), gravity acceleration (GravityAcc), body acceleration jerk (BodyAccJerk), rotation (Gyro), and rotational jerk (GyroJerk). They are all calculated in the time (Time) domain. 

####FrequencyBodyAccStdXaxis
####FrequencyBodyAccStdYaxis
####FrequencyBodyAccStdZaxis (class = numeric)

These variables hold the average standard deviation (Std) for body acceleration (BodyAcc) in the frequency (Frequency) domain along the X, Y, and Z axes respectively.  Body acceleration itself is calculated by splitting an acceleration signal from the accelerometers into its component gravity and body (ie human-subject-generated) acceleration signals. Calculations in the frequency domain allow for the analysis of signals over a range of frequencies.

####FrequencyBodyAccJerkStdXaxis
####FrequencyBodyAccJerkStdYaxis
####FrequencyBodyAccJerkStdZaxis (class = numeric)

These variables contain the average standard deviation (Std) for jerk (Jerk), also known as the rate of change of acceleration, for body acceleration in the frequency (Frequency) domain, along the X, Y, and Z axes respectively.

####FrequencyGyroStdXaxis
####FrequencyGyroStdYaxis
####FrequencyGyroStdZaxis (class = numeric)

These variables hold the average standard deviation (Std) for the speed of rotation (Gyro) around the X, Y, and Z axes respectively in the frequency (Frequency) domain. These rates of rotation are themselves calculated from raw signals that come from the gyroscopes in the smartphones worn by the subjects.

####FrequencyBodyAccMagStd
####FrequencyBodyAccJerkMagStd
####FrequencyGyroMagStd
####FrequencyGyroJerkMagStd (class = numeric)

The MagMean variables contain calculated average standard deviation (Std) for the magnitude (Mag) of the three-dimensional signals for body acceleration (BodyAcc), body acceleration jerk (BodyAccJerk), rotation (Gyro), and rotational jerk (GyroJerk). They are all calculated in the frequency (Frequency) domain. 

Additional information on the variables and how they were obtained can be found in the README and features_info.txt files from the original dataset. 
 
##Sources
The raw dataset was compiled by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto; Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova, Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws

www.smartlab.ws
