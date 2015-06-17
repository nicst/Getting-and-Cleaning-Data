# Getting-and-Cleaning-Data
Getting and Cleaning Data course at Coursera

This reposotory contains a script for cleaning the human activity recognition using smartphones dataset.
This script can be executed by runing the run_analysis.R file.
To create the tidy dataset the following actions are taken

##### Steps
1. Download the data if it's not in the current working directory
2. Merge the training and testing datasets
3. Select all measurements that has mean or std in it's name and discard the rest
5. Replace the activity numbers in the dataframe with its corresponding name
4. Clean up the names for the measurements
   * Change mean to Mean and std to Std
   * Replace starting t with Time
   * Replace starting f with Frequency
   * Replace Acc with Acceleration
   * Remove all '-'
   * Remove second Body in BobyBody
6. Create a new tidy dataset with the average of each variable for each activity and each subject

