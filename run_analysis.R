# Download the file from the url 
  if(!file.exists("./data"))
  {
    dir.create("./data")
  }
  library(curl)
  fileurl <- 
  "https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project"
    
  download.file(fileurl, destfile = "./data/Dataset.zip", method = "curl")
  zippath <- paste(getwd(), "/data/Dataset.zip", sep="")
  despath <- paste(getwd(), "/data", sep="")
  
  #Extract the contents from the zipfile
  unzip(zipfile = zippath, despath)
  pathref <- file.path("./data" , "UCI HAR Dataset")
  
  #Read the files to create corresponding datasets
  
  x_testdata  <- read.table(file.path(pathref, "test", "X_test.txt" ),header = FALSE)
  y_testdata  <- read.table(file.path(pathref, "test", "y_test.txt" ),header = FALSE)
  
  x_traindata  <- read.table(file.path(pathref, "train", "X_train.txt" ),header = FALSE)
  y_traindata  <- read.table(file.path(pathref, "train", "y_train.txt" ),header = FALSE)
  
  subject_traindata <- read.table(file.path(pathref, "train", "subject_train.txt"),header = FALSE)
  subject_testdata <- read.table(file.path(pathref, "test", "subject_test.txt"),header = FALSE)
  
  #Merge the training and the test datasets 
  x_data <- rbind(x_testdata, x_traindata)
  y_data <- rbind(y_testdata, y_traindata)
  subject_data <- rbind(subject_testdata, subject_traindata)
  
  #Assigning names to the variables
  names(subject_data) <- c("subject")
  names(y_data) <- c("activity")
  
 # Load the feature names
  featuresnames_data <- read.table(file.path(pathref, "features.txt"),head=FALSE)
  names(x_data) <- featuresnames_data$v2
  
  #Combine the columns to form the dataset
  combineddata <- cbind(subject_data, y_data)
  final_data <- cbind(combineddata, x_data)
  
  #Extract the measurements on the mean and standard deviation for each measurement
  subset_names <- featuresnames_data$V2[grep("mean\\(\\)|std\\(\\)", featuresnames_data$V2)]
  col_names <- c("subject", "activity", subset_names)
  Data <- subset(final_data, select = col_names)
  
  #Load the activity names 
  activity_names <- read.table(file.path(pathref, "activity_labels.txt"),header = FALSE)
  activity_label <- activity_names$v2
  activity_values <- activity_names$v1
  
  #Replace the activity values with respective descriptive activity names 
  library(plyr)
  Data$activity <- as.factor(Data$activity)
  Data$activity <- mapvalues(Data$activity, from = activity_values, to = activity_label)
  
  #Appropriately label the data set with descriptive variable names.
  names(Data)<-gsub("^t", "time", names(Data))
  names(Data)<-gsub("^f", "frequency", names(Data))
  names(Data)<-gsub("Acc", "Accelerometer", names(Data))
  names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
  names(Data)<-gsub("Mag", "Magnitude", names(Data))
  names(Data)<-gsub("BodyBody", "Body", names(Data))
  
  #Independent tidy data set with the average of each variable for each activity and each subject.
  tidy_dataset <- ddply(Data, .(subject, activity), function(x) colMeans(x[,3:68]))
  write.table(tidy_dataset, file = "tidydata.txt",row.name=FALSE)
  
