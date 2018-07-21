# Getting and Cleaning Data Course Project
# Author: Amrit Singh Rana
# Date: 21-07-2018
# File: run_analysis.R
# 
# Purpose:-
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
library(data.table)

# Downloading and unzipping the data files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")

unzip(zipfile = "data.zip")

# Reading activity labels and features
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("sno", "activity_label"))
features <- fread("UCI HAR Dataset/features.txt", col.names = c("sno", "feature_name"))

# Extracting mean and stadard deviation measurements from the variables
features_to_be_used_indices <- grep(pattern = "mean|std",x = features$feature_name)
features_to_be_used_names <- as.character(features[features_to_be_used_indices,feature_name])

# Reading and labelling training data - only the required variables
training_data <- fread("UCI HAR Dataset/train/X_train.txt", col.names = features_to_be_used_names, select = features_to_be_used_indices)
training_activities <- fread("UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))
training_subjects <- fread("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))

# Joining activity, subject and other training data to create complete training dataset
training_dataset <- cbind(training_data, training_activities, training_subjects)

# Reading and labellling test data - only the required varibles
test_data <- fread("UCI HAR Dataset/test/X_test.txt", col.names = features_to_be_used_names, select = features_to_be_used_indices)
test_activities <- fread("UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))
test_subjects <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))

# Joining activity, subject and other test data to create complete test dataset
test_dataset <- cbind(test_data, test_activities, test_subjects)

# Merging training and test dataset to create one merged data set
merged_data <- rbind.data.frame(training_dataset, test_dataset)

# Replacing activity index with activity name (from the activity_labels data), and factorizing the data
merged_data$activity <- factor(merged_data$activity, labels = activity_labels$activity_label, levels = activity_labels$sno)

# Factorizing subject indices
merged_data$subject <- as.factor(merged_data$subject)

# Grouping the dataset by subject and activity
grouped_merged_data <- group_by(merged_data, activity, subject)

# Calculating mean of each variable for each acitivity-subject pair
summarized_data <- summarize_all(grouped_merged_data, mean)

# Writing the tidied data to a file at current working directory
data.table::fwrite(x = summarized_data, file = "tidy_dataset.txt")