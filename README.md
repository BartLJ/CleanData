# CleanData
Coursera Getting and Cleaning Data Course Project

This github repository holds an assignment for the Coursera project that can be found on https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project.

## Data sources
The original data sources have to be downloaded and unzipped from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and the "UCI HAR Dataset" directory has to be set as the working directory for the run_analysis.R script to function properly, retaining the original directory structure.

## Script
The script "run_analysis.R" executes following steps:
* it merges the 6 training and test set files into 1 data set
* for all measurements in the data set, it only retains the mean and standard deviation
* it replaces the numeric activity ids with descriptive labels as found in the activity_labels.txt file
* it transforms the cryptic variable names with descriptive names
* it calculates the mean of all retained variables by activity and subject, exports the final data set to the file "data_summary.txt" and invokes a Data Viewer on it
