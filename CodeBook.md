# Getting and Cleaning Data Course Project

## Author
Amrit Singh Rana

## Source of data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description of data
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R file performs the following transformations on the 
data:

1. Downloads the zip from the source
2. Unzips the file to extract data
3. Reads the featues and activity_labels (Features to attach relevant 
variable names to the data and activity_labels to map activity names to 
activity number)
4. Extracts only mean and standard deviation features (variables) from 
the features
5. Reads training and test data, extracts only the relevant features and 
names the variables meaningfully
6. Maps activity labels (activity names) to activity numbers in the test 
and training data
7. Merges activity and training data to one single dataset
8. Groups the merged dataset by activity and subject
9. Computes mean values for each variable for each acitivity-subject 
pair.
10. Writes the above created dataset to the current working directory by 
the name "tidy_dataset.txt"
