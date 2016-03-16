library(reshape2)
library(dplyr)
library(data.table)

if (!file.exists("./data/UCI HAR Dataset")) {
  dir.create("/data/UCI HAR Dataset")
}

# Load features
features <- read.table("./data/UCI HAR Dataset/features.txt")
# Select only std and mean columns.
STDnMeanCols <- grep("std|mean",features$V2)


# load activity lables.
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
# Rename default header V1 and V2 to a meaningful one.. (Activity_ID and Activity_desc)
activity_labels <- dplyr :: rename(activity_labels,Activity_ID = V1, Activity = V2)

#--------------------------------------- process test data -------------------------------------------------
# Load test's X_test data.
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",col.names = features[,2],stringsAsFactors = FALSE)
# Select only Mean and STD columns.
X_test <- select(X_test,STDnMeanCols)

# Add descriptive activity names column to X_test data.  
Y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt",col.names = "Activity_ID",stringsAsFactors = FALSE)
Y_test <- merge(Y_test,activity_labels,by  = "Activity_ID")
Y_test <- select(Y_test,2)
X_test <- cbind(Y_test,X_test)


# Add Subject names column to above X_test data using cbind.
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")
X_test <- cbind(test_subject,X_test)
X_test<- tbl_df(X_test)

#---------------------------------------- process train data --------------------------------------------------

# Load train's X_train data
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",col.names = features[,2],stringsAsFactors = FALSE)
# Select only Mean and STD columns.
X_train <- select(X_train,STDnMeanCols)

# Add descriptive activity names column to X_train data.  
Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",col.names = "Activity_ID",stringsAsFactors = FALSE)
Y_train <- merge(Y_train,activity_labels,by  = "Activity_ID")
Y_train <- select(Y_train,2)
X_train <- cbind(Y_train,X_train)

# Add Subject names column to above X_train data using cbind.
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")
X_train <-cbind(train_subject,X_train)
X_train<- tbl_df(X_train)

#-------------------------------------------merge test and train data -------------------------------------------
# combine X_test and X_train
Merge_data <- rbind(X_train,X_test)

#--------------------------------------------create a tidy data :-------------------------------------------------

# Melt all the variables and dcast to put it back as a tidy data set.   
Melt_data <- melt(Merge_data,id=c("Subject","Activity"))
tidy_data <- dcast(Melt_data,Subject + Activity ~ variable,mean)

#-------------------------------------------- Remove all temp storage --------------------------------------------
rm(features)
rm(Melt_data)
rm(activity_labels)
rm(X_test)
rm(X_train)
rm(Y_test)
rm(Y_train)
rm(Merge_data)
rm(test_subject)
rm(train_subject)
rm(STDnMeanCols)

#-------------------------------------------- Write csv file  ---------------------------------------------------

write.table(tidy_data,file = "./data/UCI HAR Dataset/tidy_data_output.csv",sep = ",",col.names = NA)
