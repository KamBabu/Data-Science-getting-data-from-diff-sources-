library(dplyr)
# 1. Import features.txt that contains the variable (column) names.
# 2. Import train data and used features to include column names. 
# 3. Import Activity data and name the column as "Activitiy".
# 4. Import Subject data and name the coulumn as "Subject" 
# 5. Bind Activity,Subject,and data columns
# 6. Repeat steps 2-5 for test data.
# 7. Combine train and test data.
# 8. Extracts only the measurements on the mean and standard deviation.
# 8a. Extract the header names from features.
# 8b. Add +2 to the result of above vector so that Subject and Activity columns are included.
# 8c. Extracts only the measurements on the mean and standard deviation.
# 9. Group the above result by Subject and Activity
# 10. Final result of mean of all the measurements by Subject and Activity.

features <- read.table("./UCI HAR Dataset/features.txt")
# 2.  
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names = features[,2],stringsAsFactors = FALSE)
# 3. 
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "Activity")
# 4.  
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")
# 5. 
trainDataWithLabelSubject <- cbind(trainSubject,trainLabel,trainData)
# 6. 
testData <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names = features[,2],stringsAsFactors = FALSE)
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "Activity")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")
testDataWithLabelSubject <- cbind(testSubject,testLabel,testData)
# 7. 
TrainAndTestData <- rbind(trainDataWithLabelSubject,testDataWithLabelSubject)
# 8. 
# 8a.
STDnMeanCols <- grep("std|mean",features$V2,perl = T)
# 8b.
STDnMeanCols <- STDnMeanCols + 2
STDnMeanCols <- c(1,2,STDnMeanCols)
# 8c.
ColsOfInterest <- select(TrainAndTestData,STDnMeanCols)
# 9.
GroupbySubnAct <- group_by(ColsOfInterest,Subject,Activity)
# 10.
meanResultBySubnAct <- summarise_each(GroupbySubnAct, funs(mean(., na.rm=TRUE)), -Subject,-Activity)

