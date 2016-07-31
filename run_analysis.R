## This script cleans and analyzes data from a Human Activity Recognition Using Smartphones Data Set
## for the Coursera Getting and Cleaning Data Course Project

## first load required libraries
library(utils)
library(dplyr)

## Assumption:
## all data files downloaded from the original data set
## (in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
## are downloaded and unzipped in the working directory, retaining the original directory structure

data_dir  <- getwd()
train_dir <- file.path(data_dir, "train")
test_dir  <- file.path(data_dir, "test")

## Merge the training and the test sets to create one data set
idx_X <- read.table(file.path(data_dir, "features.txt"))[,2]
df_X_train <- tbl_df(read.table(file.path(train_dir, "X_train.txt"), col.names = idx_X))
df_y_train <- tbl_df(read.table(file.path(train_dir, "y_train.txt"), col.names = "activity"))
df_subject_train <- tbl_df(read.table(file.path(train_dir, "subject_train.txt"), col.names = "subject" ))
df_train <- cbind(df_X_train, df_y_train, df_subject_train)

df_X_test <- tbl_df(read.table(file.path(test_dir, "X_test.txt"), col.names = idx_X))
df_y_test <- tbl_df(read.table(file.path(test_dir, "y_test.txt"), col.names = "activity"))
df_subject_test <- tbl_df(read.table(file.path(test_dir, "subject_test.txt"), col.names = "subject" ))
df_test <- cbind(df_X_test, df_y_test, df_subject_test)

df <- rbind(df_train, df_test)

## Extract only the measurements on the mean and standard deviation for each measurement
df <- df %>% select( matches("\\.mean\\.|\\.std\\.|activity|subject") )

## Use descriptive activity names to name the activities in the data set
activities <- read.table(file.path(data_dir, "activity_labels.txt"),
                         row.names = 1,
                         col.names = c("id","activity"),
                         stringsAsFactors = TRUE)
df$activity <- activities[df$activity, 'activity']

## Appropriately label the data set with descriptive variable names

names(df) <- sub('^t(.*)','\\1intimedomain', names(df))
names(df) <- sub('^f(.*)','\\1infrequencydomain', names(df))
names(df) <- sub('(.*)\\.mean\\.(.*)','meanof\\1\\2', names(df))
names(df) <- sub('(.*)\\.std\\.(.*)','stdof\\1\\2', names(df))
names(df) <- gsub('Acc', 'linearacceleration', names(df))
names(df) <- gsub('Gyro', 'angularvelocity', names(df))
names(df) <- gsub('Mag', 'magnitude', names(df))
names(df) <- gsub('BodyBody', 'Body', names(df))
names(df) <- gsub('\\.', '', names(df))
names(df) <- tolower(names(df))

## Create a second, independent tidy data set with the average of each variable for each activity
## and each subject

df_summary <- df %>% group_by(activity, subject) %>% summarize_all(mean)
names(df_summary) <- sub('^(stdof|meanof)','meanof\\1',names(df_summary))

write.table(df_summary, "data_summary.txt", row.names = FALSE)
View(df_summary)