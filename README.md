# DARE-Newcrest Data Challenge: Flotation Plant Data

This repository contains digital resources for the DARE-Newcrest data challenge.

## Data
The data are available in the `data` folder. We will be using the files:

    - data/hourly_train_data.csv
    - data/hourly_test_data.csv

## Code
The data were prepared using the notebook `00_Data_Preprocessing.ipynb`.

You will use the notebook `01_Data_Challenge.ipynb` to complete the challenge.

This has code for loading the data, splitting into train/validation/test,
scaling the data, and an example training a simple linear regression model and
neural network. 

## Challenge
Your challenge is to develop a better model for prediction.

Model performance will be assessed using Mean Absolute Error, Mean Squared
Error and Coefficient of Determination (R<sup>2</sup>) metrics.

N.B. The notebook contains some standard functions for evaluating and plotting
model performance.
