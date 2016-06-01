# source libraries
library(dplyr)

# set variables for source URL, destination filename and data directory
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "./data/data.zip"    
dd <- "data"

# check if data directory exists and create it if needed
if (!file.exists(dd)) dir.create(dd)

# check if data file has already been downloaded and download if needed
if (!file.exists(f)) download.file(URL,f,method="curl")       

# unzip the source file with overwrite
unzip(f,exdir=dd)

# read in the data files. They are described in readme.txt from the download.
dd = "./data/UCI HAR Dataset/"
activities <- read.table(paste(dd,"activity_labels.txt",sep="")) # activity lbl
features <- read.table(paste(dd,"features.txt",sep=""),colClasses="character") # feature lbl
dd = "./data/UCI HAR Dataset/test/"
x_test <- read.table(paste(dd,"X_test.txt",sep="")) # Test dataset
y_test <- read.table(paste(dd,"Y_test.txt",sep="")) # Test labels
s_test <- read.table(paste(dd,"subject_test.txt",sep="")) # Test Subject
dd = "./data/UCI HAR Dataset/train/"
x_train <- read.table(paste(dd,"X_train.txt",sep="")) # Train dataset
y_train <- read.table(paste(dd,"Y_train.txt",sep="")) # Train labels
s_train <- read.table(paste(dd,"subject_train.txt",sep="")) # Train Subject

# combine columns and rows for the above datasets
df <- rbind(cbind(s_test,y_test,x_test),cbind(s_train,y_train,x_train))

# add column names as subject, activity, and add labels from features.txt
names(df) <- c("subject","activity",features[,2])

# extract only the variables for the mean() or std(), plus first two columns
df <- df[,c(1:2,grep("std()|mean()",names(df)))]

# merge activity names and drop the extra variable resulting afterward
df <-merge(df,activities,by.x="activity",by.y="V1")
df <- mutate(df,activity = V2)
df <- df[1:length(df)-1]

# change variable names to lower case and remove the "()"
names(df) <- gsub("\\(\\)","",tolower(names(df)))

# expand abbreviations in variable names 
names(df) <- gsub("freq","frequency ",names(df))
names(df) <- gsub("^t","time domain ",names(df))
names(df) <- gsub("^f","frequency domain ",names(df))
names(df) <- gsub("body","body ",names(df))
names(df) <- gsub("body body","body",names(df))
names(df) <- gsub("gravity","gravity ",names(df))
names(df) <- gsub("gyro","gyroscope ",names(df))
names(df) <- gsub("acc","accelerometer ",names(df))
names(df) <- gsub("jerk","jerk ",names(df))
names(df) <- gsub("mag","mag ",names(df))
names(df) <- gsub("-mean","mean ",names(df))
names(df) <- gsub("-std","standard deviation ",names(df))
names(df) <- gsub("-x","x axis ",names(df))
names(df) <- gsub("-y","y axis ",names(df))
names(df) <- gsub("-z","z axis ",names(df))

# and finally trim trailing whitespace from variable names
names(df) <- trimws(names(df),"right")

# create 2nd tidy dataset with avg of each variable for each activity/subject
tidyDF <- group_by(df,subject,activity)
tidyDF <- summarize_each(tidyDF,funs(mean))

# export the dataset
write.table(tidyDF,"Means by Subject and Activity.txt",row.names = FALSE)