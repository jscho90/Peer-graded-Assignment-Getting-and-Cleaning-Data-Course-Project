
# Variable Description




## Assigned data
Data frames below contain each data described below from downloaded project dataset files.  
Refer to README in downloaded project dataset folder for a description of each data file.  


**features** <- features.txt  
**activities** <- activity_labels.txt  
**subject_test** <- test/subject_test.txt  
**x_test** <- test/X_test.txt  
**y_test** <- test/y_test.txt  
**subject_train** <- test/subject_train.txt  
**x_train** <- test/X_train.txt  
**y_train** <- test/y_train.txt  




## Merged data
Data frames below are created by merging each following dataset.


**X** <- x_train, x_test  
**Y** <- y_train, y_test  
**Subject** <- subject_train, subject_test  
**Merged_Data** <- Subject, Y, X  




## Extracted data
**Tidy_Data** is created by subsetting Merged_Data with subject, code, and mean and standard deviation for each measurement.




## Final tidy data
**Tidy_Data_Final** is created by subsetting and summarizing Tidy_Data with the average of each variable after groupped by subject and activity.
