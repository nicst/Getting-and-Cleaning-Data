library(plyr)



# If data does isn't stored on the computer dowload and unzip it

if(!dir.exists("UCI HAR Dataset")) {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url,"temp.zip",method="curl")
        unzip("temp.zip")
        unlink("temp.zip")
}

#### Step 1 : Merges the training and the test sets to create one data set ####


# Read all data from file

trainData <- list(
        subject = read.table("UCI HAR Dataset/train/subject_train.txt"),
        x = read.table("UCI HAR Dataset/train/X_train.txt"),
        y = read.table("UCI HAR Dataset/train/y_train.txt")
)

testData <- list(
        subject = read.table("UCI HAR Dataset/test/subject_test.txt"),
        x = read.table("UCI HAR Dataset/test/X_test.txt"),
        y = read.table("UCI HAR Dataset/test/y_test.txt")
)

data <- list(
        subject = rbind(trainData$subject,testData$subject),
        features = rbind(trainData$x,testData$x),
        activity = rbind(trainData$y,testData$y)
)



#### Step 2 : Extracts only the measurements on the mean and  ####
####    standard deviation for each measurement.              ####


featureLabels <- read.table("UCI HAR Dataset/features.txt")$V2
selected <- grepl('mean\\(\\)|std\\(\\)',featureLabels)
featureLabels <- gsub('mean\\(\\)','Mean',featureLabels)
featureLabels <- gsub('std\\(\\)','Std',featureLabels)

data$features <- data$features[,selected]


#### Step 3 : Uses descriptive activity names to name the activities  ####
####    in the data set                                               ####


data$activity$id <-1:nrow(data$activity)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity <- merge(data$activity,activityLabels)
data$activity <- data.frame(Activity = activity[activity$id,"V2"])


#### Step 4 : Appropriately labels the data set with descriptive ####
####    variable names.                                          #### 


names(data$features) <- featureLabels[selected]
names(data$subject) <- "Subject"

#### Join everything in one single dataframe ####

tidyData <- data.frame(data)


#### Step 5 : Creates a second, independent tidy data set with the average ####
#### of each variable for each activity and each subject.                  ####


variables <- !grepl("Subject|Activity",names(tidyData)) 
meanData <- ddply(tidyData,.(Subject,Activity),
                  function(x) {colMeans(x[,variables])})

#### Write resulting data to file ####

write.table(meanData,"TidyDataMeans.txt",row.names = FALSE)
