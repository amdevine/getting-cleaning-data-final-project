### Getting and Cleaning Data Final Project

# Code Book

## Original Dataset

Observations were randomly assigned to `test` and `train` folders within `UCI HAR Dataset`. For the purposes of this analysis, no distinction between `test` and `train` was made and the datasets were combined.

Within the `test` and `train` folders:

- `subject_train.txt` and `subject_test.txt`: Contain the ID number of the subject conducting the activity. Values from 1-30. 10,299 integer (categorical) values total.

- `y_train.txt` and `y_test.txt`: Contain the ID number of the activity being performed. Values from 1-6. ID numbers correspond to activities as defined by `activity_labels.txt` found in the root UCI HAR Dataset folder. 10,299 integer (categorical) values total.

- `X_train.txt` and `X_test.txt`: Contain vectors of 561 features calculated for each observation made. Feature labels for each vector can be found in `features.txt` found in the root UCI HAR Dataset folder. 10,299 vectors containing 561 double values each.

## Data Transformations

1. `test` and `train` datasets were combined for each of the three files: `subject_*.txt`, `y_*.txt`, and `X_*.txt`. In each case, the train dataset was appended onto the end of the test dataset.

2. Labels were applied to the feature vector dataset by reading `features.txt` and matching labels positionally. The `make.names()` R function was applied to the feature names, which modified names to prevent duplication and changed all nonstandard characters (such as `()`) into acceptable column name characters.

3. Subject IDs and activity IDs were matched to corresponding feature vectors positionally.

4. Activity names were joined to each observation by matching activity ID numbers from `activity_labels.txt`. Activity ID numbers were subsequently dropped from the dataset.

5. Feature vectors were filtered so that only columns containing means and standard deviations were retained.

6. The dataset was reshaped using `tidyr::gather()`. Each observation consisted of the subject ID, the activity, the measurement being taken (e.g. fBodyAcc.mean.X), and the value for that measurement.

7. The data were grouped (`dplyr::group_by()`) by subject ID, activity type, and measurement type.

8. The data were summarized (`dplyr::summarize()`) to find the mean measurement value for the subject ID, activity type, and measurement type.

9. The data were reshaped using `tidyr::spread()`. Each observation consisted of the subject ID, the activity, and every measurement type. The values for the measurement types were the mean values for that measurement type by subject and activity.

## Summary Dataset

File: `avg_mean_sd_per_subject_activity.txt`

| | |
| --- | --- |
| Column 1 | **subjectid** |
| Name | Test Subject ID |
| Description | The ID of the subject performing the activity. |
| Data Type | integer (categorical) |
| Values | 1-30 |

| | |
| --- | --- |
| Column 2 | **activity** |
| Name | Activity |
| Description | Activity performed by Test Subject |
| Data Type | categorical |
| Values | <ul><li>WALKING</li><li>WALKING_UPSTAIRS</li><li>WALKING_DOWNSTAIRS</li><li>SITTING</li><li>STANDING</li><li>LAYING</li></ul> |

| | |
| --- | --- |
| Columns 3-69 | **Measurement means and standard deviations** |
| Description | Contain mean values and standard deviations for measurements derived from accelerometer and gyroscope data, for each test subject and each activity. Values are means of means and means of standard deviations for each of the types of measurement. For further details, refer to `features_info.txt` in UCI HAR Dataset. |
| Data Type | double |
| Columns | <ol start="3"><li>angle.tBodyAccJerkMeangravityMean.</li><li>fBodyAcc.mean.X</li><li>fBodyAcc.mean.Y</li><li>fBodyAcc.mean.Z</li><li>fBodyAcc.std.X</li><li>fBodyAcc.std.Y</li><li>fBodyAcc.std.Z</li><li>fBodyAccJerk.mean.X</li><li>fBodyAccJerk.mean.Y</li><li>fBodyAccJerk.mean.Z</li><li>fBodyAccJerk.std.X</li><li>fBodyAccJerk.std.Y</li><li>fBodyAccJerk.std.Z</li><li>fBodyAccMag.mean</li><li>fBodyAccMag.std</li><li>fBodyBodyAccJerkMag.mean</li><li>fBodyBodyAccJerkMag.std</li><li>fBodyBodyGyroJerkMag.mean</li><li>fBodyBodyGyroJerkMag.std</li><li>fBodyBodyGyroMag.mean</li><li>fBodyBodyGyroMag.std</li><li>fBodyGyro.mean.X</li><li>fBodyGyro.mean.Y</li><li>fBodyGyro.mean.Z</li><li>fBodyGyro.std.X</li><li>fBodyGyro.std.Y</li><li>fBodyGyro.std.Z</li><li>tBodyAcc.mean.X</li><li>tBodyAcc.mean.Y</li><li>tBodyAcc.mean.Z</li><li>tBodyAcc.std.X</li><li>tBodyAcc.std.Y</li><li>tBodyAcc.std.Z</li><li>tBodyAccJerk.mean.X</li><li>tBodyAccJerk.mean.Y</li><li>tBodyAccJerk.mean.Z</li><li>tBodyAccJerk.std.X</li><li>tBodyAccJerk.std.Y</li><li>tBodyAccJerk.std.Z</li><li>tBodyAccJerkMag.mean</li><li>tBodyAccJerkMag.std</li><li>tBodyAccMag.mean</li><li>tBodyAccMag.std</li><li>tBodyGyro.mean.X</li><li>tBodyGyro.mean.Y</li><li>tBodyGyro.mean.Z</li><li>tBodyGyro.std.X</li><li>tBodyGyro.std.Y</li><li>tBodyGyro.std.Z</li><li>tBodyGyroJerk.mean.X</li><li>tBodyGyroJerk.mean.Y</li><li>tBodyGyroJerk.mean.Z</li><li>tBodyGyroJerk.std.X</li><li>tBodyGyroJerk.std.Y</li><li>tBodyGyroJerk.std.Z</li><li>tBodyGyroJerkMag.mean</li><li>tBodyGyroJerkMag.std</li><li>tBodyGyroMag.mean</li><li>tBodyGyroMag.std</li><li>tGravityAcc.mean.X</li><li>tGravityAcc.mean.Y</li><li>tGravityAcc.mean.Z</li><li>tGravityAcc.std.X</li><li>tGravityAcc.std.Y</li><li>tGravityAcc.std.Z</li><li>tGravityAccMag.mean</li><li>tGravityAccMag.std</li></ol> |

