# This script analyzes data from the Human Activity Recognition
# Using Smartphones study. It produces a summary of the means and standard
# deviations for each measurement calculated from each test subject
# and each test activity.

# Assumes UCI HAR Dataset folder is stored in working directory.

library(data.table)
library(dplyr)
library(tidyr)


# --------------------------------------------------------------------------- #
# 1. Merge training and test sets to create one data set.

# Imports feature vector dataset
xtest <- fread('./UCI HAR Dataset/test/X_test.txt', header = FALSE)
xtrain <- fread('./UCI HAR Dataset/train/X_train.txt', header = FALSE)
xdata <- rbind(xtest, xtrain)
rm(xtest)
rm(xtrain)
    
# Imports features.txt and assigns feature names as column headers for feature
# dataset. Modifies column names to prevent duplicates, converts non-name 
# characters into name characters
features <- fread('./UCI HAR Dataset/features.txt', header = FALSE)
features <- make.names(features$V2, unique = TRUE)
colnames(xdata) <- features
rm(features)

# Imports activity IDs and cbinds to feature dataset
ytest <- fread('./UCI HAR Dataset/test/y_test.txt', header = FALSE)
ytrain <- fread('./UCI HAR Dataset/train/y_train.txt', header = FALSE)
ydata <- rbind(ytest, ytrain)
colnames(ydata) <- c("activityid")
obs <- cbind(ydata, xdata)
rm(xdata)
rm(ytest)
rm(ytrain)
rm(ydata)

# Imports subject IDs and cbinds to observations dataset
subtest <- fread('./UCI HAR Dataset/test/subject_test.txt', header = FALSE)
subtrain <- fread('./UCI HAR Dataset/train/subject_train.txt', header = FALSE)
subdata <- rbind(subtest, subtrain)
colnames(subdata) <- "subjectid"
obs <- cbind(subdata, obs)
rm(subtest)
rm(subtrain)
rm(subdata)


# --------------------------------------------------------------------------- #
# 2. Extract only the measurements on the mean and standard deviation
#    for each measurement

obs_mean_sd <- select(obs, subjectid, activityid, 
                      matches("(mean\\.\\.|std\\.\\.)"))
rm(obs)


# --------------------------------------------------------------------------- #
# 3. Use descriptive activity names to name the activities in the data set

# Read activity key-value pairs
acts <- fread('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
colnames(acts) <- c("activityid", "activity")

# Left join observations and activities by activityid columns
obs_mean_sd <- obs_mean_sd %>% 
                merge(acts, by = "activityid") %>%
                select(subjectid, activityid, activity, everything())
rm(acts)


# --------------------------------------------------------------------------- #
# 4. Appropriately label the data set with descriptive variable names

colnames(obs_mean_sd) <- gsub("..", "", names(obs_mean_sd), fixed = TRUE)


# --------------------------------------------------------------------------- #
# 5. Create a second, independent tidy data set with the average of
#    each variable for each activity and each subject.

# Gather observations into one long dataframe.  Group by subjectid, activity,
# and measurementtype, then find the mean. Spread back into a "wide" format.
obs_summary <-  obs_mean_sd %>%
                select(-activityid) %>%
                gather(key="measurementtype", 
                       value="measurementvalue", 
                       -(subjectid:activity)) %>%
                group_by(subjectid, activity, measurementtype) %>%
                summarize(meanvalue = mean(measurementvalue)) %>%
                spread(measurementtype, meanvalue)


# --------------------------------------------------------------------------- #
# Writes summary tiday dataset to a file

write.table(obs_summary, "avg_mean_sd_per_subject_activity.txt", row.name=FALSE)

