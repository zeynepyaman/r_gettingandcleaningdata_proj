Data source: [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Dataset before preprocessing include:
    activity_label.txt
    features_info.txt
    README.txt
    test data folder
        Inertial Signals folder
        subject_test.txt
        X_test.txt
        y_test.txt
    train data folder
       Inertial Signals folder
        subject_test.txt
        X_train.txt
        y_train.txt
### Labels were modified as following:
    "t" = "Time"
    "f" = "Frequency"
    "Acc" = "Accelerometer"
    "Gyro" = "Gyroscope"
    "Mag" = "Magnitude"
    "BodyBody" = "Body"
    
### Output file
    The output file 'tidy_data.txt' contains 180 observations with 68 total variables.