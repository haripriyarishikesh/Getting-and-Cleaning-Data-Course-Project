CODEBOOK
-------------
**The codebook describes the data, variables used methods used to create the tidy dataset**

*Following are the steps involved in extracting the tidy dataset*

*Downloading and extracting the files from the specified location.
*Read the respective files required and load the data in respective data tables.
*Merge the tables to form the combined data .
*Assign meaningfull names to the  variables.
*Extract the columns with mean and SD measurments and create a subset data with the extracted columns.
*Replace the activity values with their corresponding desciptive names.
*An independent tidy data set with the average of each variable for each activity and each subject is created  using ddply.
*The tidy dataset is written to a text file as well to create tidydata.txt.

*VARIABLES* 
----------
DATA TABLES
-----------
Data was loaded into the following variables form their respective files
*x_testdata from X_test.txt(contains test feature data)
*y_testdata from y_test.txt(contains test avtivity data)
*x_traindata from X_train.txt(contains training feature data) 
*y_traindata from y_train.txt(contains training activity data)
*subject_testdata from subject_test.txt(contains data about the test subjects).
*subject_traindata from subject_train.txt(contains data about the training subjects)
*featurenames_data from features.txt (feature names)

Combining the respective feature, data and subjects results in the following tables 
*x_data
*y_data
*subject_data
*final_data -combined data table form the above three datasets.
*Data - Data table extracted from final_data with measurements on the mean and standard deviation.
*tidy_dataset - dataset with the average for each variable depending on the activity and subject.

*Library used*
------------
curl and plyr 






