import numpy as np
import pandas as pd
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error


from functions.plotting_functions import plot_model_fit

###############################################################################
###############################################################################

def calculate_model_performance(y_obs, y_mod, **kwargs):
    '''
    Calculate the model performance metrics:
    - R2
    - RMSE
    - MAE
    '''
    # Calculate the metrics
    r2 = r2_score(y_obs, y_mod)
    rmse = np.sqrt(mean_squared_error(y_obs, y_mod))
    mae = mean_absolute_error(y_obs, y_mod)
    metrics_out = {
        'r2': r2,
        'rmse': rmse,
        'mae': mae
    }
    return metrics_out

###############################################################################
###############################################################################

def assess_model_prediction(pred_dict_in, test=False, **kwargs):
    '''
    Plot the model performance for training, validation and test data.
    Return the metrics for model performance.
    Input:
        - pred_dict: A dictionary with:
            - train_y: observed values for training data
            - train_y_pred: predicted values for training data
            - val_y: observed values for validation data
            - val_y_pred: predicted values for validation data
            - test_y: observed values for test data
            - test_y_pred: predicted values for test data
        - test: False - set to True to get test set results
    Output:
        - metrics: A pandas dataframe with:
            - R2i
            - RMSE
            - MAE
        - plots for train, validation and test performance
    '''
    # deal with residual dataframes
    pred_dict = {k: v.values if isinstance(v, pd.DataFrame) or isinstance(v, pd.Series) else v for k, v in pred_dict_in.items()}

    # Calculate the metrics
    if not pred_dict['train_y'] is None:
        train_metrics = calculate_model_performance(
            pred_dict['train_y'], pred_dict['train_y_pred']
        )
        plot_model_fit(
            pred_dict['train_time'],pred_dict['train_y'], pred_dict['train_y_pred'], mod_metrics=train_metrics,
            title='Model fit for training data'
        )
    else:
        train_metrics = None
    if not pred_dict['val_y'] is None:
        val_metrics = calculate_model_performance(
            pred_dict['val_y'], pred_dict['val_y_pred']
        )
        plot_model_fit(
            pred_dict['val_time'],pred_dict['val_y'], pred_dict['val_y_pred'], mod_metrics=val_metrics,
            title='Model fit for validation data'
        )
    else:
        val_metrics = None
    if not pred_dict['test_y'] is None and test:
        test_metrics = calculate_model_performance(
            pred_dict['test_y'], pred_dict['test_y_pred']
        )
        plot_model_fit(
            pred_dict['test_time'],pred_dict['test_y'], pred_dict['test_y_pred'], mod_metrics=test_metrics,
            title='Model fit for test data'
        )
    else:
        test_metrics = None
    
    # construct pandas dataframe
    metrics = pd.DataFrame(
        {
            'train': train_metrics,
            'val': val_metrics,
            'test': test_metrics
         }
    )

    return metrics

###############################################################################
###############################################################################

def inversescaler_pred_dict(predicted_data, scaler=None):
    '''
    Construct a dictionary with the model predictions and inverse transform if needed.
    '''
    if not scaler is None:
        predicted_data['train_y'] = scaler.inverse_transform(predicted_data['train_y'])
        predicted_data['train_y_pred'] = scaler.inverse_transform(predicted_data['train_y_pred'].reshape(-1,1))
        predicted_data['test_y'] = scaler.inverse_transform(predicted_data['test_y'])
        predicted_data['test_y_pred'] = scaler.inverse_transform(predicted_data['test_y_pred'].reshape(-1,1))
        if not predicted_data['val_y'] is None:
            predicted_data['val_y'] = scaler.inverse_transform(predicted_data['val_y'])
            predicted_data['val_y_pred'] = scaler.inverse_transform(predicted_data['val_y_pred'].reshape(-1,1))

    return predicted_data
