#Read Me

This ReadMe describes the creation of a "clean" version of the Samsung
data set found in:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
%20Dataset.zip
by merging the 'test' and 'train' data sets, adding easier to read labels,
extracting the mean and std deviations of the features, and returning a table
with the averages over each activity and subject of the mean and std deviations
of each feature.

To script should be run from the same directory where the "UCI HAR
Dataset" directory is, and requires the R package "dplyr" to be installed.

The script basically starts by doing a horizontal merger for the 'subject', 
'Y', and 'X' files separately for the 'train' and 'test' datasets. At this
point, it also incorporates the corresponding activity names to each activity
code in the 'Y' files, and also adds the feature names to the 'X' files.
Based on the assignment requirements, the code extracts the mean() and std()
columns for each measurement using the grep function. 

The script subsequently merges vertically the two merged datasets, train and test.
With the merged data set, it now proceeds to calculate the mean of each individual 
measurement, grouping by activity and subject, i.e., each of the 30 subjects will have
a single measurement for each of the 6 activities performed. The code writes this new
'clean' data set to a file called "cleanDataset.txt"
The code has been commented for an easier understanding.
