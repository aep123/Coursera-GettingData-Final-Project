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
I created the tidy.txt file by creating an R script called run_analysis.R to merge, clean, and analyze data from eight files contained in the raw data described above, which were:  

  * X\_train.txt           main training dataset, containing the 561-element data vectors
  * Y\_train.txt           activity code for each row in the training data set
  * subject\_train.text    subject for each row of the training data set
  * X\_test.txt            main test dataset, containing the 561-element data vectors
  * Y\_test.txt            activity code for each row in the test data set
  * subject\_test.txt      subject for each row of the test data set
  * features.txt           list of the variables in the vector for each window
  * activity\_labels.txt   table of activity codes and their corresponding activities  
  * 
The cleaning script requires the dplyr package. Since the data frames created by the files above were so large and I was working on an older personal desktop computer, the script removes all the temporary data frames it creates in order to save computer memory.  

More details on the script and how it runs can be found at https://github.com/aep123/Coursera-GettingData-Final-Project/blob/master/README.md.  

##Overview of the tidy.txt file  
The final tidy.txt file is a text file with 180 rows of data - one row for each subject and each activity (30 subjects x 6 activities). Each row contains a vector of 68 variables.  The first two values in the vector provide subject and activity type, and the remaining 66 variables provide the averages of all mean and standard deviation calculations provided in the raw data files for that subject and activity type.  

##Variables in the tidy.txt file  
###Subject  (class = numeric)  
Each subject in the dataset is represented by a number between 1 and 30.   

###Activity (class = character)  
Each activity in the dataset is described simply with one or two words. The six activities represented in the dataset are laying, sitting, standing, walking, walking downstairs, and walking upstairs.  

###Calculated variables (class = numeric)  
The remaining 66 variables in the dataset are the averages of multiple values contained in the raw data files.  The original files did not provide any units of measurement for these variables.  A key to the variable names follows.  

  * Time, Frequency - indicate whether the variable is for time or frequency domain signals
  * BodyAcceleration, GravityAcceleration - represent the two calculated components (body and gravity) derived from the raw accelerometer signals
  * Gyro - denotes calculation is derived from a gyroscope measurement
  * Jerk - for variables that calculate rate of change of acceleration
  * Magnitude - the magnitude of the three-dimensional signal, calculated using Euclidean norm
  * Mean, StandardDeviation - denotes mean or standard deviation calculation for a given variable
  * X,Y,Z - denotes the axis (X, Y, or Z) being measured by either the accelerometer (measures acceleration along the axis) or gyroscope (measures rotation around the axis)  

_for example: the variable 'TimeGyroJerkStandardDeviationXaxis' is a calculation of the average standard deviation for Jerk (change in acceleration) for the gyroscope along the x axis in the time domain._  

_second example: the variable 'FrequencyBodyAccelerationMagnitudeMean' is a calculation of the average magnitude mean for body acceleration in the frequency domain._  

Additional information on the variables and how they were obtained can be found in the README and features_info.txt files from the original dataset.  

##Sources  
The raw dataset was compiled by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto; Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova, Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws
