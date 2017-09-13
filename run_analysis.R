
library(dplyr)

setwd("./3-Getting & Cleaning Data/")

#read UCI HAR Dataset
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
# features_info <- read.table("./UCI HAR Dataset/features_info.txt")
# README <- read.table("./UCI HAR Dataset/README.txt")

#read UCI HAR Dataset/test Data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

#read UCI HAR Dataset/train/Internal Signals Data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#read UCI HAR Dataset/test/Internal Signals Data
body_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

#read UCI HAR Dataset/train/Internal Signals Data
body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

#
##
###
####
##### Merges the training and the test sets to create one data set.
# View(ncol(X_test))
# View(ncol(X_train))
# View(nrow(Y_test))
# View(nrow(Y_train))

X <- rbind(X_test,X_train)
Y <- rbind(Y_test,Y_train)
subject <- rbind(subject_test,subject_train)

#
##
###
####
##### Extracts only the measurements on the mean and standard deviation for each measurement.
select_x <- features[grep("mean\\(\\)|
                          std\\(\\)",features[,2]),]
X1 <- X[,select_x[,1]]

#
##
###
####
##### Uses descriptive activity names to name the activities in the data set
colnames(Y) <- "activity_type"
Y$activity_type <- factor(Y$activity_type, labels = as.character(activity_labels[,2]))
activity_type <- Y[,1]

#
##
###
####
##### Appropriately labels the data set with descriptive variable names.
colnames(X1) <- features[select_x[,1],2]

#
##
###
####
##### From the data set in step 4, creates a second, independent tidy data set with the average of each 
##### variable for each activity and each subject.
colnames(subject) <- "subject"
total <- cbind(X1,activity_type,subject)
total_mean <- summarize_all(
        group_by(total,activity_type,subject),
        funs(mean)
        )
write.table(total_mean,file = "./tidydata.txt",col.names = TRUE,row.names = FALSE)






