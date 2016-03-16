Code Book

Title: Getting and Cleaning Data Course Project

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.


run_analysis.R Code walk thru.

1. features.txt contains the header information for the X_train and X_test data. 
   Extract column header that start with Std and Mean.  
2. activity_labels.txt contains two vectors: id and activity description. 
   Default header is V1 and V2 - replace with meaningful header names.
3. Shape X_test data by merging activity ID column from Y_test data. 
   Replacing activity ID with descriptive activity names.
   Obtain subject id from subject_test.txt and merge subject id column to X_test data    
4. Repeat step 3 with X_train.txt, Y_train.txt and Subject_train.txt
5. Combine X_train and X_test data.
6. Creating a tidy data from the above result.
   Group by Subject and Activity type and Melt all other variables.
   Summarize the mean for each Subject and Activity type.
   Decast to put the variables back in individual columns to create a tidy dataset.
7. Write the output. 
