# This script analyzes data from the Human Activity Recognition
# Using Smartphones study.
# Assumes UCI HAR Dataset folder is stored in same directory as run_analysis.R.

library(data.table)
library(dplyr)
library(tidyr)

# --------------------------------------------------------------------------- #
# 1. Merge training and test sets to create one data set.

# Checks if train and test data have already been combined. If not, 
# imports and rbinds them.
if(!exists("xdata")) {
    xtest <- fread('./UCI HAR Dataset/test/X_test.txt', header = FALSE)
    xtrain <- fread('./UCI HAR Dataset/train/X_train.txt', header = FALSE)
    xdata <- rbind(xtest, xtrain)
    rm(xtest)
    rm(xtrain)
    
    # Imports features.txt and assigns feature names as xdata column headers.
    features <- fread('./UCI HAR Dataset/features.txt', header = FALSE)
    features <- make.names(features$V2, unique = TRUE)
    colnames(xdata) <- features
}

# Imports and cbinds y_* (activities) and subject_* (subjects) 
ytest <- fread('./UCI HAR Dataset/test/y_test.txt', header = FALSE)
ytrain <- fread('./UCI HAR Dataset/train/y_train.txt', header = FALSE)
ydata <- rbind(ytest, ytrain)
colnames(ydata) <- c("activityid")
obs <- cbind(ydata, xdata)
rm(ytest)
rm(ytrain)

subtest <- fread('./UCI HAR Dataset/test/subject_test.txt', header = FALSE)
subtrain <- fread('./UCI HAR Dataset/train/subject_train.txt', header = FALSE)
subdata <- rbind(subtest, subtrain)
colnames(subdata) <- "subjectid"
obs <- cbind(subdata, obs)
rm(subtest)
rm(subtrain)


# --------------------------------------------------------------------------- #
# 2. Extract only the measurements on the mean and standard deviation
#    for each measurement

obs_mean_sd <- select(obs, subjectid, activityid, matches("(mean\\.\\.|std\\.\\.)"))


# --------------------------------------------------------------------------- #
# 3. Use descriptive activity names to name the activities in the data set

acts <- fread('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
colnames(acts) <- c("activityid", "activity")
obs_mean_sd <- obs_mean_sd %>% 
                merge(acts, by = "activityid") %>%
                select(subjectid, activityid, activity, everything())


# --------------------------------------------------------------------------- #
# 4. Appropriately label the data set with descriptive variable names

# colnames(obs_mean_sd) <- gsub("..", "", names(obs_mean_sd), fixed = TRUE)


# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.