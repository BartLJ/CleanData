# CodeBook for Coursera Getting and Cleaning Data Course Project

## Raw data

The data analyzed in this project is from the Activity Recognition Using Smartphones Data Set as described on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The original data sources have to be downloaded and unzipped from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and the "UCI HAR Dataset" directory has to be set as the working directory for the run_analysis.R script to function properly, retaining the original directory structure.

These data sources also contain an explanation of the different features available.

## The script

The script "run_analysis.R" loads and cleans the raw data sets and calculates the averages of the mean and standard deviations features, grouped by human activity and subject.

## Variables

The script "run_analysis.R" contains following variables:
* data_dir : contains the data directory, which is the root directory of the downloaded and unzipped data source. According to the specifications, it is set to the working directory. This directory should contain e.g. the file 'features.txt'
* train_dir : contains the data directory with training data. This directory should contain e.g. the file 'X_train.txt'
* test_dir : contains the data directory with test data. This directory should contain e.g. the file 'X_test.txt'
* idx_X : a factor-type vector with the feature names represented in X_train.txt and X_test.txt. This vector is read from features.txt

* df_X_train : a data table imported from file X_train.txt with column names from idx_X, containing the raw training features
* df_y_train : a data table imported from file y_train.txt, containing the activity id corresponding to the training features in df_X_train
* df_subject_train : a data table imported from file subject_train.txt, containt the subject id corresponding to the training features in df_X_train
* df_train : a column-wise merge of the data tables df_X_train, df_y_train and df_subject_train

* df_X_test : a data table imported from file X_test.txt with column names from idx_X, containing the raw test features
* df_y_test : a data table imported from file y_test.txt, containing the activity id corresponding to the test features in df_X_test
* df_subject_test : a data table imported from file subject_test.txt, containt the subject id corresponding to the test features in df_X_test
* df_test : a data table which is a column-wise merge of the data tables df_X_test, df_y_test and df_subject_test

* df : a data table which is a row-wise merge of the data tables df_train and df_test

* activities : a data table imported from file activity_labels.txt, which gives the mapping between activity id and the corresponding activity label

* df_summary : a data table which summarizes a subset of data in df (see transformations below). It contains following variables:
    ** activity : the activity label
    ** subject : the subject id
    ** meanof... : the average value of the corresponding raw feature in df, grouped by activity and subject

## Transformations

Following transformations are executed in script run_analysis.R to transform the raw data sets into data set df_summary:

* the 3 raw data tables df_X_train, df_y_train and df_subject_train are merged column-wise into data table df_train
* the 3 raw data tables df_X_test, df_y_test and df_subject_test are merged column-wise into data table df_test
* data tables df_train and df_test are merged row-wise into data table df
* only the measurements on the mean and standard deviation for each measurement are retained in data table df by filtering the columns of this data table which match regular expression "\\.mean\\.|\\.std\\.|activity|subject"
* the activity id in data table df is replaced with the corresponding activity label, by lookup in data table activities
* the variables names in data table df are replaced by their descriptive equivalents as follows:
   * the prefix 't' is removed and replaced by a suffix 'intimedomain'
   * the prefix 'f' is removed and replaced by a suffix 'infrequencydomain'
   * a variable name which describes a mean statistic gets a prefix 'meanof'
   * a variable name which describes a standard deviation statistic gets a prefix 'stdof'
   * the substring 'Acc' is replaced by 'linearacceleration'
   * the substring 'Gyro' is replaced by 'angularvelocity'
   * the substring 'Mag' is replaced by 'magnitude'
   * the faulty repetition 'BodyBody' is replaced by 'Body'
   * all dots are moved from the variable names
   * all variable names are converted to lower case

* the final data table df_summary is created from data table df by grouping on variables activity and subject and calculating the average (mean) of the remaining variables. The feature variable names from data table df are prefixed with 'meanof'
