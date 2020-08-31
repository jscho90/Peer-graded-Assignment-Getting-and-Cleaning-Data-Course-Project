
# Loads required packages
library(dplyr)

# Downloads and unzip the data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/UCI HAR Dataset.zip")
unzip(zipfile="./data/UCI HAR Dataset.zip", exdir="./data")

# Assigns all data to data frames
features <- read.table("./data/UCI HAR Dataset/features.txt", col.names=c("n", "feature"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names=c("code", "activity"))
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names=features$feature)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names=c("code"))
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names=c("subject"))
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names=features$feature)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names=c("code"))

# Merges the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Extracts only the measurements on the mean and standard deviation for each measurement
Tidy_Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Uses descriptive activity names to name the activities in the data set
Tidy_Data$code <- activities[Tidy_Data$code, 2]

# Appropriately labels the data set with descriptive variable names
names(Tidy_Data)[2] = "activity"
names(Tidy_Data) <- gsub("Acc", "Accelerometer", names(Tidy_Data))
names(Tidy_Data) <- gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data) <- gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data) <- gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data) <- gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data) <- gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data) <- gsub("tBody", "TimeBody", names(Tidy_Data))
names(Tidy_Data) <- gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("-std()", "STD", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data) <- gsub("gravity", "Gravity", names(Tidy_Data))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Tidy_Data_Final <- Tidy_Data %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
write.table(Tidy_Data_Final, "Tidy_Data_Final.txt", row.name=FALSE)
