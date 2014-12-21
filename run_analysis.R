library(dplyr)

# First, we define the names of the tables to be read
tabTrainX = "UCI HAR Dataset/train/X_train.txt"
tabTrainY = "UCI HAR Dataset/train/Y_train.txt"
tabTrainSub = "UCI HAR Dataset/train/subject_train.txt"

tabTestX = "UCI HAR Dataset/test/X_test.txt"
tabTestY = "UCI HAR Dataset/test/Y_test.txt"
tabTestSub = "UCI HAR Dataset/test/subject_test.txt"

# We also read the feature names
tabFnames = "UCI HAR Dataset/features.txt"
fnames = read.table(tabFnames)

# We read the tables from the train data set
trainSub = read.table(tabTrainSub)
trainX = read.table(tabTrainX)
trainY = read.table(tabTrainY)

# Here we start assigning some descriptive labels
names(trainSub) <- c("subject")
names(trainX) <- fnames$V2

# Here we look for those features with mean() and std()
# on their name, and store their indices in the 'keep' variable
# which is used to define a new data frame
keep <- grep("mean\\(|std\\(",names(trainX))
meanStdTrainX <- trainX[keep]

# Here we assign a descriptive activity name for each
# activity, as given in "activity_labels.txt"
trainY$activity <- "ACTIVITY_PLACEHOLDER"
trainY$activity[trainY$V1==1] <- "WALKING"
trainY$activity[trainY$V1==2] <- "WALKING_UPSTAIRS"
trainY$activity[trainY$V1==3] <- "WALKING_DOWNSTAIRS"
trainY$activity[trainY$V1==4] <- "SITTING"
trainY$activity[trainY$V1==5] <- "STANDING"
trainY$activity[trainY$V1==6] <- "LAYING"
trainY <- trainY[c("activity")]

# We merge the 3 dataframes from the train dataset into one
trainMerged = cbind(trainSub,trainY,meanStdTrainX)

# We repeat the steps above, now for the test data set
testSub = read.table(tabTestSub)
testX = read.table(tabTestX)
testY = read.table(tabTestY)

names(testSub) <- c("subject")
names(testX) <- fnames$V2

keep <- grep("mean\\(|std\\(",names(testX))
meanStdTestX <- testX[keep]

testY$activity <- "ACTIVITY_PLACEHOLDER"
testY$activity[testY$V1==1] <- "WALKING"
testY$activity[testY$V1==2] <- "WALKING_UPSTAIRS"
testY$activity[testY$V1==3] <- "WALKING_DOWNSTAIRS"
testY$activity[testY$V1==4] <- "SITTING"
testY$activity[testY$V1==5] <- "STANDING"
testY$activity[testY$V1==6] <- "LAYING"
testY <- testY[c("activity")]

testMerged = cbind(testSub,testY,meanStdTestX)

# Now we merge (vertically) the previously merged 
# train and test data frames
allMerged = rbind(trainMerged,testMerged)

# Here we apply the mean function to our data frame grouping
# by subject and by activity
allClean <- summarise_each(group_by(allMerged,subject,activity),funs(mean))

# Finally, we write the clean dataset to a table
write.table(allClean, file="cleanDataset.txt", row.names=FALSE)

