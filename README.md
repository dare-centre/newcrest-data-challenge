# DARE-Newcrest data challenge - flotation plant dataset
DARE 2022

This repository contains the data and example jupyter notebooks for the DARE-Newcrest data challenge.

## Data
The data is available in the `data` folder. We will be using the files:

    - `data/hourly_train_data.csv`
    - `data/hourly_test_data.csv`

## Code
The data were prepared using the notebook `00_Data_Preprocessing.ipynb` notebook.
You will use the notebook `01_Data_Challenge.ipynb` to complete the challenge. This has code for loading the data, splitting into train/validation/test, scaling the data, and an example training a simple linear regression model and neural network. 

You will need to develop a better model for prediction.

The notebook also has some standard functions at the end for evaluating and plotting model performance. We are aiming for the best performance in R2, MSE and MAE.