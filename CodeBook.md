## Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration
and gravity. The gravitational force is assumed to have only low
frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain. See
‘features\_info.txt’ for more details.

#### For each record it is provided:

-   Triaxial acceleration from the accelerometer (total acceleration)
    and the estimated body acceleration.
-   Triaxial Angular velocity from the gyroscope.
-   A 561-feature vector with time and frequency domain variables.
-   Its activity label.
-   An identifier of the subject who carried out the experiment.

#### The dataset includes the following files:

-   ‘README.txt’

-   ‘features\_info.txt’: Shows information about the variables used on
    the feature vector.

-   ‘features.txt’: List of all features.

-   ‘activity\_labels.txt’: Links the class labels with their activity
    name.

-   ‘train/X\_train.txt’: Training set.

-   ‘train/y\_train.txt’: Training labels.

-   ‘test/X\_test.txt’: Test set.

-   ‘test/y\_test.txt’: Test labels.

-   ‘train/subject\_train.txt’: Each row identifies the subject who
    performed the activity for each window sample. Its range is from 1
    to 30.

## Data Transformation

Based on the structure of the dataset, the above files are first
combined by rows and then merged They are combined by rows by activity
(‘train/y\_train.txt’ and ‘test/y\_test.txt’), subject
(‘subject\_test.txt’ and ‘subject\_train.txt’), and features
(‘X\_train.txt’ and ‘X\_test.txt’). Then, they are merged by columns.
The variable names for the features columns are assigned from the
‘features.txt’ file.

I later extract only the measurements on the mean and standard deviation
for each measurement. This is done by subsetting names of features by
measurements on the mean() and std() and the merged data by selected
names of features.

The data is further cleaned by (a) changing numerical activity entries
to descriptive character entries based on ‘activity\_labels.txt’, and
(b) updating variable names to be descriptive.

Finally, a second, independent tidy data set with the average of each
variable for each activity and each subject is created.

## Variable Descriptions

First, there is a subject index variable ranges from 1 to 30. Second,
there is an activity character variable of the aforementioned six
activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
STANDING, LAYING). The rest variables coincide with extracted feature
variables. They indicate the parameter(time or frequency), the
components of the sensor signals (gravitational or body motion), the
sensor signals (accelerometer or gyroscope), summary statistics (mean or
std), and 3-axial angle (X, Y, or Z) in an order.
