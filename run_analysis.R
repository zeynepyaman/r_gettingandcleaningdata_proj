##Coursera Getting and Cleaning Data Course Project

#Loading necessary libraries
library(data.table)
library(dplyr)

#Downloading and unzipping the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipped_file <- "UCI_HAR_Dataset.zip"
data_dir <- "UCI HAR Dataset"

if (!file.exists(zipped_file)) {
  download.file(url, zipped_file, method = "curl")
}

if (!file.exists(data_dir)) {
  unzip(zipped_file)
}

#Reading activity labels and features
activity_labels <- read.table(file.path(data_dir, "activity_labels.txt"), col.names = c("activityId", "activityType"))
features <- read.table(file.path(data_dir, "features.txt"), col.names = c("featureId", "featureName"))

#Reading training and test data
subject_train <- read.table(file.path(data_dir, "train", "subject_train.txt"), col.names = "subjectId")
x_train <- read.table(file.path(data_dir, "train", "X_train.txt"))
y_train <- read.table(file.path(data_dir, "train", "y_train.txt"), col.names = "activityId")

subject_test <- read.table(file.path(data_dir, "test", "subject_test.txt"), col.names = "subjectId")
x_test <- read.table(file.path(data_dir, "test", "X_test.txt"))
y_test <- read.table(file.path(data_dir, "test", "y_test.txt"), col.names = "activityId")

#Merging training and test sets into one
subject_data <- rbind(subject_train, subject_test)
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)

merged_data <- cbind(subject_data, y_data, x_data)

#Naming columns in x_data with original feature names
colnames(merged_data)[3:ncol(merged_data)] <- features$featureName

#Selecting only mean() and std() features
selected_features <- grepl("mean\\(\\)|std\\(\\)", features$featureName)
selected_columns <- c("subjectId", "activityId", features$featureName[selected_features])
tidy_data <- merged_data[, selected_columns, drop = FALSE]

#Adding activity names
tidy_data <- merge(tidy_data, activity_labels, by = "activityId")

#Creating a tidy dataset with the average of each variable
final_tidy_data <- tidy_data %>%
  group_by(subjectId, activityType) %>%
  summarise(across(where(is.numeric), mean))

#Writing tidy data set to a file
write.table(final_tidy_data, "tidy_data.txt", row.name = FALSE)


