#Coursera Course: Getting and Cleaning Data Course Project
#30 January 2016
#Student: Brooks J. Breece

install.packages("dplyr")

library(dplyr)


#Import test data
X_test <- read.table("test\X_test.txt", quote="\"", comment.char="")
y_test <- read.table("test\y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("test\subject_test.txt", quote="\"", comment.char="")

#Bind test data
test <- cbind(subject_test,y_test,X_test)

#Import training data
subject_train <- read.table("train\subject_train.txt", quote="\"", comment.char="")
y_train <- read.table("train\y_train.txt", quote="\"", comment.char="")
X_train <- read.table("train\X_train.txt", quote="\"", comment.char="")

#Bind training data
train <- cbind(subject_train,y_train,X_train)

#Merge data
data <- rbind(test,train)

#Get column names from features.txt
features <- read.table("features.txt", quote="\"", comment.char="")

#Add column header entries for subject and activity name
names <- c("subject","actname",as.character(features$V2))
colnames(data) <- names
colnames(data) <- make.names(colnames(data), unique=TRUE)

#Select columns with mean or std
meanstd_data <- select(data,1:2,matches("mean|std"))

#Import activity descriptions
activity_labels <- read.table("activity_labels.txt", quote="\"", comment.char="")

#Add activity description to table
meanstd_data <- merge(meanstd_data,activity_labels, by.x="actname", by.y="V1")
meanstd_data$actname <- meanstd_data$V2
meanstd_data$V2 <- NULL

#Tidy column names
colnames(meanstd_data) <- sub("^f","frequency",colnames(meanstd_data))
colnames(meanstd_data) <- sub("^t","time",colnames(meanstd_data))
colnames(meanstd_data) <- gsub("[[:punct:]]","",colnames(meanstd_data))

#Group by activity and subject
g <- group_by(meanstd_data,actname,subject)

#Average by activity and subject
mean_activity_subject <- summarize_each(g,funs(mean))

#Output final table
write.table(mean_activity_subject, file = "mean_activity_subject.txt", row.name=FALSE)