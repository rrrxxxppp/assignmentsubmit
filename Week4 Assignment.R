###Download zip file
Url<-  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, "UCI HAR Dataset.zip", mode = "wb")
unzip('UCI HAR Dataset.zip')

###Read the tables

train_subject<- read.table('./UCI HAR Dataset/train/subject_train.txt')
train_set<-read.table('./UCI HAR Dataset/train/X_train.txt')
train_label<-read.table('./UCI HAR Dataset/train/y_train.txt')
test_subject<- read.table('./UCI HAR Dataset/test/subject_test.txt')
test_set<-read.table('./UCI HAR Dataset/test/X_test.txt')
test_label<-read.table('./UCI HAR Dataset/test/y_test.txt')
features<- read.table('UCI HAR Dataset/features.txt',as.is = TRUE)
activity_labels<- read.table('UCI HAR Dataset/activity_labels.txt')
colnames(activity_labels)<- c('ID','name')


###1. Merges the training and the test sets to create one data set.

activity_train<- cbind(train_subject,train_set,train_label)
activity_test<-cbind(test_subject,test_set,test_label)
activity_all<- rbind(activity_train,activity_test)
colnames(activity_all)=c('subjects', features[,2],'labels')


###2. Extracts only the measurements on the mean and standard deviation for each measurement. 

activity_extract<- activity_all[,grepl('subjects|mean|std|labels',colnames(activity_all))]



###3. Uses descriptive activity names to name the activities in the data set.

activity_extract$labels<- factor(activity_extract$labels, activity_labels$ID, activity_labels$name)


###4. Appropriately labels the data set with descriptive variable names. 
readableCols<- colnames(activity_extract)
readableCols<-gsub('^t','time', readableCols)
readableCols<-gsub('^f','frequency', readableCols)
readableCols<-gsub('Acc','Accelerometer', readableCols)
readableCols<-gsub('Gyro','Gyroscope', readableCols)
readableCols<-gsub('Mag','Magnitude', readableCols)
readableCols<-gsub('BodyBody','Body', readableCols)
readableCols<-gsub('[\\(\\)\\-]','', readableCols)
colnames(activity_extract)<-readableCols


###5. From the data set in step 4, creates a second, independent tidy data set with the average of 
###   each variable for each activity and each subject.

library(dyplyr)
activity_group<-group_by(activity_extract, subjects, labels)
activity_mean<-summarise_each(activity_group,mean)
write.table(activity_mean,'Tidy_dataset.txt',row.names = FALSE,quote = FALSE)



